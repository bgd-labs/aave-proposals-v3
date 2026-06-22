// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from 'forge-std/Test.sol';
import {Vm} from 'forge-std/Vm.sol';
// solhint-disable-next-line no-unused-import
import {SpokeInstance} from 'aave-v4/spoke/instances/SpokeInstance.sol'; // forces artifact build for vm.getDeployedCode
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {AaveV4PayloadEthereumSpoke} from './AaveV4PayloadSpoke.sol';

abstract contract AaveV4PayloadEthereumSpokeTestBase is Test {
  /// @dev keccak256 of the sorted SpokeInstance `methodIdentifiers`. Re-pin on aave-v4 bumps; a
  ///      mismatch logs the actual hash and signature list.
  bytes32 internal constant CANONICAL_SPOKE_ABI_HASH =
    0x2eb338fb28a7172a4895f0baa27c978c48682ba77a0a74e483da7409da0ee22a;

  function test_assumption_canonicalSpokeABI_unchanged() public view {
    _assertCanonicalSpokeABI(CANONICAL_SPOKE_ABI_HASH);
  }

  function test_assumption_spokeConfiguratorSelectors_areOnCanonicalSpoke() public view {
    _assertSelectorsAreOnCanonicalSpoke(Roles.getSpokeConfiguratorRoleSelectors());
  }

  function test_assumption_spokeUserPositionUpdaterSelectors_areOnCanonicalSpoke() public view {
    _assertSelectorsAreOnCanonicalSpoke(Roles.getSpokePositionUpdaterRoleSelectors());
  }

  function test_assumption_selectorGroupsAreDisjoint() public pure {
    bytes4[] memory configuratorSelectors = Roles.getSpokeConfiguratorRoleSelectors();
    bytes4[] memory updaterSelectors = Roles.getSpokePositionUpdaterRoleSelectors();
    for (uint256 i; i < configuratorSelectors.length; ++i) {
      for (uint256 j; j < updaterSelectors.length; ++j) {
        assertTrue(
          configuratorSelectors[i] != updaterSelectors[j],
          'configurator/updater selector overlap'
        );
      }
    }
  }

  function _assertCanonicalSpokeABI(bytes32 expectedHash) internal view {
    string[] memory signatures = _canonicalSpokeSignatures();
    bytes32 actualHash = _hashSignatures(signatures);
    if (actualHash != expectedHash) {
      console.log('Canonical Spoke ABI hash mismatch.');
      console.log('Got hash:');
      console.logBytes32(actualHash);
      console.log('Current sorted signatures:');
      for (uint256 i; i < signatures.length; ++i) console.log(signatures[i]);
      revert('Update CANONICAL_SPOKE_ABI_HASH and review wrapper selector lists.');
    }
  }

  function _assertSelectorsAreOnCanonicalSpoke(bytes4[] memory wrapperSelectors) internal view {
    string[] memory signatures = _canonicalSpokeSignatures();
    bytes4[] memory canonicalSelectors = new bytes4[](signatures.length);
    for (uint256 i; i < signatures.length; ++i) {
      canonicalSelectors[i] = bytes4(keccak256(bytes(signatures[i])));
    }
    for (uint256 i; i < wrapperSelectors.length; ++i) {
      bool found;
      for (uint256 j; j < canonicalSelectors.length; ++j) {
        if (wrapperSelectors[i] == canonicalSelectors[j]) {
          found = true;
          break;
        }
      }
      if (!found) {
        console.log('Wrapper selector missing from canonical Spoke ABI:');
        console.logBytes4(wrapperSelectors[i]);
        revert('selector not present on canonical Spoke');
      }
    }
  }

  function _canonicalSpokeSignatures() internal view returns (string[] memory) {
    bytes memory code = vm.getDeployedCode(_canonicalSpokeArtifact());
    string memory path = vm.getArtifactPathByDeployedCode(code);
    string memory json = vm.readFile(path);
    return vm.parseJsonKeys(json, '.methodIdentifiers');
  }

  function _payload() internal view virtual returns (AaveV4PayloadEthereumSpoke);

  function _canonicalSpokeArtifact() internal pure virtual returns (string memory) {
    return 'SpokeInstance.sol';
  }

  function _hashSignatures(string[] memory signatures) internal pure returns (bytes32) {
    return keccak256(abi.encode(_sortStrings(signatures)));
  }

  function _sortStrings(string[] memory strings) internal pure returns (string[] memory) {
    for (uint256 i; i < strings.length; ++i) {
      for (uint256 j = i + 1; j < strings.length; ++j) {
        if (_stringLessThan(strings[j], strings[i])) {
          string memory tmp = strings[i];
          strings[i] = strings[j];
          strings[j] = tmp;
        }
      }
    }
    return strings;
  }

  function _stringLessThan(string memory left, string memory right) internal pure returns (bool) {
    bytes memory leftBytes = bytes(left);
    bytes memory rightBytes = bytes(right);
    uint256 minLength = leftBytes.length < rightBytes.length ? leftBytes.length : rightBytes.length;
    for (uint256 i; i < minLength; ++i) {
      if (leftBytes[i] < rightBytes[i]) return true;
      if (leftBytes[i] > rightBytes[i]) return false;
    }
    return leftBytes.length < rightBytes.length;
  }

  /// @dev Asserts `logs` contains an event from `emitter` with topic[0] == `selector` and indexed
  ///      topics matching `indexedArgs` as a prefix.
  function _assertEventEmitted(
    Vm.Log[] memory logs,
    address emitter,
    bytes32 selector,
    bytes32[] memory indexedArgs,
    string memory errMsg
  ) internal pure {
    for (uint256 i; i < logs.length; ++i) {
      Vm.Log memory entry = logs[i];
      if (entry.emitter != emitter) continue;
      if (entry.topics.length < 1 + indexedArgs.length) continue;
      if (entry.topics[0] != selector) continue;
      bool matched = true;
      for (uint256 j; j < indexedArgs.length; ++j) {
        if (entry.topics[1 + j] != indexedArgs[j]) {
          matched = false;
          break;
        }
      }
      if (matched) return;
    }
    assertTrue(false, errMsg);
  }
}
