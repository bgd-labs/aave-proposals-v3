// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './BaseTest.sol';
import {GovernanceV3BNB} from 'aave-address-book/GovernanceV3BNB.sol';
import {AaveV3BNB_LayerZeroBridgeAdapterUpdateToV2_20240322} from './AaveV3BNB_LayerZeroBridgeAdapterUpdateToV2_20240322.sol';

/**
 * @dev Test for AaveV3BNB_LayerZeroBridgeAdapterUpdateToV2_20240322
 * command: make test-contract filter=AaveV3BNB_LayerZeroBridgeAdapterUpdateToV2_20240322
 */
contract AaveV3BNB_LayerZeroBridgeAdapterUpdateToV2_20240322_Test is BaseTest {
  constructor()
    BaseTest(
      GovernanceV3BNB.CROSS_CHAIN_CONTROLLER,
      type(AaveV3BNB_LayerZeroBridgeAdapterUpdateToV2_20240322).creationCode,
      'bnb',
      37187776
    )
  {}
}
