// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, HarmonyScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Harmony_FreezePriceFeedsOnV3Harmony_20231122} from './AaveV3Harmony_FreezePriceFeedsOnV3Harmony_20231122.sol';

/**
 * @dev Deploy Harmony
 * command: make deploy-ledger contract=src/20231122_AaveV3Harmony_FreezePriceFeedsOnV3Harmony/FreezePriceFeedsOnV3Harmony_20231122.s.sol:DeployHarmony chain=harmony
 */
contract DeployHarmony is HarmonyScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Harmony_FreezePriceFeedsOnV3Harmony_20231122 payload0 = new AaveV3Harmony_FreezePriceFeedsOnV3Harmony_20231122();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231122_AaveV3Harmony_FreezePriceFeedsOnV3Harmony/FreezePriceFeedsOnV3Harmony_20231122.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](0);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231122_AaveV3Harmony_FreezePriceFeedsOnV3Harmony/FreezePriceFeedsOnV3Harmony.md'
      )
    );
  }
}
