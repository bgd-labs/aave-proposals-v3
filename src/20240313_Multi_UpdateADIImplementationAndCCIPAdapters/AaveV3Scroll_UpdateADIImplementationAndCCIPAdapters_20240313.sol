// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {MiscScroll} from 'aave-address-book/MiscScroll.sol';
import {GovernanceV3Scroll} from 'aave-address-book/GovernanceV3Scroll.sol';
import {BaseCCCImplementationUpdatePayload} from './BaseCCCImplementationUpdatePayload.sol';

/**
 * @title aDI and bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/21
 */
contract AaveV3Scroll_UpdateADIImplementationAndCCIPAdapters_20240313 is
  BaseCCCImplementationUpdatePayload(
    BaseCCCImplementationUpdatePayload.CCCImplementationUpdateInput({
      ccc: GovernanceV3Scroll.CROSS_CHAIN_CONTROLLER,
      proxyAdmin: MiscScroll.PROXY_ADMIN,
      newCCCImplementation: 0x5e06b10B3b9c3E1c0996D2544A35B9839Be02922
    })
  )
{}
