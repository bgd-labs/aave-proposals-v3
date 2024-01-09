// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Ethereum_RequestForBountyPayoutDecember2023_20231213} from './AaveV3Ethereum_RequestForBountyPayoutDecember2023_20231213.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20231213_AaveV3Ethereum_RequestForBountyPayoutDecember2023/RequestForBountyPayoutDecember2023_20231213.s.sol:DeployEthereum chain=mainnet
 * verify-command: npx catapulta-verify -b broadcast/RequestForBountyPayoutDecember2023_20231213.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Ethereum_RequestForBountyPayoutDecember2023_20231213 payload0 = AaveV3Ethereum_RequestForBountyPayoutDecember2023_20231213(
        GovV3Helpers.deployDeterministic(
          type(AaveV3Ethereum_RequestForBountyPayoutDecember2023_20231213).creationCode
        )
      );

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
 * command: make deploy-ledger contract=src/20231213_AaveV3Ethereum_RequestForBountyPayoutDecember2023/RequestForBountyPayoutDecember2023_20231213.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_RequestForBountyPayoutDecember2023_20231213).creationCode
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231213_AaveV3Ethereum_RequestForBountyPayoutDecember2023/RequestForBountyPayoutDecember2023.md'
      )
    );
  }
}
