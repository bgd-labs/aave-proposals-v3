// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovernanceV3Linea} from 'aave-address-book/GovernanceV3Linea.sol';

import {EthereumScript, LineaScript, ChainIds} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Linea_OnboardRsETHToAaveV3LineaInstance_20250811} from './AaveV3Linea_OnboardRsETHToAaveV3LineaInstance_20250811.sol';

/**
 * @dev Deploy Linea
 * deploy-command: make deploy-ledger contract=src/20250811_AaveV3Linea_OnboardRsETHToAaveV3LineaInstance/OnboardRsETHToAaveV3LineaInstance_20250811.s.sol:DeployLinea chain=linea
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/OnboardRsETHToAaveV3LineaInstance_20250811.s.sol/59144/run-latest.json
 */
contract DeployLinea is LineaScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Linea_OnboardRsETHToAaveV3LineaInstance_20250811).creationCode
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
 * command: make deploy-ledger contract=src/20250811_AaveV3Linea_OnboardRsETHToAaveV3LineaInstance/OnboardRsETHToAaveV3LineaInstance_20250811.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    payloads[0] = PayloadsControllerUtils.Payload({
      chain: ChainIds.LINEA,
      accessLevel: PayloadsControllerUtils.AccessControl.Level_1,
      payloadsController: address(GovernanceV3Linea.PAYLOADS_CONTROLLER),
      payloadId: 12
    });

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250811_AaveV3Linea_OnboardRsETHToAaveV3LineaInstance/OnboardRsETHToAaveV3LineaInstance.md'
      )
    );
  }
}
