// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript, MetisScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Metis_EnableMetisAsCollateralOnMetisChain_20240814} from './AaveV3Metis_EnableMetisAsCollateralOnMetisChain_20240814.sol';

/**
 * @dev Deploy Metis
 * deploy-command: make deploy-ledger contract=src/20240814_AaveV3Metis_EnableMetisAsCollateralOnMetisChain/EnableMetisAsCollateralOnMetisChain_20240814.s.sol:DeployMetis chain=metis
 * verify-command: FOUNDRY_PROFILE=metis npx catapulta-verify -b broadcast/EnableMetisAsCollateralOnMetisChain_20240814.s.sol/1088/run-latest.json
 */
contract DeployMetis is MetisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Metis_EnableMetisAsCollateralOnMetisChain_20240814).creationCode
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
 * command: make deploy-ledger contract=src/20240814_AaveV3Metis_EnableMetisAsCollateralOnMetisChain/EnableMetisAsCollateralOnMetisChain_20240814.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsMetis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsMetis[0] = GovV3Helpers.buildAction(
      type(AaveV3Metis_EnableMetisAsCollateralOnMetisChain_20240814).creationCode
    );
    payloads[0] = GovV3Helpers.buildMetisPayload(vm, actionsMetis);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240814_AaveV3Metis_EnableMetisAsCollateralOnMetisChain/EnableMetisAsCollateralOnMetisChain.md'
      )
    );
  }
}
