// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, GovV3Helpers, IERC20} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AaveDAOBGDLabs2MonthSecurityRetainer_20260406} from './AaveV3Ethereum_AaveDAOBGDLabs2MonthSecurityRetainer_20260406.sol';

/**
 * @dev Test for AaveV3Ethereum_AaveDAOBGDLabs2MonthSecurityRetainer_20260406
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260406_AaveV3Ethereum_AaveDAOBGDLabs2MonthSecurityRetainer/AaveV3Ethereum_AaveDAOBGDLabs2MonthSecurityRetainer_20260406.t.sol -vv
 */
contract AaveV3Ethereum_AaveDAOBGDLabs2MonthSecurityRetainer_20260406_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AaveDAOBGDLabs2MonthSecurityRetainer_20260406 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24820179);
    proposal = new AaveV3Ethereum_AaveDAOBGDLabs2MonthSecurityRetainer_20260406();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AaveDAOBGDLabs2MonthSecurityRetainer_20260406',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_BgdReceivedUsdtToken() public {
    uint256 balanceBefore = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      proposal.BGD_RECEIVER()
    );
    GovV3Helpers.executePayload(vm, address(proposal));
    uint256 balanceAfter = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      proposal.BGD_RECEIVER()
    );

    assertEq(balanceAfter - balanceBefore, 200_000e6);
  }
}
