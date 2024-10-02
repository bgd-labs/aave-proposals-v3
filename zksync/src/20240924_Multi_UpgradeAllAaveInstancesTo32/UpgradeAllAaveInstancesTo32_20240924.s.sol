// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore} from 'aave-helpers/src/GovV3Helpers.sol';
import {ZkSyncScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {Payloads} from '../../../src/20240924_Multi_UpgradeAllAaveInstancesTo32/UpgradeAllAaveInstancesTo32_20240924.s.sol';

/**
 * @dev Deploy ZkSync
 * deploy-command: make deploy-ledger contract=zksync/src/20240924_Multi_UpgradeAllAaveInstancesTo32/UpgradeAllAaveInstancesTo32_20240924.s.sol:DeployZkSync chain=zksync
 * verify-command: FOUNDRY_PROFILE=zksync npx catapulta-verify -b broadcast/UpgradeAllAaveInstancesTo32_20240924.s.sol/324/run-latest.json
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
