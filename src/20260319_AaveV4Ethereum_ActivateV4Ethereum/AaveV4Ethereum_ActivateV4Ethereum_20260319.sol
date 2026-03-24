// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IHub} from './interfaces/IHub.sol';
import {IHubConfigurator} from './interfaces/IHubConfigurator.sol';
import {AaveV4EthereumAddresses, AaveV4EthereumHubs} from './AaveV4EthereumAddresses.sol';

/**
 * @title Aave V4 Activation on Ethereum Mainnet
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0x55e85a32828da36122b9c8d50548696d7c748fd41c775f5bf06bdf0f2e32a265
 */
contract AaveV4Ethereum_ActivateV4Ethereum_20260319 is IProposalGenericExecutor {
  function execute() external override {
    _activateHub(AaveV4EthereumHubs.CORE_HUB);
    _activateHub(AaveV4EthereumHubs.PLUS_HUB);
    _activateHub(AaveV4EthereumHubs.PRIME_HUB);
  }

  function _activateHub(IHub hub) internal {
    uint256 assetCount = hub.getAssetCount();
    for (uint256 assetId; assetId < assetCount; ++assetId) {
      _activateAsset({hub: hub, assetId: assetId});
    }
  }

  function _activateAsset(IHub hub, uint256 assetId) internal {
    uint256 spokeCount = hub.getSpokeCount(assetId);

    for (uint256 spokeId; spokeId < spokeCount; ++spokeId) {
      address spoke = hub.getSpokeAddress(assetId, spokeId);
      IHubConfigurator(AaveV4EthereumAddresses.HUB_CONFIGURATOR).updateSpokeActive({
        hub: address(hub),
        assetId: assetId,
        spoke: spoke,
        active: true
      });
    }
  }
}
