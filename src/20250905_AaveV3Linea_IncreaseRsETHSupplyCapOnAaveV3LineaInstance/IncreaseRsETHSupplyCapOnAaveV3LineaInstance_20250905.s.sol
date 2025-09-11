// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript, LineaScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Linea_IncreaseRsETHSupplyCapOnAaveV3LineaInstance_20250905} from './AaveV3Linea_IncreaseRsETHSupplyCapOnAaveV3LineaInstance_20250905.sol';

/**
 * @dev Deploy Linea
 * deploy-command: make deploy-ledger contract=src/20250905_AaveV3Linea_IncreaseRsETHSupplyCapOnAaveV3LineaInstance/IncreaseRsETHSupplyCapOnAaveV3LineaInstance_20250905.s.sol:DeployLinea chain=linea
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/IncreaseRsETHSupplyCapOnAaveV3LineaInstance_20250905.s.sol/59144/run-latest.json
 */
contract DeployLinea is LineaScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Linea_IncreaseRsETHSupplyCapOnAaveV3LineaInstance_20250905).creationCode
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
 * command: make deploy-ledger contract=src/20250905_AaveV3Linea_IncreaseRsETHSupplyCapOnAaveV3LineaInstance/IncreaseRsETHSupplyCapOnAaveV3LineaInstance_20250905.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsLinea = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsLinea[0] = GovV3Helpers.buildAction(0x393cb9078fe3610D0daFAf3369EE61Fe78dcCB95);
      payloads[0] = GovV3Helpers.buildLineaPayload(vm, actionsLinea);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250905_AaveV3Linea_IncreaseRsETHSupplyCapOnAaveV3LineaInstance/IncreaseRsETHSupplyCapOnAaveV3LineaInstance.md'
      )
    );
  }
}
