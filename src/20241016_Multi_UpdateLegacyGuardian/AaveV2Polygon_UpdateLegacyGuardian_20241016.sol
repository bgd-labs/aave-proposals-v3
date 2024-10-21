// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon} from 'aave-address-book/AaveV2Polygon.sol';
import {RenewalV2Params, RenewalV2BasePayload} from './RenewalV2BasePayload.sol';
import {ProtocolGuardians} from './Guardians.sol';
/**
 * @title Update legacy guardian
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/48
 */
contract AaveV2Polygon_UpdateLegacyGuardian_20241016 is RenewalV2BasePayload {
  constructor()
    RenewalV2BasePayload(
      RenewalV2Params({
        addressesProvider: AaveV2Polygon.POOL_ADDRESSES_PROVIDER,
        guardian: ProtocolGuardians.POLYGON_GUARDIAN
      })
    )
  {}
}
