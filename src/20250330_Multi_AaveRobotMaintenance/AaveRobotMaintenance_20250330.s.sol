// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript, PolygonScript, AvalancheScript, OptimismScript, ArbitrumScript, BaseScript, BNBScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Ethereum_AaveRobotMaintenance_20250330} from './AaveV3Ethereum_AaveRobotMaintenance_20250330.sol';
import {AaveV3Polygon_AaveRobotMaintenance_Part1_20250330} from './AaveV3Polygon_AaveRobotMaintenance_Part1_20250330.sol';
import {AaveV3Polygon_AaveRobotMaintenance_Part2_20250330} from './AaveV3Polygon_AaveRobotMaintenance_Part2_20250330.sol';
import {AaveV3Avalanche_AaveRobotMaintenance_20250330} from './AaveV3Avalanche_AaveRobotMaintenance_20250330.sol';
import {AaveV3Optimism_AaveRobotMaintenance_20250330} from './AaveV3Optimism_AaveRobotMaintenance_20250330.sol';
import {AaveV3Arbitrum_AaveRobotMaintenance_20250330} from './AaveV3Arbitrum_AaveRobotMaintenance_20250330.sol';
import {AaveV3Base_AaveRobotMaintenance_Part1_20250330} from './AaveV3Base_AaveRobotMaintenance_Part1_20250330.sol';
import {AaveV3Base_AaveRobotMaintenance_Part2_20250330} from './AaveV3Base_AaveRobotMaintenance_Part2_20250330.sol';
import {AaveV3BNB_AaveRobotMaintenance_Part1_20250330} from './AaveV3BNB_AaveRobotMaintenance_Part1_20250330.sol';
import {AaveV3BNB_AaveRobotMaintenance_Part2_20250330} from './AaveV3BNB_AaveRobotMaintenance_Part2_20250330.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20250330_Multi_AaveRobotMaintenance/AaveRobotMaintenance_20250330.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/AaveRobotMaintenance_20250330.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_AaveRobotMaintenance_20250330).creationCode
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
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20250330_Multi_AaveRobotMaintenance/AaveRobotMaintenance_20250330.s.sol:DeployPolygon chain=polygon
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/AaveRobotMaintenance_20250330.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Polygon_AaveRobotMaintenance_Part1_20250330).creationCode
    );
    address payload1 = GovV3Helpers.deployDeterministic(
      type(AaveV3Polygon_AaveRobotMaintenance_Part2_20250330).creationCode
    );

    // register action at payloadsController
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(payload0));
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(payload1));
  }
}

/**
 * @dev Deploy Avalanche
 * deploy-command: make deploy-ledger contract=src/20250330_Multi_AaveRobotMaintenance/AaveRobotMaintenance_20250330.s.sol:DeployAvalanche chain=avalanche
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/AaveRobotMaintenance_20250330.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Avalanche_AaveRobotMaintenance_20250330).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20250330_Multi_AaveRobotMaintenance/AaveRobotMaintenance_20250330.s.sol:DeployOptimism chain=optimism
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/AaveRobotMaintenance_20250330.s.sol/10/run-latest.json
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Optimism_AaveRobotMaintenance_20250330).creationCode
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
 * @dev Deploy Arbitrum
 * deploy-command: make deploy-ledger contract=src/20250330_Multi_AaveRobotMaintenance/AaveRobotMaintenance_20250330.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/AaveRobotMaintenance_20250330.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Arbitrum_AaveRobotMaintenance_20250330).creationCode
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
 * @dev Deploy Base
 * deploy-command: make deploy-ledger contract=src/20250330_Multi_AaveRobotMaintenance/AaveRobotMaintenance_20250330.s.sol:DeployBase chain=base
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/AaveRobotMaintenance_20250330.s.sol/8453/run-latest.json
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Base_AaveRobotMaintenance_Part1_20250330).creationCode
    );
    address payload1 = GovV3Helpers.deployDeterministic(
      type(AaveV3Base_AaveRobotMaintenance_Part2_20250330).creationCode
    );

    // register action at payloadsController
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(payload0));
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(payload1));
  }
}

/**
 * @dev Deploy BNB
 * deploy-command: make deploy-ledger contract=src/20250330_Multi_AaveRobotMaintenance/AaveRobotMaintenance_20250330.s.sol:DeployBNB chain=bnb
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/AaveRobotMaintenance_20250330.s.sol/56/run-latest.json
 */
contract DeployBNB is BNBScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3BNB_AaveRobotMaintenance_Part1_20250330).creationCode
    );
    address payload1 = GovV3Helpers.deployDeterministic(
      type(AaveV3BNB_AaveRobotMaintenance_Part1_20250330).creationCode
    );

    // register action at payloadsController
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(payload0));
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(payload1));
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20250330_Multi_AaveRobotMaintenance/AaveRobotMaintenance_20250330.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](10);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_AaveRobotMaintenance_20250330).creationCode
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygonOne = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygonOne[0] = GovV3Helpers.buildAction(
      type(AaveV3Polygon_AaveRobotMaintenance_Part1_20250330).creationCode
    );
    payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygonOne);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygonTwo = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygonTwo[0] = GovV3Helpers.buildAction(
      type(AaveV3Polygon_AaveRobotMaintenance_Part2_20250330).creationCode
    );
    payloads[2] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygonTwo);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalanche[0] = GovV3Helpers.buildAction(
      type(AaveV3Avalanche_AaveRobotMaintenance_20250330).creationCode
    );
    payloads[3] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsOptimism[0] = GovV3Helpers.buildAction(
      type(AaveV3Optimism_AaveRobotMaintenance_20250330).creationCode
    );
    payloads[4] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(
      type(AaveV3Arbitrum_AaveRobotMaintenance_20250330).creationCode
    );
    payloads[5] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBaseOne = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBaseOne[0] = GovV3Helpers.buildAction(
      type(AaveV3Base_AaveRobotMaintenance_Part1_20250330).creationCode
    );
    payloads[6] = GovV3Helpers.buildBasePayload(vm, actionsBaseOne);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBaseTwo = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBaseTwo[0] = GovV3Helpers.buildAction(
      type(AaveV3Base_AaveRobotMaintenance_Part2_20250330).creationCode
    );
    payloads[7] = GovV3Helpers.buildBasePayload(vm, actionsBaseTwo);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBNBOne = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBNBOne[0] = GovV3Helpers.buildAction(
      type(AaveV3BNB_AaveRobotMaintenance_Part1_20250330).creationCode
    );
    payloads[8] = GovV3Helpers.buildBNBPayload(vm, actionsBNBOne);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBNBTwo = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBNBTwo[0] = GovV3Helpers.buildAction(
      type(AaveV3BNB_AaveRobotMaintenance_Part2_20250330).creationCode
    );
    payloads[9] = GovV3Helpers.buildBNBPayload(vm, actionsBNBTwo);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250330_Multi_AaveRobotMaintenance/AaveRobotMaintenance.md'
      )
    );
  }
}
