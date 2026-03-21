// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_WstETHCAPOOracleIncidentUserReimbursement_20260312} from './AaveV3Ethereum_WstETHCAPOOracleIncidentUserReimbursement_20260312.sol';

/**
 * @dev Test for AaveV3Ethereum_WstETHCAPOOracleIncidentUserReimbursement_20260312
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260312_AaveV3Ethereum_WstETHCAPOOracleIncidentUserReimbursement/AaveV3Ethereum_WstETHCAPOOracleIncidentUserReimbursement_20260312.t.sol -vv
 */
contract AaveV3Ethereum_WstETHCAPOOracleIncidentUserReimbursement_20260312_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_WstETHCAPOOracleIncidentUserReimbursement_20260312 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24642267);
    proposal = new AaveV3Ethereum_WstETHCAPOOracleIncidentUserReimbursement_20260312();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_WstETHCAPOOracleIncidentUserReimbursement_20260312',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_afcAllowance() public {
    assertEq(
      IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        MiscEthereum.AFC_SAFE
      ),
      0,
      'AFC WETH allowance should be 0 before'
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        MiscEthereum.AFC_SAFE
      ),
      proposal.WETH_REIMBURSEMENT(),
      'AFC WETH allowance mismatch after'
    );
  }
}
