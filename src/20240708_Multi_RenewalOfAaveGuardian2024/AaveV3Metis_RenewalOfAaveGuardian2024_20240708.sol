// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';
import {MiscMetis} from 'aave-address-book/MiscMetis.sol';
import {GovernanceV3Metis} from 'aave-address-book/GovernanceV3Metis.sol';

import {RenewalV3Params, RenewalV3BasePayload} from './RenewalV3BasePayload.sol';
import {ProtocolGuardians, GovernanceGuardians} from './Guardians.sol';
/**
 * @title Renewal of Aave Guardian 2024
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x51cde0e183bd250839ef1fc4feb04a592263f848d44d1f67618504f98fa80865
 * - Discussion: https://governance.aave.com/t/arfc-renewal-of-aave-guardian-2024/17523
 */
contract AaveV3Metis_RenewalOfAaveGuardian2024_20240708 is RenewalV3BasePayload {
  constructor()
    RenewalV3BasePayload(
      RenewalV3Params({
        aclManager: AaveV3Metis.ACL_MANAGER,
        governance: address(0),
        payloadsController: address(GovernanceV3Metis.PAYLOADS_CONTROLLER),
        protocolGuardian: ProtocolGuardians.METIS_GUARDIAN,
        governanceGuardian: GovernanceGuardians.METIS_GUARDIAN,
        oldGuardian: MiscMetis.PROTOCOL_GUARDIAN
      })
    )
  {}
}
