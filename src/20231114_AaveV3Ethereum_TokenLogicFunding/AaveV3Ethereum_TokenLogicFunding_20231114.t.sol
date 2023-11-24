// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {CommonTestBase} from 'aave-helpers/CommonTestBase.sol';
import {AaveV3Ethereum_TokenLogicFunding_20231114} from './AaveV3Ethereum_TokenLogicFunding_20231114.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_TokenLogicFunding_20231114
 * command: make test-contract filter=AaveV3Ethereum_TokenLogicFunding_20231114
 */
contract AaveV3Ethereum_TokenLogicFunding_20231114_Test is CommonTestBase {
  AaveV3Ethereum_TokenLogicFunding_20231114 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18577793);
    proposal = AaveV3Ethereum_TokenLogicFunding_20231114(0x97D74bceC48b003FCd54Ae30e595028A38e8bBA1);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    uint256 balanceBefore = IERC20(proposal.GHO()).balanceOf(proposal.TOKENLOGIC());

    executePayload(vm, address(proposal));

    uint256 balanceAfter = IERC20(proposal.GHO()).balanceOf(proposal.TOKENLOGIC());

    assertEq(balanceAfter - balanceBefore, 115_000 * 1e18);
  }
}
