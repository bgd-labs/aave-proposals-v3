// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './BaseTest.sol';
import {GovernanceV3Gnosis} from 'aave-address-book/GovernanceV3Gnosis.sol';
import {AaveV3Gnosis_LayerZeroBridgeAdapterUpdateToV2_20240322} from './AaveV3Gnosis_LayerZeroBridgeAdapterUpdateToV2_20240322.sol';

/**
 * @dev Test for AaveV3Gnosis_LayerZeroBridgeAdapterUpdateToV2_20240322
 * command: make test-contract filter=AaveV3Gnosis_LayerZeroBridgeAdapterUpdateToV2_20240322
 */
contract AaveV3Gnosis_LayerZeroBridgeAdapterUpdateToV2_20240322_Test is BaseTest {
  constructor()
    BaseTest(
      GovernanceV3Gnosis.CROSS_CHAIN_CONTROLLER,
      type(AaveV3Gnosis_LayerZeroBridgeAdapterUpdateToV2_20240322).creationCode,
      'gnosis',
      33056141
    )
  {}
}
