// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore} from 'aave-helpers/src/GovV3Helpers.sol';

import {ZkSyncScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3ZkSync_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023} from './AaveV3ZkSync_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.sol';

/**
 * @dev Deploy ZkSync
 * deploy-command: make deploy-ledger-zk contract=zksync/src/20251023_Multi_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances/DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.s.sol:DeployZkSync chain=zksync
 */
contract DeployZkSync is ZkSyncScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = address(
      new AaveV3ZkSync_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023{
        salt: 'aave'
      }()
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}
