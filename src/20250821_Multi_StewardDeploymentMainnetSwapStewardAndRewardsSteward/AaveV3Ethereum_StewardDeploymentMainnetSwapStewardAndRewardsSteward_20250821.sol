// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {EmissionManager} from 'aave-v3-origin/contracts/rewards/EmissionManager.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

interface IMainnetSwapSteward {
  function increaseTokenBudget(address token, uint256 budget) external;
  function setSwappablePair(address fromToken, address toToken, bool allowed) external;
  function setTokenOracle(address token, address oracle) external;
}

/**
 * @title Steward Deployment: MainnetSwapSteward and RewardsSteward
 * @author @TokenLogic
 * - Snapshot: PENDING
 * - Discussion: PENDING
 */
contract AaveV3Ethereum_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821 is
  IProposalGenericExecutor
{
  // https://etherscan.io/address/0x2C7f01A1322ce99EEB331d6Eb73Aff400f11C5CB
  address public constant REWARDS_STEWARD = 0x2C7f01A1322ce99EEB331d6Eb73Aff400f11C5CB;

  // https://etherscan.io/address/0xb7D402138Cb01BfE97d95181C849379d6AD14d19
  address public constant SWAP_STEWARD = 0xb7D402138Cb01BfE97d95181C849379d6AD14d19;

  function execute() external {
    // RewardsSteward
    EmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setClaimer(
      address(AaveV3Ethereum.COLLECTOR),
      REWARDS_STEWARD
    );

    // MainnetSwapSteward
    // Token: A
    // IMainnetSwapSteward(SWAP_STEWARD).setSwappablePair();
    // IMainnetSwapSteward(SWAP_STEWARD).setTokenOracle();
    // IMainnetSwapSteward(SWAP_STEWARD).increaseTokenBudget();
  }
}
