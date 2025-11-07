// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovernanceV3ZkSync} from 'aave-address-book/GovernanceV3ZkSync.sol';
import {ChainIds} from 'solidity-utils/contracts/utils/ChainHelpers.sol';
import {EthereumScript, MetisScript, BNBScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Ethereum_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023} from './AaveV3Ethereum_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.sol';
import {AaveV3Metis_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023} from './AaveV3Metis_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.sol';
import {AaveV3BNB_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023} from './AaveV3BNB_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20251023_Multi_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances/DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023)
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
 * @dev Deploy Metis
 * deploy-command: make deploy-ledger contract=src/20251023_Multi_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances/DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.s.sol:DeployMetis chain=metis
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.s.sol/1088/run-latest.json
 */
contract DeployMetis is MetisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Metis_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20251023_Multi_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances/DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.s.sol:DeployBNB chain=bnb
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.s.sol/56/run-latest.json
 */
contract DeployBNB is BNBScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3BNB_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023).creationCode
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
 * command: make deploy-ledger contract=src/20251023_Multi_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances/DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](4);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsEthereum[0] = GovV3Helpers.buildAction(
        type(AaveV3Ethereum_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023)
          .creationCode
      );
      payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsMetis = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsMetis[0] = GovV3Helpers.buildAction(
        type(AaveV3Metis_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023)
          .creationCode
      );
      payloads[1] = GovV3Helpers.buildMetisPayload(vm, actionsMetis);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsBNB = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsBNB[0] = GovV3Helpers.buildAction(
        type(AaveV3BNB_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023).creationCode
      );
      payloads[2] = GovV3Helpers.buildBNBPayload(vm, actionsBNB);
    }

    {
      payloads[3] = PayloadsControllerUtils.Payload({
        chain: ChainIds.ZKSYNC,
        accessLevel: PayloadsControllerUtils.AccessControl.Level_1,
        payloadsController: address(GovernanceV3ZkSync.PAYLOADS_CONTROLLER),
        payloadId: 32
      });
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20251023_Multi_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances/DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances.md'
      )
    );
  }
}
