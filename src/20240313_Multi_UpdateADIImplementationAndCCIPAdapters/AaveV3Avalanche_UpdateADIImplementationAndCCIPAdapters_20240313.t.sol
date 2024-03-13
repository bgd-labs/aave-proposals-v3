// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import './BaseTest.sol';

import {AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313.sol';

/**
 * @dev Test for AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313
 * command: make test-contract filter=AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313
 */
contract AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313_Test is BaseTest {
  constructor()
    BaseTest(
      GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER,
      MiscAvalanche.PROXY_ADMIN,
      type(AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313).creationCode,
      'avalanche',
      42801819
    )
  {}
}
