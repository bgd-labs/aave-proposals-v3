// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base, AaveV3BaseEModes} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3PayloadBase} from 'aave-helpers/v3-config-engine/AaveV3PayloadBase.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IV3RateStrategyFactory} from 'aave-helpers/v3-config-engine/IV3RateStrategyFactory.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title Onboarding wstETH to Aave V3 on Base Network
 * @author Alice Rozengarden (@Rozengarden - Aave-chan initiative)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x9cf4ba743e0363f77fbbd1bf0d3946b06154abd57cd4bc897c23cdfcdb3bcbeb
 * - Discussion: https://governance.aave.com/t/arfc-onboarding-wsteth-to-aave-v3-on-base-network/15510/5
 */
contract AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork_20231127 is AaveV3PayloadBase {
  using SafeERC20 for IERC20;

  address public constant wstETH = 0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452;
  uint256 public constant wstETH_SEED_AMOUNT = 0.01 ether;

  function _postExecute() internal override {
    IERC20(wstETH).forceApprove(address(AaveV3Base.POOL), wstETH_SEED_AMOUNT);
    AaveV3Base.POOL.supply(wstETH, wstETH_SEED_AMOUNT, address(AaveV3Base.COLLECTOR), 0);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: wstETH,
      assetSymbol: 'wstETH',
      priceFeed: 0x945fD405773973d286De54E44649cc0d9e264F78,
      eModeCategory: AaveV3BaseEModes.ETH_CORRELATED,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 71_00,
      liqThreshold: 76_00,
      liqBonus: 6_00,
      reserveFactor: 15_00,
      supplyCap: 4_000,
      borrowCap: 400,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(45_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(7_00),
        variableRateSlope2: _bpsToRay(300_00),
        stableRateSlope1: _bpsToRay(13_00),
        stableRateSlope2: _bpsToRay(300_00),
        baseStableRateOffset: _bpsToRay(3_00),
        stableRateExcessOffset: _bpsToRay(5_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      })
    });

    return listings;
  }
}
