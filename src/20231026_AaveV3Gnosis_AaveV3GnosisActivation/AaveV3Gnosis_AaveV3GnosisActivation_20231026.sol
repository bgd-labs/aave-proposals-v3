// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';
import {AaveV3PayloadGnosis} from 'aave-helpers/v3-config-engine/AaveV3PayloadGnosis.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IV3RateStrategyFactory} from 'aave-helpers/v3-config-engine/IV3RateStrategyFactory.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title Aave v3 Gnosis Activation
 * @author BGD Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb62c93a8b3590dc46eed92b223da5fcbbf6b52f1f79a0c2fcd80bbc0afea59d8
 * - Discussion: https://governance.aave.com/t/arfc-aave-v3-deployment-on-gnosischain/14695
 */
contract AaveV3Gnosis_AaveV3GnosisActivation_20231026 is AaveV3PayloadGnosis {
  using SafeERC20 for IERC20;

  address public constant WETH = 0x6A023CCd1ff6F2045C3309768eAd9E68F978f6e1;
  address public constant wstETH = 0x6C76971f98945AE98dD7d4DFcA8711ebea946eA6;
  address public constant GNO = 0x9C58BAcC331c9aa871AFD802DB6379a98e80CEdb;
  address public constant USDC = 0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83;
  address public constant WXDAI = 0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d;
  address public constant EURe = 0xcB444e90D8198415266c6a2724b7900fb12FC56E;
  address public constant sDAI = 0xaf204776c7245bF4147c2612BF6e5972Ee483701;

  address public constant GUARDIAN = 0xF163b8698821cefbD33Cf449764d69Ea445cE23D;
  address public constant FREEZING_STEWARD = 0x3Ceaf9b6CAb92dFe6302D0CC3F1BA880C28d35e5;

  function _postExecute() internal override {
    AaveV3Gnosis.ACL_MANAGER.addPoolAdmin(GUARDIAN);
    AaveV3Gnosis.ACL_MANAGER.addRiskAdmin(FREEZING_STEWARD);
    AaveV3Gnosis.ACL_MANAGER.addRiskAdmin(AaveV3Gnosis.CAPS_PLUS_RISK_STEWARD);

    _supply(AaveV3Gnosis.POOL, WETH, 0.01 * 1e18, address(AaveV3Gnosis.COLLECTOR));
    _supply(AaveV3Gnosis.POOL, wstETH, 0.01 * 1e18, address(AaveV3Gnosis.COLLECTOR));
    _supply(AaveV3Gnosis.POOL, GNO, 0.1 * 1e18, address(AaveV3Gnosis.COLLECTOR));
    _supply(AaveV3Gnosis.POOL, USDC, 10 * 1e6, address(AaveV3Gnosis.COLLECTOR));
    _supply(AaveV3Gnosis.POOL, WXDAI, 10 * 1e18, address(AaveV3Gnosis.COLLECTOR));
    _supply(AaveV3Gnosis.POOL, EURe, 10 * 1e18, address(AaveV3Gnosis.COLLECTOR));
    _supply(AaveV3Gnosis.POOL, sDAI, 10 * 1e18, address(AaveV3Gnosis.COLLECTOR));
  }

  function eModeCategoriesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryUpdate[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryUpdate[]
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](1);

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 1,
      ltv: 90_00,
      liqThreshold: 93_00,
      liqBonus: 1_00,
      priceSource: 0x0000000000000000000000000000000000000000,
      label: 'ETH correlated'
    });

    return eModeUpdates;
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](7);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: WETH,
      assetSymbol: 'WETH',
      priceFeed: 0xa767f745331D267c7751297D982b050c93985627,
      eModeCategory: 1,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 6_00,
      reserveFactor: 15_00,
      supplyCap: 4_000,
      borrowCap: 3_500,
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

    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: wstETH,
      assetSymbol: 'wstETH',
      priceFeed: 0xcb0670258e5961CCA85D8F71D29C1167Ef20De99,
      eModeCategory: 1,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 6_00,
      reserveFactor: 15_00,
      supplyCap: 4_000,
      borrowCap: 400,
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

    listings[2] = IAaveV3ConfigEngine.Listing({
      asset: GNO,
      assetSymbol: 'GNO',
      priceFeed: 0x22441d81416430A54336aB28765abd31a792Ad37,
      eModeCategory: 0,
      enabledToBorrow: EngineFlags.DISABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 31_00,
      liqThreshold: 36_00,
      liqBonus: 10_00,
      reserveFactor: 15_00,
      supplyCap: 30_000,
      borrowCap: 0,
      debtCeiling: 1_000_000,
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
      asset: USDC,
      assetSymbol: 'USDC',
      priceFeed: 0x26C31ac71010aF62E6B486D1132E266D6298857D,
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
      supplyCap: 1_000_000,
      borrowCap: 1_000_000,
      debtCeiling: 0,
      liqProtocolFee: 20_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(5_00),
        variableRateSlope2: _bpsToRay(75_00),
        stableRateSlope1: _bpsToRay(5_00),
        stableRateSlope2: _bpsToRay(75_00),
        baseStableRateOffset: _bpsToRay(1_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      })
    });

    listings[4] = IAaveV3ConfigEngine.Listing({
      asset: WXDAI,
      assetSymbol: 'WXDAI',
      priceFeed: 0x678df3415fc31947dA4324eC63212874be5a82f8,
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
      supplyCap: 1_500_000,
      borrowCap: 1_500_000,
      debtCeiling: 0,
      liqProtocolFee: 20_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(5_00),
        variableRateSlope2: _bpsToRay(75_00),
        stableRateSlope1: _bpsToRay(5_00),
        stableRateSlope2: _bpsToRay(75_00),
        baseStableRateOffset: _bpsToRay(1_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      })
    });

    listings[5] = IAaveV3ConfigEngine.Listing({
      asset: EURe,
      assetSymbol: 'EURe',
      priceFeed: 0xab70BCB260073d036d1660201e9d5405F5829b7a,
      eModeCategory: 0,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 15_00,
      supplyCap: 500_000,
      borrowCap: 500_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(4_00),
        variableRateSlope2: _bpsToRay(75_00),
        stableRateSlope1: _bpsToRay(4_00),
        stableRateSlope2: _bpsToRay(75_00),
        baseStableRateOffset: _bpsToRay(1_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      })
    });

    listings[6] = IAaveV3ConfigEngine.Listing({
      asset: sDAI,
      assetSymbol: 'sDAI',
      priceFeed: 0x1D0f881Ce1a646E2f27Dec3c57Fa056cB838BCC2,
      eModeCategory: 0,
      enabledToBorrow: EngineFlags.DISABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 77_00,
      liqThreshold: 80_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 1_500_000,
      borrowCap: 0,
      debtCeiling: 0,
      liqProtocolFee: 20_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(4_00),
        variableRateSlope2: _bpsToRay(75_00),
        stableRateSlope1: _bpsToRay(4_00),
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
