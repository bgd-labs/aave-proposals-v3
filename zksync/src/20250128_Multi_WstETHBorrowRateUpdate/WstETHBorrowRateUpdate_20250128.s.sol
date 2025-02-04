// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore} from 'aave-helpers/src/GovV3Helpers.sol';
import {ZkSyncScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3ZkSync_WstETHBorrowRateUpdate_20250128} from './AaveV3ZkSync_WstETHBorrowRateUpdate_20250128.sol';

// @dev wrapper factory contract for deploying the payload
contract Deploy_AaveV3ZkSync_WstETHBorrowRateUpdate_20250128 {
  address public immutable PAYLOAD;

  constructor() {
    PAYLOAD = GovV3Helpers.deployDeterministicZkSync(
      type(AaveV3ZkSync_WstETHBorrowRateUpdate_20250128).creationCode
    );
  }
}

/**
 * @dev Deploy ZkSync
 * deploy-command: make deploy-pk FOUNDRY_PROFILE=contract=zksync/src/20250128_Multi_WstETHBorrowRateUpdate/WstETHBorrowRateUpdate_20250128.s.sol:DeployZkSync chain=zksync
 */
contract DeployZkSync is ZkSyncScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = new Deploy_AaveV3ZkSync_WstETHBorrowRateUpdate_20250128().PAYLOAD();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}
