// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript, OptimismScript, MetisScript, GnosisScript, ScrollScript, CeloScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Optimism_EnhancingMarketGranularityInAaveV36_20260112} from './AaveV3Optimism_EnhancingMarketGranularityInAaveV36_20260112.sol';
import {AaveV3Metis_EnhancingMarketGranularityInAaveV36_20260112} from './AaveV3Metis_EnhancingMarketGranularityInAaveV36_20260112.sol';
import {AaveV3Gnosis_EnhancingMarketGranularityInAaveV36_20260112} from './AaveV3Gnosis_EnhancingMarketGranularityInAaveV36_20260112.sol';
import {AaveV3Scroll_EnhancingMarketGranularityInAaveV36_20260112} from './AaveV3Scroll_EnhancingMarketGranularityInAaveV36_20260112.sol';
import {AaveV3Celo_EnhancingMarketGranularityInAaveV36_20260112} from './AaveV3Celo_EnhancingMarketGranularityInAaveV36_20260112.sol';

/**
 * @dev Deploy Optimism
 * deploy-command: make deploy-ledger contract=src/20260112_Multi_EnhancingMarketGranularityInAaveV36/EnhancingMarketGranularityInAaveV36_20260112.s.sol:DeployOptimism chain=optimism
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/EnhancingMarketGranularityInAaveV36_20260112.s.sol/10/run-latest.json
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Optimism_EnhancingMarketGranularityInAaveV36_20260112).creationCode
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
 * @dev Deploy Metis
 * deploy-command: make deploy-ledger contract=src/20260112_Multi_EnhancingMarketGranularityInAaveV36/EnhancingMarketGranularityInAaveV36_20260112.s.sol:DeployMetis chain=metis
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/EnhancingMarketGranularityInAaveV36_20260112.s.sol/1088/run-latest.json
 */
contract DeployMetis is MetisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Metis_EnhancingMarketGranularityInAaveV36_20260112).creationCode
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
 * @dev Deploy Gnosis
 * deploy-command: make deploy-ledger contract=src/20260112_Multi_EnhancingMarketGranularityInAaveV36/EnhancingMarketGranularityInAaveV36_20260112.s.sol:DeployGnosis chain=gnosis
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/EnhancingMarketGranularityInAaveV36_20260112.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Gnosis_EnhancingMarketGranularityInAaveV36_20260112).creationCode
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
 * @dev Deploy Scroll
 * deploy-command: make deploy-ledger contract=src/20260112_Multi_EnhancingMarketGranularityInAaveV36/EnhancingMarketGranularityInAaveV36_20260112.s.sol:DeployScroll chain=scroll
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/EnhancingMarketGranularityInAaveV36_20260112.s.sol/534352/run-latest.json
 */
contract DeployScroll is ScrollScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Scroll_EnhancingMarketGranularityInAaveV36_20260112).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260112_Multi_EnhancingMarketGranularityInAaveV36/EnhancingMarketGranularityInAaveV36_20260112.s.sol:DeployCelo chain=celo
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/EnhancingMarketGranularityInAaveV36_20260112.s.sol/42220/run-latest.json
 */
contract DeployCelo is CeloScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Celo_EnhancingMarketGranularityInAaveV36_20260112).creationCode
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
 * command: make deploy-ledger contract=src/20260112_Multi_EnhancingMarketGranularityInAaveV36/EnhancingMarketGranularityInAaveV36_20260112.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](6);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsOptimism[0] = GovV3Helpers.buildAction(
        type(AaveV3Optimism_EnhancingMarketGranularityInAaveV36_20260112).creationCode
      );
      payloads[0] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsMetis = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsMetis[0] = GovV3Helpers.buildAction(
        type(AaveV3Metis_EnhancingMarketGranularityInAaveV36_20260112).creationCode
      );
      payloads[1] = GovV3Helpers.buildMetisPayload(vm, actionsMetis);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsGnosis[0] = GovV3Helpers.buildAction(
        type(AaveV3Gnosis_EnhancingMarketGranularityInAaveV36_20260112).creationCode
      );
      payloads[2] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsScroll = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsScroll[0] = GovV3Helpers.buildAction(
        type(AaveV3Scroll_EnhancingMarketGranularityInAaveV36_20260112).creationCode
      );
      payloads[3] = GovV3Helpers.buildScrollPayload(vm, actionsScroll);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsZkSync = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsZkSync[0] = GovV3Helpers.buildActionZkSync(
        vm,
        'AaveV3ZkSync_EnhancingMarketGranularityInAaveV36_20260112'
      );
      payloads[4] = GovV3Helpers.buildZkSyncPayload(vm, actionsZkSync);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsCelo = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsCelo[0] = GovV3Helpers.buildAction(
        type(AaveV3Celo_EnhancingMarketGranularityInAaveV36_20260112).creationCode
      );
      payloads[5] = GovV3Helpers.buildCeloPayload(vm, actionsCelo);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20260112_Multi_EnhancingMarketGranularityInAaveV36/EnhancingMarketGranularityInAaveV36.md'
      )
    );
  }
}
