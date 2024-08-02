// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {RenewalV2Params, RenewalV2BasePayload} from './RenewalV2BasePayload.sol';
import {ProtocolGuardians} from './Guardians.sol';

/**
 * @title Renewal of Aave Guardian 2024
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x003ce30676805f71e5b356745fb3f01e5f82b8d1655750aaef46c7ed4a0a3578
 * - Discussion: https://governance.aave.com/t/arfc-renewal-of-aave-guardian-2024/17523
 */
contract AaveV2Ethereum_RenewalOfAaveGuardian2024_20240708 is RenewalV2BasePayload {
  constructor()
    RenewalV2BasePayload(
      RenewalV2Params({
        addressesProvider: AaveV2Ethereum.POOL_ADDRESSES_PROVIDER,
        guardian: ProtocolGuardians.ETHEREUM_GUARDIAN
      })
    )
  {}
}
