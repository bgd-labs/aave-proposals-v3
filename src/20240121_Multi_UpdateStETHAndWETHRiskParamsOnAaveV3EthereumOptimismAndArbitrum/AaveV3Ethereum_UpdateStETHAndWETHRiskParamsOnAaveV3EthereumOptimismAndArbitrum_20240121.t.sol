// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121} from './AaveV3Ethereum_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121.sol';

/**
 * @dev Test for AaveV3Ethereum_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121
 * command: make test-contract filter=AaveV3Ethereum_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121
 */
contract AaveV3Ethereum_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121
    internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19057854);
    proposal = new AaveV3Ethereum_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
