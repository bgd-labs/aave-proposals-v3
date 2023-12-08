// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Ethereum_GauntletRecommendationToReactivateCRVBorrowingOnV3_20231127} from './AaveV3Ethereum_GauntletRecommendationToReactivateCRVBorrowingOnV3_20231127.sol';
import {AaveV3Polygon_GauntletRecommendationToReactivateCRVBorrowingOnV3_20231127} from './AaveV3Polygon_GauntletRecommendationToReactivateCRVBorrowingOnV3_20231127.sol';

/**
 * @dev Deploy Ethereum
 * command: make deploy-ledger contract=src/20231127_Multi_GauntletRecommendationToReactivateCRVBorrowingOnV3/GauntletRecommendationToReactivateCRVBorrowingOnV3_20231127.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Ethereum_GauntletRecommendationToReactivateCRVBorrowingOnV3_20231127 payload0 = new AaveV3Ethereum_GauntletRecommendationToReactivateCRVBorrowingOnV3_20231127();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload0));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Polygon
 * command: make deploy-ledger contract=src/20231127_Multi_GauntletRecommendationToReactivateCRVBorrowingOnV3/GauntletRecommendationToReactivateCRVBorrowingOnV3_20231127.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Polygon_GauntletRecommendationToReactivateCRVBorrowingOnV3_20231127 payload0 = new AaveV3Polygon_GauntletRecommendationToReactivateCRVBorrowingOnV3_20231127();

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
 * command: make deploy-ledger contract=src/20231127_Multi_GauntletRecommendationToReactivateCRVBorrowingOnV3/GauntletRecommendationToReactivateCRVBorrowingOnV3_20231127.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](2);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(0x78aCeC1B92dF516DA14B3dbed91219772180330A);
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(0x78aCeC1B92dF516DA14B3dbed91219772180330A);
    payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231127_Multi_GauntletRecommendationToReactivateCRVBorrowingOnV3/GauntletRecommendationToReactivateCRVBorrowingOnV3.md'
      )
    );
  }
}
