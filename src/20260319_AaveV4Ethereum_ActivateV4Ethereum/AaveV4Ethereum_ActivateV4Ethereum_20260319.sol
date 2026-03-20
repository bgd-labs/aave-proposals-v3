// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IHub} from './interfaces/IHub.sol';
import {IHubConfigurator} from './interfaces/IHubConfigurator.sol';
import {AaveV4EthereumAddresses} from './AaveV4EthereumAddresses.sol';

/**
 * @title Aave V4 Ethereum - Activate Spokes
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0x55e85a32828da36122b9c8d50548696d7c748fd41c775f5bf06bdf0f2e32a265
 */
contract AaveV4Ethereum_ActivateV4Ethereum_20260319 is IProposalGenericExecutor {
  function execute() external override {
    address[3] memory hubs = AaveV4EthereumAddresses.getHubs();

    for (uint256 h = 0; h < hubs.length; ++h) {
      uint256 assetCount = IHub(hubs[h]).getAssetCount();
      for (uint256 a = 0; a < assetCount; ++a) {
        _activateAllSpokes(hubs[h], a);
      }
    }
  }

  function _activateAllSpokes(address hub, uint256 assetId) internal {
    uint256 spokeCount = IHub(hub).getSpokeCount(assetId);

    for (uint256 i = 0; i < spokeCount; ++i) {
      address spoke = IHub(hub).getSpokeAddress(assetId, i);
      IHubConfigurator(AaveV4EthereumAddresses.HUB_CONFIGURATOR).updateSpokeActive(
        hub,
        assetId,
        spoke,
        true
      );
    }
  }
}
