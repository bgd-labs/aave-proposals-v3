// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {MiscScroll} from 'aave-address-book/MiscScroll.sol';
import {GovernanceV3Scroll} from 'aave-address-book/GovernanceV3Scroll.sol';

import {AaveV3Scroll_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3Scroll_UpdateADIImplementationAndCCIPAdapters_20240313.sol';
import {BaseCCCImplementationUpdatePayloadTest} from './BaseCCCImplementationUpdatePayloadTest.sol';

/**
 * @dev Test for AaveV3Scroll_UpdateADIImplementationAndCCIPAdapters_20240313
 * command: make test-contract filter=AaveV3Scroll_UpdateADIImplementationAndCCIPAdapters_20240313
 */
contract AaveV3Scroll_UpdateADIImplementationAndCCIPAdapters_20240313_Test is
  BaseCCCImplementationUpdatePayloadTest(
    GovernanceV3Scroll.CROSS_CHAIN_CONTROLLER,
    MiscScroll.PROXY_ADMIN,
    type(AaveV3Scroll_UpdateADIImplementationAndCCIPAdapters_20240313).creationCode,
    'scroll',
    4063725
  )
{}
