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
 * @title Migration of remaining gov v2 executor controlled systems Part1
 * - migrating paraswap positive slippage
 * - migrating arc permissions
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x4fd357741900bfe62a863d1e3ec84fbf79bfebd5bdda3f66eee75b8845274b6d
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/17
 */
contract AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130 is IProposalGenericExecutor {
  address public immutable MAINNET_PAYLOAD;
  address public immutable POLYGON_PAYLOAD;

  uint256 public immutable EXECUTION_TIME;

  constructor(address mainnetPayload, address polygonPayload, uint256 executionTime) {
    MAINNET_PAYLOAD = mainnetPayload;
    POLYGON_PAYLOAD = polygonPayload;
    EXECUTION_TIME = executionTime;
  }

  function execute() external {
    // mainnet payload
    IExecutor(AaveGovernanceV2.SHORT_EXECUTOR).queueTransaction(
      MAINNET_PAYLOAD,
      0,
      'execute()',
      '',
      EXECUTION_TIME,
      true
    );
    // l2 payload
    IExecutor(AaveGovernanceV2.SHORT_EXECUTOR).queueTransaction(
      address(AaveGovernanceV2.CROSSCHAIN_FORWARDER_POLYGON),
      0,
      'execute(address)',
      abi.encode(POLYGON_PAYLOAD),
      EXECUTION_TIME,
      true
    );
  }
}

/**
 * @title Migration of remaining gov v2 executor controlled systems Part2
 * - migrating paraswap positive slippage
 * - migrating arc permissions
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x4fd357741900bfe62a863d1e3ec84fbf79bfebd5bdda3f66eee75b8845274b6d
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/17
 */
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
      PART1.MAINNET_PAYLOAD(),
      0,
      'execute()',
      '',
      PART1.EXECUTION_TIME(),
      true
    );

    IExecutor(AaveGovernanceV2.SHORT_EXECUTOR).executeTransaction(
      address(AaveGovernanceV2.CROSSCHAIN_FORWARDER_POLYGON),
      0,
      'execute(address)',
      abi.encode(PART1.POLYGON_PAYLOAD()),
      PART1.EXECUTION_TIME(),
      true
    );
  }
}
