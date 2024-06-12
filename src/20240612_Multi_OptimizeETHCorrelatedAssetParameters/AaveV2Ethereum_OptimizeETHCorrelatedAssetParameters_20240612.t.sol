// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_OptimizeETHCorrelatedAssetParameters_20240612} from './AaveV2Ethereum_OptimizeETHCorrelatedAssetParameters_20240612.sol';

/**
 * @dev Test for AaveV2Ethereum_OptimizeETHCorrelatedAssetParameters_20240612
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV2Ethereum_OptimizeETHCorrelatedAssetParameters_20240612.t.sol -vv
 */
contract AaveV2Ethereum_OptimizeETHCorrelatedAssetParameters_20240612_Test is ProtocolV2TestBase {
  AaveV2Ethereum_OptimizeETHCorrelatedAssetParameters_20240612 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20078542);
    proposal = new AaveV2Ethereum_OptimizeETHCorrelatedAssetParameters_20240612();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Ethereum_OptimizeETHCorrelatedAssetParameters_20240612',
      AaveV2Ethereum.POOL,
      address(proposal)
    );
  }
}
