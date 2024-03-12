// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {WithPayloads, DeployPayloadsEthereum, CreateProposal} from '../templating/DeploymentScripts.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Ethereum_RequestForBountyPayoutJanuary2024_20240125} from './AaveV3Ethereum_RequestForBountyPayoutJanuary2024_20240125.sol';

abstract contract ProposalActions is WithPayloads {
  function getActions() public pure override returns (ActionsPerChain[] memory) {
    ActionsPerChain[] memory payloads = new ActionsPerChain[](1);

    payloads[0].chainName = 'ethereum';
    payloads[0].actionCode = new bytes[](1);
    payloads[0].actionCode[0] = type(AaveV3Ethereum_RequestForBountyPayoutJanuary2024_20240125)
      .creationCode;

    return payloads;
  }
}

contract DeployEthereum is ProposalActions, DeployPayloadsEthereum {}

contract ProposalCreation is
  ProposalActions,
  CreateProposal(
    'src/20240125_AaveV3Ethereum_RequestForBountyPayoutJanuary2024/RequestForBountyPayoutJanuary2024.md'
  )
{}
