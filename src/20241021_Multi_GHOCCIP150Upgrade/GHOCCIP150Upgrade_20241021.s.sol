// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript, ArbitrumScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Ethereum_GHOCCIP150Upgrade_20241021} from './AaveV3Ethereum_GHOCCIP150Upgrade_20241021.sol';
import {AaveV3Arbitrum_GHOCCIP150Upgrade_20241021} from './AaveV3Arbitrum_GHOCCIP150Upgrade_20241021.sol';
import {Script} from 'forge-std/Script.sol';

import {IUpgradeableBurnMintTokenPool} from 'src/interfaces/ccip/IUpgradeableBurnMintTokenPool.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20241021_Multi_GHOCCIP150Upgrade/GHOCCIP150Upgrade_20241021.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=mainnet npx catapulta-verify -b broadcast/GHOCCIP150Upgrade_20241021.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_GHOCCIP150Upgrade_20241021).creationCode
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
 * @dev Deploy Arbitrum
 * deploy-command: make deploy-ledger contract=src/20241021_Multi_GHOCCIP150Upgrade/GHOCCIP150Upgrade_20241021.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: FOUNDRY_PROFILE=arbitrum npx catapulta-verify -b broadcast/GHOCCIP150Upgrade_20241021.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Arbitrum_GHOCCIP150Upgrade_20241021).creationCode
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
 * command: make deploy-ledger contract=src/20241021_Multi_GHOCCIP150Upgrade/GHOCCIP150Upgrade_20241021.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](2);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_GHOCCIP150Upgrade_20241021).creationCode
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(
      type(AaveV3Arbitrum_GHOCCIP150Upgrade_20241021).creationCode
    );
    payloads[1] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(vm, 'src/20241021_Multi_GHOCCIP150Upgrade/GHOCCIP150Upgrade.md')
    );
  }
}

contract EthConfigurator is Script {
  function run() external {
    vm.startBroadcast();
    // Set rate limit
    IRateLimiter.Config memory rateLimitConfig = IRateLimiter.Config({
      isEnabled: true,
      capacity: 10_000e18,
      rate: 60e18
    });
    IUpgradeableBurnMintTokenPool(0x7768248E1Ff75612c18324bad06bb393c1206980)
      .setChainRateLimiterConfig(3478487238524512106, rateLimitConfig, rateLimitConfig);
    vm.stopBroadcast();
  }
}
contract ArbConfigurator is Script {
  function run() external {
    vm.startBroadcast();
    // Set rate limit
    IRateLimiter.Config memory rateLimitConfig = IRateLimiter.Config({
      isEnabled: true,
      capacity: 10_000e18,
      rate: 60e18
    });
    IUpgradeableBurnMintTokenPool(0x3eC2b6F818B72442fc36561e9F930DD2b60957D2)
      .setChainRateLimiterConfig(16015286601757825753, rateLimitConfig, rateLimitConfig);
    vm.stopBroadcast();
  }
}
