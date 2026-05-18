// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {EthereumScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';

import {AaveV4Ethereum_SVRfeeds_20260507} from './AaveV4Ethereum_SVRfeeds_20260507.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-account contract=src/20260507_AaveV4Ethereum_SVRfeeds/SVRfeeds_20260507.s.sol chain=mainnet ACCOUNT_NAME=<accountName>
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast returns (address) {
    // deploy payload
    return GovV3Helpers.deployDeterministic(type(AaveV4Ethereum_SVRfeeds_20260507).creationCode);
  }
}
