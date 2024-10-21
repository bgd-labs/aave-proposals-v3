// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {MiscOptimism} from 'aave-address-book/MiscOptimism.sol';
import {GovernanceV3Optimism} from 'aave-address-book/GovernanceV3Optimism.sol';
import {RenewalV3Params, RenewalV3BasePayload} from './RenewalV3BasePayload.sol';
import {ProtocolGuardians, GovernanceGuardians} from './Guardians.sol';
/**
 * @title Update legacy guardian
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/48
 */
contract AaveV3Optimism_UpdateLegacyGuardian_20241016 is RenewalV3BasePayload {
  constructor()
    RenewalV3BasePayload(
      RenewalV3Params({
        aclManager: AaveV3Optimism.ACL_MANAGER,
        governance: address(0),
        payloadsController: address(GovernanceV3Optimism.PAYLOADS_CONTROLLER),
        protocolGuardian: ProtocolGuardians.OPTIMISM_GUARDIAN,
        governanceGuardian: GovernanceGuardians.OPTIMISM_GUARDIAN,
        oldGuardian: MiscOptimism.PROTOCOL_GUARDIAN
      })
    )
  {}
}
