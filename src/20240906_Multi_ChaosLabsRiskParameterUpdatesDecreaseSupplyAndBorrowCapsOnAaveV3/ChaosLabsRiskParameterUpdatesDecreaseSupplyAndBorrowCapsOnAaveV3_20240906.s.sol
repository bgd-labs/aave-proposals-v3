// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript, OptimismScript, BNBScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Ethereum_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906} from './AaveV3Ethereum_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906.sol';
import {AaveV3Optimism_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906} from './AaveV3Optimism_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906.sol';
import {AaveV3BNB_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906} from './AaveV3BNB_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20240906_Multi_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3/ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=mainnet npx catapulta-verify -b broadcast/ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906)
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
 * @dev Deploy Optimism
 * deploy-command: make deploy-ledger contract=src/20240906_Multi_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3/ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906.s.sol:DeployOptimism chain=optimism
 * verify-command: FOUNDRY_PROFILE=optimism npx catapulta-verify -b broadcast/ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906.s.sol/10/run-latest.json
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Optimism_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906)
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
 * @dev Deploy BNB
 * deploy-command: make deploy-ledger contract=src/20240906_Multi_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3/ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906.s.sol:DeployBNB chain=bnb
 * verify-command: FOUNDRY_PROFILE=bnb npx catapulta-verify -b broadcast/ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906.s.sol/56/run-latest.json
 */
contract DeployBNB is BNBScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3BNB_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906)
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
 * command: make deploy-ledger contract=src/20240906_Multi_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3/ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](3);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906)
        .creationCode
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsOptimism[0] = GovV3Helpers.buildAction(
      type(AaveV3Optimism_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906)
        .creationCode
    );
    payloads[1] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBNB = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBNB[0] = GovV3Helpers.buildAction(
      type(AaveV3BNB_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906)
        .creationCode
    );
    payloads[2] = GovV3Helpers.buildBNBPayload(vm, actionsBNB);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240906_Multi_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3/ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3.md'
      )
    );
  }
}
