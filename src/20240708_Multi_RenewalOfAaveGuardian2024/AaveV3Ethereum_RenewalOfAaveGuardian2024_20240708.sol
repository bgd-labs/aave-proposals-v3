// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {RenewalV3Params, RenewalV3BasePayload} from './RenewalV3BasePayload.sol';
import {ProtocolGuardians, GovernanceGuardians} from './Guardians.sol';
/**
 * @title Renewal of Aave Guardian 2024
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x003ce30676805f71e5b356745fb3f01e5f82b8d1655750aaef46c7ed4a0a3578
 * - Discussion: https://governance.aave.com/t/arfc-renewal-of-aave-guardian-2024/17523
 */
contract AaveV3Ethereum_RenewalOfAaveGuardian2024_20240708 is RenewalV3BasePayload {
  constructor()
    RenewalV3BasePayload(
      RenewalV3Params({
        aclManager: AaveV3Ethereum.ACL_MANAGER,
        governance: address(GovernanceV3Ethereum.GOVERNANCE),
        payloadsController: address(GovernanceV3Ethereum.PAYLOADS_CONTROLLER),
        protocolGuardian: ProtocolGuardians.ETHEREUM_GUARDIAN,
        governanceGuardian: GovernanceGuardians.ETHEREUM_GUARDIAN,
        oldGuardian: MiscEthereum.PROTOCOL_GUARDIAN
      })
    )
  {}
}
