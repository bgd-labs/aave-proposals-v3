// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript, GnosisScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance_20251024} from './AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance_20251024.sol';

/**
 * @dev Deploy Gnosis
 * deploy-command: make deploy-ledger contract=src/20251024_AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance/USDCOldDeprecationOnGnosisChainInstance_20251024.s.sol:DeployGnosis chain=gnosis
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/USDCOldDeprecationOnGnosisChainInstance_20251024.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance_20251024).creationCode
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
 * command: make deploy-ledger contract=src/20251024_AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance/USDCOldDeprecationOnGnosisChainInstance_20251024.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsGnosis[0] = GovV3Helpers.buildAction(
        type(AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance_20251024).creationCode
      );
      payloads[0] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20251024_AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance/USDCOldDeprecationOnGnosisChainInstance.md'
      )
    );
  }
}
