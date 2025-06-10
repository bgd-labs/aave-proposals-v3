// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AAVEBuybacksAllocation_20250403} from './AaveV3Ethereum_AAVEBuybacksAllocation_20250403.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';

/**
 * @dev Test for AaveV3Ethereum_AAVEBuybacksAllocation_20250403
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250403_AaveV3Ethereum_AAVEBuybacksAllocation/AaveV3Ethereum_AAVEBuybacksAllocation_20250403.t.sol -vv
 */
contract AaveV3Ethereum_AAVEBuybacksAllocation_20250403_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AAVEBuybacksAllocation_20250403 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22189779);
    proposal = new AaveV3Ethereum_AAVEBuybacksAllocation_20250403();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AAVEBuybacksAllocation_20250403',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_allowance() external {
    uint256 allowanceBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AFC()
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AFC()
    );

    uint256 diffAllowance = allowanceAfter - allowanceBefore;
    assertEq(diffAllowance, proposal.USDT_AMOUNT());
  }

  function test_claim() external {
    uint256 balanceCollectorBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceAFCBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(proposal.AFC());

    // execute approval
    GovV3Helpers.executePayload(vm, address(proposal));

    // execute transfer
    vm.startPrank(proposal.AFC());
    IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AFC(),
      proposal.USDT_AMOUNT()
    );
    vm.stopPrank();

    uint256 balanceCollectorAfter = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceAFCAfter = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(proposal.AFC());

    uint256 diffBalanceAFC = balanceAFCAfter - balanceAFCBefore;
    uint256 diffBalanceCollector = balanceCollectorBefore - balanceCollectorAfter;

    // -1 because of low decimal precision of USDT
    assertEq(diffBalanceAFC, proposal.USDT_AMOUNT() - 1);
    assertEq(diffBalanceCollector, proposal.USDT_AMOUNT());
  }
}
