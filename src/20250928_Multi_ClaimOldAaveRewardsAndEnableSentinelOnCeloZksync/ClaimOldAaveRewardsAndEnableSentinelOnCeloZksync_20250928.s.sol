// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript, CeloScript, ChainIds} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {GovernanceV3ZkSync} from 'aave-address-book/GovernanceV3ZkSync.sol';
import {AaveV2Ethereum_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928_Part1, AaveV2Ethereum_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928_Part2} from './AaveV2Ethereum_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.sol';
import {AaveV3Celo_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928} from './AaveV3Celo_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20250928_Multi_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync/ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.s.sol/1/run-latest.json
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
        type(AaveV2Ethereum_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928_Part1)
          .creationCode,
        abi.encode(executionTime)
      )
    );
    address payload1 = GovV3Helpers.deployDeterministic(
      abi.encodePacked(
        type(AaveV2Ethereum_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928_Part2)
          .creationCode,
        payload0
      )
    );

    // register action at payloadsController
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(payload0));
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(payload1));
  }
}

/**
 * @dev Deploy Celo
 * deploy-command: make deploy-ledger contract=src/20250928_Multi_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync/ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.s.sol:DeployCelo chain=celo
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.s.sol/42220/run-latest.json
 */
contract DeployCelo is CeloScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Celo_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928).creationCode
    );

    // register action at payloadsController
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(payload0));
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20250928_Multi_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync/ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](4);

    // compose actions for validation
    {
      payloads[0] = GovV3Helpers.buildMainnetPayload(vm, GovV3Helpers.buildAction(address(0))); // TODO: payload part 1
    }

    {
      payloads[1] = GovV3Helpers.buildMainnetPayload(vm, GovV3Helpers.buildAction(address(0))); // TODO: payload part 2
    }

    {
      payloads[2] = PayloadsControllerUtils.Payload({
        chain: ChainIds.ZKSYNC,
        accessLevel: PayloadsControllerUtils.AccessControl.Level_1,
        payloadsController: address(GovernanceV3ZkSync.PAYLOADS_CONTROLLER),
        payloadId: 0 // TODO
      });
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsCelo = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsCelo[0] = GovV3Helpers.buildAction(
        type(AaveV3Celo_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928).creationCode
      );
      payloads[3] = GovV3Helpers.buildCeloPayload(vm, actionsCelo);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250928_Multi_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync/ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync.md'
      )
    );
  }
}
