// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovHelpers} from 'aave-helpers/src/GovHelpers.sol';
import {EthereumScript, ArbitrumScript, PolygonScript, AvalancheScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Ethereum_RescueTokensFromAdapters_20240916_GovV2} from './AaveV3Ethereum_RescueTokensFromAdapters_20240916_GovV2.sol';
// import {AaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809} from './AaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809.sol';
// import {AaveV3_Polygon_AddDebtSwapAdapterAsFlashBorrower_20230809} from './AaveV3_Polygon_AddDebtSwapAdapterAsFlashBorrower_20230809.sol';
// import {AaveV3_Avalanche_AddDebtSwapAdapterAsFlashBorrower_20230809} from './AaveV3_Avalanche_AddDebtSwapAdapterAsFlashBorrower_20230809.sol';
// import {AaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809} from './AaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809.sol';

/**
 * @dev Deploy AaveV3Ethereum_RescueTokensFromAdapters_20240916_GovV2
 * command: make deploy-ledger contract=src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_AddDebtSwapAdapterAsFlashBorrower_20230809.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3Ethereum_RescueTokensFromAdapters_20240916_GovV2();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_AddDebtSwapAdapterAsFlashBorrower_20230809.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0xbCb167bDCF14a8F791d6f4A6EDd964aed2F8813B); //TODO: fill in proposal address
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
