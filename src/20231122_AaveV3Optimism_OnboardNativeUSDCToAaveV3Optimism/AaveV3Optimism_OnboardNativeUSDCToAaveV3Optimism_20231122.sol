// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism, AaveV3OptimismAssets, AaveV3OptimismEModes} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3PayloadOptimism} from 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IV3RateStrategyFactory} from 'aave-helpers/v3-config-engine/IV3RateStrategyFactory.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title Onboard Native USDC to Aave V3 Optimism
 * @author @marczeller - Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xf04fdb85e27849310557716d09fb2ed7f84b1a8c4f493088899ad91a2d834fb0
 * - Discussion: https://governance.aave.com/t/arfc-onboard-native-usdc-to-aave-v3-optimism-market/15463
 */
contract AaveV3Optimism_OnboardNativeUSDCToAaveV3Optimism_20231122 is AaveV3PayloadOptimism {
  using SafeERC20 for IERC20;

  address public constant USDCN = 0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85;
  uint256 public constant USDCN_SEED_AMOUNT = 1e6;

  function _postExecute() internal override {
    IERC20(USDCN).forceApprove(address(AaveV3Optimism.POOL), USDCN_SEED_AMOUNT);
    AaveV3Optimism.POOL.supply(USDCN, USDCN_SEED_AMOUNT, address(AaveV3Optimism.COLLECTOR), 0);
  }

  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](1);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3OptimismAssets.USDC_UNDERLYING,
      supplyCap: 25_000_000,
      borrowCap: 20_000_000
    });

    return capsUpdate;
  }

  function borrowsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.BorrowUpdate[] memory)
  {
    IAaveV3ConfigEngine.BorrowUpdate[]
      memory borrowUpdates = new IAaveV3ConfigEngine.BorrowUpdate[](1);

    borrowUpdates[0] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3OptimismAssets.USDC_UNDERLYING,
      enabledToBorrow: EngineFlags.KEEP_CURRENT,
      flashloanable: EngineFlags.KEEP_CURRENT,
      stableRateModeEnabled: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: 20_00
    });

    return borrowUpdates;
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: USDCN,
      assetSymbol: 'USDCn',
      priceFeed: 0x16a9FA2FDa030272Ce99B29CF780dFA30361E0f3,
      eModeCategory: AaveV3OptimismEModes.STABLECOINS,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 80_00,
      liqThreshold: 85_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 25_000_000,
      borrowCap: 20_000_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(3_50),
        variableRateSlope2: _bpsToRay(60_00),
        stableRateSlope1: _bpsToRay(3_50),
        stableRateSlope2: _bpsToRay(60_00),
        baseStableRateOffset: _bpsToRay(1_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      })
    });

    return listings;
  }
}
