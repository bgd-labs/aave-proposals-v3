// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ILendingPool} from 'aave-address-book/AaveV2.sol';
import {ICollector} from 'aave-address-book/AaveV3.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase} from 'aave-helpers/src/ProtocolV2TestBase.sol';
import {ClinicStewardV2Activation_20250904} from './ClinicStewardV2Activation_20250904.sol';
import {BOT} from './AaveV2Deprecation_20250904.s.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';

interface ISteward {
  function availableBudget() external view returns (uint256);
  function POOL() external view returns (address);
  function COLLECTOR() external view returns (address);
  function ORACLE() external view returns (address);
}

abstract contract BaseActivationTest is ProtocolV2TestBase {
  uint256 public immutable BLOCK_NUMBER;
  ILendingPool public immutable POOL;
  address public immutable COLLECTOR;
  address public immutable STEWARD;
  uint256 public immutable BUDGET;

  ClinicStewardV2Activation_20250904 internal proposal;

  string public NETWORK_NAME;
  string public NETWORK_SUB_NAME;

  constructor(
    string memory networkName,
    string memory networkSubName,
    uint256 blocknumber,
    ILendingPool pool,
    ICollector collector,
    address steward,
    uint256 expectedBudget
  ) {
    NETWORK_NAME = networkName;
    NETWORK_SUB_NAME = networkSubName;

    BLOCK_NUMBER = blocknumber;
    POOL = pool;
    COLLECTOR = address(collector);
    STEWARD = steward;
    BUDGET = expectedBudget;
  }

  function setUp() external {
    vm.createSelectFork(vm.rpcUrl(NETWORK_NAME), BLOCK_NUMBER);

    proposal = new ClinicStewardV2Activation_20250904(COLLECTOR, STEWARD, BOT);
  }

  function test_defaultProposalExecution() public {
    string memory reportName = string(
      abi.encodePacked('ClinicStewardV2Activation_20250904_', NETWORK_NAME)
    );
    if (bytes(NETWORK_SUB_NAME).length > 0) {
      reportName = string(abi.encodePacked(reportName, '_', NETWORK_SUB_NAME));
    }

    defaultTest(reportName, POOL, address(proposal));

    assertTrue(IAccessControl(COLLECTOR).hasRole('FUNDS_ADMIN', proposal.STEWARD()));
    assertTrue(
      IAccessControl(proposal.STEWARD()).hasRole(keccak256('CLEANUP_ROLE'), proposal.CLEANUP_BOT())
    );

    assertEq(ISteward(proposal.STEWARD()).availableBudget(), BUDGET);
    assertEq(ISteward(proposal.STEWARD()).POOL(), address(POOL));
    assertEq(ISteward(proposal.STEWARD()).COLLECTOR(), address(COLLECTOR));
    assertEq(ISteward(proposal.STEWARD()).ORACLE(), POOL.getAddressesProvider().getPriceOracle());
  }
}
