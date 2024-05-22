// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';

import {AaveV2Ethereum_AprilFinanceUpdate_20240421} from './AaveV2Ethereum_AprilFinanceUpdate_20240421.sol';

/**
 * @dev Test for AaveV2Ethereum_AprilFinanceUpdate_20240421
 * command: make test-contract filter=AaveV2Ethereum_AprilFinanceUpdate_20240421
 */
contract AaveV2Ethereum_AprilFinanceUpdate_20240421_Test is ProtocolV2TestBase {
  event SwapRequested(
    address milkman,
    address indexed fromToken,
    address indexed toToken,
    address fromOracle,
    address toOracle,
    uint256 amount,
    address indexed recipient,
    uint256 slippage
  );

  struct TokenToSwap {
    address underlying;
    address aToken;
    uint256 balance;
  }

  AaveV2Ethereum_AprilFinanceUpdate_20240421 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19812746);
    proposal = new AaveV2Ethereum_AprilFinanceUpdate_20240421();
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Ethereum_AprilFinanceUpdate_20240421',
      AaveV2Ethereum.POOL,
      address(proposal)
    );
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

  function test_allowanceChanges() public {
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

    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.MERIT_WALLET()
      ),
      0
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.MERIT_WALLET()
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

    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.MERIT_WALLET()
      ),
      proposal.MERIT_GHO_ALLOWANCE()
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.MERIT_WALLET()
      ),
      proposal.MERIT_WETH_V3_ALLOWANCE()
    );
  }

  function test_v2ToV3Migration() public {
    uint256 balanceALINKBefore = IERC20(AaveV2EthereumAssets.LINK_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceAWBTCBefore = IERC20(AaveV2EthereumAssets.WBTC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceAWETHBefore = IERC20(AaveV2EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceASNXCBefore = IERC20(AaveV2EthereumAssets.SNX_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceAEthLINKBefore = IERC20(AaveV3EthereumAssets.LINK_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceAEthWBTCBefore = IERC20(AaveV3EthereumAssets.WBTC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceAEthWETHBefore = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceAEthSNXCBefore = IERC20(AaveV3EthereumAssets.SNX_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    assertLt(
      IERC20(AaveV2EthereumAssets.LINK_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceALINKBefore
    );
    assertLt(
      IERC20(AaveV2EthereumAssets.WBTC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAWBTCBefore
    );
    assertLt(
      IERC20(AaveV2EthereumAssets.WETH_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAWETHBefore
    );
    assertLt(
      IERC20(AaveV2EthereumAssets.SNX_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceASNXCBefore
    );

    assertGt(
      IERC20(AaveV3EthereumAssets.LINK_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAEthLINKBefore
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.WBTC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAEthWBTCBefore
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAEthWETHBefore
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.SNX_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAEthSNXCBefore
    );
  }

  function test_withdrawV2() public {
    TokenToSwap[] memory tokens = new TokenToSwap[](3);
    tokens[0] = TokenToSwap(
      AaveV2EthereumAssets.DAI_UNDERLYING,
      AaveV2EthereumAssets.DAI_A_TOKEN,
      IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        1 ether
    );
    tokens[1] = TokenToSwap(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      AaveV2EthereumAssets.USDC_A_TOKEN,
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) - 1e6
    );
    tokens[2] = TokenToSwap(
      AaveV2EthereumAssets.USDT_UNDERLYING,
      AaveV2EthereumAssets.USDT_A_TOKEN,
      IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        proposal.USDT_V2_TO_KEEP()
    );

    for (uint256 i = 0; i < tokens.length; i++) {
      assertGt(IERC20(tokens[i].aToken).balanceOf(address(AaveV3Ethereum.COLLECTOR)), 0);
    }

    _expectEmits();

    executePayload(vm, address(proposal));

    for (uint256 i = 0; i < tokens.length; i++) {
      assertApproxEqAbs(
        IERC20(tokens[i].aToken).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
        1 ether,
        1000 ether
      );
    } // V2 Withdrawals leave a lot behind
  }

  function test_withdrawV3() public {
    TokenToSwap[] memory tokens = new TokenToSwap[](2);
    tokens[0] = TokenToSwap(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDC_A_TOKEN,
      proposal.USDC_V3_TO_SWAP()
    );
    tokens[1] = TokenToSwap(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.DAI_A_TOKEN,
      proposal.DAI_V3_TO_SWAP()
    );

    for (uint256 i = 0; i < tokens.length; i++) {
      assertGt(IERC20(tokens[i].aToken).balanceOf(address(AaveV3Ethereum.COLLECTOR)), 0);
    }

    uint256 balanceAEthUSDCBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceAEthDAIBefore = IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    _expectEmits();

    executePayload(vm, address(proposal));

    assertApproxEqAbs(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAEthUSDCBefore - proposal.USDC_V3_TO_SWAP(),
      1,
      'aEthUSDC not within 1 ether'
    );
    assertApproxEqAbs(
      IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAEthDAIBefore - proposal.DAI_V3_TO_SWAP(),
      1,
      'aEthDAI not within 1 ether'
    );
  }

  function _expectEmits() internal {
    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      proposal.GHO_USD_FEED(),
      2559123908595926911497284, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      50
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      proposal.GHO_USD_FEED(),
      2682550752636, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      100
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDT_ORACLE,
      proposal.GHO_USD_FEED(),
      1333036975589, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      100
    );
  }
}
