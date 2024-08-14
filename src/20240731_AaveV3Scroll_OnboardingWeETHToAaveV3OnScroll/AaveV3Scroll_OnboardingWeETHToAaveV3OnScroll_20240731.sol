// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll, AaveV3ScrollEModes} from 'aave-address-book/AaveV3Scroll.sol';
import {AaveV3PayloadScroll} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadScroll.sol';
import {EngineFlags} from 'aave-v3-periphery/contracts/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
/**
 * @title Onboarding weETH to Aave V3 on Scroll
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x252bafcf8ead0bf1869b7ba9fef430caf3977dfd1e1f84e2e4bc1842e83520b4
 * - Discussion: https://governance.aave.com/t/arfc-onboarding-weeth-to-aave-v3-on-scroll/18301
 */
contract AaveV3Scroll_OnboardingWeETHToAaveV3OnScroll_20240731 is AaveV3PayloadScroll {
  using SafeERC20 for IERC20;

  address public constant weETH = 0x01f0a31698C4d065659b9bdC21B3610292a1c506;
  uint256 public constant weETH_SEED_AMOUNT = 5e15;

  function _postExecute() internal override {
    IERC20(weETH).forceApprove(address(AaveV3Scroll.POOL), weETH_SEED_AMOUNT);
    AaveV3Scroll.POOL.supply(weETH, weETH_SEED_AMOUNT, address(AaveV3Scroll.COLLECTOR), 0);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: weETH,
      assetSymbol: 'weETH',
      priceFeed: 0x32f924C0e0F1Abf5D1ff35B05eBc5E844dEdD2A9,
      eModeCategory: AaveV3ScrollEModes.ETH_CORRELATED,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 72_50,
      liqThreshold: 75_00,
      liqBonus: 7_50,
      reserveFactor: 15_00,
      supplyCap: 2_000,
      borrowCap: 400,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 7_00,
        variableRateSlope2: 300_00
      })
    });

    return listings;
  }
}
