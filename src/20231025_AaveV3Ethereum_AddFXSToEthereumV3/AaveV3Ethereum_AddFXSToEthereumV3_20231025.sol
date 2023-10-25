// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumEModes} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Add FXS to Ethereum V3
 * @author Alice Rozengarden (@Rozengarden - Aave-chan initiative)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xd8a8bdf3692666195895efbe0e885887c73b614273d6f0bd584c68afa9c11600
 * - Discussion: https://governance.aave.com/t/arfc-add-fxs-to-ethereum-v3/15112
 */
contract AaveV3Ethereum_AddFXSToEthereumV3_20231025 is AaveV3PayloadEthereum {
  address public constant FXS = address(0x3432B6A60D23Ca0dFCa7761B7ab56459D9C964D0);

  function _postExecute() internal override {
    AaveV3Ethereum.POOL.supply(FXS, 10 ** 18, AaveV3Ethereum.COLLECTOR, 0);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: FXS,
      assetSymbol: 'FXS',
      priceFeed: 0x6Ebc52C8C1089be9eB3945C4350B68B8E4C2233f,
      eModeCategory: AaveV3EthereumEModes.NONE,
      enabledToBorrow: ENABLED,
      stableRateModeEnabled: DISABLED,
      borrowableInIsolation: DISABLED,
      withSiloedBorrowing: DISABLED,
      flashloanable: ENABLED,
      ltv: 35_00,
      liqThreshold: 45_00,
      liqBonus: 10_00,
      reserveFactor: 20_00,
      supplyCap: 800_000_000,
      borrowCap: 500_000_000,
      debtCeiling: 4_000_000_000,
      liqProtocolFee: 10_00,
      rateStrategyParams: Rates.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(45_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(9_00),
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
