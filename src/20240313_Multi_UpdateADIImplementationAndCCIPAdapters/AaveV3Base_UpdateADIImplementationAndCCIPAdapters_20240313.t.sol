// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';

import {AaveV3Base_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3Base_UpdateADIImplementationAndCCIPAdapters_20240313.sol';
import {BaseCCCImplementationUpdatePayloadTest} from './BaseCCCImplementationUpdatePayloadTest.sol';

/**
 * @dev Test for AaveV3Base_UpdateADIImplementationAndCCIPAdapters_20240313
 * command: make test-contract filter=AaveV3Base_UpdateADIImplementationAndCCIPAdapters_20240313
 */
contract AaveV3Base_UpdateADIImplementationAndCCIPAdapters_20240313_Test is
  BaseCCCImplementationUpdatePayloadTest(
    GovernanceV3Base.CROSS_CHAIN_CONTROLLER,
    MiscBase.PROXY_ADMIN,
    type(AaveV3Base_UpdateADIImplementationAndCCIPAdapters_20240313).creationCode,
    'base',
    11725901
  )
{}
