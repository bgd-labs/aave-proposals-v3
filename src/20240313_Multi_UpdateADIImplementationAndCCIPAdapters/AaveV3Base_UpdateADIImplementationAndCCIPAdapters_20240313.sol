// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';
import {BaseCCCImplementationUpdatePayload} from './BaseCCCImplementationUpdatePayload.sol';

/**
 * @title aDI and bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/21
 */
contract AaveV3Base_UpdateADIImplementationAndCCIPAdapters_20240313 is
  BaseCCCImplementationUpdatePayload(
    BaseCCCImplementationUpdatePayload.CCCImplementationUpdateInput({
      ccc: GovernanceV3Base.CROSS_CHAIN_CONTROLLER,
      proxyAdmin: MiscBase.PROXY_ADMIN,
      newCCCImplementation: 0x9b6f5ef589A3DD08670Dd146C11C4Fb33E04494F
    })
  )
{}
