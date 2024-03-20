// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumEModes} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IV3RateStrategyFactory} from 'aave-helpers/v3-config-engine/IV3RateStrategyFactory.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title sfrxETH Listing
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x7b5eb16470a0246d8515fc551962740735c7db93bf7c39810e7d3126c04e49c3
 * - Discussion: https://governance.aave.com/t/arfc-onboarding-sfrxeth-to-aave-v3-ethereum/15673
 */
contract AaveV3Ethereum_SfrxETHListing_20240321 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant sfrxETH = 0xac3E018457B222d93114458476f3E3416Abbe38F;
  uint256 public constant sfrxETH_SEED_AMOUNT = 1e16;

  function _postExecute() internal override {
    IERC20(sfrxETH).forceApprove(address(AaveV3Ethereum.POOL), sfrxETH_SEED_AMOUNT);
    AaveV3Ethereum.POOL.supply(sfrxETH, sfrxETH_SEED_AMOUNT, address(AaveV3Ethereum.COLLECTOR), 0);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: sfrxETH,
      assetSymbol: 'sfrxETH',
      priceFeed: 0x0000000000000000000000000000000000000000,
      eModeCategory: AaveV3EthereumEModes.ETH_CORRELATED,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 74_50,
      liqThreshold: 77_00,
      liqBonus: 5_00,
      reserveFactor: 15_00,
      supplyCap: 55_000,
      borrowCap: 5_500,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(45_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(7_00),
        variableRateSlope2: _bpsToRay(300_00),
        stableRateSlope1: _bpsToRay(0),
        stableRateSlope2: _bpsToRay(0),
        baseStableRateOffset: _bpsToRay(0),
        stableRateExcessOffset: _bpsToRay(0),
        optimalStableToTotalDebtRatio: _bpsToRay(0)
      })
    });

    return listings;
  }
}
