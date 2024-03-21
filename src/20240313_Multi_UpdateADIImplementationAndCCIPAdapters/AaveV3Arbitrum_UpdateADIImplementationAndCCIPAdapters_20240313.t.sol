// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';

import {AaveV3Arbitrum_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3Arbitrum_UpdateADIImplementationAndCCIPAdapters_20240313.sol';
import {BaseCCCImplementationUpdatePayloadTest} from './BaseCCCImplementationUpdatePayloadTest.sol';

/**
 * @dev Test for AaveV3Arbitrum_UpdateADIImplementationAndCCIPAdapters_20240313
 * command: make test-contract filter=AaveV3Arbitrum_UpdateADIImplementationAndCCIPAdapters_20240313
 */
contract AaveV3Arbitrum_UpdateADIImplementationAndCCIPAdapters_20240313_Test is
  BaseCCCImplementationUpdatePayloadTest(
    GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER,
    MiscArbitrum.PROXY_ADMIN,
    type(AaveV3Arbitrum_UpdateADIImplementationAndCCIPAdapters_20240313).creationCode,
    'arbitrum',
    189596312
  )
{}
