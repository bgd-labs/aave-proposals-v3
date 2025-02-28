// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript, PolygonScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Polygon_AdjustAavePolygonV3RiskParameters_20250228} from './AaveV3Polygon_AdjustAavePolygonV3RiskParameters_20250228.sol';

/**
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20250228_AaveV3Polygon_AdjustAavePolygonV3RiskParameters/AdjustAavePolygonV3RiskParameters_20250228.s.sol:DeployPolygon chain=polygon
 * verify-command: FOUNDRY_PROFILE=polygon npx catapulta-verify -b broadcast/AdjustAavePolygonV3RiskParameters_20250228.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Polygon_AdjustAavePolygonV3RiskParameters_20250228).creationCode
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
 * command: make deploy-ledger contract=src/20250228_AaveV3Polygon_AdjustAavePolygonV3RiskParameters/AdjustAavePolygonV3RiskParameters_20250228.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(
      type(AaveV3Polygon_AdjustAavePolygonV3RiskParameters_20250228).creationCode
    );
    payloads[0] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250228_AaveV3Polygon_AdjustAavePolygonV3RiskParameters/AdjustAavePolygonV3RiskParameters.md'
      )
    );
  }
}
