// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';
import {MiscBNB} from 'aave-address-book/MiscBNB.sol';
import {GovernanceV3BNB} from 'aave-address-book/GovernanceV3BNB.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import './BaseTest.sol';

import {AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313.sol';

/**
 * @dev Test for AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313
 * command: make test-contract filter=AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313
 */
contract AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313_Test is BaseTest {
  constructor()
    BaseTest(
      GovernanceV3BNB.CROSS_CHAIN_CONTROLLER,
      MiscBNB.PROXY_ADMIN,
      type(AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313).creationCode,
      'bnb',
      37073128
    )
  {}
}
