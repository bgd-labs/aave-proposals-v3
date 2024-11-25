// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {ITransparentProxyFactory, ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/interfaces/ITransparentProxyFactory.sol';
import {GHODirectMinter} from './GHODirectMinter.sol';
import {AaveV3EthereumLido_GHOListingOnLidoPool_20241119} from './AaveV3EthereumLido_GHOListingOnLidoPool_20241119.sol';

library GHODirectMinterDeploymentLib {
  function _deploy() internal returns (address) {
    address vaultImpl = address(
      new GHODirectMinter(
        AaveV3EthereumLido.POOL,
        address(AaveV3EthereumLido.COLLECTOR),
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );
    return
      ITransparentProxyFactory(MiscEthereum.TRANSPARENT_PROXY_FACTORY).create(
        vaultImpl,
        ProxyAdmin(MiscEthereum.PROXY_ADMIN),
        abi.encodeWithSelector(
          GHODirectMinter.initialize.selector,
          GovernanceV3Ethereum.EXECUTOR_LVL_1
        )
      );
  }
}

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20241119_AaveV3EthereumLido_GHOListingOnLidoPool/GHOListingOnLidoPool_20241119.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=mainnet npx catapulta-verify -b broadcast/GHOListingOnLidoPool_20241119.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3EthereumLido_GHOListingOnLidoPool_20241119).creationCode
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
 * command: make deploy-ledger contract=src/20241119_AaveV3EthereumLido_GHOListingOnLidoPool/GHOListingOnLidoPool_20241119.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV3EthereumLido_GHOListingOnLidoPool_20241119).creationCode
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20241119_AaveV3EthereumLido_GHOListingOnLidoPool/GHOListingOnLidoPool.md'
      )
    );
  }
}
