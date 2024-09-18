// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovHelpers} from 'aave-helpers/src/GovHelpers.sol';
import {EthereumScript, PolygonScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Polygon_RescueTokensFromAdapters_20240916_GovV2} from './AaveV3Polygon_RescueTokensFromAdapters_20240916_GovV2.sol';

/**
 * @dev Deploy AaveV3Polygon_RescueTokensFromAdapters_20240916_GovV2
 * command: make deploy-ledger contract=src/20240916_Multi_RescueTokensFromAdapters/RescueTokensFromAdaptersGovV2_20240916.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3Polygon_RescueTokensFromAdapters_20240916_GovV2();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20240916_Multi_RescueTokensFromAdapters/RescueTokensFromAdaptersGovV2_20240916.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(0xbCb167bDCF14a8F791d6f4A6EDd964aed2F8813B); //TODO: fill in proposal address
    // GovV3Helpers.createProposal(
    //   vm,
    //   payloads,
    //   GovV3Helpers.ipfsHashFile(
    //     vm,
    //     'src/20240916_Multi_RescueTokensFromAdapters/RescueTokensFromAdapters.md'
    //   )
    // );
    // GovHelpers.createProposal(
    //   payloads,
    //   GovHelpers.ipfsHashFile(
    //     vm,
    //     'src/20240916_Multi_RescueTokensFromAdapters/RescueTokensFromAdapters.md'
    //   )
    // );
  }
}
