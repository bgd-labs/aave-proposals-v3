// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_LRTAndWstETHUnificationSummary_20250324} from './AaveV3EthereumLido_LRTAndWstETHUnificationSummary_20250324.sol';

/**
 * @dev Test for AaveV3EthereumLido_LRTAndWstETHUnificationSummary_20250324
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250324_Multi_LRTAndWstETHUnificationSummary/AaveV3EthereumLido_LRTAndWstETHUnificationSummary_20250324.t.sol -vv
 */
contract AaveV3EthereumLido_LRTAndWstETHUnificationSummary_20250324_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_LRTAndWstETHUnificationSummary_20250324 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22117340);
    proposal = new AaveV3EthereumLido_LRTAndWstETHUnificationSummary_20250324();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_LRTAndWstETHUnificationSummary_20250324',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }
}
