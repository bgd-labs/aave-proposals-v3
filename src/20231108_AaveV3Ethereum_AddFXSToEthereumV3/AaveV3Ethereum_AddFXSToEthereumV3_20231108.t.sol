// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AddFXSToEthereumV3_20231108} from './AaveV3Ethereum_AddFXSToEthereumV3_20231108.sol';

/**
 * @dev Test for AaveV3Ethereum_AddFXSToEthereumV3_20231108
 * command: make test-contract filter=AaveV3Ethereum_AddFXSToEthereumV3_20231108
 */
contract AaveV3Ethereum_AddFXSToEthereumV3_20231108_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AddFXSToEthereumV3_20231108 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18564410);
    proposal = new AaveV3Ethereum_AddFXSToEthereumV3_20231108();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AddFXSToEthereumV3_20231108',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_collectorHasFXSFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Ethereum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.FXS());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.COLLECTOR)), 10 ** 18);
  }
}
