// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320} from './AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320.sol';
import './BaseTest.sol';

/**
 * @dev Test for AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320
 * command: make test-contract filter=AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320
 */
contract AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320_Test is BaseTest {
  constructor()
    BaseTest(
      GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER,
      type(AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320).creationCode,
      'avalanche',
      43150105
    )
  {}
}
