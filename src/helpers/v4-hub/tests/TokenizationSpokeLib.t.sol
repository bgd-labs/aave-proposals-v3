// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';

import {TokenizationSpokeLib} from '../TokenizationSpokeLib.sol';

/// @dev Minimal spoke exposing `asset()`, like a TokenizationSpoke.
contract MockAssetSpoke {
  address public asset;

  constructor(address asset_) {
    asset = asset_;
  }
}

/// @dev Spoke without an `asset()` selector (e.g. the user spoke / fee receiver), which the
///      library must skip rather than match.
contract MockPlainSpoke {}

/// @dev Stub Hub exposing only the three functions `TokenizationSpokeLib.find` calls.
contract MockTokenizationHub {
  address[] internal _spokes;

  function setSpokes(address[] memory spokes_) external {
    _spokes = spokes_;
  }

  function getAssetId(address) external pure returns (uint256) {
    return 1;
  }

  function getSpokeCount(uint256) external view returns (uint256) {
    return _spokes.length;
  }

  function getSpokeAddress(uint256, uint256 index) external view returns (address) {
    return _spokes[index];
  }
}

/// @dev External boundary so `vm.expectRevert` intercepts the library's `require`.
contract TokenizationSpokeLibHarness {
  function find(IHub hub, address underlying) external view returns (address) {
    return TokenizationSpokeLib.find(hub, underlying);
  }
}

/**
 * @dev command: forge test --match-path=src/helpers/v4-hub/tests/TokenizationSpokeLib.t.sol -vv
 */
contract TokenizationSpokeLibTest is Test {
  address internal constant UNDERLYING = address(0xABCD);
  address internal constant OTHER_ASSET = address(0xBEEF);

  MockTokenizationHub internal hub;
  TokenizationSpokeLibHarness internal harness;

  function setUp() public {
    hub = new MockTokenizationHub();
    harness = new TokenizationSpokeLibHarness();
  }

  function test_find_returnsZeroWhenNoSpokeMatches() public {
    address[] memory spokes = new address[](2);
    spokes[0] = address(new MockPlainSpoke()); // no asset() selector → staticcall fails, skipped
    spokes[1] = address(new MockAssetSpoke(OTHER_ASSET)); // asset() != underlying
    hub.setSpokes(spokes);

    assertEq(harness.find(IHub(address(hub)), UNDERLYING), address(0));
  }

  function test_find_returnsTheSingleMatchingSpoke() public {
    address matching = address(new MockAssetSpoke(UNDERLYING));
    address[] memory spokes = new address[](3);
    spokes[0] = address(new MockPlainSpoke());
    spokes[1] = matching;
    spokes[2] = address(new MockAssetSpoke(OTHER_ASSET));
    hub.setSpokes(spokes);

    assertEq(harness.find(IHub(address(hub)), UNDERLYING), matching);
  }

  function test_find_revertsWhenMultipleSpokesMatch() public {
    address[] memory spokes = new address[](2);
    spokes[0] = address(new MockAssetSpoke(UNDERLYING));
    spokes[1] = address(new MockAssetSpoke(UNDERLYING));
    hub.setSpokes(spokes);

    vm.expectRevert(bytes('multiple tokenization spokes match'));
    harness.find(IHub(address(hub)), UNDERLYING);
  }
}
