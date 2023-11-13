// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
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
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18516167); // TODO: Update block number post bridge
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

    uint256 balanceAUsdcBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 balanceAUsdtBeforeV2 = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 balanceAUsdtBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 balanceADaiBefore = IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertGt(balanceUsdcBefore, proposal.USDC_TO_DEPOSIT());

    assertGt(balanceUsdtBefore, proposal.USDT_TO_DEPOSIT_V3());

    assertGt(balanceDaiBefore, proposal.DAI_TO_DEPOSIT());

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      AaveV3EthereumAssets.GHO_ORACLE,
      proposal.USDC_TO_SWAP(),
      address(AaveV3Ethereum.COLLECTOR),
      100
    );

    GovHelpers.executePayload(vm, address(proposal), GovernanceV3Ethereum.EXECUTOR_LVL_1);

    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(address(proposal.SWAPPER())),
      0
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceUsdcBefore - proposal.USDC_TO_DEPOSIT() - proposal.USDC_TO_SWAP()
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceUsdtBefore - proposal.USDT_TO_DEPOSIT_V3() - proposal.USDT_TO_DEPOSIT_V2()
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceDaiBefore - proposal.DAI_TO_DEPOSIT()
    );

    assertGt(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAUsdcBefore
    );

    assertGt(
      IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAUsdtBeforeV2
    );

    assertGt(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAUsdtBefore
    );

    assertGt(
      IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceADaiBefore
    );
  }
}
