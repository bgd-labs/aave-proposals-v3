// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';
import {MiscBNB} from 'aave-address-book/MiscBNB.sol';
import {AaveV3PayloadBnb} from 'aave-helpers/v3-config-engine/AaveV3PayloadBnb.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IV3RateStrategyFactory} from 'aave-helpers/v3-config-engine/IV3RateStrategyFactory.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title Aave v3 BNB Activation
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x60d44523a63e022fcca2f54aa3b84977e49fec0bdf15c9a298122422f6dd5902
 * - Discussion: https://governance.aave.com/t/arfc-aave-v3-deployment-on-bnb-chain/12609/
 */
contract AaveV3Bnb_AaveV3BNBActivation_20231122 is AaveV3PayloadBnb {
  using SafeERC20 for IERC20;

  address public constant CAKE = 0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82;
  uint256 public constant CAKE_SEED_AMOUNT = 1e18;
  address public constant WBNB = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
  uint256 public constant WBNB_SEED_AMOUNT = 0.05e18;
  address public constant BTCB = 0x7130d2A12B9BCbFAe4f2634d864A1Ee1Ce3Ead9c;
  uint256 public constant BTCB_SEED_AMOUNT = 0.0005e18;
  address public constant ETH = 0x2170Ed0880ac9A755fd29B2688956BD959F933F8;
  uint256 public constant ETH_SEED_AMOUNT = 0.01e18;
  address public constant USDC = 0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d;
  uint256 public constant USDC_SEED_AMOUNT = 5e18;
  address public constant USDT = 0x55d398326f99059fF775485246999027B3197955;
  uint256 public constant USDT_SEED_AMOUNT = 5e18;

  address public constant POOL_IMPL = 0xE23AE099E2EF2a75183d06Af93c8EE0B5f1B546D;

  function _postExecute() internal override {
    AaveV3BNB.ACL_MANAGER.addPoolAdmin(MiscBNB.PROTOCOL_GUARDIAN);
    AaveV3BNB.ACL_MANAGER.addRiskAdmin(AaveV3BNB.FREEZING_STEWARD);
    AaveV3BNB.ACL_MANAGER.addRiskAdmin(AaveV3BNB.CAPS_PLUS_RISK_STEWARD);

    _supply(AaveV3BNB.POOL, CAKE, CAKE_SEED_AMOUNT, 0x000000000000000000000000000000000000dEaD);
    _supply(AaveV3BNB.POOL, WBNB, WBNB_SEED_AMOUNT, 0x000000000000000000000000000000000000dEaD);
    _supply(AaveV3BNB.POOL, BTCB, BTCB_SEED_AMOUNT, 0x000000000000000000000000000000000000dEaD);
    _supply(AaveV3BNB.POOL, ETH, ETH_SEED_AMOUNT, 0x000000000000000000000000000000000000dEaD);
    _supply(AaveV3BNB.POOL, USDC, USDC_SEED_AMOUNT, 0x000000000000000000000000000000000000dEaD);
    _supply(AaveV3BNB.POOL, USDT, USDT_SEED_AMOUNT, 0x000000000000000000000000000000000000dEaD);
  }

  function _preExecute() internal override {
    AaveV3BNB.POOL_ADDRESSES_PROVIDER.setPoolImpl(POOL_IMPL);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](6);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: CAKE,
      assetSymbol: 'CAKE',
      priceFeed: 0xB6064eD41d4f67e353768aA239cA86f4F73665a1,
      eModeCategory: 0,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 55_00,
      liqThreshold: 61_00,
      liqBonus: 10_00,
      reserveFactor: 20_00,
      supplyCap: 5_000_000,
      borrowCap: 2_250_000,
      debtCeiling: 7_000_000,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(45_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(7_00),
        variableRateSlope2: _bpsToRay(300_00),
        stableRateSlope1: _bpsToRay(7_00),
        stableRateSlope2: _bpsToRay(300_00),
        baseStableRateOffset: _bpsToRay(2_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: WBNB,
      assetSymbol: 'WBNB',
      priceFeed: 0x0567F2323251f0Aab15c8dFb1967E4e8A7D42aeE,
      eModeCategory: 0,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 70_00,
      liqThreshold: 75_00,
      liqBonus: 10_00,
      reserveFactor: 20_00,
      supplyCap: 50_000,
      borrowCap: 22_500,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(45_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(7_00),
        variableRateSlope2: _bpsToRay(300_00),
        stableRateSlope1: _bpsToRay(7_00),
        stableRateSlope2: _bpsToRay(300_00),
        baseStableRateOffset: _bpsToRay(2_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      })
    });
    listings[2] = IAaveV3ConfigEngine.Listing({
      asset: BTCB,
      assetSymbol: 'BTCB',
      priceFeed: 0x264990fbd0A4796A3E3d8E37C4d5F87a3aCa5Ebf,
      eModeCategory: 0,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 70_00,
      liqThreshold: 75_00,
      liqBonus: 10_00,
      reserveFactor: 20_00,
      supplyCap: 400,
      borrowCap: 180,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(45_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(7_00),
        variableRateSlope2: _bpsToRay(300_00),
        stableRateSlope1: _bpsToRay(7_00),
        stableRateSlope2: _bpsToRay(300_00),
        baseStableRateOffset: _bpsToRay(2_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      })
    });
    listings[3] = IAaveV3ConfigEngine.Listing({
      asset: ETH,
      assetSymbol: 'ETH',
      priceFeed: 0x9ef1B8c0E4F7dc8bF5719Ea496883DC6401d5b2e,
      eModeCategory: 0,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 80_00,
      liqThreshold: 82_50,
      liqBonus: 10_00,
      reserveFactor: 15_00,
      supplyCap: 5_000,
      borrowCap: 4_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(80_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(3_30),
        variableRateSlope2: _bpsToRay(80_00),
        stableRateSlope1: _bpsToRay(4_00),
        stableRateSlope2: _bpsToRay(80_00),
        baseStableRateOffset: _bpsToRay(2_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      })
    });
    listings[4] = IAaveV3ConfigEngine.Listing({
      asset: USDC,
      assetSymbol: 'USDC',
      priceFeed: 0x51597f405303C4377E36123cBc172b13269EA163,
      eModeCategory: 0,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 77_00,
      liqThreshold: 80_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 50_000_000,
      borrowCap: 45_000_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(6_00),
        variableRateSlope2: _bpsToRay(60_00),
        stableRateSlope1: _bpsToRay(6_00),
        stableRateSlope2: _bpsToRay(60_00),
        baseStableRateOffset: _bpsToRay(1_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      })
    });
    listings[5] = IAaveV3ConfigEngine.Listing({
      asset: USDT,
      assetSymbol: 'USDT',
      priceFeed: 0xB97Ad0E74fa7d920791E90258A6E2085088b4320,
      eModeCategory: 0,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 80_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 50_000_000,
      borrowCap: 45_000_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(6_00),
        variableRateSlope2: _bpsToRay(75_00),
        stableRateSlope1: _bpsToRay(6_00),
        stableRateSlope2: _bpsToRay(75_00),
        baseStableRateOffset: _bpsToRay(1_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      })
    });

    return listings;
  }

  function _supply(IPool pool, address asset, uint256 amount, address onBehalfOf) internal {
    IERC20(asset).forceApprove(address(pool), amount);
    pool.supply(asset, amount, onBehalfOf, 0);
  }
}
