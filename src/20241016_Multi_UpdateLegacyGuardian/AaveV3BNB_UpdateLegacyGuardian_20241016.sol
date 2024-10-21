// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';
import {MiscBNB} from 'aave-address-book/MiscBNB.sol';
import {GovernanceV3BNB} from 'aave-address-book/GovernanceV3BNB.sol';
import {RenewalV3Params, RenewalV3BasePayload} from './RenewalV3BasePayload.sol';
import {ProtocolGuardians, GovernanceGuardians} from './Guardians.sol';
/**
 * @title Update legacy guardian
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/48
 */
contract AaveV3BNB_UpdateLegacyGuardian_20241016 is RenewalV3BasePayload {
  constructor()
    RenewalV3BasePayload(
      RenewalV3Params({
        aclManager: AaveV3BNB.ACL_MANAGER,
        governance: address(0),
        payloadsController: address(GovernanceV3BNB.PAYLOADS_CONTROLLER),
        protocolGuardian: ProtocolGuardians.BNB_GUARDIAN,
        governanceGuardian: GovernanceGuardians.BNB_GUARDIAN,
        oldGuardian: MiscBNB.PROTOCOL_GUARDIAN
      })
    )
  {}
}
