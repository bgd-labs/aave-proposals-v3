// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPool, ICollector} from 'aave-address-book/AaveV3.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {ActivationPayload_20250228} from './ActivationPayload_20250228.sol';
import {BOT} from './ClinicStewardActivation_20250228.s.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';

interface ISteward {
  function availableBudget() external view returns (uint256);
}

abstract contract BaseActivationTest is ProtocolV3TestBase {
  uint256 public immutable BLOCK_NUMBER;
  IPool public immutable POOL;
  address public immutable COLLECTOR;
  address public immutable STEWARD;
  uint256 public immutable BUDGET;
  ActivationPayload_20250228 internal proposal;
  string public NETWORK;

  constructor(
    string memory network,
    uint256 blocknumber,
    IPool pool,
    ICollector collector,
    address steward,
    uint256 expectedBudget
  ) {
    NETWORK = network;
    BLOCK_NUMBER = blocknumber;
    POOL = pool;
    COLLECTOR = address(collector);
    STEWARD = steward;
    BUDGET = expectedBudget;
  }

  function setUp() external {
    vm.createSelectFork(vm.rpcUrl(NETWORK), BLOCK_NUMBER);
    proposal = new ActivationPayload_20250228(COLLECTOR, STEWARD, BOT);
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      string(abi.encodePacked('ActivationPayload_20250228', NETWORK)),
      POOL,
      address(proposal)
    );

    IAccessControl(COLLECTOR).hasRole('FUNDS_ADMIN', proposal.STEWARD());
    IAccessControl(proposal.STEWARD()).hasRole(keccak256('CLEANUP_ROLE'), proposal.CLEANUP_BOT());
    assertEq(ISteward(proposal.STEWARD()).availableBudget(), BUDGET);
  }
}
