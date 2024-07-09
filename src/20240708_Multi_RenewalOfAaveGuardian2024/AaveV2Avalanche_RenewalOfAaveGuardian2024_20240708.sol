// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Avalanche} from 'aave-address-book/AaveV2Avalanche.sol';
import {RenewalV2Params, RenewalV2BasePayload} from './RenewalV2BasePayload.sol';
import {Guardians} from './Guardians.sol';

/**
 * @title Renewal of Aave Guardian 2024
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x51cde0e183bd250839ef1fc4feb04a592263f848d44d1f67618504f98fa80865
 * - Discussion: https://governance.aave.com/t/arfc-renewal-of-aave-guardian-2024/17523
 */
contract AaveV2Avalanche_RenewalOfAaveGuardian2024_20240708 is RenewalV2BasePayload {
  constructor()
    RenewalV2BasePayload(
      RenewalV2Params({
        addressesProvider: AaveV2Avalanche.POOL_ADDRESSES_PROVIDER,
        guardian: Guardians.AVALANCHE_GUARDIAN
      })
    )
  {}
}
