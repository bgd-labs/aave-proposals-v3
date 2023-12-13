// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Ethereum_ContinuousSecurityProposalAaveCertora_20231212} from './AaveV3Ethereum_ContinuousSecurityProposalAaveCertora_20231212.sol';

/**
 * @dev Deploy Ethereum
 * command: make deploy-ledger contract=src/20231212_AaveV3Ethereum_ContinuousSecurityProposalAaveCertora_oldgov/ContinuousSecurityProposalAaveCertora_20231212.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    new AaveV3Ethereum_ContinuousSecurityProposalAaveCertora_20231212();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231212_AaveV3Ethereum_ContinuousSecurityProposalAaveCertora_oldgov/ContinuousSecurityProposalAaveCertora_20231212.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(0));

    // create proposal
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20231212_AaveV3Ethereum_ContinuousSecurityProposalAaveCertora_oldgov/ContinuousSecurityProposalAaveCertora.md'
      )
    );
  }
}
