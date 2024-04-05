// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './BaseTest.sol';
import {GovernanceV3Optimism} from 'aave-address-book/GovernanceV3Optimism.sol';
import {AaveV3Optimism_NativeBridgeAdaptersUpdate_20240322} from './AaveV3Optimism_NativeBridgeAdaptersUpdate_20240322.sol';

/**
 * @dev Test for AaveV3Optimism_NativeBridgeAdaptersUpdate_20240322
 * command: make test-contract filter=AaveV3Optimism_NativeBridgeAdaptersUpdate_20240322
 */
contract AaveV3Optimism_NativeBridgeAdaptersUpdate_20240322_Test is BaseTest {
  constructor()
    BaseTest(
      GovernanceV3Optimism.CROSS_CHAIN_CONTROLLER,
      type(AaveV3Optimism_NativeBridgeAdaptersUpdate_20240322).creationCode,
      'optimism',
      117759224,
      'Optimism native adapter'
    )
  {}
}
