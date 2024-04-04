// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {BaseCCCImplementationUpdatePayload} from './BaseCCCImplementationUpdatePayload.sol';

/**
 * @title aDI and bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/21
 */
contract AaveV3Arbitrum_UpdateADIImplementationAndCCIPAdapters_20240313 is
  BaseCCCImplementationUpdatePayload(
    BaseCCCImplementationUpdatePayload.CCCImplementationUpdateInput({
      ccc: GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER,
      proxyAdmin: MiscArbitrum.PROXY_ADMIN,
      newCCCImplementation: 0x6e633269af45F37c44659D98f382dd0DD524E5Df
    })
  )
{}
