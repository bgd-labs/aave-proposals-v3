// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AddFXSToEthereumV3_20231025} from './AaveV3Ethereum_AddFXSToEthereumV3_20231025.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_AddFXSToEthereumV3_20231025
 * command: make test-contract filter=AaveV3Ethereum_AddFXSToEthereumV3_20231025
 */
contract AaveV3Ethereum_AddFXSToEthereumV3_20231025_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AddFXSToEthereumV3_20231025 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18428586);
    proposal = new AaveV3Ethereum_AddFXSToEthereumV3_20231025();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AddFXSToEthereumV3_20231025',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_collectorHasFXSFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertGe(
      IERC20(0x3432B6A60D23Ca0dFCa7761B7ab56459D9C964D0).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      10 ** 18
    );
  }
}
