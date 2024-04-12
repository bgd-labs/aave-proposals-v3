// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumEModes} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3PayloadArbitrum} from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IV3RateStrategyFactory} from 'aave-helpers/v3-config-engine/IV3RateStrategyFactory.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
/**
 * @title weETH Arbitrum onboarding
 * @author @mzeller - ACI
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/arfc-onboard-weeth-to-aave-v3-on-ethereum/16758/11
 */
contract AaveV3Arbitrum_WeETHArbitrumOnboarding_20240409 is AaveV3PayloadArbitrum {
  using SafeERC20 for IERC20;

  address public constant weETH = 0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe;
  uint256 public constant weETH_SEED_AMOUNT = 0.01e18;

  function _postExecute() internal override {
    IERC20(weETH).forceApprove(address(AaveV3Arbitrum.POOL), weETH_SEED_AMOUNT);
    AaveV3Arbitrum.POOL.supply(weETH, weETH_SEED_AMOUNT, address(AaveV3Arbitrum.COLLECTOR), 0);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: weETH,
      assetSymbol: 'weETH',
      priceFeed: 0x517276B5972C4Db7E88B9F76Ee500E888a2D73C3,
      eModeCategory: AaveV3ArbitrumEModes.ETH_CORRELATED,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 72_50,
      liqThreshold: 75_00,
      liqBonus: 7_50,
      reserveFactor: 15_00,
      supplyCap: 1_000,
      borrowCap: 100,
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
        stableRateExcessOffset: _bpsToRay(20_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      })
    });

    return listings;
  }
}
