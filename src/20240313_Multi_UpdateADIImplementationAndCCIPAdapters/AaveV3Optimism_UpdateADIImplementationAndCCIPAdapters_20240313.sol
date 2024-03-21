// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {MiscOptimism} from 'aave-address-book/MiscOptimism.sol';
import {GovernanceV3Optimism} from 'aave-address-book/GovernanceV3Optimism.sol';
import {BaseCCCImplementationUpdatePayload} from './BaseCCCImplementationUpdatePayload.sol';

/**
 * @title aDI and bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/21
 */
contract AaveV3Optimism_UpdateADIImplementationAndCCIPAdapters_20240313 is
  BaseCCCImplementationUpdatePayload(
    BaseCCCImplementationUpdatePayload.CCCImplementationUpdateInput({
      ccc: GovernanceV3Optimism.CROSS_CHAIN_CONTROLLER,
      proxyAdmin: MiscOptimism.PROXY_ADMIN,
      newCCCImplementation: 0xa5cc218513305221201f196760E9e64e9D49d98A
    })
  )
{}
