// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {RenewalV3Params, RenewalV3BasePayload} from './RenewalV3BasePayload.sol';
import {ProtocolGuardians, GovernanceGuardians} from './Guardians.sol';
/**
 * @title Update legacy guardian
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/48
 */
contract AaveV3Arbitrum_UpdateLegacyGuardian_20241016 is RenewalV3BasePayload {
  constructor()
    RenewalV3BasePayload(
      RenewalV3Params({
        aclManager: AaveV3Arbitrum.ACL_MANAGER,
        governance: address(0),
        payloadsController: address(GovernanceV3Arbitrum.PAYLOADS_CONTROLLER),
        protocolGuardian: ProtocolGuardians.ARBITRUM_GUARDIAN,
        governanceGuardian: GovernanceGuardians.ARBITRUM_GUARDIAN,
        oldGuardian: MiscArbitrum.PROTOCOL_GUARDIAN
      })
    )
  {}
}
