// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_FluidAlignment_TokenTransfers_20241127} from './AaveV3Ethereum_FluidAlignment_TokenTransfers_20241127.sol';

/**
 * @dev Test for AaveV3Ethereum_FluidAlignment_TokenTransfers_20241127
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241127_Multi_FluidAlignment/AaveV3Ethereum_FluidAlignment_20241127.t.sol -vv
 */
contract AaveV3Ethereum_FluidAlignment_TokenTransfers_20241127_Test is ProtocolV3TestBase {
  AaveV3Ethereum_FluidAlignment_TokenTransfers_20241127 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21280537);
    proposal = new AaveV3Ethereum_FluidAlignment_TokenTransfers_20241127();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_FluidAlignment_TokenTransfers_20241127',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_hasReceivedInst() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    uint256 balance = IERC20(proposal.INST_TOKEN()).balanceOf(address(AaveV3Ethereum.COLLECTOR));
    assertEq(balance, proposal.INST_AMOUNT());
  }

  function test_hasSentGho() external {
    uint256 balanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    GovV3Helpers.executePayload(vm, address(proposal));
    uint256 balanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertGt(balanceBefore, balanceAfter);
    assertEq(balanceBefore - balanceAfter, proposal.GHO_AMOUNT());
  }
}
