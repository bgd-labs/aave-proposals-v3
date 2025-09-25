// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_PyUSDParametersOptimization_20250919} from './AaveV3Ethereum_PyUSDParametersOptimization_20250919.sol';

/**
 * @dev Test for AaveV3Ethereum_PyUSDParametersOptimization_20250919
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250919_AaveV3Ethereum_PyUSDParametersOptimization/AaveV3Ethereum_PyUSDParametersOptimization_20250919.t.sol -vv
 */
contract AaveV3Ethereum_PyUSDParametersOptimization_20250919_Test is ProtocolV3TestBase {
  AaveV3Ethereum_PyUSDParametersOptimization_20250919 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23431964);
    proposal = new AaveV3Ethereum_PyUSDParametersOptimization_20250919();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_PyUSDParametersOptimization_20250919',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
