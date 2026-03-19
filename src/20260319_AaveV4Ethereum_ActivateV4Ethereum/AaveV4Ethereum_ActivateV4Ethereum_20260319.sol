// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IHub} from '../interfaces/v4/IHub.sol';
import {IHubConfigurator} from '../interfaces/v4/IHubConfigurator.sol';
import {AaveV4EthereumAddresses} from './AaveV4EthereumAddresses.sol';

/**
 * @title Aave V4 Ethereum - Activate Spokes
 * @author Aave Labs
 * - Discussion: TODO
 */
contract AaveV4Ethereum_ActivateV4Ethereum_20260319 is IProposalGenericExecutor {
  function execute() external override {
    address[3] memory hubs = [
      AaveV4EthereumAddresses.CORE_HUB,
      AaveV4EthereumAddresses.PLUS_HUB,
      AaveV4EthereumAddresses.PRIME_HUB
    ];
    address[10] memory spokes = [
      AaveV4EthereumAddresses.MAIN_SPOKE,
      AaveV4EthereumAddresses.BLUECHIP_SPOKE,
      AaveV4EthereumAddresses.ETHENA_CORRELATED_SPOKE,
      AaveV4EthereumAddresses.ETHENA_ECOSYSTEM_SPOKE,
      AaveV4EthereumAddresses.ETHERFI_ESPOKE,
      AaveV4EthereumAddresses.FOREX_SPOKE,
      AaveV4EthereumAddresses.GOLD_SPOKE,
      AaveV4EthereumAddresses.KELP_ESPOKE,
      AaveV4EthereumAddresses.LIDO_ESPOKE,
      AaveV4EthereumAddresses.LOMBARD_BTC_SPOKE
    ];

    address treasurySpoke = AaveV4EthereumAddresses.TREASURY_SPOKE;

    for (uint256 h = 0; h < hubs.length; ++h) {
      uint256 assetCount = IHub(hubs[h]).getAssetCount();
      for (uint256 a = 0; a < assetCount; ++a) {
        // Activate regular spokes if listed
        for (uint256 s = 0; s < spokes.length; ++s) {
          if (IHub(hubs[h]).isSpokeListed(a, spokes[s])) {
            IHubConfigurator(AaveV4EthereumAddresses.HUB_CONFIGURATOR).updateSpokeActive(
              hubs[h],
              a,
              spokes[s],
              true
            );
          }
        }

        // TODO: repeat the same pattern for the tokenization spoke once its address is available

        // Activate treasury spoke
        IHubConfigurator(AaveV4EthereumAddresses.HUB_CONFIGURATOR).updateSpokeActive(
          hubs[h],
          a,
          treasurySpoke,
          true
        );
      }
    }
  }
}
