// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {MiscGnosis} from 'aave-address-book/MiscGnosis.sol';
import {GovernanceV3Gnosis} from 'aave-address-book/GovernanceV3Gnosis.sol';
import {BaseCCCImplementationUpdatePayload} from './BaseCCCImplementationUpdatePayload.sol';

/**
 * @title aDI and bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/21
 */
contract AaveV3Gnosis_UpdateADIImplementationAndCCIPAdapters_20240313 is
  BaseCCCImplementationUpdatePayload(
    BaseCCCImplementationUpdatePayload.CCCImplementationUpdateInput({
      ccc: GovernanceV3Gnosis.CROSS_CHAIN_CONTROLLER,
      proxyAdmin: MiscGnosis.PROXY_ADMIN,
      newCCCImplementation: 0x5e06b10B3b9c3E1c0996D2544A35B9839Be02922
    })
  )
{}
