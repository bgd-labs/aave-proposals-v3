// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseMKRDebtCeilingOnV3Ethereum_20231116} from './AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseMKRDebtCeilingOnV3Ethereum_20231116.sol';

/**
 * @dev Deploy Ethereum
 * command: make deploy-ledger contract=src/20231116_AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseMKRDebtCeilingOnV3Ethereum/ChaosLabsRiskParameterUpdatesIncreaseMKRDebtCeilingOnV3Ethereum_20231116.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseMKRDebtCeilingOnV3Ethereum_20231116 payload0 = new AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseMKRDebtCeilingOnV3Ethereum_20231116();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload0));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231116_AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseMKRDebtCeilingOnV3Ethereum/ChaosLabsRiskParameterUpdatesIncreaseMKRDebtCeilingOnV3Ethereum_20231116.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(0xb1dA0D9bBC23A602145C9Efaf81ADD188B206d88);
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231116_AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseMKRDebtCeilingOnV3Ethereum/ChaosLabsRiskParameterUpdatesIncreaseMKRDebtCeilingOnV3Ethereum.md'
      )
    );
  }
}
