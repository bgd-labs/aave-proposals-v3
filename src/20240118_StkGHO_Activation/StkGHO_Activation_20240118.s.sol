// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {StkGHO_Activation_20240118} from './StkGHO_Activation_20240118.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20240118_StkGHO_Activation/StkGHO_Activation_20240118.s.sol:DeployPolygon chain=polygon
 * verify-command: npx catapulta-verify -b broadcast/ReserveFactorUpdates_20240102.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(StkGHO_Activation_20240118).creationCode
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
 * command: make deploy-ledger contract=src/20240118_StkGHO_Activation/StkGHO_Activation_20240118.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  uint256 public constant STKGHO_EMISSION_PER_SECOND = 578703703703704; // 50 AAVE/day
  uint256 public constant DISTRIBUTION_DURATION = 90 days; // three months
  address public constant STKGHO_PROXY = 0x1a88Df1cFe15Af22B3c4c783D4e6F7F9e0C1885d; // AaveSafetyModule.STK_GHO;

  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(type(StkGHO_Activation_20240118).creationCode);
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsPolygon);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(vm, 'src/StkGHO_Activation_20240118/StkGHOActivation.md')
    );
  }
}
