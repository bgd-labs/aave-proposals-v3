// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IHubConfigurator} from 'aave-v4/hub/interfaces/IHubConfigurator.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';

import {AaveV4Avalanche, AaveV4AvalancheHubs} from 'aave-address-book/AaveV4Avalanche.sol';

/**
 * @title Aave V4 Avalanche Activation
 * @author Aave Labs
 * - Snapshot: https://snapshot.org/#/aavedao.eth/proposal/0xe5c4a9387ce1096075f2ad5c3840a915ef730a1ad9180118be8bd4b6f10dacfe
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-v4-on-avalanche/25165
 */
contract AaveV4Avalanche_AaveV4AvalancheActivation_20260708 is IProposalGenericExecutor {
  function execute() external override {
    _activateHub(AaveV4AvalancheHubs.CORE_HUB);
  }

  function _activateHub(IHub hub) internal {
    uint256 assetCount = hub.getAssetCount();
    for (uint256 assetId; assetId < assetCount; ++assetId) {
      _activateAsset(hub, assetId);
    }
  }

  function _activateAsset(IHub hub, uint256 assetId) internal {
    uint256 spokeCount = hub.getSpokeCount(assetId);

    for (uint256 spokeId; spokeId < spokeCount; ++spokeId) {
      address spoke = hub.getSpokeAddress({assetId: assetId, index: spokeId});
      IHubConfigurator(AaveV4Avalanche.HUB_CONFIGURATOR).updateSpokeActive({
        hub: address(hub),
        assetId: assetId,
        spoke: spoke,
        active: true
      });
    }
  }
}
