// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Monad} from 'aave-address-book/AaveV3Monad.sol';
import {GovernanceV3Monad} from 'aave-address-book/GovernanceV3Monad.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IERC20Metadata} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';
import {Errors} from 'aave-v3-origin/contracts/protocol/libraries/helpers/Errors.sol';
import {IPriceCapAdapter} from 'src/interfaces/IPriceCapAdapter.sol';
import {IPriceCapAdapterStable} from 'src/interfaces/IPriceCapAdapterStable.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Monad_AaveV3MonadActivation_20260623} from './AaveV3Monad_AaveV3MonadActivation_20260623.sol';

/// @dev Minimal surface to walk a listed price adapter down to the underlying Chainlink SVR feed.
/// Each adapter type exposes exactly one of these getters: correlated CAPO adapters expose
/// `BASE_TO_USD_AGGREGATOR`, stable cap adapters expose `ASSET_TO_USD_AGGREGATOR`, and the
/// USD-scaling conversion adapter that wraps the SVR feed exposes `source`.
interface IPriceFeed {
  function decimals() external view returns (uint8);
  function source() external view returns (address);
  function BASE_TO_USD_AGGREGATOR() external view returns (address);
  function ASSET_TO_USD_AGGREGATOR() external view returns (address);
}

/**
 * @dev Test for AaveV3Monad_AaveV3MonadActivation_20260623
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260623_AaveV3Monad_AaveV3MonadActivation/AaveV3Monad_AaveV3MonadActivation_20260623.t.sol -vv
 */
contract AaveV3Monad_AaveV3MonadActivation_20260623_Test is ProtocolV3TestBase {
  AaveV3Monad_AaveV3MonadActivation_20260623 internal proposal;

  // CAPO parameters recommended by LlamaRisk
  // https://governance.aave.com/t/arfc-deploy-aave-protocol-on-monad/24943
  uint256 internal constant CAPO_SNAPSHOT_DELAY = 7 days;
  // max yearly ratio growth (bps); deployed adapters must match these exactly
  uint256 internal constant SUSDE_MAX_GROWTH = 11_17;
  uint256 internal constant WSTETH_MAX_GROWTH = 10_70;
  uint256 internal constant WEETH_MAX_GROWTH = 9_53;
  uint256 internal constant SYRUPUSDC_MAX_GROWTH = 8_05;
  // stablecoin upward price-cap bound: $1.04 (8 decimals)
  int256 internal constant STABLE_PRICE_CAP = 1.04e8;

  // Chainlink SVR (Smart Value Recapture) feeds wrapped by the listed price adapters.
  // Several assets are priced off the same base feed, so the SVR feeds are reused across listings.
  address internal constant ETH_USD_SVR_FEED = 0xcE6538287B42D833f294662edad8B3dA070C6902;
  address internal constant CBBTC_USD_SVR_FEED = 0x1AF85c71aa71cA1138308012400cc0D784A88e8A;
  address internal constant USDC_USD_SVR_FEED = 0x6789f81a983AfE7bd4C2a557c27084Ab705e56AB;
  address internal constant USDT0_USD_SVR_FEED = 0xaAF8D304F82e386f7c777bd61724B8015B087d1d;
  address internal constant AUSD_USD_SVR_FEED = 0xEd21588eA25ADC77384d47A466F0F75EEa58eBf3;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('monad'), 83865577);
    proposal = new AaveV3Monad_AaveV3MonadActivation_20260623();
    // temporary: seed the executor so _postExecute() can supply to the DUST_BIN
    deal(proposal.USDT0(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.USDT0_SEED_AMOUNT());
    deal(proposal.USDC(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.USDC_SEED_AMOUNT());
    deal(proposal.USDe(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.USDe_SEED_AMOUNT());
    deal(proposal.mUSD(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.mUSD_SEED_AMOUNT());
    deal(proposal.AUSD(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.AUSD_SEED_AMOUNT());
    deal(proposal.WETH(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.WETH_SEED_AMOUNT());
    deal(proposal.cbBTC(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.cbBTC_SEED_AMOUNT());
    deal(proposal.wstETH(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.wstETH_SEED_AMOUNT());
    deal(proposal.weETH(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.weETH_SEED_AMOUNT());
    deal(proposal.syrupUSDC(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.syrupUSDC_SEED_AMOUNT());
    deal(proposal.sUSDe(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.sUSDe_SEED_AMOUNT());
  }

  /**
   * @dev AUSD uses namespaced storage that forge-std `deal` cannot write; the generic e2e funds
   * test users via `deal`, so route AUSD through an on-chain holder instead.
   */
  function deal(address token, address to, uint256 give) internal override {
    if (token == proposal.AUSD()) {
      vm.prank(0xD5D960E8C380B724a48AC59E2DfF1b2CB4a1eAee);
      IERC20(token).transfer(to, give);
      return;
    }
    super.deal(token, to, give);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Monad_AaveV3MonadActivation_20260623', AaveV3Monad.POOL, address(proposal));
  }

  function test_dustBinHasUSDT0Funds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.USDT0());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)),
      proposal.USDT0_SEED_AMOUNT()
    );
  }

  function test_dustBinHasUSDCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.USDC());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)),
      proposal.USDC_SEED_AMOUNT()
    );
  }

  function test_dustBinHasUSDeFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.USDe());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)),
      proposal.USDe_SEED_AMOUNT()
    );
  }

  function test_dustBinHasmUSDFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.mUSD());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)),
      proposal.mUSD_SEED_AMOUNT()
    );
  }

  function test_dustBinHasAUSDFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.AUSD());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)),
      proposal.AUSD_SEED_AMOUNT()
    );
  }

  function test_dustBinHasWETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.WETH());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)),
      proposal.WETH_SEED_AMOUNT()
    );
  }

  function test_dustBinHascbBTCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.cbBTC());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)),
      proposal.cbBTC_SEED_AMOUNT()
    );
  }

  function test_dustBinHaswstETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.wstETH());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)),
      proposal.wstETH_SEED_AMOUNT()
    );
  }

  function test_dustBinHasweETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.weETH());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)),
      proposal.weETH_SEED_AMOUNT()
    );
  }

  function test_dustBinHassyrupUSDCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.syrupUSDC());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)),
      proposal.syrupUSDC_SEED_AMOUNT()
    );
  }

  function test_dustBinHassUSDeFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.sUSDe());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)),
      proposal.sUSDe_SEED_AMOUNT()
    );
  }

  function test_eModeConfiguration() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    uint8 eMode_syrupUSDC__Stablecoins = _findEModeCategoryId('syrupUSDC__Stablecoins');
    _assertEModeCollateralConfig({
      id: eMode_syrupUSDC__Stablecoins,
      ltv: 90_00,
      liquidationThreshold: 92_00,
      liquidationBonus: 100_00 + 4_00,
      isolated: false
    });

    address[] memory collaterals_syrupUSDC__Stablecoins = new address[](1);
    collaterals_syrupUSDC__Stablecoins[0] = proposal.syrupUSDC();
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryCollateralBitmap(eMode_syrupUSDC__Stablecoins),
      _toBitmap(collaterals_syrupUSDC__Stablecoins)
    );

    address[] memory borrowables_syrupUSDC__Stablecoins = new address[](4);
    borrowables_syrupUSDC__Stablecoins[0] = proposal.USDT0();
    borrowables_syrupUSDC__Stablecoins[1] = proposal.USDC();
    borrowables_syrupUSDC__Stablecoins[2] = proposal.mUSD();
    borrowables_syrupUSDC__Stablecoins[3] = proposal.AUSD();
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryBorrowableBitmap(eMode_syrupUSDC__Stablecoins),
      _toBitmap(borrowables_syrupUSDC__Stablecoins)
    );

    uint8 eMode_USDe_sUSDe__Stablecoins = _findEModeCategoryId('USDe_sUSDe__Stablecoins');
    _assertEModeCollateralConfig({
      id: eMode_USDe_sUSDe__Stablecoins,
      ltv: 90_00,
      liquidationThreshold: 92_00,
      liquidationBonus: 100_00 + 4_00,
      isolated: false
    });

    address[] memory collaterals_USDe_sUSDe__Stablecoins = new address[](2);
    collaterals_USDe_sUSDe__Stablecoins[0] = proposal.USDe();
    collaterals_USDe_sUSDe__Stablecoins[1] = proposal.sUSDe();
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryCollateralBitmap(eMode_USDe_sUSDe__Stablecoins),
      _toBitmap(collaterals_USDe_sUSDe__Stablecoins)
    );

    address[] memory borrowables_USDe_sUSDe__Stablecoins = new address[](3);
    borrowables_USDe_sUSDe__Stablecoins[0] = proposal.USDT0();
    borrowables_USDe_sUSDe__Stablecoins[1] = proposal.USDC();
    borrowables_USDe_sUSDe__Stablecoins[2] = proposal.AUSD();
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryBorrowableBitmap(eMode_USDe_sUSDe__Stablecoins),
      _toBitmap(borrowables_USDe_sUSDe__Stablecoins)
    );

    uint8 eMode_wstETH__WETH = _findEModeCategoryId('wstETH__WETH');
    _assertEModeCollateralConfig({
      id: eMode_wstETH__WETH,
      ltv: 94_00,
      liquidationThreshold: 96_00,
      liquidationBonus: 100_00 + 1_00,
      isolated: true
    });

    address[] memory collaterals_wstETH__WETH = new address[](1);
    collaterals_wstETH__WETH[0] = proposal.wstETH();
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryCollateralBitmap(eMode_wstETH__WETH),
      _toBitmap(collaterals_wstETH__WETH)
    );

    address[] memory borrowables_wstETH__WETH = new address[](1);
    borrowables_wstETH__WETH[0] = proposal.WETH();
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryBorrowableBitmap(eMode_wstETH__WETH),
      _toBitmap(borrowables_wstETH__WETH)
    );

    uint8 eMode_weETH__WETH = _findEModeCategoryId('weETH__WETH');
    _assertEModeCollateralConfig({
      id: eMode_weETH__WETH,
      ltv: 93_00,
      liquidationThreshold: 95_00,
      liquidationBonus: 100_00 + 1_00,
      isolated: true
    });

    address[] memory collaterals_weETH__WETH = new address[](1);
    collaterals_weETH__WETH[0] = proposal.weETH();
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryCollateralBitmap(eMode_weETH__WETH),
      _toBitmap(collaterals_weETH__WETH)
    );

    address[] memory borrowables_weETH__WETH = new address[](1);
    borrowables_weETH__WETH[0] = proposal.WETH();
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryBorrowableBitmap(eMode_weETH__WETH),
      _toBitmap(borrowables_weETH__WETH)
    );
  }

  function test_eMode_syrupUSDC__Stablecoins_supplyAndBorrow() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _supplyAndBorrowInEMode('syrupUSDC__Stablecoins', proposal.syrupUSDC(), proposal.USDT0());
  }

  function test_eMode_USDe_sUSDe__Stablecoins_supplyAndBorrow() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _supplyAndBorrowInEMode('USDe_sUSDe__Stablecoins', proposal.USDe(), proposal.USDT0());
  }

  function test_eMode_wstETH__WETH_supplyAndBorrow() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _supplyAndBorrowInEMode('wstETH__WETH', proposal.wstETH(), proposal.WETH());
  }

  function test_eMode_weETH__WETH_supplyAndBorrow() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _supplyAndBorrowInEMode('weETH__WETH', proposal.weETH(), proposal.WETH());
  }

  function test_USDeBorrowWithoutEModeReverts() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = makeAddr('borrowWithoutEModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(proposal.USDe()).decimals();
    deal(proposal.USDe(), user, supplyAmount);

    vm.startPrank(user);

    IERC20(proposal.USDe()).approve(address(AaveV3Monad.POOL), supplyAmount);
    AaveV3Monad.POOL.supply(proposal.USDe(), supplyAmount, user, 0);

    // LTV is 0 outside the e-mode, so the borrow must revert
    address borrowAsset = proposal.USDT0();
    vm.expectRevert(abi.encodeWithSelector(Errors.LtvValidationFailed.selector));
    AaveV3Monad.POOL.borrow(borrowAsset, 1, 2, 0, user);

    vm.stopPrank();
  }

  function test_wstETHBorrowWithoutEModeReverts() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = makeAddr('borrowWithoutEModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(proposal.wstETH()).decimals();
    deal(proposal.wstETH(), user, supplyAmount);

    vm.startPrank(user);

    IERC20(proposal.wstETH()).approve(address(AaveV3Monad.POOL), supplyAmount);
    AaveV3Monad.POOL.supply(proposal.wstETH(), supplyAmount, user, 0);

    // LTV is 0 outside the e-mode, so the borrow must revert.
    // Borrow USDT0 (globally borrowable); WETH is borrow-disabled outside the e-modes.
    address borrowAsset = proposal.USDT0();
    vm.expectRevert(abi.encodeWithSelector(Errors.LtvValidationFailed.selector));
    AaveV3Monad.POOL.borrow(borrowAsset, 1, 2, 0, user);

    vm.stopPrank();
  }

  function test_weETHBorrowWithoutEModeReverts() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = makeAddr('borrowWithoutEModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(proposal.weETH()).decimals();
    deal(proposal.weETH(), user, supplyAmount);

    vm.startPrank(user);

    IERC20(proposal.weETH()).approve(address(AaveV3Monad.POOL), supplyAmount);
    AaveV3Monad.POOL.supply(proposal.weETH(), supplyAmount, user, 0);

    // LTV is 0 outside the e-mode, so the borrow must revert.
    // Borrow USDT0 (globally borrowable); WETH is borrow-disabled outside the e-modes.
    address borrowAsset = proposal.USDT0();
    vm.expectRevert(abi.encodeWithSelector(Errors.LtvValidationFailed.selector));
    AaveV3Monad.POOL.borrow(borrowAsset, 1, 2, 0, user);

    vm.stopPrank();
  }

  function test_syrupUSDCBorrowWithoutEModeReverts() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = makeAddr('borrowWithoutEModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(proposal.syrupUSDC()).decimals();
    deal(proposal.syrupUSDC(), user, supplyAmount);

    vm.startPrank(user);

    IERC20(proposal.syrupUSDC()).approve(address(AaveV3Monad.POOL), supplyAmount);
    AaveV3Monad.POOL.supply(proposal.syrupUSDC(), supplyAmount, user, 0);

    // LTV is 0 outside the e-mode, so the borrow must revert
    address borrowAsset = proposal.USDT0();
    vm.expectRevert(abi.encodeWithSelector(Errors.LtvValidationFailed.selector));
    AaveV3Monad.POOL.borrow(borrowAsset, 1, 2, 0, user);

    vm.stopPrank();
  }

  function test_sUSDeBorrowWithoutEModeReverts() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = makeAddr('borrowWithoutEModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(proposal.sUSDe()).decimals();
    deal(proposal.sUSDe(), user, supplyAmount);

    vm.startPrank(user);

    IERC20(proposal.sUSDe()).approve(address(AaveV3Monad.POOL), supplyAmount);
    AaveV3Monad.POOL.supply(proposal.sUSDe(), supplyAmount, user, 0);

    // LTV is 0 outside the e-mode, so the borrow must revert
    address borrowAsset = proposal.USDT0();
    vm.expectRevert(abi.encodeWithSelector(Errors.LtvValidationFailed.selector));
    AaveV3Monad.POOL.borrow(borrowAsset, 1, 2, 0, user);

    vm.stopPrank();
  }

  function test_capoCorrelatedAdaptersMatchLlamaRisk() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    _assertCapoAdapter(proposal.sUSDe(), proposal.sUSDe_PRICE_FEED(), SUSDE_MAX_GROWTH);
    _assertCapoAdapter(proposal.wstETH(), proposal.wstETH_PRICE_FEED(), WSTETH_MAX_GROWTH);
    _assertCapoAdapter(proposal.weETH(), proposal.weETH_PRICE_FEED(), WEETH_MAX_GROWTH);
    _assertCapoAdapter(proposal.syrupUSDC(), proposal.syrupUSDC_PRICE_FEED(), SYRUPUSDC_MAX_GROWTH);
  }

  function test_capoStableAdaptersMatchLlamaRisk() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    _assertStablePriceCap(proposal.USDT0(), proposal.USDT0_PRICE_FEED());
    _assertStablePriceCap(proposal.USDC(), proposal.USDC_PRICE_FEED());
    _assertStablePriceCap(proposal.USDe(), proposal.USDe_PRICE_FEED());
    _assertStablePriceCap(proposal.AUSD(), proposal.AUSD_PRICE_FEED());
  }

  function test_priceFeedsMatchProposal() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    _assertOracleSource(proposal.USDT0(), proposal.USDT0_PRICE_FEED());
    _assertOracleSource(proposal.USDC(), proposal.USDC_PRICE_FEED());
    _assertOracleSource(proposal.USDe(), proposal.USDe_PRICE_FEED());
    _assertOracleSource(proposal.mUSD(), proposal.mUSD_PRICE_FEED());
    _assertOracleSource(proposal.AUSD(), proposal.AUSD_PRICE_FEED());
    _assertOracleSource(proposal.WETH(), proposal.WETH_PRICE_FEED());
    _assertOracleSource(proposal.cbBTC(), proposal.cbBTC_PRICE_FEED());
    _assertOracleSource(proposal.wstETH(), proposal.wstETH_PRICE_FEED());
    _assertOracleSource(proposal.weETH(), proposal.weETH_PRICE_FEED());
    _assertOracleSource(proposal.syrupUSDC(), proposal.syrupUSDC_PRICE_FEED());
    _assertOracleSource(proposal.sUSDe(), proposal.sUSDe_PRICE_FEED());
  }

  function test_priceAdaptersWrapExpectedSvrFeeds() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    // stable cap adapters
    _assertSvrFeed(proposal.USDT0(), USDT0_USD_SVR_FEED);
    _assertSvrFeed(proposal.USDC(), USDC_USD_SVR_FEED);
    _assertSvrFeed(proposal.USDe(), USDT0_USD_SVR_FEED);
    _assertSvrFeed(proposal.AUSD(), AUSD_USD_SVR_FEED);

    // USD-scaling conversion adapters over the asset feed
    _assertSvrFeed(proposal.WETH(), ETH_USD_SVR_FEED);
    _assertSvrFeed(proposal.cbBTC(), CBBTC_USD_SVR_FEED);

    // correlated CAPO adapters priced off the base asset's feed
    _assertSvrFeed(proposal.wstETH(), ETH_USD_SVR_FEED);
    _assertSvrFeed(proposal.weETH(), ETH_USD_SVR_FEED);
    _assertSvrFeed(proposal.syrupUSDC(), USDC_USD_SVR_FEED);
    _assertSvrFeed(proposal.sUSDe(), USDT0_USD_SVR_FEED);
  }

  function test_riskStewardRiskAdmin() public {
    assertFalse(AaveV3Monad.ACL_MANAGER.isRiskAdmin(proposal.RISK_STEWARD()));
    GovV3Helpers.executePayload(vm, address(proposal));
    assertTrue(AaveV3Monad.ACL_MANAGER.isRiskAdmin(proposal.RISK_STEWARD()));
  }

  function _assertCapoAdapter(
    address asset,
    address expectedFeed,
    uint256 forumMaxGrowth
  ) internal view {
    assertEq(
      AaveV3Monad.ORACLE.getSourceOfAsset(asset),
      expectedFeed,
      'oracle source != listed price feed'
    );

    IPriceCapAdapter adapter = IPriceCapAdapter(expectedFeed);
    assertEq(
      uint256(adapter.MINIMUM_SNAPSHOT_DELAY()),
      CAPO_SNAPSHOT_DELAY,
      'snapshot delay != 7 days'
    );

    assertEq(
      adapter.getMaxYearlyGrowthRatePercent(),
      forumMaxGrowth,
      'max yearly growth != LlamaRisk recommendation'
    );
  }

  function _assertStablePriceCap(address asset, address expectedFeed) internal view {
    assertEq(
      AaveV3Monad.ORACLE.getSourceOfAsset(asset),
      expectedFeed,
      'oracle source != listed price feed'
    );
    assertEq(
      IPriceCapAdapterStable(expectedFeed).getPriceCap(),
      STABLE_PRICE_CAP,
      'stable cap != $1.04'
    );
  }

  function _assertOracleSource(address asset, address expectedFeed) internal view {
    assertEq(
      AaveV3Monad.ORACLE.getSourceOfAsset(asset),
      expectedFeed,
      'oracle source != listed price feed'
    );
  }

  function _assertSvrFeed(address asset, address expectedSvrFeed) internal view {
    address svrFeed = _resolveSvrFeed(AaveV3Monad.ORACLE.getSourceOfAsset(asset));
    assertEq(svrFeed, expectedSvrFeed, 'price adapter wraps unexpected SVR feed');
    assertEq(IPriceFeed(svrFeed).decimals(), 18, 'SVR feed is not 18 decimals');
  }

  /// @dev Unwraps a listed price adapter to the Chainlink SVR feed it ultimately reads from.
  /// Cap adapters point to their base via BASE_TO_USD_AGGREGATOR/ASSET_TO_USD_AGGREGATOR; the
  /// SVR feed is reached once the recursion hits the USD-scaling conversion adapter (source()).
  function _resolveSvrFeed(address feed) internal view returns (address) {
    try IPriceFeed(feed).BASE_TO_USD_AGGREGATOR() returns (address base) {
      return _resolveSvrFeed(base);
    } catch {}
    try IPriceFeed(feed).ASSET_TO_USD_AGGREGATOR() returns (address base) {
      return _resolveSvrFeed(base);
    } catch {}
    return IPriceFeed(feed).source();
  }

  function _findEModeCategoryId(string memory label) internal view returns (uint8) {
    for (uint8 i = 1; i < 255; i++) {
      if (keccak256(bytes(AaveV3Monad.POOL.getEModeCategoryLabel(i))) == keccak256(bytes(label))) {
        return i;
      }
    }
    revert('eMode category not found');
  }

  function _assertEModeCollateralConfig(
    uint8 id,
    uint256 ltv,
    uint256 liquidationThreshold,
    uint256 liquidationBonus,
    bool isolated
  ) internal view {
    DataTypes.CollateralConfig memory cfg = AaveV3Monad.POOL.getEModeCategoryCollateralConfig(id);
    assertEq(cfg.ltv, ltv);
    assertEq(cfg.liquidationThreshold, liquidationThreshold);
    assertEq(cfg.liquidationBonus, liquidationBonus);
    assertEq(AaveV3Monad.POOL.getIsEModeCategoryIsolated(id), isolated);
  }

  function _toBitmap(address[] memory assets) internal view returns (uint128 bitmap) {
    for (uint256 i = 0; i < assets.length; i++) {
      bitmap |= uint128(1) << AaveV3Monad.POOL.getReserveData(assets[i]).id;
    }
  }

  function _supplyAndBorrowInEMode(
    string memory label,
    address collateral,
    address borrowAsset
  ) internal {
    uint8 eModeId = _findEModeCategoryId(label);

    // seed the pool with borrowable liquidity so the e-mode borrow can be filled
    address liquidityProvider = makeAddr('liquidityProvider');
    uint256 liquidityAmount = 1_000 * 10 ** IERC20Metadata(borrowAsset).decimals();
    deal(borrowAsset, liquidityProvider, liquidityAmount);
    vm.startPrank(liquidityProvider);
    IERC20(borrowAsset).approve(address(AaveV3Monad.POOL), liquidityAmount);
    AaveV3Monad.POOL.supply(borrowAsset, liquidityAmount, liquidityProvider, 0);
    vm.stopPrank();

    address user = makeAddr('eModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(collateral).decimals();
    deal(collateral, user, supplyAmount);

    vm.startPrank(user);

    AaveV3Monad.POOL.setUserEMode(eModeId);

    IERC20(collateral).approve(address(AaveV3Monad.POOL), supplyAmount);
    AaveV3Monad.POOL.supply(collateral, supplyAmount, user, 0);

    uint256 borrowAmount = 10 * 10 ** IERC20Metadata(borrowAsset).decimals();
    AaveV3Monad.POOL.borrow(borrowAsset, borrowAmount, 2, 0, user);

    address vToken = AaveV3Monad.POOL.getReserveVariableDebtToken(borrowAsset);
    assertApproxEqAbs(IERC20(vToken).balanceOf(user), borrowAmount, 1);

    IERC20(borrowAsset).approve(address(AaveV3Monad.POOL), borrowAmount);
    AaveV3Monad.POOL.repay(borrowAsset, borrowAmount, 2, user);
    AaveV3Monad.POOL.withdraw(collateral, supplyAmount / 2, user);

    vm.stopPrank();
  }
}
