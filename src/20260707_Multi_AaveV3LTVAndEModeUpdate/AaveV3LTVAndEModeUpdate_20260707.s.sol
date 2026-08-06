// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript, AvalancheScript, GnosisScript, MantleScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Ethereum_AaveV3LTVAndEModeUpdate_20260707} from './AaveV3Ethereum_AaveV3LTVAndEModeUpdate_20260707.sol';
import {AaveV3Avalanche_AaveV3LTVAndEModeUpdate_20260707} from './AaveV3Avalanche_AaveV3LTVAndEModeUpdate_20260707.sol';
import {AaveV3Gnosis_AaveV3LTVAndEModeUpdate_20260707} from './AaveV3Gnosis_AaveV3LTVAndEModeUpdate_20260707.sol';
import {AaveV3Mantle_AaveV3LTVAndEModeUpdate_20260707} from './AaveV3Mantle_AaveV3LTVAndEModeUpdate_20260707.sol';
import {AaveV3EthereumLido_AaveV3LTVAndEModeUpdate_20260707} from './AaveV3EthereumLido_AaveV3LTVAndEModeUpdate_20260707.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20260707_Multi_AaveV3LTVAndEModeUpdate/AaveV3LTVAndEModeUpdate_20260707.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/AaveV3LTVAndEModeUpdate_20260707.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_AaveV3LTVAndEModeUpdate_20260707).creationCode
    );
    address payload1 = GovV3Helpers.deployDeterministic(
      type(AaveV3EthereumLido_AaveV3LTVAndEModeUpdate_20260707).creationCode
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](2);
    actions[0] = GovV3Helpers.buildAction(payload0);
    actions[1] = GovV3Helpers.buildAction(payload1);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Avalanche
 * deploy-command: make deploy-ledger contract=src/20260707_Multi_AaveV3LTVAndEModeUpdate/AaveV3LTVAndEModeUpdate_20260707.s.sol:DeployAvalanche chain=avalanche
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/AaveV3LTVAndEModeUpdate_20260707.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Avalanche_AaveV3LTVAndEModeUpdate_20260707).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260707_Multi_AaveV3LTVAndEModeUpdate/AaveV3LTVAndEModeUpdate_20260707.s.sol:DeployGnosis chain=gnosis
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/AaveV3LTVAndEModeUpdate_20260707.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Gnosis_AaveV3LTVAndEModeUpdate_20260707).creationCode
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
 * @dev Deploy Mantle
 * deploy-command: make deploy-ledger contract=src/20260707_Multi_AaveV3LTVAndEModeUpdate/AaveV3LTVAndEModeUpdate_20260707.s.sol:DeployMantle chain=mantle
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/AaveV3LTVAndEModeUpdate_20260707.s.sol/5000/run-latest.json
 */
contract DeployMantle is MantleScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Mantle_AaveV3LTVAndEModeUpdate_20260707).creationCode
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
 * command: make deploy-ledger contract=src/20260707_Multi_AaveV3LTVAndEModeUpdate/AaveV3LTVAndEModeUpdate_20260707.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](4);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](2);
      actionsEthereum[0] = GovV3Helpers.buildAction(
        type(AaveV3Ethereum_AaveV3LTVAndEModeUpdate_20260707).creationCode
      );
      actionsEthereum[1] = GovV3Helpers.buildAction(
        type(AaveV3EthereumLido_AaveV3LTVAndEModeUpdate_20260707).creationCode
      );
      payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsAvalanche[0] = GovV3Helpers.buildAction(
        type(AaveV3Avalanche_AaveV3LTVAndEModeUpdate_20260707).creationCode
      );
      payloads[1] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsGnosis[0] = GovV3Helpers.buildAction(
        type(AaveV3Gnosis_AaveV3LTVAndEModeUpdate_20260707).creationCode
      );
      payloads[2] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsMantle = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsMantle[0] = GovV3Helpers.buildAction(
        type(AaveV3Mantle_AaveV3LTVAndEModeUpdate_20260707).creationCode
      );
      payloads[3] = GovV3Helpers.buildMantlePayload(vm, actionsMantle);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20260707_Multi_AaveV3LTVAndEModeUpdate/AaveV3LTVAndEModeUpdate.md'
      )
    );
  }
}
