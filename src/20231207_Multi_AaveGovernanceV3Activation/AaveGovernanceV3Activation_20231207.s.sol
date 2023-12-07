// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';

/**
 * @dev Create Long Proposal
 * command: make deploy-ledger contract=src/20231207_Multi_AaveGovernanceV3Activation/AaveGovernanceV3Activation_20231207.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](2);
    payloads[0] = GovHelpers.buildMainnet(0x62F5c2C54495567537c0f9C4B66A6adb3b584148);
    payloads[1] = GovHelpers.buildBasePayload(0x44B4221c950fCf23A40e68dEa29feD0bB88893a9);

    // create proposal
    vm.startBroadcast();
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20231207_Multi_AaveGovernanceV3Activation/AaveGovernanceV3Activation.md'
      )
    );
  }
}
