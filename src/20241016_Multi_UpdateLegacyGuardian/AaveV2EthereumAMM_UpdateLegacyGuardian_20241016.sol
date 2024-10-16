// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2EthereumAMM} from 'aave-address-book/AaveV2EthereumAMM.sol';
import {RenewalV2Params, RenewalV2BasePayload} from './RenewalV2BasePayload.sol';
import {ProtocolGuardians} from './Guardians.sol';

/**
 * @title Update legacy guardian
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/48
 */
contract AaveV2EthereumAMM_UpdateLegacyGuardian_20241016 is RenewalV2BasePayload {
  constructor()
    RenewalV2BasePayload(
      RenewalV2Params({
        addressesProvider: AaveV2EthereumAMM.POOL_ADDRESSES_PROVIDER,
        guardian: ProtocolGuardians.ETHEREUM_GUARDIAN
      })
    )
  {}
}
