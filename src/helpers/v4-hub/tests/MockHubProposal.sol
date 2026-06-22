// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';

import {AaveV4PayloadEthereumHub} from '../AaveV4PayloadHub.sol';

/// @dev Hub-only payload that lists an asset on a freshly-deployed Hub, used to exercise the Hub
///      test base in isolation.
contract MockHubProposal is AaveV4PayloadEthereumHub {
  IHub internal constant NEW_HUB = IHub(0x00000000000000000000000000000000000000A1);
  address internal constant ASSET = address(0xC1);
  address internal constant IR_STRATEGY = address(0xD1);

  function newHubs() public pure override returns (IHub[] memory) {
    IHub[] memory hubs = new IHub[](1);
    hubs[0] = NEW_HUB;
    return hubs;
  }

  /// @dev Test-only accessor for the internal `_hubName` resolution (override + base + revert).
  function exposedHubName(IHub hub) public pure returns (string memory) {
    return _hubName(hub);
  }

  function _hubName(IHub hub) internal pure override returns (string memory) {
    if (hub == NEW_HUB) return 'Mock';
    return super._hubName(hub);
  }

  function _hubAssetListings() internal pure override returns (HubAssetListing[] memory) {
    HubAssetListing[] memory listings = new HubAssetListing[](1);
    listings[0] = HubAssetListing({
      hub: NEW_HUB,
      underlying: ASSET,
      liquidityFee: 10_00,
      irStrategy: IR_STRATEGY,
      irData: _nonBorrowableIRData(),
      tokenization: _tokenization(NEW_HUB, 'MOCK', 0)
    });
    return listings;
  }
}
