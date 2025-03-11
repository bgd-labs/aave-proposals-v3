// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovernanceV3Celo} from 'aave-address-book/GovernanceV3Celo.sol';
import {EthereumScript, CeloScript, ChainIds} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Celo_AaveV33CeloActivation_20250224} from './AaveV3Celo_AaveV33CeloActivation_20250224.sol';

/**
 * @dev Deploy Celo
 * deploy-command: make deploy-pk contract=src/20250224_AaveV3Celo_AaveV33CeloActivation/AaveV33CeloActivation_20250224.s.sol:DeployCelo chain=celo
 * verify-command: FOUNDRY_PROFILE=celo npx catapulta-verify -b broadcast/AaveV33CeloActivation_20250224.s.sol/42220/run-latest.json
 */
contract DeployCelo is CeloScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Celo_AaveV33CeloActivation_20250224).creationCode
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
 * command: make deploy-ledger contract=src/20250224_AaveV3Celo_AaveV33CeloActivation/AaveV33CeloActivation_20250224.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);
    payloads[0] = PayloadsControllerUtils.Payload({
      chain: ChainIds.CELO,
      accessLevel: PayloadsControllerUtils.AccessControl.Level_1,
      payloadsController: address(GovernanceV3Celo.PAYLOADS_CONTROLLER),
      payloadId: 1
    });

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250224_AaveV3Celo_AaveV33CeloActivation/AaveV33CeloActivation.md'
      )
    );
  }
}
