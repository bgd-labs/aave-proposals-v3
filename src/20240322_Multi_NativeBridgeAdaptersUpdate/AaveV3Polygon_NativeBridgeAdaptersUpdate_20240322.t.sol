// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './BaseTest.sol';
import {GovernanceV3Polygon} from 'aave-address-book/GovernanceV3Polygon.sol';
import {AaveV3Polygon_NativeBridgeAdaptersUpdate_20240322} from './AaveV3Polygon_NativeBridgeAdaptersUpdate_20240322.sol';

/**
 * @dev Test for AaveV3Polygon_NativeBridgeAdaptersUpdate_20240322
 * command: make test-contract filter=AaveV3Polygon_NativeBridgeAdaptersUpdate_20240322
 */
contract AaveV3Polygon_NativeBridgeAdaptersUpdate_20240322_Test is BaseTest {
  constructor()
    BaseTest(
      GovernanceV3Polygon.CROSS_CHAIN_CONTROLLER,
      type(AaveV3Polygon_NativeBridgeAdaptersUpdate_20240322).creationCode,
      'polygon',
      54954005,
      'Polygon native adapter'
    )
  {}
}
