// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_FundingUpdatePartB_20240324} from './AaveV3Ethereum_FundingUpdatePartB_20240324.sol';

/**
 * @dev Test for AaveV3Ethereum_FundingUpdatePartB_20240324
 * command: make test-contract filter=AaveV3Ethereum_FundingUpdatePartB_20240324
 */
contract AaveV3Ethereum_FundingUpdatePartB_20240324_Test is ProtocolV3TestBase {
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

  AaveV3Ethereum_FundingUpdatePartB_20240324 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19508017);
    proposal = new AaveV3Ethereum_FundingUpdatePartB_20240324();
  }

  function test_alcTransfers() public {
    uint256 balanceCRVBeforeCollector = IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceBALBeforeCollector = IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceCRVBeforeALC = IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(
      proposal.ALC_SAFE()
    );
    uint256 balanceBALBeforeALC = IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).balanceOf(
      proposal.ALC_SAFE()
    );

    assertGt(balanceCRVBeforeCollector, 0);
    assertGt(balanceBALBeforeCollector, 0);

    executePayload(vm, address(proposal));

    uint256 balanceCRVAfterCollector = IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceBALAfterCollector = IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceCRVAfterALC = IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(
      proposal.ALC_SAFE()
    );
    uint256 balanceBALAfterALC = IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).balanceOf(
      proposal.ALC_SAFE()
    );

    assertEq(balanceCRVAfterCollector, 0, 'collector CRV balance after not 0');
    assertEq(balanceBALAfterCollector, 0, 'collector BAL balance after not 0');

    assertEq(
      balanceCRVAfterALC,
      balanceCRVBeforeALC + balanceCRVBeforeCollector,
      'collector CRV balance after not 0'
    );
    assertEq(
      balanceBALAfterALC,
      balanceBALBeforeALC + balanceBALBeforeCollector,
      'collector BAL balance after not 0'
    );
  }

  function test_swaps() public {
    uint256 dpiBalanceBefore = IERC20(AaveV2EthereumAssets.DPI_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 aUsdcBalanceBefore = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    assertGt(dpiBalanceBefore, 0);

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      proposal.GHO_USD_FEED(),
      proposal.USDC_V2_TO_SWAP() + 1, // Rounding error of 1
      address(AaveV3Ethereum.COLLECTOR),
      100
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV2EthereumAssets.DPI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      proposal.DPI_USD_FEED(),
      proposal.GHO_USD_FEED(),
      proposal.DPI_TO_SWAP(),
      address(AaveV3Ethereum.COLLECTOR),
      700
    );

    executePayload(vm, address(proposal));

    assertGt(
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      aUsdcBalanceBefore - proposal.USDC_V2_TO_SWAP(),
      'aUSDC balance after does not match'
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.DPI_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      dpiBalanceBefore - proposal.DPI_TO_SWAP()
    );
  }

  function test_deposits() public {
    uint256 balanceWETHCollectorBefore = address(AaveV3Ethereum.COLLECTOR).balance;
    uint256 balanceDaiCollectorBefore = IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 balanceEthAWETHBefore = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceEthADAIBefore = IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertGt(balanceWETHCollectorBefore, 0);
    assertGt(balanceDaiCollectorBefore, 0);

    executePayload(vm, address(proposal));

    uint256 balanceEthAWETHAfter = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceAEthDAIAfter = IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertEq(address(AaveV3Ethereum.COLLECTOR).balance, 0);
    assertEq(
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    assertEq(balanceEthAWETHAfter, balanceEthAWETHBefore + balanceWETHCollectorBefore);
    assertApproxEqAbs(balanceAEthDAIAfter, balanceEthADAIBefore + balanceDaiCollectorBefore, 1);
  }
}
