// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ClaimZKSyncAirdrop_20241219} from './AaveV3Ethereum_ClaimZKSyncAirdrop_20241219.sol';

contract TestGetETHFromCollector is AaveV3Ethereum_ClaimZKSyncAirdrop_20241219 {
  function _getETHFromCollector(uint256 amount) public {
    return getETHFromCollector(amount);
  }
}

/**
 * @dev Test for AaveV3Ethereum_ClaimZKSyncAirdrop_20241219
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241219_AaveV3Ethereum_ClaimZKSyncAirdrop/AaveV3Ethereum_ClaimZKSyncAirdrop_20241219.t.sol -vv
 */
contract AaveV3Ethereum_ClaimZKSyncAirdrop_20241219_Test is ProtocolV3TestBase {
  AaveV3Ethereum_ClaimZKSyncAirdrop_20241219 internal proposal;
  TestGetETHFromCollector internal testGetETHFromCollector;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21437605);
    proposal = new AaveV3Ethereum_ClaimZKSyncAirdrop_20241219();
    testGetETHFromCollector = new TestGetETHFromCollector();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    uint256 mintValueClaim = 786432000000000;
    uint256 mintValueTransfer = 1328196266668064768;

    vm.assertGe(GovernanceV3Ethereum.EXECUTOR_LVL_1.balance, mintValueClaim + mintValueTransfer);

    defaultTest(
      'AaveV3Ethereum_ClaimZKSyncAirdrop_20241219',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_ETHTransfer() public {
    uint256 mintValueClaim = 786432000000000;
    uint256 mintValueTransfer = 1328196266668064768;

    vm.assertEq(GovernanceV3Ethereum.EXECUTOR_LVL_1.balance, 0);

    testGetETHFromCollector._getETHFromCollector(mintValueClaim + mintValueTransfer);

    vm.assertEq(GovernanceV3Ethereum.EXECUTOR_LVL_1.balance, mintValueClaim + mintValueTransfer);

    emit log_uint(GovernanceV3Ethereum.EXECUTOR_LVL_1.balance);
    emit log_uint(mintValueClaim);
    emit log_uint(mintValueTransfer);
  }
}
