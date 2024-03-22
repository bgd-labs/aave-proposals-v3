// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {MiscMetis} from 'aave-address-book/MiscMetis.sol';
import {GovernanceV3Metis} from 'aave-address-book/GovernanceV3Metis.sol';
import {BaseCCCImplementationUpdatePayload} from './BaseCCCImplementationUpdatePayload.sol';

/**
 * @title aDI and bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/21
 */
contract AaveV3Metis_UpdateADIImplementationAndCCIPAdapters_20240313 is
  BaseCCCImplementationUpdatePayload(
    BaseCCCImplementationUpdatePayload.CCCImplementationUpdateInput({
      ccc: GovernanceV3Metis.CROSS_CHAIN_CONTROLLER,
      proxyAdmin: MiscMetis.PROXY_ADMIN,
      newCCCImplementation: 0xa198Fac58E02A5C5F8F7e877895d50cFa9ad1E04
    })
  )
{}
