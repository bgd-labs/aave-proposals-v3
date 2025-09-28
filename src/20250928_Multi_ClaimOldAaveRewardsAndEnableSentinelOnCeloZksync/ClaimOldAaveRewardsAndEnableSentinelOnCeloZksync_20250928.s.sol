// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript, CeloScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV2Ethereum_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928} from './AaveV2Ethereum_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.sol';
import {AaveV3Celo_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928} from './AaveV3Celo_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20250928_Multi_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync/ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV2Ethereum_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928).creationCode
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
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

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20250928_Multi_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync/ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](3);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsEthereum[0] = GovV3Helpers.buildAction(
        type(AaveV2Ethereum_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928).creationCode
      );
      payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsZkSync = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsZkSync[0] = GovV3Helpers.buildActionZkSync(
        vm,
        'AaveV3ZkSync_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928'
      );
      payloads[1] = GovV3Helpers.buildZkSyncPayload(vm, actionsZkSync);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsCelo = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsCelo[0] = GovV3Helpers.buildAction(
        type(AaveV3Celo_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928).creationCode
      );
      payloads[2] = GovV3Helpers.buildCeloPayload(vm, actionsCelo);
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
