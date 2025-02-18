// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGsm} from 'src/interfaces/IGsm.sol';
import {IGsmRegistry} from 'src/interfaces/IGsmRegistry.sol';
import {IAaveCLRobotOperator} from './IAaveCLRobotOperator.sol';

import {AaveV3Ethereum_GSMsMigrationToGSM4626_20250114} from './AaveV3Ethereum_GSMsMigrationToGSM4626_20250114.sol';

/**
 * @dev Test for AaveV3Ethereum_GSMsMigrationToGSM4626_20250114
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250114_AaveV3Ethereum_GSMsMigrationToGSM4626/AaveV3Ethereum_GSMsMigrationToGSM4626_20250114.t.sol -vv
 */
contract AaveV3Ethereum_GSMsMigrationToGSM4626_20250114_Test is ProtocolV3TestBase {
  AaveV3Ethereum_GSMsMigrationToGSM4626_20250114 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21818217);
    proposal = new AaveV3Ethereum_GSMsMigrationToGSM4626_20250114();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_GSMsMigrationToGSM4626_20250114',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_checkConfig() public {
    uint256 facilitatorListLengthBefore = IGhoToken(GhoEthereum.GHO_TOKEN)
      .getFacilitatorsList()
      .length;

    IGhoToken.Facilitator memory oldGsmUsdc = IGhoToken(GhoEthereum.GHO_TOKEN).getFacilitator(
      GhoEthereum.GSM_USDC
    );

    IGhoToken.Facilitator memory oldGsmUsdt = IGhoToken(GhoEthereum.GHO_TOKEN).getFacilitator(
      GhoEthereum.GSM_USDT
    );

    executePayload(vm, address(proposal));

    assertTrue(
      IGhoToken(GhoEthereum.GHO_TOKEN).getFacilitatorsList().length == facilitatorListLengthBefore
    );
    IGhoToken.Facilitator memory gsmUsdc = IGhoToken(GhoEthereum.GHO_TOKEN).getFacilitator(
      proposal.NEW_GSM_USDC()
    );
    assertEq(gsmUsdc.label, proposal.GSM_USDC_NAME());
    assertEq(gsmUsdc.bucketCapacity, proposal.USDC_CAPACITY());
    assertApproxEqAbs(gsmUsdc.bucketLevel, oldGsmUsdc.bucketLevel, 0.0001 ether);

    IGhoToken.Facilitator memory gsmUsdt = IGhoToken(GhoEthereum.GHO_TOKEN).getFacilitator(
      proposal.NEW_GSM_USDT()
    );
    assertEq(gsmUsdt.label, proposal.GSM_USDT_NAME());
    assertEq(gsmUsdt.bucketCapacity, proposal.USDT_CAPACITY());
    assertApproxEqAbs(gsmUsdt.bucketLevel, oldGsmUsdt.bucketLevel, 0.0001 ether);

    // GSM USDC
    GsmConfig memory gsmUsdcConfig = GsmConfig({
      sellFee: 0, // 0%
      buyFee: 0.0020e4, // 0.2%
      exposureCap: 8_000_000e6,
      isFrozen: false,
      isSeized: false,
      freezerCanUnfreeze: true,
      freezeLowerBound: 0.99e8,
      freezeUpperBound: 1.01e8,
      unfreezeLowerBound: 0.995e8,
      unfreezeUpperBound: 1.005e8
    });
    _checkGsmConfig(
      IGsm(proposal.NEW_GSM_USDC()),
      AaveV3EthereumAssets.USDC_STATA_TOKEN,
      IOracleSwapFreezer(proposal.USDC_ORACLE_SWAP_FREEZER()),
      gsmUsdcConfig
    );

    // GSM USDT
    GsmConfig memory gsmUsdtConfig = GsmConfig({
      sellFee: 0, // 0%
      buyFee: 0.0020e4, // 0.2%
      exposureCap: 16_000_000e6,
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
      AaveV3EthereumAssets.USDT_STATA_TOKEN,
      IOracleSwapFreezer(proposal.USDT_ORACLE_SWAP_FREEZER()),
      gsmUsdtConfig
    );
  }

  function test_checkOldGSMsDisabled() public {
    executePayload(vm, address(proposal));

    assertTrue(IGsm(GhoEthereum.GSM_USDC).getIsSeized());
    assertTrue(IGsm(GhoEthereum.GSM_USDT).getIsSeized());

    assertEq(IERC20(GhoEthereum.GHO_TOKEN).balanceOf(GhoEthereum.GSM_USDC), 0);
    assertEq(IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(GhoEthereum.GSM_USDC), 0);

    assertEq(IERC20(GhoEthereum.GHO_TOKEN).balanceOf(GhoEthereum.GSM_USDT), 0);
    assertEq(IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(GhoEthereum.GSM_USDT), 0);

    IGhoToken.Facilitator memory oldGsmUsdc = IGhoToken(GhoEthereum.GHO_TOKEN).getFacilitator(
      GhoEthereum.GSM_USDC
    );

    assertEq(oldGsmUsdc.bucketCapacity, 0);
    assertEq(oldGsmUsdc.bucketLevel, 0);

    IGhoToken.Facilitator memory oldGsmUsdt = IGhoToken(GhoEthereum.GHO_TOKEN).getFacilitator(
      GhoEthereum.GSM_USDT
    );

    assertEq(oldGsmUsdt.bucketCapacity, 0);
    assertEq(oldGsmUsdt.bucketLevel, 0);

    assertEq(IGsm(GhoEthereum.GSM_USDC).getAvailableUnderlyingExposure(), 0, 'wrong exposure cap');
    assertEq(IGsm(GhoEthereum.GSM_USDT).getAvailableUnderlyingExposure(), 0, 'wrong exposure cap');

    assertFalse(
      IGsm(GhoEthereum.GSM_USDC).hasRole(
        proposal.SWAP_FREEZER_ROLE(),
        GhoEthereum.GSM_USDC_ORACLE_SWAP_FREEZER
      )
    );
    assertFalse(
      IGsm(GhoEthereum.GSM_USDT).hasRole(
        proposal.SWAP_FREEZER_ROLE(),
        GhoEthereum.GSM_USDT_ORACLE_SWAP_FREEZER
      )
    );
    assertFalse(
      IGsm(GhoEthereum.GSM_USDC).hasRole(
        proposal.SWAP_FREEZER_ROLE(),
        GovernanceV3Ethereum.EXECUTOR_LVL_1
      )
    );
    assertFalse(
      IGsm(GhoEthereum.GSM_USDT).hasRole(
        proposal.SWAP_FREEZER_ROLE(),
        GovernanceV3Ethereum.EXECUTOR_LVL_1
      )
    );
  }

  function test_oracleSwapFreezers() public {
    // OracleSwapFreezers are not authorized
    assertEq(
      IGsm(proposal.NEW_GSM_USDC()).hasRole(
        IGsm(proposal.NEW_GSM_USDC()).SWAP_FREEZER_ROLE(),
        proposal.USDC_ORACLE_SWAP_FREEZER()
      ),
      false
    );
    assertEq(
      IGsm(proposal.NEW_GSM_USDT()).hasRole(
        IGsm(proposal.NEW_GSM_USDT()).SWAP_FREEZER_ROLE(),
        proposal.USDT_ORACLE_SWAP_FREEZER()
      ),
      false
    );

    IOracleSwapFreezer usdcFreezer = IOracleSwapFreezer(proposal.USDC_ORACLE_SWAP_FREEZER());
    IOracleSwapFreezer usdtFreezer = IOracleSwapFreezer(proposal.USDT_ORACLE_SWAP_FREEZER());
    (uint128 usdcFreezeLowerBound, ) = usdcFreezer.getFreezeBound();
    (uint128 usdcUnfreezeLowerBound, ) = usdcFreezer.getUnfreezeBound();
    (uint128 usdtFreezeLowerBound, ) = usdtFreezer.getFreezeBound();
    (uint128 usdtUnfreezeLowerBound, ) = usdtFreezer.getUnfreezeBound();

    // Price outside the price range
    // Freezers cannot execute freeze without authorization
    _mockAssetPrice(
      address(AaveV3Ethereum.ORACLE),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      usdcFreezeLowerBound - 1
    );
    _mockAssetPrice(
      address(AaveV3Ethereum.ORACLE),
      AaveV3EthereumAssets.USDT_UNDERLYING,
      usdtFreezeLowerBound - 1
    );

    (bool canPerformUpkeep, ) = usdcFreezer.checkUpkeep(bytes(''));
    assertEq(canPerformUpkeep, false);
    usdcFreezer.performUpkeep(bytes(''));
    assertEq(IGsm(proposal.NEW_GSM_USDC()).getIsFrozen(), false);

    (canPerformUpkeep, ) = usdtFreezer.checkUpkeep(bytes(''));
    assertEq(canPerformUpkeep, false);
    usdtFreezer.performUpkeep(bytes(''));
    assertEq(IGsm(proposal.NEW_GSM_USDT()).getIsFrozen(), false);

    // Payload execution
    executePayload(vm, address(proposal));

    // Freezers are authorized now
    assertEq(
      IGsm(proposal.NEW_GSM_USDC()).hasRole(
        IGsm(proposal.NEW_GSM_USDC()).SWAP_FREEZER_ROLE(),
        proposal.USDC_ORACLE_SWAP_FREEZER()
      ),
      true
    );
    assertEq(
      IGsm(proposal.NEW_GSM_USDT()).hasRole(
        IGsm(proposal.NEW_GSM_USDT()).SWAP_FREEZER_ROLE(),
        proposal.USDT_ORACLE_SWAP_FREEZER()
      ),
      true
    );

    // Freezers freeze GSM contracts
    (canPerformUpkeep, ) = usdcFreezer.checkUpkeep(bytes(''));
    assertEq(canPerformUpkeep, true);
    usdcFreezer.performUpkeep(bytes(''));
    assertEq(IGsm(proposal.NEW_GSM_USDC()).getIsFrozen(), true);

    (canPerformUpkeep, ) = usdtFreezer.checkUpkeep(bytes(''));
    assertEq(canPerformUpkeep, true);
    usdtFreezer.performUpkeep(bytes(''));
    assertEq(IGsm(proposal.NEW_GSM_USDT()).getIsFrozen(), true);

    // Price back to normal
    _mockAssetPrice(
      address(AaveV3Ethereum.ORACLE),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      usdcUnfreezeLowerBound + 1
    );
    _mockAssetPrice(
      address(AaveV3Ethereum.ORACLE),
      AaveV3EthereumAssets.USDT_UNDERLYING,
      usdtUnfreezeLowerBound + 1
    );

    (canPerformUpkeep, ) = usdcFreezer.checkUpkeep(bytes(''));
    assertEq(canPerformUpkeep, true);
    usdcFreezer.performUpkeep(bytes(''));
    assertEq(IGsm(proposal.NEW_GSM_USDC()).getIsFrozen(), false);

    (canPerformUpkeep, ) = usdtFreezer.checkUpkeep(bytes(''));
    assertEq(canPerformUpkeep, true);
    usdtFreezer.performUpkeep(bytes(''));
    assertEq(IGsm(proposal.NEW_GSM_USDT()).getIsFrozen(), false);
  }

  function test_checkRoles() public {
    executePayload(vm, address(proposal));

    _checkRolesConfig(IGsm(proposal.NEW_GSM_USDC()));
    _checkRolesConfig(IGsm(proposal.NEW_GSM_USDT()));
  }

  function test_gsmIsOperational() public {
    executePayload(vm, address(proposal));

    deal(AaveV3EthereumAssets.USDC_UNDERLYING, address(this), 1_000e6);
    deal(AaveV3EthereumAssets.USDT_UNDERLYING, address(this), 1_000e6);
    deal(AaveV3EthereumAssets.USDC_STATA_TOKEN, address(this), 1_000e6);
    deal(AaveV3EthereumAssets.USDT_STATA_TOKEN, address(this), 1_000e6);

    // Old GSMs are seized
    vm.expectRevert(bytes('GSM_SEIZED'));
    IGsm(GhoEthereum.GSM_USDC).buyAsset(1000e6, address(this));
    vm.expectRevert(bytes('GSM_SEIZED'));
    IGsm(GhoEthereum.GSM_USDT).buyAsset(1000e6, address(this));
    vm.expectRevert(bytes('GSM_SEIZED'));
    IGsm(GhoEthereum.GSM_USDC).sellAsset(1000e6, address(this));
    vm.expectRevert(bytes('GSM_SEIZED'));
    IGsm(GhoEthereum.GSM_USDT).sellAsset(1000e6, address(this));

    // New GSMs are operational
    IERC20(AaveV3EthereumAssets.USDC_STATA_TOKEN).approve(proposal.NEW_GSM_USDC(), 1_000e6);
    IERC20(AaveV3EthereumAssets.USDT_STATA_TOKEN).approve(proposal.NEW_GSM_USDT(), 1_000e6);
    IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).approve(proposal.NEW_GSM_USDC(), 1_200 ether);
    IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).approve(proposal.NEW_GSM_USDT(), 1_200 ether);

    IGsm(proposal.NEW_GSM_USDC()).sellAsset(1_000e6, address(this));
    IGsm(proposal.NEW_GSM_USDT()).sellAsset(1_000e6, address(this));

    IGsm(proposal.NEW_GSM_USDC()).buyAsset(500e6, address(this));
    IGsm(proposal.NEW_GSM_USDT()).buyAsset(500e6, address(this));
  }

  function _checkRolesConfig(IGsm gsm) internal view {
    // DAO permissions
    assertTrue(
      gsm.hasRole(bytes32(0), GovernanceV3Ethereum.EXECUTOR_LVL_1),
      'Executor is not admin'
    );
    assertTrue(
      gsm.hasRole(gsm.SWAP_FREEZER_ROLE(), GovernanceV3Ethereum.EXECUTOR_LVL_1),
      'Executor is not swap freezer'
    );
    assertTrue(
      gsm.hasRole(gsm.CONFIGURATOR_ROLE(), GovernanceV3Ethereum.EXECUTOR_LVL_1),
      'Executor is not configurator'
    );
    // No need to be liquidator or token rescuer at the beginning
    assertFalse(gsm.hasRole(gsm.LIQUIDATOR_ROLE(), GovernanceV3Ethereum.EXECUTOR_LVL_1));
    assertFalse(gsm.hasRole(gsm.TOKEN_RESCUER_ROLE(), GovernanceV3Ethereum.EXECUTOR_LVL_1));

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
  }

  function _mockAssetPrice(address priceOracle, address asset, uint256 price) internal {
    vm.mockCall(
      priceOracle,
      abi.encodeWithSelector(IPriceOracle.getAssetPrice.selector, asset),
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
    assertLt(gsm.getAvailableUnderlyingExposure(), config.exposureCap, 'wrong exposure cap');
    assertEq(gsm.getIsFrozen(), config.isFrozen, 'wrong freeze state');
    assertEq(gsm.getIsSeized(), config.isSeized, 'wrong seized state');

    // Fee Strategy
    IFeeStrategy feeStrategy = IFeeStrategy(gsm.getFeeStrategy());
    assertEq(feeStrategy.getSellFee(10000), config.sellFee, 'wrong sell fee');
    assertEq(feeStrategy.getBuyFee(10000), config.buyFee, 'wrong buy fee');

    // Price Strategy
    IFixedPriceStrategy4626 priceStrategy = IFixedPriceStrategy4626(gsm.PRICE_STRATEGY());
    assertApproxEqAbs(priceStrategy.getAssetPriceInGho(1e6, true), 1 ether, 0.15 ether);
    assertApproxEqAbs(priceStrategy.getGhoPriceInAsset(1 ether, true), 1e6, 0.15e6);

    assertEq(gsm.getGhoTreasury(), address(AaveV3Ethereum.COLLECTOR));

    // Oracle freezer
    assertEq(freezer.getCanUnfreeze(), config.freezerCanUnfreeze, 'wrong freezer config');
    (uint256 lowerBound, uint256 upperBound) = freezer.getFreezeBound();
    assertEq(lowerBound, config.freezeLowerBound, 'wrong freeze lower bound');
    assertEq(upperBound, config.freezeUpperBound, 'wrong freeze upper bound');
    (lowerBound, upperBound) = freezer.getUnfreezeBound();
    assertEq(lowerBound, config.unfreezeLowerBound, 'wrong unfreeze lower bound');
    assertEq(upperBound, config.unfreezeUpperBound, 'wrong unfreeze upper bound');
  }
}

interface IFeeStrategy {
  function getBuyFee(uint256 grossAmount) external view returns (uint256);
  function getSellFee(uint256 grossAmount) external view returns (uint256);
}

interface IOracleSwapFreezer {
  function getCanUnfreeze() external view returns (bool);
  function getFreezeBound() external view returns (uint128, uint128);
  function getUnfreezeBound() external view returns (uint128, uint128);
  function checkUpkeep(bytes calldata) external view returns (bool, bytes memory);
  function performUpkeep(bytes calldata) external;
}

interface IPriceOracle {
  function getAssetPrice(address asset) external view returns (uint256);
}

interface IFixedPriceStrategy4626 {
  function getAssetPriceInGho(uint256 assetAmount, bool roundUp) external view returns (uint256);
  function getGhoPriceInAsset(uint256 ghoAmount, bool roundUp) external view returns (uint256);
}
