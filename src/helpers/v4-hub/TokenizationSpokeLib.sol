// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';

/// @title TokenizationSpokeLib
/// @notice Locates the TokenizationSpoke registered on a Hub for a given asset. Only a
///         TokenizationSpoke exposes `asset()`, so probing it uniquely identifies the ERC4626
///         wrapper among an asset's registered spokes (the user spoke and fee receiver do not).
library TokenizationSpokeLib {
  /// @return The TokenizationSpoke registered on `hub` for `underlying`, or address(0) if none.
  ///         Reverts if more than one matches.
  function find(IHub hub, address underlying) internal view returns (address) {
    uint256 assetId = hub.getAssetId(underlying);
    uint256 spokeCount = hub.getSpokeCount(assetId);
    address found;
    for (uint256 i; i < spokeCount; ++i) {
      address candidate = hub.getSpokeAddress(assetId, i);
      (bool ok, bytes memory data) = candidate.staticcall(abi.encodeWithSignature('asset()'));
      if (!ok || data.length < 32 || abi.decode(data, (address)) != underlying) continue;
      require(found == address(0), 'multiple tokenization spokes match');
      found = candidate;
    }
    return found;
  }
}
