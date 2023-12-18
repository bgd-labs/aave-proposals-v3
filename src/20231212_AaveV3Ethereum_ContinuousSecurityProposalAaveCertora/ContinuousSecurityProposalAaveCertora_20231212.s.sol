// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vm} from 'forge-std/Vm.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Ethereum_ContinuousSecurityProposalAaveCertoraPart1_20231212} from './AaveV3Ethereum_ContinuousSecurityProposalAaveCertoraPart1_20231212.sol';
import {AaveV3Ethereum_ContinuousSecurityProposalAaveCertoraPart2_20231212} from './AaveV3Ethereum_ContinuousSecurityProposalAaveCertoraPart2_20231212.sol';

library CertoraProposalDeployer {
  function _deployPart1() internal {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_ContinuousSecurityProposalAaveCertoraPart1_20231212).creationCode
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }

  function _deployPart2() internal {
    // deploy payloads
    GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_ContinuousSecurityProposalAaveCertoraPart2_20231212).creationCode
    );
  }

  function _deployProposal(Vm vm) internal {
    GovHelpers.Payload[] memory govPayloads = new GovHelpers.Payload[](2);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_ContinuousSecurityProposalAaveCertoraPart1_20231212).creationCode
    ); // part1
    PayloadsControllerUtils.Payload memory payload = GovV3Helpers.buildMainnetPayload(
      vm,
      actionsEthereum
    );

    // GHO payload
    govPayloads[0] = GovV3Helpers.build2_5Payload(payload);

    // part2
    govPayloads[1] = GovHelpers.buildMainnet(
      GovV3Helpers.predictDeterministicAddress(
        type(AaveV3Ethereum_ContinuousSecurityProposalAaveCertoraPart2_20231212).creationCode
      )
    );

    // create proposal
    GovHelpers.createProposal(
      govPayloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231212_AaveV3Ethereum_ContinuousSecurityProposalAaveCertora/ContinuousSecurityProposalAaveCertora.md'
      )
    );
  }
}

/**
 * @dev Deploy Ethereum
 * command: make deploy-ledger contract=src/20231212_AaveV3Ethereum_ContinuousSecurityProposalAaveCertora/ContinuousSecurityProposalAaveCertora_20231212.s.sol:DeployEthereumPart1 chain=mainnet
 */
contract DeployEthereumPart1 is EthereumScript {
  function run() external broadcast {
    CertoraProposalDeployer._deployPart1();
  }
}

/**
 * @dev Deploy Ethereum
 * command: make deploy-ledger contract=src/20231212_AaveV3Ethereum_ContinuousSecurityProposalAaveCertora_oldgov/ContinuousSecurityProposalAaveCertora_20231212.s.sol:DeployEthereumPart2 chain=mainnet
 */
contract DeployEthereumPart2 is EthereumScript {
  function run() external broadcast {
    CertoraProposalDeployer._deployPart2();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231212_AaveV3Ethereum_ContinuousSecurityProposalAaveCertora/ContinuousSecurityProposalAaveCertora_20231212.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    CertoraProposalDeployer._deployProposal(vm);
  }
}
