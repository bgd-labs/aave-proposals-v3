// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

interface IExecutor {
  function queueTransaction(
    address target,
    uint256 value,
    string memory signature,
    bytes memory data,
    uint256 executionTime,
    bool withDelegatecall
  ) external returns (bytes32);

  function executeTransaction(
    address target,
    uint256 value,
    string memory signature,
    bytes memory data,
    uint256 executionTime,
    bool withDelegatecall
  ) external payable returns (bytes memory);

  function getDelay() external view returns (uint256);
}

/**
 * @title Migration of remaining gov v2 permissions
 * @author TODO
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130 is IProposalGenericExecutor {
  address public immutable PAYLOAD;

  uint256 public immutable EXECUTION_TIME;

  constructor(address payload, uint256 executionTime) {
    PAYLOAD = payload;
    EXECUTION_TIME = executionTime;
  }

  function execute() external {
    // mainnet payload
    IExecutor(AaveGovernanceV2.SHORT_EXECUTOR).queueTransaction(
      PAYLOAD,
      0,
      'execute()',
      '',
      EXECUTION_TIME,
      true
    );
    // l2 payload
    // IExecutor(AaveGovernanceV2.SHORT_EXECUTOR).queueTransaction(
    //   address(0), // forwarder
    //   0,
    //   'execute(address)',
    //   abi.encode(payloadAddress),
    //   EXECUTION_TIME,
    //   true
    // );
  }
}

contract AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_Part2_20240130 is
  IProposalGenericExecutor
{
  // referencing part1 as timing must be identical for the queue hash to match the executionHash
  AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130 immutable PART1;

  constructor(AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130 part1) {
    PART1 = part1;
  }

  function execute() external {
    // analog to first payload, but using executeTransaction
    IExecutor(AaveGovernanceV2.SHORT_EXECUTOR).executeTransaction(
      PART1.PAYLOAD(),
      0,
      'execute()',
      '',
      PART1.EXECUTION_TIME(),
      true
    );
  }
}
