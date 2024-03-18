// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovernanceV3Polygon} from 'aave-address-book/GovernanceV3Polygon.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import './BaseTest.sol';
import {AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313.sol';
import {AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313.sol';
import {AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313.sol';
import {AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313.sol';

/**
 * @dev Test for AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313
 * command: make test-contract filter=AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313
 */
contract AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313_Test is BaseTest {
  constructor()
    BaseTest(
      GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER,
      MiscEthereum.PROXY_ADMIN,
      type(AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313).creationCode,
      'mainnet',
      19418547
    )
  {}
}
