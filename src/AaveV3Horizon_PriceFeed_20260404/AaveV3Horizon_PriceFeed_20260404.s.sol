// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console2 as console} from 'forge-std/console2.sol';
import {EthereumScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Horizon_PriceFeed_20260404} from 'src/AaveV3Horizon_PriceFeed_20260404/AaveV3Horizon_PriceFeed_20260404.sol';

/**
 * @dev Deploy the payload and log Safe-ready calldata for Emergency MS execution.
 * command: make deploy-payload
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    address payload = GovV3Helpers.deployDeterministic(
      type(AaveV3Horizon_PriceFeed_20260404).creationCode
    );
    console.log('payload:', payload);
  }
}
