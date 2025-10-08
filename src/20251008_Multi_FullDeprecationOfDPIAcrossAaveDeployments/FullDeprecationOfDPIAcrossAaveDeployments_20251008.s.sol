// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript, PolygonScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV2Ethereum_FullDeprecationOfDPIAcrossAaveDeployments_20251008} from './AaveV2Ethereum_FullDeprecationOfDPIAcrossAaveDeployments_20251008.sol';
import {AaveV2Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008} from './AaveV2Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008.sol';
import {AaveV3Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008} from './AaveV3Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20251008_Multi_FullDeprecationOfDPIAcrossAaveDeployments/FullDeprecationOfDPIAcrossAaveDeployments_20251008.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/FullDeprecationOfDPIAcrossAaveDeployments_20251008.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV2Ethereum_FullDeprecationOfDPIAcrossAaveDeployments_20251008).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20251008_Multi_FullDeprecationOfDPIAcrossAaveDeployments/FullDeprecationOfDPIAcrossAaveDeployments_20251008.s.sol:DeployPolygon chain=polygon
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/FullDeprecationOfDPIAcrossAaveDeployments_20251008.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV2Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008).creationCode
    );
    address payload1 = GovV3Helpers.deployDeterministic(
      type(AaveV3Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008).creationCode
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](2);
    actions[0] = GovV3Helpers.buildAction(payload0);
    actions[1] = GovV3Helpers.buildAction(payload1);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20251008_Multi_FullDeprecationOfDPIAcrossAaveDeployments/FullDeprecationOfDPIAcrossAaveDeployments_20251008.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](2);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsEthereum[0] = GovV3Helpers.buildAction(
        type(AaveV2Ethereum_FullDeprecationOfDPIAcrossAaveDeployments_20251008).creationCode
      );
      payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](2);
      actionsPolygon[0] = GovV3Helpers.buildAction(
        type(AaveV2Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008).creationCode
      );
      actionsPolygon[1] = GovV3Helpers.buildAction(
        type(AaveV3Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008).creationCode
      );
      payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20251008_Multi_FullDeprecationOfDPIAcrossAaveDeployments/FullDeprecationOfDPIAcrossAaveDeployments.md'
      )
    );
  }
}
