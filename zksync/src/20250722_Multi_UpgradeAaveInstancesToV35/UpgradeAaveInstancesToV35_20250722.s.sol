// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore} from 'aave-helpers/src/GovV3Helpers.sol';

import {ZkSyncScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3ZkSync_UpgradeAaveInstancesToV35_20250722} from './AaveV3ZkSync_UpgradeAaveInstancesToV35_20250722.sol';

/**
 * @dev Deploy ZkSync
 * deploy-command: make deploy-ledger-zk contract=zksync/src/20250722_Multi_UpgradeAaveInstancesToV35/UpgradeAaveInstancesToV35_20250722.s.sol:DeployZkSync chain=zksync
 */
contract DeployZkSync is ZkSyncScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = address(new AaveV3ZkSync_UpgradeAaveInstancesToV35_20250722{salt: 'aave'}());

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}
