// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB, AaveV3BNBEModes} from 'aave-address-book/AaveV3BNB.sol';
import {AaveV3PayloadBNB} from 'aave-helpers/v3-config-engine/AaveV3PayloadBNB.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IV3RateStrategyFactory} from 'aave-helpers/v3-config-engine/IV3RateStrategyFactory.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title Onboard fdUSD to Aave v3 on BSC
 * @author ACI (Aave Chan Initiative)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xedacc2aab061dbb187ef705ffee8a8f35ab3f53670e4d8e432eed9dfd2c31958
 * - Discussion: https://governance.aave.com/t/arfc-onboard-fdusd-to-aave-v3-on-bsc/16364
 */
contract AaveV3BNB_OnboardFdUSDToAaveV3OnBSC_20240201 is AaveV3PayloadBNB {
  using SafeERC20 for IERC20;

  address public constant FDUSD = 0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409;
  uint256 public constant FDUSD_SEED_AMOUNT = 1e18;

  function _postExecute() internal override {
    IERC20(FDUSD).forceApprove(address(AaveV3BNB.POOL), FDUSD_SEED_AMOUNT);
    AaveV3BNB.POOL.supply(FDUSD, FDUSD_SEED_AMOUNT, address(AaveV3BNB.COLLECTOR), 0);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: FDUSD,
      assetSymbol: 'FDUSD',
      priceFeed: 0x390180e80058A8499930F0c13963AD3E0d86Bfc9,
      eModeCategory: AaveV3BNBEModes.NONE,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 70_00,
      liqThreshold: 75_00,
      liqBonus: 5_00,
      reserveFactor: 20_00,
      supplyCap: 8_000_000,
      borrowCap: 7_500_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(6_00),
        variableRateSlope2: _bpsToRay(75_00),
        stableRateSlope1: _bpsToRay(13_00),
        stableRateSlope2: _bpsToRay(300_00),
        baseStableRateOffset: _bpsToRay(3_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      })
    });

    return listings;
  }
}
