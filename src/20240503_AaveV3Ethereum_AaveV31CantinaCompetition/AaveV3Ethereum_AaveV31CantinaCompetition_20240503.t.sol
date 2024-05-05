// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AaveV31CantinaCompetition_20240503} from './AaveV3Ethereum_AaveV31CantinaCompetition_20240503.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_AaveV31CantinaCompetition_20240503
 * command: make test-contract filter=AaveV3Ethereum_AaveV31CantinaCompetition_20240503
 */
contract AaveV3Ethereum_AaveV31CantinaCompetition_20240503_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AaveV31CantinaCompetition_20240503 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19789030);
    proposal = new AaveV3Ethereum_AaveV31CantinaCompetition_20240503();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AaveV31CantinaCompetition_20240503',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_consistentBalances() public {
    uint256 collectorGHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 recipientGHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.CANTINA_RECIPIENT()
    );

    executePayload(vm, address(proposal));

    uint256 collectorGHOBalanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 recipientGHOBalanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.CANTINA_RECIPIENT()
    );

    assertEq(collectorGHOBalanceAfter, collectorGHOBalanceBefore - proposal.TOTAL_AMOUNT());
    assertEq(recipientGHOBalanceAfter, recipientGHOBalanceBefore + proposal.TOTAL_AMOUNT());
  }
}
