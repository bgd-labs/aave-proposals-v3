// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2EthereumAMM} from 'aave-address-book/AaveV2EthereumAMM.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2EthereumAMM_ARFCDeprecateAaveV2AMMMarketStep2_20240205} from './AaveV2EthereumAMM_ARFCDeprecateAaveV2AMMMarketStep2_20240205.sol';

/**
 * @dev Test for AaveV2EthereumAMM_ARFCDeprecateAaveV2AMMMarketStep2_20240205
 * command: make test-contract filter=AaveV2EthereumAMM_ARFCDeprecateAaveV2AMMMarketStep2_20240205
 */
contract AaveV2EthereumAMM_ARFCDeprecateAaveV2AMMMarketStep2_20240205_Test is ProtocolV2TestBase {
  AaveV2EthereumAMM_ARFCDeprecateAaveV2AMMMarketStep2_20240205 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19164401);
    proposal = new AaveV2EthereumAMM_ARFCDeprecateAaveV2AMMMarketStep2_20240205();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2EthereumAMM_ARFCDeprecateAaveV2AMMMarketStep2_20240205',
      AaveV2EthereumAMM.POOL,
      address(proposal),
      false
    );
  }
}
