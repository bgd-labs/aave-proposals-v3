// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';

import {AaveV2Ethereum_AprilFinanceUpdate_20240421} from './AaveV2Ethereum_AprilFinanceUpdate_20240421.sol';

/**
 * @dev Test for AaveV2Ethereum_AprilFinanceUpdate_20240421
 * command: make test-contract filter=AaveV2Ethereum_AprilFinanceUpdate_20240421
 */
contract AaveV2Ethereum_AprilFinanceUpdate_20240421_Test is ProtocolV2TestBase {
  AaveV2Ethereum_AprilFinanceUpdate_20240421 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19706815);
    proposal = new AaveV2Ethereum_AprilFinanceUpdate_20240421();
  }

  function test_bgdReimbursements() public {
    uint256 recipientAUsdcBalanceBefore = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );
    uint256 recipientAUsdtBalanceBefore = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );
    uint256 recipientALinkBalanceBefore = IERC20(AaveV2EthereumAssets.LINK_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );

    executePayload(vm, address(proposal));

    uint256 recipientAUsdcBalanceAfter = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );
    uint256 recipientAUsdtBalanceAfter = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );
    uint256 recipientALinkBalanceAfter = IERC20(AaveV2EthereumAssets.LINK_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );

    assertApproxEqAbs(
      recipientAUsdcBalanceAfter,
      recipientAUsdcBalanceBefore + proposal.USDC_AMOUNT_REIMBURSEMENT(),
      1
    );
    assertApproxEqAbs(
      recipientAUsdtBalanceAfter,
      recipientAUsdtBalanceBefore + proposal.USDT_AMOUNT_REIMBURSEMENT(),
      1
    );
    assertApproxEqAbs(
      recipientALinkBalanceAfter,
      recipientALinkBalanceBefore + proposal.LINK_AMOUNT_REIMBURSEMENT(),
      1
    );
  }

  function test_agdAllowanceChanges() public {
    assertGt(
      IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.AGD_MULTISIG()
      ),
      0
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.AGD_MULTISIG()
      ),
      0
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.AGD_MULTISIG()
      ),
      0
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.AGD_MULTISIG()
      ),
      proposal.AGD_GHO_ALLOWANCE()
    );
  }

  function test_v2ToV3Migration() public {}

  function test_swaps() public {}
}
