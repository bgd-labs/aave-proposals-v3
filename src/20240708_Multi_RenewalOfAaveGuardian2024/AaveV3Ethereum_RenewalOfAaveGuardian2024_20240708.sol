// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {RenewalV3Params, RenewalV3BasePayload} from './RenewalV3BasePayload.sol';
import {ProtocolGuardians} from './Guardians.sol';
/**
 * @title Renewal of Aave Guardian 2024
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x51cde0e183bd250839ef1fc4feb04a592263f848d44d1f67618504f98fa80865
 * - Discussion: https://governance.aave.com/t/arfc-renewal-of-aave-guardian-2024/17523
 */
contract AaveV3Ethereum_RenewalOfAaveGuardian2024_20240708 is RenewalV3BasePayload {
  constructor()
    RenewalV3BasePayload(
      RenewalV3Params({
        aclManager: AaveV3Ethereum.ACL_MANAGER,
        governance: address(GovernanceV3Ethereum.GOVERNANCE),
        payloadsController: address(GovernanceV3Ethereum.PAYLOADS_CONTROLLER),
        newGuardian: ProtocolGuardians.ETHEREUM_GUARDIAN,
        oldGuardian: MiscEthereum.PROTOCOL_GUARDIAN
      })
    )
  {}
}
