// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AuditReimbursement_20250722} from './AaveV3Ethereum_AuditReimbursement_20250722.sol';

/**
 * @dev Test for AaveV3Ethereum_AuditReimbursement_20250722
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250722_Multi_UpgradeAaveInstancesToV35/AaveV3Ethereum_AuditReimbursement_20250722.t.sol -vv
 */
contract AaveV3Ethereum_AuditReimbursement_20250722_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AuditReimbursement_20250722 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22977349);
    proposal = new AaveV3Ethereum_AuditReimbursement_20250722();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AuditReimbursement_20250722',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_transfer() public {
    uint256 balanceBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      proposal.BGD_SAFE()
    );

    executePayload(vm, address(proposal));

    uint256 balanceAfter = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(proposal.BGD_SAFE());
    assertApproxEqAbs(balanceAfter, balanceBefore + 96050e6, 1);
  }
}
