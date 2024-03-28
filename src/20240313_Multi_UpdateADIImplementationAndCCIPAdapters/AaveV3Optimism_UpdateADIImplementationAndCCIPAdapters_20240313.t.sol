// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {MiscOptimism} from 'aave-address-book/MiscOptimism.sol';
import {GovernanceV3Optimism} from 'aave-address-book/GovernanceV3Optimism.sol';

import {AaveV3Optimism_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3Optimism_UpdateADIImplementationAndCCIPAdapters_20240313.sol';
import {BaseCCCImplementationUpdatePayloadTest} from './BaseCCCImplementationUpdatePayloadTest.sol';

/**
 * @dev Test for AaveV3Optimism_UpdateADIImplementationAndCCIPAdapters_20240313
 * command: make test-contract filter=AaveV3Optimism_UpdateADIImplementationAndCCIPAdapters_20240313
 */
contract AaveV3Optimism_UpdateADIImplementationAndCCIPAdapters_20240313_Test is
  BaseCCCImplementationUpdatePayloadTest(
    GovernanceV3Optimism.CROSS_CHAIN_CONTROLLER,
    MiscOptimism.PROXY_ADMIN,
    type(AaveV3Optimism_UpdateADIImplementationAndCCIPAdapters_20240313).creationCode,
    'optimism',
    117321235
  )
{}
