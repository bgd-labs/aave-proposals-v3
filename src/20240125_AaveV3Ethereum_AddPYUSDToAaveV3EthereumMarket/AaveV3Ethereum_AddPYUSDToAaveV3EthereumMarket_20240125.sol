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
 * @title Add PYUSD to Aave v3 Ethereum Market
 * @author JosepBove (ACI)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb91949efad61b134b913d93b00f73ca8a122259e6d1458cf793f22a0eebfd5d5
 * - Discussion: https://governance.aave.com/t/arfc-add-pyusd-to-aave-v3-ethereum-market/16218/
 */
contract AaveV3Ethereum_AddPYUSDToAaveV3EthereumMarket_20240125 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant PYUSD = 0x6c3ea9036406852006290770BEdFcAbA0e23A0e8;
  uint256 public constant PYUSD_SEED_AMOUNT = 1e6;

  function _postExecute() internal override {
    IERC20(PYUSD).forceApprove(address(AaveV3Ethereum.POOL), PYUSD_SEED_AMOUNT);
    AaveV3Ethereum.POOL.supply(PYUSD, PYUSD_SEED_AMOUNT, address(AaveV3Ethereum.COLLECTOR), 0);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: PYUSD,
      assetSymbol: 'PYUSD',
      priceFeed: 0x8f1dF6D7F2db73eECE86a18b4381F4707b918FB1,
      eModeCategory: AaveV3EthereumEModes.NONE,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 20_00,
      supplyCap: 10_000_000,
      borrowCap: 9_000_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(80_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(6_00),
        variableRateSlope2: _bpsToRay(80_00),
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
