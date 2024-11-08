// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {IAaveOracle} from 'aave-v3-origin/contracts/interfaces/IAaveOracle.sol';
import {IPriceCapAdapterStable} from './interfaces/IPriceCapAdapterStable.sol';
import {ICLSynchronicityPriceAdapterBaseToPeg} from './interfaces/ICLSynchronicityPriceAdapterBaseToPeg.sol';

abstract contract BasePayloadETHFeedTest is Test {
  function _validateETHPriceFeed(
    address underlying,
    address previousFeed,
    address newFeed,
    address newAssetToPeg
  ) public {
    assertEq(
      ICLSynchronicityPriceAdapterBaseToPeg(previousFeed).latestAnswer(),
      ICLSynchronicityPriceAdapterBaseToPeg(newFeed).latestAnswer()
    );
    assertEq(
      ICLSynchronicityPriceAdapterBaseToPeg(previousFeed).BASE_TO_PEG(),
      ICLSynchronicityPriceAdapterBaseToPeg(newFeed).BASE_TO_PEG()
    );
    assertNotEq(
      ICLSynchronicityPriceAdapterBaseToPeg(newFeed).BASE_TO_PEG(),
      ICLSynchronicityPriceAdapterBaseToPeg(newFeed).ASSET_TO_PEG()
    );
    assertEq(ICLSynchronicityPriceAdapterBaseToPeg(newFeed).ASSET_TO_PEG(), newAssetToPeg);
    assertEq(
      ICLSynchronicityPriceAdapterBaseToPeg(previousFeed).description(),
      ICLSynchronicityPriceAdapterBaseToPeg(newFeed).description()
    );

    assertFalse(IPriceCapAdapterStable(newAssetToPeg).isCapped());

    // we expect revert as the previousFeed's ASSET_TO_PEG does not have this method
    address prevFeedAssetToPeg = ICLSynchronicityPriceAdapterBaseToPeg(previousFeed).ASSET_TO_PEG();
    vm.expectRevert();
    IPriceCapAdapterStable(prevFeedAssetToPeg).getPriceCap();

    assertEq(IAaveOracle(getAaveOracle()).getSourceOfAsset(underlying), newFeed);

    if (
      keccak256(bytes(IPriceCapAdapterStable(newAssetToPeg).description())) ==
      keccak256(bytes('Capped LUSD/USD'))
    ) {
      assertEq(IPriceCapAdapterStable(newAssetToPeg).getPriceCap(), 1_10000000);
    } else {
      assertEq(IPriceCapAdapterStable(newAssetToPeg).getPriceCap(), 1_04000000);
    }
  }

  function getAaveOracle() public virtual returns (address);
}
