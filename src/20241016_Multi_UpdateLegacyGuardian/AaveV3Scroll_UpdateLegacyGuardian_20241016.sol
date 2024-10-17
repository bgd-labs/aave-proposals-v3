// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';
import {MiscScroll} from 'aave-address-book/MiscScroll.sol';
import {GovernanceV3Scroll} from 'aave-address-book/GovernanceV3Scroll.sol';
import {RenewalV3Params, RenewalV3BasePayload} from './RenewalV3BasePayload.sol';
import {ProtocolGuardians, GovernanceGuardians} from './Guardians.sol';
/**
 * @title Update legacy guardian
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/48
 */
contract AaveV3Scroll_UpdateLegacyGuardian_20241016 is RenewalV3BasePayload {
  constructor()
    RenewalV3BasePayload(
      RenewalV3Params({
        aclManager: AaveV3Scroll.ACL_MANAGER,
        governance: address(0),
        payloadsController: address(GovernanceV3Scroll.PAYLOADS_CONTROLLER),
        protocolGuardian: ProtocolGuardians.SCROLL_GUARDIAN,
        governanceGuardian: GovernanceGuardians.SCROLL_GUARDIAN,
        oldGuardian: MiscScroll.PROTOCOL_GUARDIAN
      })
    )
  {}
}
