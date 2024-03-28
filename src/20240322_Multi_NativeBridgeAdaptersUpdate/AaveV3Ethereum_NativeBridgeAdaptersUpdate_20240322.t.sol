// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './BaseTest.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {AaveV3Ethereum_NativeBridgeAdaptersUpdate_20240322} from './AaveV3Ethereum_NativeBridgeAdaptersUpdate_20240322.sol';

/**
 * @dev Test for AaveV3Ethereum_NativeBridgeAdaptersUpdate_20240322
 * command: make test-contract filter=AaveV3Ethereum_NativeBridgeAdaptersUpdate_20240322
 */
contract AaveV3Ethereum_NativeBridgeAdaptersUpdate_20240322_Test is BaseTest {
  constructor()
    BaseTest(
      GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER,
      type(AaveV3Ethereum_NativeBridgeAdaptersUpdate_20240322).creationCode,
      'mainnet',
      19490720,
      'Polygon native adapter'
    )
  {}
}
