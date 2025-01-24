// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore} from 'aave-helpers/src/GovV3Helpers.sol';
import {ZkSyncScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {Payloads} from '../../src/20250124_Multi_CollectorUpgrade/Payloads.sol';

/**
 * @dev Deploy ZkSync
 * deploy-command: make deploy-pk FOUNDRY_PROFILE=contract=zksync/src/20250124_Multi_CollectorUpgrade/CollectorUpgrade_20250124.s.sol:DeployZkSync chain=zksync
 */
contract DeployZkSync is ZkSyncScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.ZKSYNC);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}
