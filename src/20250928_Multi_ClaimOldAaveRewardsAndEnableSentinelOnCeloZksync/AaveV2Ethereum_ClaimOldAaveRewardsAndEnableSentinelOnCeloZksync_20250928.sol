// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';

import {IAaveIncentivesController} from './interfaces/IAaveIncentivesController.sol';
import {IExecutor} from './interfaces/IExecutor.sol';

/**
 * @dev payload to be called by the short executor (gov v2) to claim rewards
 * @title Claim old Aave rewards and enable sentinel on celo, zksync
 * @author BGD Labs (@bgdlabs)
 * - Discussion: TODO
 */
contract AaveV2Ethereum_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928 is
  IProposalGenericExecutor
{
  function execute() external {
    IAaveIncentivesController(AaveV2Ethereum.DEFAULT_INCENTIVES_CONTROLLER).setClaimer(
      address(AaveV2Ethereum.COLLECTOR),
      AaveGovernanceV2.SHORT_EXECUTOR
    );

    IAaveIncentivesController(AaveV2Ethereum.DEFAULT_INCENTIVES_CONTROLLER).claimRewardsOnBehalf(
      new address[](0),
      type(uint256).max,
      address(AaveV2Ethereum.COLLECTOR),
      address(AaveV2Ethereum.COLLECTOR)
    );
  }
}

/**
 * @dev part 1 payload: used to queue payload on govV2 (short-executor)
 *      payload to be called by executor-lvl-1 (govV3)
 * @title Claim old Aave rewards and temp disable BTC.b PoR
 * @author BGD Labs (@bgdlabs)
 * - Discussion: TODO
 */
contract AaveV2Ethereum_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928_Part1 is
  IProposalGenericExecutor
{
  uint256 public immutable EXECUTION_TIME;
  address public immutable PAYLOAD;

  constructor(uint256 executionTime) {
    PAYLOAD = address(
      new AaveV2Ethereum_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928()
    );
    EXECUTION_TIME = executionTime;
  }

  function execute() external {
    IExecutor(AaveGovernanceV2.SHORT_EXECUTOR).queueTransaction(
      PAYLOAD,
      0,
      'execute()',
      '',
      EXECUTION_TIME,
      true
    );
  }
}

/**
 * @dev part 2 payload: used to execute payload using short-executor (govV2)
 *      payload to be called by executor-lvl-1 (govV3)
 * @title Claim old Aave rewards and temp disable BTC.b PoR
 * @author BGD Labs (@bgdlabs)
 * - Discussion: TODO
 */
contract AaveV2Ethereum_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928_Part2 is
  IProposalGenericExecutor
{
  // referencing part1 as timing must be identical for the queue hash to match the executionHash
  AaveV2Ethereum_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928_Part1 immutable PART_1;

  constructor(
    AaveV2Ethereum_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928_Part1 part1
  ) {
    PART_1 = part1;
  }

  function execute() external {
    IExecutor(AaveGovernanceV2.SHORT_EXECUTOR).executeTransaction(
      PART_1.PAYLOAD(),
      0,
      'execute()',
      '',
      PART_1.EXECUTION_TIME(),
      true
    );
  }
}
