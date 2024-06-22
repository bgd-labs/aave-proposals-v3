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
 * @title Onboard sUSDe to Aave V3 on Ethereum
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x9c6dcf2af7d79467f34e52b505c25d5e4c89af77f00396307d42fc4816797cd9
 * - Discussion: https://governance.aave.com/t/arfc-onboard-susde-to-aave-v3-on-ethereum/17191
 */
contract AaveV3Ethereum_OnboardSUSDeToAaveV3OnEthereum_20240621 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant sUSDe = 0x9D39A5DE30e57443BfF2A8307A4256c8797A3497;
  uint256 public constant sUSDe_SEED_AMOUNT = 1e18;

  function _postExecute() internal override {
    IERC20(sUSDe).forceApprove(address(AaveV3Ethereum.POOL), sUSDe_SEED_AMOUNT);
    AaveV3Ethereum.POOL.supply(sUSDe, sUSDe_SEED_AMOUNT, address(AaveV3Ethereum.COLLECTOR), 0);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: sUSDe,
      assetSymbol: 'sUSDe',
      priceFeed: 0xb37aE8aBa6C0C1Bf2c509fc06E11aa4AF29B665A,
      eModeCategory: AaveV3EthereumEModes.NONE,
      enabledToBorrow: EngineFlags.DISABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 72_00,
      liqThreshold: 75_00,
      liqBonus: 8_50,
      reserveFactor: 20_00,
      supplyCap: 85_000_000,
      borrowCap: 0,
      debtCeiling: 40_000_000,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(0),
        variableRateSlope2: _bpsToRay(0),
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
