// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './BaseTest.sol';
import {GovernanceV3Scroll} from 'aave-address-book/GovernanceV3Scroll.sol';
import {AaveV3Scroll_NativeBridgeAdaptersUpdate_20240322} from './AaveV3Scroll_NativeBridgeAdaptersUpdate_20240322.sol';

/**
 * @dev Test for AaveV3Scroll_NativeBridgeAdaptersUpdate_20240322
 * command: make test-contract filter=AaveV3Scroll_NativeBridgeAdaptersUpdate_20240322
 */
contract AaveV3Scroll_NativeBridgeAdaptersUpdate_20240322_Test is BaseTest {
  constructor()
    BaseTest(
      GovernanceV3Scroll.CROSS_CHAIN_CONTROLLER,
      type(AaveV3Scroll_NativeBridgeAdaptersUpdate_20240322).creationCode,
      'scroll',
      4339218,
      'Scroll native adapter'
    )
  {}
}
