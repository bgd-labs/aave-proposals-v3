// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IERC4626} from 'openzeppelin-contracts/contracts/interfaces/IERC4626.sol';
import {AaveV3Plasma, AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {GovernanceV3Plasma} from 'aave-address-book/GovernanceV3Plasma.sol';
import {GhoPlasma} from 'aave-address-book/GhoPlasma.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IUpgradeableBurnMintTokenPool, IRateLimiter} from 'src/interfaces/ccip/IUpgradeableBurnMintTokenPool.sol';
import {CCIPChainSelectors} from '../helpers/gho-launch/constants/CCIPChainSelectors.sol';
import {IAaveOracle} from 'aave-address-book/AaveV2.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGsm} from 'src/interfaces/IGsm.sol';
import {IGsmFeeStrategy} from 'src/interfaces/IGsmFeeStrategy.sol';
import {IGsmRegistry} from 'src/interfaces/IGsmRegistry.sol';
import {IGsmSteward} from 'src/interfaces/IGsmSteward.sol';

import {AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2} from './AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2.sol';

interface IGhoReserve {
  function addEntity(address entity) external;
  function getLimit(address entity) external view returns (uint256);
  function setLimit(address entity, uint256 limit) external;
  function totalEntities() external view returns (uint256);
}

/**
 * @dev Test for AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250930_Multi_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards/AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2.t.sol -vv
 */
contract AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2_Test is
  ProtocolV3TestBase
{
  AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2 internal proposal;
  address public RISK_COUNCIL = 0x8513e6F37dBc52De87b166980Fa3F50639694B60;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('plasma'), 6128244);
    proposal = new AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2();

    // Deal GHO that is going to be bridged from Mainnet
    // 1 GHO for seed amount already sent to Collector
    deal(GhoPlasma.GHO_TOKEN, address(AaveV3Plasma.COLLECTOR), 50_000_010 ether);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2',
      AaveV3Plasma.POOL,
      address(proposal)
    );
  }

  function test_bridgeLimitRestore() public {
    // Mock the update from Part 1
    vm.startPrank(GovernanceV3Plasma.EXECUTOR_LVL_1);
    IUpgradeableBurnMintTokenPool(GhoPlasma.GHO_CCIP_TOKEN_POOL).setChainRateLimiterConfig(
      CCIPChainSelectors.ETHEREUM,
      IRateLimiter.Config({
        isEnabled: true,
        capacity: proposal.DEFAULT_RATE_LIMITER_CAPACITY(),
        rate: proposal.DEFAULT_RATE_LIMITER_RATE()
      }),
      IRateLimiter.Config({isEnabled: true, capacity: 5_000_000 ether, rate: 4_000_000 ether})
    );
    vm.stopPrank();
    vm.warp(block.timestamp + 1);

    IRateLimiter.TokenBucket memory bucket = IUpgradeableBurnMintTokenPool(
      GhoPlasma.GHO_CCIP_TOKEN_POOL
    ).getCurrentInboundRateLimiterState(CCIPChainSelectors.ETHEREUM);

    assertGt(bucket.capacity, proposal.DEFAULT_RATE_LIMITER_CAPACITY());
    assertGt(bucket.rate, proposal.DEFAULT_RATE_LIMITER_RATE());
    assertTrue(bucket.isEnabled);
    assertGt(bucket.tokens, proposal.DEFAULT_RATE_LIMITER_CAPACITY());

    executePayload(vm, address(proposal));

    bucket = IUpgradeableBurnMintTokenPool(GhoPlasma.GHO_CCIP_TOKEN_POOL)
      .getCurrentInboundRateLimiterState(CCIPChainSelectors.ETHEREUM);

    assertEq(bucket.capacity, proposal.DEFAULT_RATE_LIMITER_CAPACITY());
    assertEq(bucket.rate, proposal.DEFAULT_RATE_LIMITER_RATE());
    assertTrue(bucket.isEnabled);
    assertEq(bucket.tokens, proposal.DEFAULT_RATE_LIMITER_CAPACITY());
  }

  function test_dustBinHasGHOFunds() public {
    executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Plasma.POOL.getReserveAToken(GhoPlasma.GHO_TOKEN);
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Plasma.DUST_BIN)), 10 ** 18);
  }

  function test_GHOAdmin() public {
    executePayload(vm, address(proposal));
    address aGHO = AaveV3Plasma.POOL.getReserveAToken(GhoPlasma.GHO_TOKEN);
    assertEq(
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).getEmissionAdmin(GhoPlasma.GHO_TOKEN),
      proposal.GHO_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).getEmissionAdmin(aGHO),
      proposal.GHO_LM_ADMIN()
    );
  }

  function test_checkGsmConfig() public {
    // GhoReserve check limits and entities

    executePayload(vm, address(proposal));

    uint256 limit = IGhoReserve(proposal.GHO_RESERVE()).getLimit(proposal.NEW_GSM_USDT());
    assertEq(limit, proposal.USDT_CAPACITY());

    // GSM USDT
    GsmConfig memory gsmUsdtConfig = GsmConfig({
      sellFee: 0, // 0%
      buyFee: 0.001e4, // 0.2%
      exposureCap: 45_000_000e6,
      isFrozen: false,
      isSeized: false,
      freezerCanUnfreeze: true,
      freezeLowerBound: 0.99e8,
      freezeUpperBound: 1.01e8,
      unfreezeLowerBound: 0.995e8,
      unfreezeUpperBound: 1.005e8
    });
    _checkGsmConfig(
      IGsm(proposal.NEW_GSM_USDT()),
      AaveV3PlasmaAssets.USDT0_STATA_TOKEN,
      IOracleSwapFreezer(proposal.USDT_ORACLE_SWAP_FREEZER()),
      gsmUsdtConfig
    );
  }

  function test_oracleSwapFreezers() public {
    // OracleSwapFreezers are not authorized
    assertEq(
      IGsm(proposal.NEW_GSM_USDT()).hasRole(
        IGsm(proposal.NEW_GSM_USDT()).SWAP_FREEZER_ROLE(),
        proposal.USDT_ORACLE_SWAP_FREEZER()
      ),
      false
    );

    IOracleSwapFreezer usdtFreezer = IOracleSwapFreezer(proposal.USDT_ORACLE_SWAP_FREEZER());
    (uint128 usdtFreezeLowerBound, ) = usdtFreezer.getFreezeBound();
    (uint128 usdtUnfreezeLowerBound, ) = usdtFreezer.getUnfreezeBound();

    // Price outside the price range
    // Freezers cannot execute freeze without authorization
    _mockAssetPrice(
      address(AaveV3Plasma.ORACLE),
      AaveV3PlasmaAssets.USDT0_UNDERLYING,
      usdtFreezeLowerBound - 1
    );

    (bool canPerformUpkeep, ) = usdtFreezer.checkUpkeep(bytes(''));
    assertEq(canPerformUpkeep, false);
    usdtFreezer.performUpkeep(bytes(''));
    assertEq(IGsm(proposal.NEW_GSM_USDT()).getIsFrozen(), false);

    // Payload execution
    executePayload(vm, address(proposal));

    // Freezers are authorized now
    assertEq(
      IGsm(proposal.NEW_GSM_USDT()).hasRole(
        IGsm(proposal.NEW_GSM_USDT()).SWAP_FREEZER_ROLE(),
        proposal.USDT_ORACLE_SWAP_FREEZER()
      ),
      true
    );

    // Freezers freeze GSM contracts
    (canPerformUpkeep, ) = usdtFreezer.checkUpkeep(bytes(''));
    assertEq(canPerformUpkeep, true);
    usdtFreezer.performUpkeep(bytes(''));
    assertEq(IGsm(proposal.NEW_GSM_USDT()).getIsFrozen(), true);

    // Price back to normal
    _mockAssetPrice(
      address(AaveV3Plasma.ORACLE),
      AaveV3PlasmaAssets.USDT0_UNDERLYING,
      usdtUnfreezeLowerBound + 1
    );

    (canPerformUpkeep, ) = usdtFreezer.checkUpkeep(bytes(''));
    assertEq(canPerformUpkeep, true);
    usdtFreezer.performUpkeep(bytes(''));
    assertEq(IGsm(proposal.NEW_GSM_USDT()).getIsFrozen(), false);
  }

  function test_checkRoles() public {
    executePayload(vm, address(proposal));

    _checkRolesConfig(IGsm(proposal.NEW_GSM_USDT()));
  }

  function test_gsmUsdtIsOperational() public {
    executePayload(vm, address(proposal));

    deal(AaveV3PlasmaAssets.USDT0_STATA_TOKEN, address(this), 1_000e6);

    // New GSMs are operational
    IERC20(AaveV3PlasmaAssets.USDT0_STATA_TOKEN).approve(proposal.NEW_GSM_USDT(), 1_000e6);
    IERC20(GhoPlasma.GHO_TOKEN).approve(proposal.NEW_GSM_USDT(), 1_200 ether);

    uint256 amountUnderlying = 1_000e6;
    uint256 balanceBeforeUsdtGsm = IERC20(AaveV3PlasmaAssets.USDT0_STATA_TOKEN).balanceOf(
      proposal.NEW_GSM_USDT()
    );
    uint256 balanceGhoBefore = IGhoToken(GhoPlasma.GHO_TOKEN).balanceOf(address(this));

    (, uint256 ghoBought) = IGsm(proposal.NEW_GSM_USDT()).sellAsset(
      amountUnderlying,
      address(this)
    );

    assertEq(
      IERC20(AaveV3PlasmaAssets.USDT0_STATA_TOKEN).balanceOf(proposal.NEW_GSM_USDT()),
      balanceBeforeUsdtGsm + amountUnderlying,
      'amounts USDT after sellAsset not equal'
    );
    assertEq(
      IGhoToken(GhoPlasma.GHO_TOKEN).balanceOf(address(this)),
      balanceGhoBefore + ghoBought,
      'GHO balance after sellAsset not equal'
    );

    (, uint256 ghoSold) = IGsm(proposal.NEW_GSM_USDT()).buyAsset(500e6, address(this));

    assertEq(
      IERC20(AaveV3PlasmaAssets.USDT0_STATA_TOKEN).balanceOf(proposal.NEW_GSM_USDT()),
      balanceBeforeUsdtGsm + amountUnderlying - 500e6,
      'stataUSDT balance after buyAsset not equal'
    );
    assertEq(
      IGhoToken(GhoPlasma.GHO_TOKEN).balanceOf(address(this)),
      balanceGhoBefore + ghoBought - ghoSold,
      'GHO balance after buyAsset not equal'
    );
  }

  function test_ghoGsmSteward_updateExposureCapUSDT() public {
    executePayload(vm, address(proposal));

    uint128 oldExposureCap = IGsm(proposal.NEW_GSM_USDT()).getExposureCap();
    uint128 newExposureCap = oldExposureCap + 1;

    vm.startPrank(RISK_COUNCIL);
    IGsmSteward(proposal.GHO_GSM_STEWARD()).updateGsmExposureCap(
      proposal.NEW_GSM_USDT(),
      newExposureCap
    );
    uint128 currentExposureCap = IGsm(proposal.NEW_GSM_USDT()).getExposureCap();
    assertEq(currentExposureCap, newExposureCap);
  }

  function test_ghoGsmSteward_updateGsmBuySellFeesUSDT() public {
    executePayload(vm, address(proposal));

    address feeStrategy = IGsm(proposal.NEW_GSM_USDT()).getFeeStrategy();
    uint256 buyFee = IGsmFeeStrategy(feeStrategy).getBuyFee(1e4);
    uint256 sellFee = IGsmFeeStrategy(feeStrategy).getSellFee(1e4);

    vm.startPrank(RISK_COUNCIL);
    IGsmSteward(proposal.GHO_GSM_STEWARD()).updateGsmBuySellFees(
      proposal.NEW_GSM_USDT(),
      buyFee + 1,
      sellFee
    );
    address newStrategy = IGsm(proposal.NEW_GSM_USDT()).getFeeStrategy();
    uint256 newBuyFee = IGsmFeeStrategy(newStrategy).getBuyFee(1e4);
    assertEq(newBuyFee, buyFee + 1);
  }

  function _checkRolesConfig(IGsm gsm) internal view {
    // DAO permissions
    assertTrue(gsm.hasRole(bytes32(0), GovernanceV3Plasma.EXECUTOR_LVL_1), 'Executor is not admin');
    assertTrue(
      gsm.hasRole(gsm.SWAP_FREEZER_ROLE(), GovernanceV3Plasma.EXECUTOR_LVL_1),
      'Executor is not swap freezer'
    );
    assertTrue(
      gsm.hasRole(gsm.CONFIGURATOR_ROLE(), GovernanceV3Plasma.EXECUTOR_LVL_1),
      'Executor is not configurator'
    );
    // No need to be liquidator or token rescuer at the beginning
    assertFalse(gsm.hasRole(gsm.LIQUIDATOR_ROLE(), GovernanceV3Plasma.EXECUTOR_LVL_1));
    assertFalse(gsm.hasRole(gsm.TOKEN_RESCUER_ROLE(), GovernanceV3Plasma.EXECUTOR_LVL_1));

    // Deployer does not have permissions
    address deployer = 0x99C7A4A4Ab99882C422eF777b182eBda204D5B02;
    assertFalse(gsm.hasRole(bytes32(0), deployer), 'Deployer cannot be admin');
    assertFalse(gsm.hasRole(gsm.SWAP_FREEZER_ROLE(), deployer), 'Deployer cannot be swap freezer');
    assertFalse(gsm.hasRole(gsm.CONFIGURATOR_ROLE(), deployer), 'Deployer cannot be configurator');
    assertFalse(gsm.hasRole(gsm.LIQUIDATOR_ROLE(), deployer), 'Deployer cannot be liquidator');
    assertFalse(
      gsm.hasRole(gsm.TOKEN_RESCUER_ROLE(), deployer),
      'Deployer cannot be token rescuer'
    );

    // GHO Steward
    assertTrue(
      gsm.hasRole(gsm.CONFIGURATOR_ROLE(), proposal.GHO_GSM_STEWARD()),
      'Gho Steward not configured'
    );
  }

  function _mockAssetPrice(address priceOracle, address asset, uint256 price) internal {
    vm.mockCall(
      priceOracle,
      abi.encodeWithSelector(IAaveOracle.getAssetPrice.selector, asset),
      abi.encode(price)
    );
  }

  struct GsmConfig {
    uint256 sellFee;
    uint256 buyFee;
    uint256 exposureCap;
    bool isFrozen;
    bool isSeized;
    bool freezerCanUnfreeze;
    uint256 freezeLowerBound;
    uint256 freezeUpperBound;
    uint256 unfreezeLowerBound;
    uint256 unfreezeUpperBound;
  }

  function _checkGsmConfig(
    IGsm gsm,
    address underlying,
    IOracleSwapFreezer freezer,
    GsmConfig memory config
  ) internal view {
    assertEq(gsm.UNDERLYING_ASSET(), underlying, 'wrong underlying asset');
    assertEq(gsm.getAvailableUnderlyingExposure(), config.exposureCap, 'wrong exposure cap');
    assertEq(gsm.getIsFrozen(), config.isFrozen, 'wrong freeze state');
    assertEq(gsm.getIsSeized(), config.isSeized, 'wrong seized state');

    // Fee Strategy
    IGsmFeeStrategy feeStrategy = IGsmFeeStrategy(gsm.getFeeStrategy());
    assertEq(feeStrategy.getSellFee(10000), config.sellFee, 'wrong sell fee');
    assertEq(feeStrategy.getBuyFee(10000), config.buyFee, 'wrong buy fee');

    // Price Strategy
    IFixedPriceStrategy4626 priceStrategy = IFixedPriceStrategy4626(gsm.PRICE_STRATEGY());
    assertEq(
      IERC4626(underlying).previewMint(1e6) * 10 ** 12,
      priceStrategy.getAssetPriceInGho(1e6, true)
    );
    assertEq(
      IERC4626(underlying).previewWithdraw(1 ether) / 10 ** 12,
      priceStrategy.getGhoPriceInAsset(1 ether, false)
    );

    assertEq(gsm.getGhoTreasury(), address(AaveV3Plasma.COLLECTOR));

    // Oracle freezer
    assertEq(freezer.getCanUnfreeze(), config.freezerCanUnfreeze, 'wrong freezer config');
    (uint256 lowerBound, uint256 upperBound) = freezer.getFreezeBound();
    assertEq(lowerBound, config.freezeLowerBound, 'wrong freeze lower bound');
    assertEq(upperBound, config.freezeUpperBound, 'wrong freeze upper bound');
    (lowerBound, upperBound) = freezer.getUnfreezeBound();
    assertEq(lowerBound, config.unfreezeLowerBound, 'wrong unfreeze lower bound');
    assertEq(upperBound, config.unfreezeUpperBound, 'wrong unfreeze upper bound');

    assertEq(freezer.ADDRESS_PROVIDER(), address(AaveV3Plasma.POOL_ADDRESSES_PROVIDER));
    assertEq(freezer.GSM(), address(gsm));
  }
}

interface IOracleSwapFreezer {
  function ADDRESS_PROVIDER() external view returns (address);
  function GSM() external view returns (address);
  function getCanUnfreeze() external view returns (bool);
  function getFreezeBound() external view returns (uint128, uint128);
  function getUnfreezeBound() external view returns (uint128, uint128);
  function checkUpkeep(bytes calldata) external view returns (bool, bytes memory);
  function performUpkeep(bytes calldata) external;
}

interface IFixedPriceStrategy4626 {
  function getAssetPriceInGho(uint256 assetAmount, bool roundUp) external view returns (uint256);
  function getGhoPriceInAsset(uint256 ghoAmount, bool roundUp) external view returns (uint256);
}
