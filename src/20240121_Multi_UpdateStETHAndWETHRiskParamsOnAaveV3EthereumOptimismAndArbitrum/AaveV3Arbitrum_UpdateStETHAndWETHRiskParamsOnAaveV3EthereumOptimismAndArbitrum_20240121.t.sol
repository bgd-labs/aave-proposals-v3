// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121} from './AaveV3Arbitrum_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121.sol';

/**
 * @dev Test for AaveV3Arbitrum_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121
 * command: make test-contract filter=AaveV3Arbitrum_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121
 */
contract AaveV3Arbitrum_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121_Test is
  ProtocolV3TestBase
{
  AaveV3Arbitrum_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121
    internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 172815645);
    proposal = new AaveV3Arbitrum_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }
}
