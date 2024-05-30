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
 * @title Onboard USDe Aave V3 Ethereum
 * @author ACI
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xc1b6d0d390a2dabf81206f592f740c69163dd028dcb0f50182d0ad3a50e744b0
 * - Discussion: https://governance.aave.com/t/arfc-onboard-usde-to-aave-v3-on-ethereum/17690
 */
contract AaveV3Ethereum_OnboardUSDeAaveV3Ethereum_20240528 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant USDe = 0x4c9EDD5852cd905f086C759E8383e09bff1E68B3;
  uint256 public constant USDe_SEED_AMOUNT = 1e18;

  function _postExecute() internal override {
    IERC20(USDe).forceApprove(address(AaveV3Ethereum.POOL), USDe_SEED_AMOUNT);
    AaveV3Ethereum.POOL.supply(USDe, USDe_SEED_AMOUNT, address(AaveV3Ethereum.COLLECTOR), 0);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: USDe,
      assetSymbol: 'USDe',
      priceFeed: 0x55B6C4D3E8A27b8A1F5a263321b602e0fdEEcC17,
      eModeCategory: AaveV3EthereumEModes.NONE,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 72_00,
      liqThreshold: 75_00,
      liqBonus: 8_50,
      reserveFactor: 25_00,
      supplyCap: 80_000_000,
      borrowCap: 72_000_000,
      debtCeiling: 40_000_000,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(80_00),
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
