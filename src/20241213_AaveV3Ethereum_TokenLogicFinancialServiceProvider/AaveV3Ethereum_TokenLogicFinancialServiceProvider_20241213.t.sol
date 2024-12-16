// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_TokenLogicFinancialServiceProvider_20241213} from './AaveV3Ethereum_TokenLogicFinancialServiceProvider_20241213.sol';

/**
 * @dev Test for AaveV3Ethereum_TokenLogicFinancialServiceProvider_20241213
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241213_AaveV3Ethereum_TokenLogicFinancialServiceProvider/AaveV3Ethereum_TokenLogicFinancialServiceProvider_20241213.t.sol -vv
 */
contract AaveV3Ethereum_TokenLogicFinancialServiceProvider_20241213_Test is ProtocolV3TestBase {
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

  AaveV3Ethereum_TokenLogicFinancialServiceProvider_20241213 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21414994);
    proposal = new AaveV3Ethereum_TokenLogicFinancialServiceProvider_20241213();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_TokenLogicFinancialServiceProvider_20241213',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_deposit() public {
    (address aTokenAddress, , ) = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(AaveV3EthereumAssets.GHO_UNDERLYING);

    uint256 collectorGhoBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3EthereumLido.COLLECTOR)
    );
    uint256 collectorAGhoBalanceBefore = IERC20(aTokenAddress).balanceOf(
      address(AaveV3EthereumLido.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    uint256 collectorGhoBalanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3EthereumLido.COLLECTOR)
    );
    uint256 collectorAGhoBalanceAfter = IERC20(aTokenAddress).balanceOf(
      address(AaveV3EthereumLido.COLLECTOR)
    );

    assertEq(collectorGhoBalanceBefore - collectorGhoBalanceAfter, proposal.GHO_DEPOSIT_AMOUNT());
    assertEq(collectorAGhoBalanceAfter - collectorAGhoBalanceBefore, proposal.GHO_DEPOSIT_AMOUNT());
  }

  function test_swap() public {
    uint256 collectorAEthUsdcBalanceBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      proposal.GHO_USD_FEED(),
      proposal.A_ETH_USDC_WITHDRAW_AMOUNT(),
      address(AaveV3EthereumLido.COLLECTOR),
      200
    );

    executePayload(vm, address(proposal));

    uint256 collectorAEthUsdcBalanceAfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertApproxEqAbs(
      collectorAEthUsdcBalanceBefore,
      collectorAEthUsdcBalanceAfter + proposal.A_ETH_USDC_WITHDRAW_AMOUNT(),
      1e6
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
        0x1D18380041Ba52ef4011e8264E2F9605D7a023Fe // milkmanInstance contract
      ),
      proposal.A_ETH_USDC_WITHDRAW_AMOUNT()
    );
  }

  function test_stream() public {
    uint256 nextCollectorStreamID = AaveV3Ethereum.COLLECTOR.getNextStreamId();

    executePayload(vm, address(proposal));

    (
      address sender,
      address recipient,
      uint256 deposit,
      address tokenAddress,
      uint256 startTime,
      uint256 stopTime,
      uint256 remainingBalance,

    ) = AaveV3Ethereum.COLLECTOR.getStream(nextCollectorStreamID);

    assertEq(sender, address(AaveV3Ethereum.COLLECTOR));
    assertEq(recipient, proposal.TOKENLOGIC_SAFE());
    assertEq(deposit, proposal.ACTUAL_STREAM_AMOUNT());
    assertEq(tokenAddress, AaveV3EthereumAssets.GHO_UNDERLYING);
    assertEq(startTime, proposal.STREAM_START_TIME());
    assertEq(stopTime - startTime, proposal.STREAM_DURATION());
    assertEq(remainingBalance, proposal.ACTUAL_STREAM_AMOUNT());

    // Can withdraw during stream
    vm.warp(block.timestamp + 35 days);

    uint256 collectorGhoBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 receiverGhoBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.TOKENLOGIC_SAFE()
    );

    vm.startPrank(proposal.TOKENLOGIC_SAFE());
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(
      nextCollectorStreamID,
      proposal.ACTUAL_STREAM_AMOUNT() / 12
    );
    vm.stopPrank();

    assertGt(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(proposal.TOKENLOGIC_SAFE()),
      receiverGhoBalanceBefore
    );

    assertLt(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      collectorGhoBalanceBefore
    );

    // Can withdraw post stream all remaining funds
    vm.warp(block.timestamp + proposal.STREAM_DURATION());

    (, , , , , , uint256 remaining, ) = AaveV3Ethereum.COLLECTOR.getStream(nextCollectorStreamID);

    vm.startPrank(proposal.TOKENLOGIC_SAFE());
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextCollectorStreamID, remaining);
    vm.stopPrank();

    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(proposal.TOKENLOGIC_SAFE()),
      receiverGhoBalanceBefore + proposal.ACTUAL_STREAM_AMOUNT()
    );
  }
}
