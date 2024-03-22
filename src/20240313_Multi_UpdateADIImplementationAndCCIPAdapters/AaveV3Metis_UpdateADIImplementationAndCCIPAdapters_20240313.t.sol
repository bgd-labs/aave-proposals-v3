// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {MiscMetis} from 'aave-address-book/MiscMetis.sol';
import {GovernanceV3Metis} from 'aave-address-book/GovernanceV3Metis.sol';

import {AaveV3Metis_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3Metis_UpdateADIImplementationAndCCIPAdapters_20240313.sol';
import {BaseCCCImplementationUpdatePayloadTest} from './BaseCCCImplementationUpdatePayloadTest.sol';

/**
 * @dev Test for AaveV3Metis_UpdateADIImplementationAndCCIPAdapters_20240313
 * command: make test-contract filter=AaveV3Metis_UpdateADIImplementationAndCCIPAdapters_20240313
 */
contract AaveV3Metis_UpdateADIImplementationAndCCIPAdapters_20240313_Test is
  BaseCCCImplementationUpdatePayloadTest(
    GovernanceV3Metis.CROSS_CHAIN_CONTROLLER,
    MiscMetis.PROXY_ADMIN,
    type(AaveV3Metis_UpdateADIImplementationAndCCIPAdapters_20240313).creationCode,
    'metis',
    15127085
  )
{}
