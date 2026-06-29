// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3MegaEth, AaveV3MegaEthAssets} from 'aave-address-book/AaveV3MegaEth.sol';
import {GovernanceV3MegaEth} from 'aave-address-book/GovernanceV3MegaEth.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IERC20Metadata} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';
import {Errors} from 'aave-v3-origin/contracts/protocol/libraries/helpers/Errors.sol';

import {AggregatorInterface} from 'aave-v3-origin/contracts/dependencies/chainlink/AggregatorInterface.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IPriceCapAdapter} from '../interfaces/IPriceCapAdapter.sol';
import {AaveV3MegaEth_OnboardStcUSDMegaEth_20260624} from './AaveV3MegaEth_OnboardStcUSDMegaEth_20260624.sol';

/**
 * @dev Test for AaveV3MegaEth_OnboardStcUSDMegaEth_20260624
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260624_AaveV3MegaEth_OnboardStcUSDMegaEth/AaveV3MegaEth_OnboardStcUSDMegaEth_20260624.t.sol -vv
 */
contract AaveV3MegaEth_OnboardStcUSDMegaEth_20260624_Test is ProtocolV3TestBase {
  address internal constant USDC_CAPO_BASE_FEED = 0x9182ACce3C6456955877c0BBE56107bC7239FE07;
  address internal constant stcUSD_cUSD_RATIO_FEED = 0x7055a15452B19D193fbA6ec2FF6bf7B515cf577d;
  uint256 internal constant stcUSD_SNAPSHOT_BLOCK = 16943306;

  AaveV3MegaEth_OnboardStcUSDMegaEth_20260624 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('megaeth'), 19948900);
    proposal = new AaveV3MegaEth_OnboardStcUSDMegaEth_20260624();

    // Seed the executor with stcUSD until it is funded on-chain, so _postExecute can supply the seed amount
    deal(proposal.stcUSD(), GovernanceV3MegaEth.EXECUTOR_LVL_1, proposal.stcUSD_SEED_AMOUNT());
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3MegaEth_OnboardStcUSDMegaEth_20260624',
      AaveV3MegaEth.POOL,
      address(proposal)
    );
  }

  function test_stcUSDPriceFeedMatchesLlamaRiskConfig() public view {
    IPriceCapAdapter capo = IPriceCapAdapter(proposal.stcUSD_PRICE_FEED());

    assertEq(capo.MINIMUM_SNAPSHOT_DELAY(), 14 days, 'wrong snapshot delay');
    assertEq(capo.getMaxYearlyGrowthRatePercent(), 10_50, 'wrong max growth');
    assertEq(capo.decimals(), 8, 'wrong decimals');
    assertEq(capo.description(), 'Capped stcUSD / USDC / USD', 'wrong description');

    AggregatorInterface baseFeed = capo.BASE_TO_USD_AGGREGATOR();
    assertEq(address(baseFeed), USDC_CAPO_BASE_FEED, 'wrong base feed');
    assertEq(baseFeed.description(), 'Capped USDC/USD', 'wrong base feed description');
    assertEq(baseFeed.decimals(), 8, 'wrong base feed decimals');

    address ratioFeed = capo.RATIO_PROVIDER();
    assertEq(ratioFeed, stcUSD_cUSD_RATIO_FEED, 'wrong ratio feed');
    assertEq(
      AggregatorInterface(ratioFeed).description(),
      'STCAPUSD / CAPUSD Exchange Rate',
      'wrong ratio feed description'
    );

    assertFalse(capo.isCapped(), 'should not be capped');
    int256 price = capo.latestAnswer();
    assertGt(price, 0.98e8, 'price too low');
    assertLt(price, 1.15e8, 'price too high');
  }

  function test_stcUSDCapoSnapshotAnchored() public {
    IPriceCapAdapter capo = IPriceCapAdapter(proposal.stcUSD_PRICE_FEED());
    uint256 snapshotRatio = capo.getSnapshotRatio();
    uint256 snapshotTimestamp = capo.getSnapshotTimestamp();
    address ratioFeed = capo.RATIO_PROVIDER();

    // the adapter has no code at its snapshot block, so the embedded snapshot is verified against
    // the underlying ratio provider feed, which existed at that time
    vm.createSelectFork(vm.rpcUrl('megaeth'), stcUSD_SNAPSHOT_BLOCK);
    assertEq(block.timestamp, snapshotTimestamp, 'wrong snapshot block');
    assertEq(
      uint256(AggregatorInterface(ratioFeed).latestAnswer()),
      snapshotRatio,
      'snapshot mismatch'
    );
  }

  function test_stcUSDOraclePriceReflectsCapo() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    assertEq(
      AaveV3MegaEth.ORACLE.getSourceOfAsset(proposal.stcUSD()),
      proposal.stcUSD_PRICE_FEED(),
      'wrong oracle source'
    );
    assertEq(
      AaveV3MegaEth.ORACLE.getAssetPrice(proposal.stcUSD()),
      uint256(IPriceCapAdapter(proposal.stcUSD_PRICE_FEED()).latestAnswer()),
      'oracle price mismatch'
    );
  }

  function test_dustBinHasstcUSDFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3MegaEth.POOL.getReserveAToken(proposal.stcUSD());
    assertApproxEqAbs(
      IERC20(aTokenAddress).balanceOf(address(AaveV3MegaEth.DUST_BIN)),
      proposal.stcUSD_SEED_AMOUNT(),
      1
    );
  }

  function test_eModeConfiguration() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    uint8 eMode_StcUSD__Stablecoins = _findEModeCategoryId('stcUSD__Stablecoins');
    _assertEModeCollateralConfig({
      id: eMode_StcUSD__Stablecoins,
      ltv: 88_00,
      liquidationThreshold: 90_00,
      liquidationBonus: 100_00 + 4_00,
      isolated: true
    });

    address[] memory collaterals_StcUSD__Stablecoins = new address[](1);
    collaterals_StcUSD__Stablecoins[0] = proposal.stcUSD();
    assertEq(
      AaveV3MegaEth.POOL.getEModeCategoryCollateralBitmap(eMode_StcUSD__Stablecoins),
      _toBitmap(collaterals_StcUSD__Stablecoins)
    );

    address[] memory borrowables_StcUSD__Stablecoins = new address[](2);
    borrowables_StcUSD__Stablecoins[0] = AaveV3MegaEthAssets.USDT0_UNDERLYING;
    borrowables_StcUSD__Stablecoins[1] = AaveV3MegaEthAssets.USDm_UNDERLYING;
    assertEq(
      AaveV3MegaEth.POOL.getEModeCategoryBorrowableBitmap(eMode_StcUSD__Stablecoins),
      _toBitmap(borrowables_StcUSD__Stablecoins)
    );
  }
  function test_eMode_StcUSD__Stablecoins_supplyAndBorrow() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _supplyAndBorrowInEMode(
      'stcUSD__Stablecoins',
      proposal.stcUSD(),
      AaveV3MegaEthAssets.USDT0_UNDERLYING
    );
  }
  function test_stcUSDBorrowWithoutEModeReverts() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    // USDT0 is unfunded at the fork block, so seed borrowable liquidity before borrowing
    _seedLiquidity(AaveV3MegaEthAssets.USDT0_UNDERLYING, 10_000);

    address user = makeAddr('borrowWithoutEModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(proposal.stcUSD()).decimals();
    deal(proposal.stcUSD(), user, supplyAmount);

    vm.startPrank(user);

    IERC20(proposal.stcUSD()).approve(address(AaveV3MegaEth.POOL), supplyAmount);
    AaveV3MegaEth.POOL.supply(proposal.stcUSD(), supplyAmount, user, 0);

    // LTV is 0 outside the e-mode, so the borrow must revert
    vm.expectRevert(abi.encodeWithSelector(Errors.LtvValidationFailed.selector));
    AaveV3MegaEth.POOL.borrow(AaveV3MegaEthAssets.USDT0_UNDERLYING, 1, 2, 0, user);

    vm.stopPrank();
  }
  function _seedLiquidity(address asset, uint256 wholeTokens) internal {
    uint256 amount = wholeTokens * 10 ** IERC20Metadata(asset).decimals();
    address liquidityProvider = makeAddr('liquidityProvider');
    deal(asset, liquidityProvider, amount);

    vm.startPrank(liquidityProvider);
    IERC20(asset).approve(address(AaveV3MegaEth.POOL), amount);
    AaveV3MegaEth.POOL.supply(asset, amount, liquidityProvider, 0);
    vm.stopPrank();
  }
  function _findEModeCategoryId(string memory label) internal view returns (uint8) {
    for (uint8 i = 1; i < 255; i++) {
      if (
        keccak256(bytes(AaveV3MegaEth.POOL.getEModeCategoryLabel(i))) == keccak256(bytes(label))
      ) {
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
    DataTypes.CollateralConfig memory cfg = AaveV3MegaEth.POOL.getEModeCategoryCollateralConfig(id);
    assertEq(cfg.ltv, ltv);
    assertEq(cfg.liquidationThreshold, liquidationThreshold);
    assertEq(cfg.liquidationBonus, liquidationBonus);
    assertEq(AaveV3MegaEth.POOL.getIsEModeCategoryIsolated(id), isolated);
  }
  function _toBitmap(address[] memory assets) internal view returns (uint128 bitmap) {
    for (uint256 i = 0; i < assets.length; i++) {
      bitmap |= uint128(1) << AaveV3MegaEth.POOL.getReserveData(assets[i]).id;
    }
  }
  function _supplyAndBorrowInEMode(
    string memory label,
    address collateral,
    address borrowAsset
  ) internal {
    uint8 eModeId = _findEModeCategoryId(label);

    // the borrowable reserve is unfunded at the fork block, so seed liquidity before borrowing
    _seedLiquidity(borrowAsset, 10_000);

    address user = makeAddr('eModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(collateral).decimals();
    deal(collateral, user, supplyAmount);

    vm.startPrank(user);

    AaveV3MegaEth.POOL.setUserEMode(eModeId);

    IERC20(collateral).approve(address(AaveV3MegaEth.POOL), supplyAmount);
    AaveV3MegaEth.POOL.supply(collateral, supplyAmount, user, 0);

    uint256 borrowAmount = 10 * 10 ** IERC20Metadata(borrowAsset).decimals();
    AaveV3MegaEth.POOL.borrow(borrowAsset, borrowAmount, 2, 0, user);

    address vToken = AaveV3MegaEth.POOL.getReserveVariableDebtToken(borrowAsset);
    assertApproxEqAbs(IERC20(vToken).balanceOf(user), borrowAmount, 1);

    IERC20(borrowAsset).approve(address(AaveV3MegaEth.POOL), borrowAmount);
    AaveV3MegaEth.POOL.repay(borrowAsset, borrowAmount, 2, user);
    AaveV3MegaEth.POOL.withdraw(collateral, supplyAmount / 2, user);

    vm.stopPrank();
  }
}
