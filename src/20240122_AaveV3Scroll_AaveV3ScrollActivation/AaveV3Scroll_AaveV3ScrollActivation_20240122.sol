// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';
import {MiscScroll} from 'aave-address-book/MiscScroll.sol';
import {AaveV3PayloadScroll} from 'aave-helpers/v3-config-engine/AaveV3PayloadScroll.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';
import {IV3RateStrategyFactory} from 'aave-helpers/v3-config-engine/IV3RateStrategyFactory.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title Aave v3 Scroll Activation
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x8110de95ff2827946ede0a9b8c5b9c1876605163bb1e7f8c637b6b80848224c8
 * - Discussion: https://governance.aave.com/t/arfc-aave-v3-deployment-on-scroll-mainnet/16126/
 */
contract AaveV3Scroll_AaveV3ScrollActivation_20240122 is AaveV3PayloadScroll {
  using SafeERC20 for IERC20;

  address public constant WETH = 0x5300000000000000000000000000000000000004;
  uint256 public constant WETH_SEED_AMOUNT = 0.005e18;
  address public constant USDC = 0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4;
  uint256 public constant USDC_SEED_AMOUNT = 10e6;
  address public constant wstETH = 0xf610A9dfB7C89644979b4A0f27063E9e7d7Cda32;
  uint256 public constant wstETH_SEED_AMOUNT = 0.005e18;

  function _postExecute() internal override {
    AaveV3Scroll.ACL_MANAGER.addPoolAdmin(MiscScroll.PROTOCOL_GUARDIAN);
    AaveV3Scroll.ACL_MANAGER.addRiskAdmin(AaveV3Scroll.FREEZING_STEWARD);
    AaveV3Scroll.ACL_MANAGER.addRiskAdmin(AaveV3Scroll.CAPS_PLUS_RISK_STEWARD);

    _supply(AaveV3Scroll.POOL, WETH, WETH_SEED_AMOUNT, 0x000000000000000000000000000000000000dEaD);
    _supply(AaveV3Scroll.POOL, USDC, USDC_SEED_AMOUNT, 0x000000000000000000000000000000000000dEaD);
    _supply(
      AaveV3Scroll.POOL,
      wstETH,
      wstETH_SEED_AMOUNT,
      0x000000000000000000000000000000000000dEaD
    );
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
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](3);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: WETH,
      assetSymbol: 'WETH',
      priceFeed: 0x6bF14CB0A831078629D993FDeBcB182b21A8774C,
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
      supplyCap: 240,
      borrowCap: 200,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(80_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(3_30),
        variableRateSlope2: _bpsToRay(8_00),
        stableRateSlope1: _bpsToRay(3_30),
        stableRateSlope2: _bpsToRay(8_00),
        baseStableRateOffset: _bpsToRay(2_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: USDC,
      assetSymbol: 'USDC',
      priceFeed: 0x43d12Fb3AfCAd5347fA764EeAB105478337b7200,
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
      borrowCap: 900_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(6_00),
        variableRateSlope2: _bpsToRay(60_00),
        stableRateSlope1: _bpsToRay(6_00),
        stableRateSlope2: _bpsToRay(60_00),
        baseStableRateOffset: _bpsToRay(1_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      })
    });
    listings[2] = IAaveV3ConfigEngine.Listing({
      asset: wstETH,
      assetSymbol: 'wstETH',
      priceFeed: 0xdb93e2712a8B36835078f8D28c70fCC95FD6d37c,
      eModeCategory: 1,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 7_00,
      reserveFactor: 15_00,
      supplyCap: 130,
      borrowCap: 45,
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

    return listings;
  }

  function _supply(IPool pool, address asset, uint256 amount, address onBehalfOf) internal {
    IERC20(asset).forceApprove(address(pool), amount);
    pool.supply(asset, amount, onBehalfOf, 0);
  }
}
