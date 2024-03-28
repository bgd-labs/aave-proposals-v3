// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './BaseTest.sol';
import {GovernanceV3Metis} from 'aave-address-book/GovernanceV3Metis.sol';
import {AaveV3Metis_NativeBridgeAdaptersUpdate_20240322} from './AaveV3Metis_NativeBridgeAdaptersUpdate_20240322.sol';

/**
 * @dev Test for AaveV3Metis_NativeBridgeAdaptersUpdate_20240322
 * command: make test-contract filter=AaveV3Metis_NativeBridgeAdaptersUpdate_20240322
 */
contract AaveV3Metis_NativeBridgeAdaptersUpdate_20240322_Test is BaseTest {
  constructor()
    BaseTest(
      GovernanceV3Metis.CROSS_CHAIN_CONTROLLER,
      type(AaveV3Metis_NativeBridgeAdaptersUpdate_20240322).creationCode,
      'metis',
      15632608,
      'Metis native adapter'
    )
  {}
}
