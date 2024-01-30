// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229} from './AaveV2Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229.sol';
import {AaveV3Polygon_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229} from './AaveV3Polygon_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20231229_Multi_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1/TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229.s.sol:DeployEthereum chain=mainnet
 * verify-command: npx catapulta-verify -b broadcast/TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV2Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229)
        .creationCode
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
 * deploy-command: make deploy-ledger contract=src/20231229_Multi_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1/TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229.s.sol:DeployPolygon chain=polygon
 * verify-command: npx catapulta-verify -b broadcast/TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Polygon_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229)
        .creationCode
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
 * command: make deploy-ledger contract=src/20231229_Multi_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1/TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](2);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV2Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229)
        .creationCode
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(
      type(AaveV3Polygon_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229)
        .creationCode
    );
    payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    // create proposal
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231229_Multi_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1/TreasuryManagementGSMFundingRWAStrategyPreparationsPart1.md'
      )
    );
  }
}
