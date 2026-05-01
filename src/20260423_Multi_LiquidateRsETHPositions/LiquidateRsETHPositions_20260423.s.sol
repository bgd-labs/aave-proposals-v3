// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript, ArbitrumScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';

import {AaveV3Ethereum_LiquidateRsETHPositionUser1_20260423} from './mainnet/AaveV3Ethereum_LiquidateRsETHPositionUser1_20260423.sol';
import {AaveV3Ethereum_LiquidateRsETHPositionUser2_20260423} from './mainnet/AaveV3Ethereum_LiquidateRsETHPositionUser2_20260423.sol';

import {AaveV3Arbitrum_LiquidateRsETHPositionUser1_20260423} from './arbitrum/AaveV3Arbitrum_LiquidateRsETHPositionUser1_20260423.sol';
import {AaveV3Arbitrum_LiquidateRsETHPositionUser2_20260423} from './arbitrum/AaveV3Arbitrum_LiquidateRsETHPositionUser2_20260423.sol';
import {AaveV3Arbitrum_LiquidateRsETHPositionUser3_20260423} from './arbitrum/AaveV3Arbitrum_LiquidateRsETHPositionUser3_20260423.sol';
import {AaveV3Arbitrum_LiquidateRsETHPositionUser4_20260423} from './arbitrum/AaveV3Arbitrum_LiquidateRsETHPositionUser4_20260423.sol';
import {AaveV3Arbitrum_LiquidateRsETHPositionUser5_20260423} from './arbitrum/AaveV3Arbitrum_LiquidateRsETHPositionUser5_20260423.sol';
import {AaveV3Arbitrum_LiquidateRsETHPositionUser6_20260423} from './arbitrum/AaveV3Arbitrum_LiquidateRsETHPositionUser6_20260423.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20260423_Multi_LiquidateRsETHPositions/LiquidateRsETHPositions_20260423.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/LiquidateRsETHPositions_20260423.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_LiquidateRsETHPositionUser1_20260423).creationCode
    );
    GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_LiquidateRsETHPositionUser2_20260423).creationCode
    );
  }
}

/**
 * @dev Deploy Arbitrum
 * deploy-command: make deploy-ledger contract=src/20260423_Multi_LiquidateRsETHPositions/LiquidateRsETHPositions_20260423.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/LiquidateRsETHPositions_20260423.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    GovV3Helpers.deployDeterministic(
      type(AaveV3Arbitrum_LiquidateRsETHPositionUser1_20260423).creationCode
    );
    GovV3Helpers.deployDeterministic(
      type(AaveV3Arbitrum_LiquidateRsETHPositionUser2_20260423).creationCode
    );
    GovV3Helpers.deployDeterministic(
      type(AaveV3Arbitrum_LiquidateRsETHPositionUser3_20260423).creationCode
    );
    GovV3Helpers.deployDeterministic(
      type(AaveV3Arbitrum_LiquidateRsETHPositionUser4_20260423).creationCode
    );
    GovV3Helpers.deployDeterministic(
      type(AaveV3Arbitrum_LiquidateRsETHPositionUser5_20260423).creationCode
    );
    GovV3Helpers.deployDeterministic(
      type(AaveV3Arbitrum_LiquidateRsETHPositionUser6_20260423).creationCode
    );
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20260423_Multi_LiquidateRsETHPositions/LiquidateRsETHPositions_20260423.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](8);

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
      actions[0] = GovV3Helpers.buildAction(
        type(AaveV3Ethereum_LiquidateRsETHPositionUser1_20260423).creationCode
      );
      payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actions);
    }
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
      actions[0] = GovV3Helpers.buildAction(
        type(AaveV3Ethereum_LiquidateRsETHPositionUser2_20260423).creationCode
      );
      payloads[1] = GovV3Helpers.buildMainnetPayload(vm, actions);
    }
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
      actions[0] = GovV3Helpers.buildAction(
        type(AaveV3Arbitrum_LiquidateRsETHPositionUser1_20260423).creationCode
      );
      payloads[2] = GovV3Helpers.buildArbitrumPayload(vm, actions);
    }
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
      actions[0] = GovV3Helpers.buildAction(
        type(AaveV3Arbitrum_LiquidateRsETHPositionUser2_20260423).creationCode
      );
      payloads[3] = GovV3Helpers.buildArbitrumPayload(vm, actions);
    }
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
      actions[0] = GovV3Helpers.buildAction(
        type(AaveV3Arbitrum_LiquidateRsETHPositionUser3_20260423).creationCode
      );
      payloads[4] = GovV3Helpers.buildArbitrumPayload(vm, actions);
    }
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
      actions[0] = GovV3Helpers.buildAction(
        type(AaveV3Arbitrum_LiquidateRsETHPositionUser4_20260423).creationCode
      );
      payloads[5] = GovV3Helpers.buildArbitrumPayload(vm, actions);
    }
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
      actions[0] = GovV3Helpers.buildAction(
        type(AaveV3Arbitrum_LiquidateRsETHPositionUser5_20260423).creationCode
      );
      payloads[6] = GovV3Helpers.buildArbitrumPayload(vm, actions);
    }
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
      actions[0] = GovV3Helpers.buildAction(
        type(AaveV3Arbitrum_LiquidateRsETHPositionUser6_20260423).creationCode
      );
      payloads[7] = GovV3Helpers.buildArbitrumPayload(vm, actions);
    }

    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20260423_Multi_LiquidateRsETHPositions/LiquidateRsETHPositions.md'
      )
    );
  }
}
