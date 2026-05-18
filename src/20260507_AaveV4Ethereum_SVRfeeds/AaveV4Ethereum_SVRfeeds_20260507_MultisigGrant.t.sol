// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IAccessManagerEnumerable} from 'aave-address-book/AaveV4.sol';
import {IAccessManager} from 'aave-v4/dependencies/openzeppelin/IAccessManager.sol';
import {AaveV4Ethereum} from 'aave-address-book/AaveV4Ethereum.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {V4Constants} from 'src/helpers/v4-constants/V4Constants.sol';
import {V4SafeHelpers} from 'src/helpers/v4-constants/V4SafeHelpers.sol';
import {ISafeAccount} from 'src/interfaces/ISafeAccount.sol';

/**
 * @title AaveV4Ethereum_SVRfeeds_20260507_MultisigGrant_Test
 * @author Aave Labs
 * @notice Standalone test for the SECURITY_COUNCIL multisig action that must run
 * BEFORE the SVR migration payload. Simulates the council Safe granting
 * SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE (id 400) to the EXECUTOR.
 *
 * command:
 *   FOUNDRY_PROFILE=test forge test --match-path=src/20260507_AaveV4Ethereum_SVRfeeds/AaveV4Ethereum_SVRfeeds_20260507_MultisigGrant.t.sol -vv
 */
contract AaveV4Ethereum_SVRfeeds_20260507_MultisigGrant_Test is Test {
  IAccessManagerEnumerable internal constant ACCESS_MANAGER = AaveV4Ethereum.ACCESS_MANAGER;
  address internal constant SECURITY_COUNCIL = V4Constants.SECURITY_COUNCIL;
  address internal constant EXECUTOR = V4Constants.EXECUTOR;
  bytes internal constant CALLDATA =
    hex'25c471a0000000000000000000000000000000000000000000000000000000000000019000000000000000000000000014339e2178a954d5fb839d5ff31644fe0f25f5170000000000000000000000000000000000000000000000000000000000000000';
  bytes internal txCalldata;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25043850);

    txCalldata = abi.encodeCall(
      IAccessManager.grantRole,
      (Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE, EXECUTOR, 0)
    );
  }

  /// @notice Pre-grant check on mainnet: EXECUTOR has the HUB role but
  /// NOT the SPOKE role.
  function test_preGrant_executorHasOnlyHubRole() public view {
    (bool hasHub, ) = ACCESS_MANAGER.hasRole(Roles.HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE, EXECUTOR);
    assertTrue(hasHub, 'pre-grant: EXECUTOR should have HUB role');

    (bool hasSpoke, ) = ACCESS_MANAGER.hasRole(
      Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE,
      EXECUTOR
    );
    assertFalse(hasSpoke, 'pre-grant: EXECUTOR should NOT have SPOKE role yet');
  }

  /// @notice Post-grant check: after the council Safe executes the grant tx,
  /// EXECUTOR holds the SPOKE role and the HUB role is unchanged.
  function test_postGrant_executorGainsSpokeRole_keepsHubRole() public {
    _executeMultisigGrant();

    (bool hasSpoke, ) = ACCESS_MANAGER.hasRole(
      Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE,
      EXECUTOR
    );
    assertTrue(hasSpoke, 'post-grant: EXECUTOR should have SPOKE role');

    (bool hasHub, ) = ACCESS_MANAGER.hasRole(Roles.HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE, EXECUTOR);
    assertTrue(hasHub, 'post-grant: HUB role must remain untouched');
  }

  /// @notice The exact AccessManager calldata that the council Safe needs to sign.
  function test_grantCalldata_selector() public view {
    assertEq(
      bytes4(txCalldata),
      IAccessManager.grantRole.selector,
      'unexpected grantRole selector'
    );
  }

  function test_calldata_matches_tx() public view {
    assertEq(txCalldata, CALLDATA, 'calldata mismatch');
  }

  // ================================================================
  // Helpers
  // ================================================================

  /// @dev Build the security council Safe tx
  function _executeMultisigGrant() internal {
    V4SafeHelpers.Action memory action = V4SafeHelpers.Action({
      to: address(ACCESS_MANAGER),
      data: txCalldata
    });
    (address to, bytes memory data, uint8 operation) = V4SafeHelpers.createSafeCalldata(action);

    _executeSafeTx({safe: SECURITY_COUNCIL, to: to, data: data, operation: operation});
  }

  /// @dev Execute a Safe transaction: drop signer threshold to 1, force-set nonce
  function _executeSafeTx(address safe, address to, bytes memory data, uint8 operation) internal {
    // Threshold lives at slot 4, nonce at slot 5 in Gnosis Safe storage.
    vm.store(safe, bytes32(uint256(4)), bytes32(uint256(1)));
    address signer = ISafeAccount(safe).getOwners()[0];

    vm.prank(signer);
    (bool ok, bytes memory ret) = safe.call(
      abi.encodeCall(
        ISafeAccount.execTransaction,
        (
          to,
          0, // value
          data,
          operation,
          0, // safeTxGas
          0, // baseGas
          0, // gasPrice
          address(0), // gasToken
          payable(address(0)), // refundReceiver
          abi.encodePacked(bytes32(uint256(uint160(signer))), bytes32(0), uint8(1))
        )
      )
    );

    if (!ok) {
      if (ret.length > 0) {
        assembly {
          revert(add(ret, 32), mload(ret))
        }
      }
      revert('_executeSafeTx: unknown error');
    }
  }
}
