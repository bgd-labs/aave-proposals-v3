// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript, ArbitrumScript, BaseScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Multi_AllowBalancerDAOToClaimLiquidityMiningRewards_20250318} from './AaveV3Multi_AllowBalancerDAOToClaimLiquidityMiningRewards_20250318.sol';

/**
 * @dev Deploy Arbitrum
 * deploy-command: make deploy-ledger contract=src/20250318_Multi_AllowBalancerDAOToClaimLiquidityMiningRewards/AllowBalancerDAOToClaimLiquidityMiningRewards_20250318.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: FOUNDRY_PROFILE=arbitrum npx catapulta-verify -b broadcast/AllowBalancerDAOToClaimLiquidityMiningRewards_20250318.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  address public constant CLAIMER = 0x9ff471F9f98F42E5151C7855fD1b5aa906b1AF7e;
  address public constant BALANCER_VAULT = 0xbA1333333333a1BA1108E8412f11850A5C319bA9;

  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Multi_AllowBalancerDAOToClaimLiquidityMiningRewards_20250318).creationCode,
      abi.encode(CLAIMER, BALANCER_VAULT, AaveV3Arbitrum.EMISSION_MANAGER)
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
 * @dev Deploy Base
 * deploy-command: make deploy-ledger contract=src/20250318_Multi_AllowBalancerDAOToClaimLiquidityMiningRewards/AllowBalancerDAOToClaimLiquidityMiningRewards_20250318.s.sol:DeployBase chain=base
 * verify-command: FOUNDRY_PROFILE=base npx catapulta-verify -b broadcast/AllowBalancerDAOToClaimLiquidityMiningRewards_20250318.s.sol/8453/run-latest.json
 */
contract DeployBase is BaseScript {
  address public constant CLAIMER = 0x9ff471F9f98F42E5151C7855fD1b5aa906b1AF7e;
  address public constant BALANCER_VAULT = 0xbA1333333333a1BA1108E8412f11850A5C319bA9;

  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Multi_AllowBalancerDAOToClaimLiquidityMiningRewards_20250318).creationCode,
      abi.encode(CLAIMER, BALANCER_VAULT, AaveV3Base.EMISSION_MANAGER)
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
 * command: make deploy-ledger contract=src/20250318_Multi_AllowBalancerDAOToClaimLiquidityMiningRewards/AllowBalancerDAOToClaimLiquidityMiningRewards_20250318.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  address public constant CLAIMER = 0x9ff471F9f98F42E5151C7855fD1b5aa906b1AF7e;
  address public constant BALANCER_VAULT = 0xbA1333333333a1BA1108E8412f11850A5C319bA9;

  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](2);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(
      type(AaveV3Multi_AllowBalancerDAOToClaimLiquidityMiningRewards_20250318).creationCode,
      abi.encode(CLAIMER, BALANCER_VAULT, AaveV3Arbitrum.EMISSION_MANAGER)
    );
    payloads[0] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBase[0] = GovV3Helpers.buildAction(
      type(AaveV3Multi_AllowBalancerDAOToClaimLiquidityMiningRewards_20250318).creationCode,
      abi.encode(CLAIMER, BALANCER_VAULT, AaveV3Base.EMISSION_MANAGER)
    );
    payloads[1] = GovV3Helpers.buildBasePayload(vm, actionsBase);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250318_Multi_AllowBalancerDAOToClaimLiquidityMiningRewards/AllowBalancerDAOToClaimLiquidityMiningRewards.md'
      )
    );
  }
}
