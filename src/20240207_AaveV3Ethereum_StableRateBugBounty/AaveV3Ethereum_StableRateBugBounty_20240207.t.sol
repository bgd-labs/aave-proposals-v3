// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum_StableRateBugBounty_20240207} from './AaveV3Ethereum_StableRateBugBounty_20240207.sol';

/**
 * @dev Test for AaveV3Ethereum_StableRateBugBounty_20240207
 * command: make test-contract filter=AaveV3Ethereum_StableRateBugBounty_20240207
 */
contract AaveV3Ethereum_StableRateBugBounty_20240207_Test is ProtocolV3TestBase {
  AaveV3Ethereum_StableRateBugBounty_20240207 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19290890);
    proposal = new AaveV3Ethereum_StableRateBugBounty_20240207();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_StableRateBugBounty_20240207',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_consistentBalances() public {
    uint256 immunefiUsdtBalanceBefore = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      proposal.IMMUNEFI_RECIPIENT()
    );
    uint256 whitehatUsdtBalanceBefore = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      proposal.WHITEHAT_RECIPIENT()
    );
    uint256 whitehatAaveBalanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      proposal.WHITEHAT_RECIPIENT()
    );

    executePayload(vm, address(proposal));

    uint256 immunefiUsdtBalanceAfter = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      proposal.IMMUNEFI_RECIPIENT()
    );
    uint256 whitehatUsdtBalanceAfter = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      proposal.WHITEHAT_RECIPIENT()
    );
    uint256 whitehatAaveBalanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      proposal.WHITEHAT_RECIPIENT()
    );

    assertApproxEqAbs(
      immunefiUsdtBalanceAfter,
      immunefiUsdtBalanceBefore + proposal.USDT_IMMUNEFI_AMOUNT(),
      1
    );
    assertApproxEqAbs(
      whitehatUsdtBalanceAfter,
      whitehatUsdtBalanceBefore + proposal.USDT_WHITEHAT_AMOUNT(),
      1
    );
    assertEq(whitehatAaveBalanceAfter, whitehatAaveBalanceBefore + proposal.AAVE_WHITEHAT_AMOUNT());
  }
}
