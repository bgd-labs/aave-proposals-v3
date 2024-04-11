// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './BaseTest.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {AaveV3Arbitrum_NativeBridgeAdaptersUpdate_20240322} from './AaveV3Arbitrum_NativeBridgeAdaptersUpdate_20240322.sol';

/**
 * @dev Test for AaveV3Arbitrum_NativeBridgeAdaptersUpdate_20240322
 * command: make test-contract filter=AaveV3Arbitrum_NativeBridgeAdaptersUpdate_20240322
 */
contract AaveV3Arbitrum_NativeBridgeAdaptersUpdate_20240322_Test is BaseTest {
  constructor()
    BaseTest(
      GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER,
      type(AaveV3Arbitrum_NativeBridgeAdaptersUpdate_20240322).creationCode,
      'arbitrum',
      193049277,
      'Arbitrum native adapter'
    )
  {}
}
