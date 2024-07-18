// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis, AaveV3GnosisEModes} from 'aave-address-book/AaveV3Gnosis.sol';
import {AaveV3PayloadGnosis} from 'aave-helpers/v3-config-engine/AaveV3PayloadGnosis.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IV3RateStrategyFactory} from 'aave-helpers/v3-config-engine/IV3RateStrategyFactory.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
/**
 * @title Onboard USDC.e on Gnosis
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xefdd7d915acc3a179c756295ad6583645dfc491424cda08916e80c8551e30943
 * - Discussion: https://governance.aave.com/t/arfc-onboard-usdc-e-to-aave-v3-gnosis-chain/17948/3
 */
contract AaveV3Gnosis_OnboardUSDCEOnGnosis_20240717 is AaveV3PayloadGnosis {
  using SafeERC20 for IERC20;

  address public constant USDCe = 0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0;
  uint256 public constant USDCe_SEED_AMOUNT = 1e6;

  function _postExecute() internal override {
    IERC20(USDCe).forceApprove(address(AaveV3Gnosis.POOL), USDCe_SEED_AMOUNT);
    AaveV3Gnosis.POOL.supply(USDCe, USDCe_SEED_AMOUNT, address(AaveV3Gnosis.COLLECTOR), 0);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: USDCe,
      assetSymbol: 'USDCe',
      priceFeed: 0x26C31ac71010aF62E6B486D1132E266D6298857D,
      eModeCategory: AaveV3GnosisEModes.NONE,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 1_500_000,
      borrowCap: 1_400_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(9_00),
        variableRateSlope2: _bpsToRay(75_00),
        stableRateSlope1: _bpsToRay(9_00),
        stableRateSlope2: _bpsToRay(75_00),
        baseStableRateOffset: _bpsToRay(0),
        stableRateExcessOffset: _bpsToRay(0),
        optimalStableToTotalDebtRatio: _bpsToRay(0)
      })
    });

    return listings;
  }
}
