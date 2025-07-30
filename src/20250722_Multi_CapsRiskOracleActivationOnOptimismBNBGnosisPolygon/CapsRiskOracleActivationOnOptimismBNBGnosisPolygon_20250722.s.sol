// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript, PolygonScript, OptimismScript, GnosisScript, BNBScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Polygon_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722} from './AaveV3Polygon_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.sol';
import {AaveV3Optimism_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722} from './AaveV3Optimism_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.sol';
import {AaveV3Gnosis_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722} from './AaveV3Gnosis_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.sol';
import {AaveV3BNB_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722} from './AaveV3BNB_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.sol';

/**
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20250722_Multi_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon/CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.s.sol:DeployPolygon chain=polygon
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Polygon_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722).creationCode
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
 * @dev Deploy Optimism
 * deploy-command: make deploy-ledger contract=src/20250722_Multi_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon/CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.s.sol:DeployOptimism chain=optimism
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.s.sol/10/run-latest.json
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Optimism_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20250722_Multi_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon/CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.s.sol:DeployGnosis chain=gnosis
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Gnosis_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722).creationCode
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
 * @dev Deploy BNB
 * deploy-command: make deploy-ledger contract=src/20250722_Multi_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon/CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.s.sol:DeployBNB chain=bnb
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.s.sol/56/run-latest.json
 */
contract DeployBNB is BNBScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3BNB_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722).creationCode
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
 * command: make deploy-ledger contract=src/20250722_Multi_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon/CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](4);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsPolygon[0] = GovV3Helpers.buildAction(
        type(AaveV3Polygon_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722).creationCode
      );
      payloads[0] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsOptimism[0] = GovV3Helpers.buildAction(
        type(AaveV3Optimism_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722)
          .creationCode
      );
      payloads[1] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsGnosis[0] = GovV3Helpers.buildAction(
        type(AaveV3Gnosis_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722).creationCode
      );
      payloads[2] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsBNB = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsBNB[0] = GovV3Helpers.buildAction(
        type(AaveV3BNB_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722).creationCode
      );
      payloads[3] = GovV3Helpers.buildBNBPayload(vm, actionsBNB);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250722_Multi_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon/CapsRiskOracleActivationOnOptimismBNBGnosisPolygon.md'
      )
    );
  }
}
