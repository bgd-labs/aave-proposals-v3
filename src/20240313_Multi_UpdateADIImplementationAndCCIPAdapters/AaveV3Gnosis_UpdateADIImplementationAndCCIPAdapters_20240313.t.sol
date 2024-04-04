// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {MiscGnosis} from 'aave-address-book/MiscGnosis.sol';
import {GovernanceV3Gnosis} from 'aave-address-book/GovernanceV3Gnosis.sol';

import {AaveV3Gnosis_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3Gnosis_UpdateADIImplementationAndCCIPAdapters_20240313.sol';
import {BaseCCCImplementationUpdatePayloadTest} from './BaseCCCImplementationUpdatePayloadTest.sol';

/**
 * @dev Test for AaveV3Gnosis_UpdateADIImplementationAndCCIPAdapters_20240313
 * command: make test-contract filter=AaveV3Gnosis_UpdateADIImplementationAndCCIPAdapters_20240313
 */
contract AaveV3Gnosis_UpdateADIImplementationAndCCIPAdapters_20240313_Test is
  BaseCCCImplementationUpdatePayloadTest(
    GovernanceV3Gnosis.CROSS_CHAIN_CONTROLLER,
    MiscGnosis.PROXY_ADMIN,
    type(AaveV3Gnosis_UpdateADIImplementationAndCCIPAdapters_20240313).creationCode,
    'gnosis',
    32990165
  )
{}
