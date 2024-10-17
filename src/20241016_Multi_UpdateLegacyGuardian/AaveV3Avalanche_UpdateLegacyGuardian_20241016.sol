// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {RenewalV3Params, RenewalV3BasePayload} from './RenewalV3BasePayload.sol';
import {ProtocolGuardians, GovernanceGuardians} from './Guardians.sol';
/**
 * @title Update legacy guardian
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/48
 */
contract AaveV3Avalanche_UpdateLegacyGuardian_20241016 is RenewalV3BasePayload {
  constructor()
    RenewalV3BasePayload(
      RenewalV3Params({
        aclManager: AaveV3Avalanche.ACL_MANAGER,
        governance: address(0),
        payloadsController: address(GovernanceV3Avalanche.PAYLOADS_CONTROLLER),
        protocolGuardian: ProtocolGuardians.AVALANCHE_GUARDIAN,
        governanceGuardian: GovernanceGuardians.AVALANCHE_GUARDIAN,
        oldGuardian: MiscAvalanche.PROTOCOL_GUARDIAN
      })
    )
  {}
}
