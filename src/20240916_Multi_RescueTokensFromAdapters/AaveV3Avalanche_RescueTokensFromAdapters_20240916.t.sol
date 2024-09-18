// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {IERC20} from 'aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_RescueTokensFromAdapters_20240916} from './AaveV3Avalanche_RescueTokensFromAdapters_20240916.sol';

/**
 * @dev Test for AaveV3Avalanche_RescueTokensFromAdapters_20240916
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20240912_Multi_RescueTokensFromAdapters/AaveV3Avalanche_RescueTokensFromAdapters_20240916.t.sol -vv
 */
contract AaveV3Avalanche_RescueTokensFromAdapters_20240916_Test is ProtocolV3TestBase {
  AaveV3Avalanche_RescueTokensFromAdapters_20240916 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 50442202);
    proposal = new AaveV3Avalanche_RescueTokensFromAdapters_20240916();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_RescueTokensFromAdapters_20240916',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }

  function test_isTokensRescued() external {
    uint256 WBTCeACLAdminInitialBalance = IERC20(AaveV3AvalancheAssets.WBTCe_UNDERLYING).balanceOf(
      AaveV3Avalanche.ACL_ADMIN
    );

    uint256 WBTCeTransferred = IERC20(AaveV3AvalancheAssets.WBTCe_UNDERLYING).balanceOf(
      proposal.ADAPTER_0()
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3AvalancheAssets.WBTCe_UNDERLYING).balanceOf(proposal.ADAPTER_0()),
      0,
      'Unexpected WBTCe_UNDERLYING remaining'
    );
    assertEq(
      WBTCeACLAdminInitialBalance + WBTCeTransferred,
      IERC20(AaveV3AvalancheAssets.WBTCe_UNDERLYING).balanceOf(AaveV3Avalanche.ACL_ADMIN),
      'Unexpected WBTCe_UNDERLYING final treasury balance'
    );
  }
}
