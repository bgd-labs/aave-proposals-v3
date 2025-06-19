// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AuditReimbursement} from './AuditReimbursement.sol';

/**
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250610_Multi_UpgradeAaveInstancesToV34/AuditReimbursement.t.sol -vv
 */
contract AuditReimbursement_Test is ProtocolV3TestBase {
  AuditReimbursement internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22725168);
    proposal = new AuditReimbursement();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_AuditReimbursement', AaveV3Ethereum.POOL, address(proposal));
  }

  function test_approvals() public {
    uint256 balanceBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      proposal.BGD_SAFE()
    );

    executePayload(vm, address(proposal));

    uint256 balanceAfter = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(proposal.BGD_SAFE());
    assertApproxEqAbs(balanceAfter, balanceBefore + 213_125e6, 1);
  }
}
