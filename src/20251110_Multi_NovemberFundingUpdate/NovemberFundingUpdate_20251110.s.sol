// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript, PolygonScript, OptimismScript, MetisScript, BNBScript, SonicScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Ethereum_NovemberFundingUpdate_20251110} from './AaveV3Ethereum_NovemberFundingUpdate_20251110.sol';
import {AaveV3Polygon_NovemberFundingUpdate_20251110} from './AaveV3Polygon_NovemberFundingUpdate_20251110.sol';
import {AaveV3Optimism_NovemberFundingUpdate_20251110} from './AaveV3Optimism_NovemberFundingUpdate_20251110.sol';
import {AaveV3Metis_NovemberFundingUpdate_20251110} from './AaveV3Metis_NovemberFundingUpdate_20251110.sol';
import {AaveV3BNB_NovemberFundingUpdate_20251110} from './AaveV3BNB_NovemberFundingUpdate_20251110.sol';
import {AaveV3Sonic_NovemberFundingUpdate_20251110} from './AaveV3Sonic_NovemberFundingUpdate_20251110.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20251110_Multi_NovemberFundingUpdate/NovemberFundingUpdate_20251110.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/NovemberFundingUpdate_20251110.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_NovemberFundingUpdate_20251110).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20251110_Multi_NovemberFundingUpdate/NovemberFundingUpdate_20251110.s.sol:DeployPolygon chain=polygon
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/NovemberFundingUpdate_20251110.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Polygon_NovemberFundingUpdate_20251110).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20251110_Multi_NovemberFundingUpdate/NovemberFundingUpdate_20251110.s.sol:DeployOptimism chain=optimism
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/NovemberFundingUpdate_20251110.s.sol/10/run-latest.json
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Optimism_NovemberFundingUpdate_20251110).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20251110_Multi_NovemberFundingUpdate/NovemberFundingUpdate_20251110.s.sol:DeployMetis chain=metis
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/NovemberFundingUpdate_20251110.s.sol/1088/run-latest.json
 */
contract DeployMetis is MetisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Metis_NovemberFundingUpdate_20251110).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20251110_Multi_NovemberFundingUpdate/NovemberFundingUpdate_20251110.s.sol:DeployBNB chain=bnb
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/NovemberFundingUpdate_20251110.s.sol/56/run-latest.json
 */
contract DeployBNB is BNBScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3BNB_NovemberFundingUpdate_20251110).creationCode
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
 * @dev Deploy Sonic
 * deploy-command: make deploy-ledger contract=src/20251110_Multi_NovemberFundingUpdate/NovemberFundingUpdate_20251110.s.sol:DeploySonic chain=sonic
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/NovemberFundingUpdate_20251110.s.sol/146/run-latest.json
 */
contract DeploySonic is SonicScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Sonic_NovemberFundingUpdate_20251110).creationCode
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
 * command: make deploy-ledger contract=src/20251110_Multi_NovemberFundingUpdate/NovemberFundingUpdate_20251110.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](6);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsEthereum[0] = GovV3Helpers.buildAction(
        type(AaveV3Ethereum_NovemberFundingUpdate_20251110).creationCode
      );
      payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsPolygon[0] = GovV3Helpers.buildAction(
        type(AaveV3Polygon_NovemberFundingUpdate_20251110).creationCode
      );
      payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsOptimism[0] = GovV3Helpers.buildAction(
        type(AaveV3Optimism_NovemberFundingUpdate_20251110).creationCode
      );
      payloads[2] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsMetis = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsMetis[0] = GovV3Helpers.buildAction(
        type(AaveV3Metis_NovemberFundingUpdate_20251110).creationCode
      );
      payloads[3] = GovV3Helpers.buildMetisPayload(vm, actionsMetis);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsBNB = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsBNB[0] = GovV3Helpers.buildAction(
        type(AaveV3BNB_NovemberFundingUpdate_20251110).creationCode
      );
      payloads[4] = GovV3Helpers.buildBNBPayload(vm, actionsBNB);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsSonic = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsSonic[0] = GovV3Helpers.buildAction(
        type(AaveV3Sonic_NovemberFundingUpdate_20251110).creationCode
      );
      payloads[5] = GovV3Helpers.buildSonicPayload(vm, actionsSonic);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20251110_Multi_NovemberFundingUpdate/NovemberFundingUpdate.md'
      )
    );
  }
}
