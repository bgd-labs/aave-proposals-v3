// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from 'forge-std/Test.sol';
import {ERC1967Utils} from 'aave-v4/dependencies/openzeppelin/ERC1967Utils.sol';
// solhint-disable-next-line no-unused-import
import {SpokeInstance} from 'aave-v4/spoke/instances/SpokeInstance.sol'; // forces artifact build for vm.getDeployedCode
import {AaveV4PayloadEthereumSpoke} from './AaveV4PayloadEthereumSpoke.sol';

abstract contract AaveV4PayloadEthereumSpokeTestBase is Test {
  /// @dev keccak256 of the alphabetically-sorted `methodIdentifiers` keys from the locally-
  ///      compiled SpokeInstance artifact. Captured by running the test with bytes32(0); the
  ///      failure logs the actual hash and the full signature list. Re-pin on aave-v4 bumps.
  bytes32 internal constant CANONICAL_SPOKE_ABI_HASH =
    0x2eb338fb28a7172a4895f0baa27c978c48682ba77a0a74e483da7409da0ee22a;

  function _artifactPathByDeployedCode(bytes calldata code) external view returns (string memory) {
    return vm.getArtifactPathByDeployedCode(code);
  }

  function test_assumption_canonicalSpokeABI_unchanged() public {
    _assertCanonicalSpokeABI(CANONICAL_SPOKE_ABI_HASH);
  }

  function test_assumption_spokeConfiguratorSelectors_areOnCanonicalSpoke() public {
    _assertSelectorsAreOnCanonicalSpoke(_payload().spokeConfiguratorSelectors());
  }

  function test_assumption_spokeUserPositionUpdaterSelectors_areOnCanonicalSpoke() public {
    _assertSelectorsAreOnCanonicalSpoke(_payload().spokeUserPositionUpdaterSelectors());
  }

  function test_assumption_selectorGroupsAreDisjoint() public view {
    bytes4[] memory configuratorSelectors = _payload().spokeConfiguratorSelectors();
    bytes4[] memory updaterSelectors = _payload().spokeUserPositionUpdaterSelectors();
    for (uint256 i; i < configuratorSelectors.length; ++i) {
      for (uint256 j; j < updaterSelectors.length; ++j) {
        assertTrue(
          configuratorSelectors[i] != updaterSelectors[j],
          'configurator/updater selector overlap'
        );
      }
    }
  }

  function _assertSpokeImplIsCanonical(address spokeProxy) internal {
    bytes32 implementationSlot = vm.load(spokeProxy, ERC1967Utils.IMPLEMENTATION_SLOT);
    address implementation = address(uint160(uint256(implementationSlot)));
    require(implementation != address(0), 'spoke impl slot is zero');
    require(implementation.code.length > 0, 'spoke impl has no code');

    address canonical = _canonicalSpokeImplementation();
    if (canonical != address(0)) {
      require(
        implementation == canonical,
        string.concat('spoke impl is not canonical: ', vm.toString(implementation))
      );
      return;
    }

    try this._artifactPathByDeployedCode(implementation.code) returns (string memory path) {
      assertTrue(
        _endsWith(path, _canonicalSpokeArtifactSuffix()),
        string.concat('spoke impl resolved to non-canonical artifact: ', path)
      );
    } catch {
      revert('spoke impl bytecode matches no compiled artifact');
    }
  }

  function _assertCanonicalSpokeABI(bytes32 expectedHash) internal {
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

  function _assertSelectorsAreOnCanonicalSpoke(bytes4[] memory wrapperSelectors) internal {
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

  function _canonicalSpokeSignatures() internal returns (string[] memory) {
    bytes memory code = vm.getDeployedCode(_canonicalSpokeArtifact());
    string memory path = vm.getArtifactPathByDeployedCode(code);
    string memory json = vm.readFile(path);
    return vm.parseJsonKeys(json, '.methodIdentifiers');
  }

  function _payload() internal view virtual returns (AaveV4PayloadEthereumSpoke);

  /// @dev Subclasses provide the trusted canonical SpokeInstance impl address. When set to the
  ///      zero address, the assertion falls back to artifact-path matching — useful when the
  ///      project's compile settings align with the deployer's; otherwise prefer the explicit
  ///      address.
  function _canonicalSpokeImplementation() internal view virtual returns (address) {
    return address(0);
  }

  function _canonicalSpokeArtifact() internal pure virtual returns (string memory) {
    return 'SpokeInstance.sol';
  }

  function _canonicalSpokeArtifactSuffix() internal pure virtual returns (string memory) {
    return '/SpokeInstance.json';
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

  function _endsWith(string memory value, string memory suffix) internal pure returns (bool) {
    bytes memory valueBytes = bytes(value);
    bytes memory suffixBytes = bytes(suffix);
    if (valueBytes.length < suffixBytes.length) return false;
    uint256 offset = valueBytes.length - suffixBytes.length;
    for (uint256 i; i < suffixBytes.length; ++i) {
      if (valueBytes[offset + i] != suffixBytes[i]) return false;
    }
    return true;
  }
}
