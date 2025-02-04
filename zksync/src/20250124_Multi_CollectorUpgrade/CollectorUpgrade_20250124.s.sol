// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore} from 'aave-helpers/src/GovV3Helpers.sol';
import {ZkSyncScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';

/**
 * @dev Deploy ZkSync
 * deploy-command: FOUNDRY_PROFILE=zksync make deploy-ledger contract=zksync/src/20250124_Multi_CollectorUpgrade/CollectorUpgrade_20250124.s.sol:DeployZkSync chain=zksync
 */
contract DeployZkSync is ZkSyncScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(0xa5569DA53e95dD6311f01CCE03FA0BAD56d04125);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}
