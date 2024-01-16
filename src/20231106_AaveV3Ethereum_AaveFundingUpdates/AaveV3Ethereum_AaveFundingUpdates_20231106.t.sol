// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_AaveFundingUpdates_20231106} from './AaveV3Ethereum_AaveFundingUpdates_20231106.sol';

/**
 * @dev Test for AaveV3Ethereum_AaveFundingUpdates_20231106
 * command: make test-contract filter=AaveV3Ethereum_AaveFundingUpdates_20231106
 */
contract AaveV3Ethereum_AaveFundingUpdates_20231106_Test is ProtocolV3TestBase {
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

  AaveV3Ethereum_AaveFundingUpdates_20231106 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18969749);
    proposal = new AaveV3Ethereum_AaveFundingUpdates_20231106();
  }

  function test_execute() public {
    uint256 balanceUsdcBefore = IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 balanceUsdtBefore = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 balanceDaiBefore = IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 balanceAUsdcV2Before = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 balanceAUsdcV3Before = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 balanceAUsdtBefore = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertGt(balanceUsdcBefore, proposal.USDC_TO_DEPOSIT());

    assertEq(balanceUsdtBefore, proposal.USDT_TO_DEPOSIT());

    assertGt(balanceAUsdcV2Before, 0);

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      proposal.GHO_ORACLE(),
      proposal.USDC_TO_SWAP(),
      address(AaveV3Ethereum.COLLECTOR),
      100
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      proposal.GHO_ORACLE(),
      proposal.DAI_TO_SWAP(),
      address(AaveV3Ethereum.COLLECTOR),
      100
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(address(proposal.SWAPPER())),
      0
    );
    assertEq(IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(proposal.SWAPPER())), 0);

    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceUsdcBefore - proposal.USDC_TO_DEPOSIT()
    );

    assertApproxEqAbs(
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0,
      25e6
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceUsdtBefore - proposal.USDT_TO_DEPOSIT()
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceDaiBefore - proposal.DAI_TO_SWAP()
    );

    assertGt(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAUsdcV3Before
    );

    assertGt(
      IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAUsdtBefore
    );
  }
}
