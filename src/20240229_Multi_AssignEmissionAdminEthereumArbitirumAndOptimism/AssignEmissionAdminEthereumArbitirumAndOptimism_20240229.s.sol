// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, OptimismScript, ArbitrumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Ethereum_AssignEmissionAdminEthereumArbitirumAndOptimism_20240229} from './AaveV3Ethereum_AssignEmissionAdminEthereumArbitirumAndOptimism_20240229.sol';
import {AaveV3Optimism_AssignEmissionAdminEthereumArbitirumAndOptimism_20240229} from './AaveV3Optimism_AssignEmissionAdminEthereumArbitirumAndOptimism_20240229.sol';
import {AaveV3Arbitrum_AssignEmissionAdminEthereumArbitirumAndOptimism_20240229} from './AaveV3Arbitrum_AssignEmissionAdminEthereumArbitirumAndOptimism_20240229.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20240229_Multi_AssignEmissionAdminEthereumArbitirumAndOptimism/AssignEmissionAdminEthereumArbitirumAndOptimism_20240229.s.sol:DeployEthereum chain=mainnet
 * verify-command: npx catapulta-verify -b broadcast/AssignEmissionAdminEthereumArbitirumAndOptimism_20240229.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_AssignEmissionAdminEthereumArbitirumAndOptimism_20240229).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20240229_Multi_AssignEmissionAdminEthereumArbitirumAndOptimism/AssignEmissionAdminEthereumArbitirumAndOptimism_20240229.s.sol:DeployOptimism chain=optimism
 * verify-command: npx catapulta-verify -b broadcast/AssignEmissionAdminEthereumArbitirumAndOptimism_20240229.s.sol/10/run-latest.json
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Optimism_AssignEmissionAdminEthereumArbitirumAndOptimism_20240229).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20240229_Multi_AssignEmissionAdminEthereumArbitirumAndOptimism/AssignEmissionAdminEthereumArbitirumAndOptimism_20240229.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: npx catapulta-verify -b broadcast/AssignEmissionAdminEthereumArbitirumAndOptimism_20240229.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Arbitrum_AssignEmissionAdminEthereumArbitirumAndOptimism_20240229).creationCode
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
 * command: make deploy-ledger contract=src/20240229_Multi_AssignEmissionAdminEthereumArbitirumAndOptimism/AssignEmissionAdminEthereumArbitirumAndOptimism_20240229.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](3);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_AssignEmissionAdminEthereumArbitirumAndOptimism_20240229).creationCode
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsOptimism[0] = GovV3Helpers.buildAction(
      type(AaveV3Optimism_AssignEmissionAdminEthereumArbitirumAndOptimism_20240229).creationCode
    );
    payloads[1] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(
      type(AaveV3Arbitrum_AssignEmissionAdminEthereumArbitirumAndOptimism_20240229).creationCode
    );
    payloads[2] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240229_Multi_AssignEmissionAdminEthereumArbitirumAndOptimism/AssignEmissionAdminEthereumArbitirumAndOptimism.md'
      )
    );
  }
}
