// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_GHOVariableDebtTokenUpgrade_20231126} from './AaveV3Ethereum_GHOVariableDebtTokenUpgrade_20231126.sol';

/**
 * @dev Test for AaveV3Ethereum_GHOVariableDebtTokenUpgrade_20231126
 * command: make test-contract filter=AaveV3Ethereum_GHOVariableDebtTokenUpgrade_20231126
 */
contract AaveV3Ethereum_GHOVariableDebtTokenUpgrade_20231126_Test is ProtocolV3TestBase {
  AaveV3Ethereum_GHOVariableDebtTokenUpgrade_20231126 internal proposal;
  address constant NEW_VGHO_IMPL = address(0);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18584275);
    proposal = new AaveV3Ethereum_GHOVariableDebtTokenUpgrade_20231126(NEW_VGHO_IMPL);
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_GHOVariableDebtTokenUpgrade_20231126',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
