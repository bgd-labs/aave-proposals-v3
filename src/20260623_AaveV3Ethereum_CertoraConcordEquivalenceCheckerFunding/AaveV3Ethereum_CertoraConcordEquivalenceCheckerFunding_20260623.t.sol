// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_CertoraConcordEquivalenceCheckerFunding_20260623} from './AaveV3Ethereum_CertoraConcordEquivalenceCheckerFunding_20260623.sol';

/**
 * @dev Test for AaveV3Ethereum_CertoraConcordEquivalenceCheckerFunding_20260623
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260623_AaveV3Ethereum_CertoraConcordEquivalenceCheckerFunding/AaveV3Ethereum_CertoraConcordEquivalenceCheckerFunding_20260623.t.sol -vv
 */
contract AaveV3Ethereum_CertoraConcordEquivalenceCheckerFunding_20260623_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_CertoraConcordEquivalenceCheckerFunding_20260623 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25380684);
    proposal = new AaveV3Ethereum_CertoraConcordEquivalenceCheckerFunding_20260623();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_CertoraConcordEquivalenceCheckerFunding_20260623',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_fund() public {
    uint256 balanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.CERTORA_RECEIVER()
    );

    executePayload(vm, address(proposal));

    uint256 balanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.CERTORA_RECEIVER()
    );
    assertEq(balanceAfter - balanceBefore, proposal.FUNDING_AMOUNT());
  }
}
