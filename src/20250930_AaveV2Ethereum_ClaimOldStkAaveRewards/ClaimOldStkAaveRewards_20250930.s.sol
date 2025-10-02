// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV2Ethereum_ClaimOldStkAaveRewards_20250930_Part1, AaveV2Ethereum_ClaimOldStkAaveRewards_20250930_Part2} from './AaveV2Ethereum_ClaimOldStkAaveRewards_20250930.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20250930_AaveV2Ethereum_ClaimOldStkAaveRewards/ClaimOldStkAaveRewards_20250930.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/ClaimOldStkAaveRewards_20250930.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    uint256 executionTime = block.timestamp +
      5 days + // Governance
      1 days + // Executor delay
      1 days; // Margin for error (time between payload deployment & proposal creation)

    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      abi.encodePacked(
        type(AaveV2Ethereum_ClaimOldStkAaveRewards_20250930_Part1).creationCode,
        abi.encode(executionTime)
      )
    );
    address payload1 = GovV3Helpers.deployDeterministic(
      abi.encodePacked(
        type(AaveV2Ethereum_ClaimOldStkAaveRewards_20250930_Part2).creationCode,
        abi.encode(payload0)
      )
    );

    // register action at payloadsController
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(payload0));
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(payload1));
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20250930_AaveV2Ethereum_ClaimOldStkAaveRewards/ClaimOldStkAaveRewards_20250930.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](2);

    // compose actions for validation
    payloads[0] = GovV3Helpers.buildMainnetPayload(
      vm,
      GovV3Helpers.buildAction(0xDeE236343caB418810DC323F1cB2553Db569926a)
    );
    payloads[1] = GovV3Helpers.buildMainnetPayload(
      vm,
      GovV3Helpers.buildAction(0x8b19CB7F294d38E2dEA04658129f8a10F6bb1002)
    );

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250930_AaveV2Ethereum_ClaimOldStkAaveRewards/ClaimOldStkAaveRewards.md'
      )
    );
  }
}
