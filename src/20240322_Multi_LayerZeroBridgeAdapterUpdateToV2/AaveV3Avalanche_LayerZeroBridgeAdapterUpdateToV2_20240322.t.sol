// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './BaseTest.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {AaveV3Avalanche_LayerZeroBridgeAdapterUpdateToV2_20240322} from './AaveV3Avalanche_LayerZeroBridgeAdapterUpdateToV2_20240322.sol';

/**
 * @dev Test for AaveV3Avalanche_LayerZeroBridgeAdapterUpdateToV2_20240322
 * command: make test-contract filter=AaveV3Avalanche_LayerZeroBridgeAdapterUpdateToV2_20240322
 */
contract AaveV3Avalanche_LayerZeroBridgeAdapterUpdateToV2_20240322_Test is BaseTest {
  constructor()
    BaseTest(
      GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER,
      type(AaveV3Avalanche_LayerZeroBridgeAdapterUpdateToV2_20240322).creationCode,
      'avalanche',
      43223949
    )
  {}
}
