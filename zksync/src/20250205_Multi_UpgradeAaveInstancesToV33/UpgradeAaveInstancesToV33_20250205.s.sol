// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore} from 'aave-helpers/src/GovV3Helpers.sol';
import {ZkSyncScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';

/**
 * @dev Deploy ZkSync
 * deploy-command: FOUNDRY_PROFILE=zksync make deploy-ledger contract=zksync/src/20250205_Multi_UpgradeAaveInstancesToV33/UpgradeAaveInstancesToV33_20250205.s.sol:DeployZkSync chain=zksync
 */
contract DeployZkSync is ZkSyncScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = 0xcE69DAb549C757432B7e4b62ec496fdc50a66218;

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}
