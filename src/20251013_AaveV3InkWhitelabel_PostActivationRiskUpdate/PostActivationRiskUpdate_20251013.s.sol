// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3InkWhitelabel} from 'aave-address-book/GovernanceV3InkWhitelabel.sol';

import {EthereumScript, InkScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3InkWhitelabel_PostActivationRiskUpdate_20251013} from './AaveV3InkWhitelabel_PostActivationRiskUpdate_20251013.sol';

/**
 * @dev Deploy Ink
 * deploy-command: make deploy-ledger contract=src/20251013_AaveV3InkWhitelabel_PostActivationRiskUpdate/PostActivationRiskUpdate_20251013.s.sol:DeployInk chain=ink
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/PostActivationRiskUpdate_20251013.s.sol/57073/run-latest.json
 */
contract DeployInk is InkScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3InkWhitelabel_PostActivationRiskUpdate_20251013).creationCode
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPermissionedPayloadCalldata(
      GovernanceV3InkWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER,
      actions
    );
  }
}
