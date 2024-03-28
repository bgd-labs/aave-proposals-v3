// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './BaseTest.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';
import {AaveV3Base_NativeBridgeAdaptersUpdate_20240322} from './AaveV3Base_NativeBridgeAdaptersUpdate_20240322.sol';

/**
 * @dev Test for AaveV3Base_NativeBridgeAdaptersUpdate_20240322
 * command: make test-contract filter=AaveV3Base_NativeBridgeAdaptersUpdate_20240322
 */
contract AaveV3Base_NativeBridgeAdaptersUpdate_20240322_Test is BaseTest {
  constructor()
    BaseTest(
      GovernanceV3Base.CROSS_CHAIN_CONTROLLER,
      type(AaveV3Base_NativeBridgeAdaptersUpdate_20240322).creationCode,
      'base',
      12163947,
      'Base native adapter'
    )
  {}
}
