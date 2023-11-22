// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Ethereum_IncreaseGHOBorrowRate_20231121} from './AaveV3Ethereum_IncreaseGHOBorrowRate_20231121.sol';

/**
 * @dev Deploy Ethereum
 * command: make deploy-ledger contract=src/20231121_AaveV3Ethereum_IncreaseGHOBorrowRate/IncreaseGHOBorrowRate_20231121.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Ethereum_IncreaseGHOBorrowRate_20231121 payload0 = new AaveV3Ethereum_IncreaseGHOBorrowRate_20231121();

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
 * command: make deploy-ledger contract=src/20231121_AaveV3Ethereum_IncreaseGHOBorrowRate/IncreaseGHOBorrowRate_20231121.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(0x0d66E00c5b876d661C3261e82a99BfFaD1ebE147);
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231121_AaveV3Ethereum_IncreaseGHOBorrowRate/IncreaseGHOBorrowRate.md'
      )
    );
  }
}
