// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript, GnosisScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Multi_AllowBalancerToClaimMiningRewards_20250122} from './AaveV3Multi_AllowBalancerToClaimMiningRewards_20250122.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20250122_Multi_AllowBalancerToClaimMiningRewards/AllowBalancerToClaimMiningRewards_20250122.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=mainnet npx catapulta-verify -b broadcast/AllowBalancerToClaimMiningRewards_20250122.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  address public constant CLAIMER = 0x9ff471F9f98F42E5151C7855fD1b5aa906b1AF7e;
  address public constant BALANCER_VAULT = 0xbA1333333333a1BA1108E8412f11850A5C319bA9;

  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Multi_AllowBalancerToClaimMiningRewards_20250122).creationCode,
      abi.encode(CLAIMER, BALANCER_VAULT, AaveV3Ethereum.EMISSION_MANAGER)
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
 * @dev Deploy Gnosis
 * deploy-command: make deploy-ledger contract=src/20250122_Multi_AllowBalancerToClaimMiningRewards/AllowBalancerToClaimMiningRewards_20250122.s.sol:DeployGnosis chain=gnosis
 * verify-command: FOUNDRY_PROFILE=gnosis npx catapulta-verify -b broadcast/AllowBalancerToClaimMiningRewards_20250122.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  address public constant CLAIMER = 0x9ff471F9f98F42E5151C7855fD1b5aa906b1AF7e;
  address public constant BALANCER_VAULT = 0xbA1333333333a1BA1108E8412f11850A5C319bA9;

  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Multi_AllowBalancerToClaimMiningRewards_20250122).creationCode,
      abi.encode(CLAIMER, BALANCER_VAULT, AaveV3Gnosis.EMISSION_MANAGER)
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
 * command: make deploy-ledger contract=src/20250122_Multi_AllowBalancerToClaimMiningRewards/AllowBalancerToClaimMiningRewards_20250122.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  address public constant CLAIMER = 0x9ff471F9f98F42E5151C7855fD1b5aa906b1AF7e;
  address public constant BALANCER_VAULT = 0xbA1333333333a1BA1108E8412f11850A5C319bA9;

  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](2);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV3Multi_AllowBalancerToClaimMiningRewards_20250122).creationCode,
      abi.encode(CLAIMER, BALANCER_VAULT, AaveV3Ethereum.EMISSION_MANAGER)
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsGnosis[0] = GovV3Helpers.buildAction(
      type(AaveV3Multi_AllowBalancerToClaimMiningRewards_20250122).creationCode,
      abi.encode(CLAIMER, BALANCER_VAULT, AaveV3Gnosis.EMISSION_MANAGER)
    );
    payloads[1] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250122_Multi_AllowBalancerToClaimMiningRewards/AllowBalancerToClaimMiningRewards.md'
      )
    );
  }
}
