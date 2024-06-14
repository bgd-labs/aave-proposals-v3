// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ALServiceProviderProposal_20240614} from './AaveV3Ethereum_ALServiceProviderProposal_20240614.sol';

/**
 * @dev Test for AaveV3Ethereum_ALServiceProviderProposal_20240614
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240614_AaveV3Ethereum_ALServiceProviderProposal/AaveV3Ethereum_ALServiceProviderProposal_20240614.t.sol -vv
 */
contract AaveV3Ethereum_ALServiceProviderProposal_20240614_Test is ProtocolV3TestBase {
  AaveV3Ethereum_ALServiceProviderProposal_20240614 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20092863);
    proposal = new AaveV3Ethereum_ALServiceProviderProposal_20240614();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_ALServiceProviderProposal_20240614',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
