// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {EthereumScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';

import {AaveV4Ethereum_IncreaseCaps_20260520} from './AaveV4Ethereum_IncreaseCaps_20260520.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-account contract=src/20260520_AaveV4Ethereum_IncreaseCaps/IncreaseCaps_20260520.s.sol chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/IncreaseCaps_20260520.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast returns (address) {
    // deploy payload
    return
      GovV3Helpers.deployDeterministic(type(AaveV4Ethereum_IncreaseCaps_20260520).creationCode);
  }
}
