// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, PolygonScript, AvalancheScript} from 'aave-helpers/ScriptUtils.sol';

/**
 * @dev Deploy Ethereum
 * command: make deploy-ledger contract=src/20231107_Multi_MultichainStableDebtTokenUpgrades/MultichainStableDebtTokenUpgrades_20231107.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(0x3D33aBB521Ef3AA17b76c3FF9aDbEBA3903C5114));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Ethereum
 * command: make deploy-ledger contract=src/20231107_Multi_MultichainStableDebtTokenUpgrades/MultichainStableDebtTokenUpgrades_20231107.s.sol:DeployEthereumSentinel chain=mainnet
 */
contract DeployEthereumSentinel is EthereumScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(0x6C43cd7DC9f8d6F9892b4757941F910E3c7f2244));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Polygon
 * command: make deploy-ledger contract=src/20231107_Multi_MultichainStableDebtTokenUpgrades/MultichainStableDebtTokenUpgrades_20231107.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(0x79bdFC73c39Ce05051959a87D78deA6B193ADcf8));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Polygon
 * command: make deploy-ledger contract=src/20231107_Multi_MultichainStableDebtTokenUpgrades/MultichainStableDebtTokenUpgrades_20231107.s.sol:DeployPolygonSentinel chain=polygon
 */
contract DeployPolygonSentinel is PolygonScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(0x2cC18D5Be60bFE2D7F3016524d2E4F1653Afeb60));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Avalanche
 * command: make deploy-ledger contract=src/20231107_Multi_MultichainStableDebtTokenUpgrades/MultichainStableDebtTokenUpgrades_20231107.s.sol:DeployAvalancheSentinel chain=avalanche
 */
contract DeployAvalancheSentinel is AvalancheScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(0x60eE8b61a13c67d0191c851BEC8F0bc850160710));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231107_Multi_MultichainStableDebtTokenUpgrades/MultichainStableDebtTokenUpgrades_20231107.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](5);

    // compose actions for validation
    // update sTokens eth
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      address(0x3D33aBB521Ef3AA17b76c3FF9aDbEBA3903C5114)
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    // update sTokens pol
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(
      address(0x79bdFC73c39Ce05051959a87D78deA6B193ADcf8)
    );
    payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    // eth sentinel
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereumSentinel = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereumSentinel[0] = GovV3Helpers.buildAction(
      address(0x6C43cd7DC9f8d6F9892b4757941F910E3c7f2244) // https://etherscan.io/address/0x6C43cd7DC9f8d6F9892b4757941F910E3c7f2244#code
    );
    payloads[2] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereumSentinel);

    // pol sentinel
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygonSentinel = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygonSentinel[0] = GovV3Helpers.buildAction(
      address(0x2cC18D5Be60bFE2D7F3016524d2E4F1653Afeb60)
    );
    payloads[3] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygonSentinel);

    // ava sentinel
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalancheSentinel = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalancheSentinel[0] = GovV3Helpers.buildAction(
      address(0x60eE8b61a13c67d0191c851BEC8F0bc850160710)
    );
    payloads[4] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalancheSentinel);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231107_Multi_MultichainStableDebtTokenUpgrades/MultichainStableDebtTokenUpgrades.md'
      )
    );
  }
}
