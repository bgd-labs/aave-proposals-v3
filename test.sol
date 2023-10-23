// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumEModes} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';

/**
 * @title test
 * @author test
 * - Snapshot: test
 * - Discussion: test
 */
contract AaveV3Ethereum_Test_20231023 is AaveV3PayloadEthereum {
  address public constant PSP = address(0xcAfE001067cDEF266AfB7Eb5A286dCFD277f3dE5);

  function _postExecute() internal override {
    AaveV3Ethereum.POOL.supply(PSP, 10 ** 18, AaveV3Ethereum.COLLECTOR, 0);
  }

  function newListings() public pure override returns (IEngine.Listing[] memory) {
    IEngine.Listing[] memory listings = new IEngine.Listing[](1);

    listings[0] = IEngine.Listing({
      asset: PSP,
      assetSymbol: 'PSP',
      priceFeed: 0x72AFAECF99C9d9C8215fF44C77B94B99C28741e8,
      eModeCategory: AaveV3EthereumEModes.NONE,
      enabledToBorrow: ENABLED,
      stableRateModeEnabled: DISABLED,
      borrowableInIsolation: DISABLED,
      withSiloedBorrowing: DISABLED,
      flashloanable: ENABLED,
      ltv: 40_00,
      liqThreshold: 50_00,
      liqBonus: 5_00,
      reserveFactor: 20_00,
      supplyCap: 10_000,
      borrowCap: 5_000,
      debtCeiling: 100_000,
      liqProtocolFee: 20_00,
      rateStrategyParams: Rates.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(80_00),
        baseVariableBorrowRate: _bpsToRay(0_00),
        variableRateSlope1: _bpsToRay(10_00),
        variableRateSlope2: _bpsToRay(100_00),
        stableRateSlope1: _bpsToRay(10_00),
        stableRateSlope2: _bpsToRay(100_00),
        baseStableRateOffset: _bpsToRay(1_00),
        stableRateExcessOffset: _bpsToRay(),
        optimalStableToTotalDebtRatio: _bpsToRay(10_00)
      })
    });

    return listings;
  }
}
