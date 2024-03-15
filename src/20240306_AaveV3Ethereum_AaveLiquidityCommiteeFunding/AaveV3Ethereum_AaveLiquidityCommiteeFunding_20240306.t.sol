// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_AaveLiquidityCommiteeFunding_20240306} from './AaveV3Ethereum_AaveLiquidityCommiteeFunding_20240306.sol';

/**
 * @dev Test for AaveV3Ethereum_AaveLiquidityCommiteeFunding_20240306
 * command: make test-contract filter=AaveV3Ethereum_AaveLiquidityCommiteeFunding_20240306
 */
contract AaveV3Ethereum_AaveLiquidityCommiteeFunding_20240306_Test is ProtocolV3TestBase {
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

  event Transfer(address indexed from, address indexed to, uint256 value);

  AaveV3Ethereum_AaveLiquidityCommiteeFunding_20240306 internal proposal;

  address swapper;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19432086);
    proposal = new AaveV3Ethereum_AaveLiquidityCommiteeFunding_20240306();
    swapper = address(proposal.SWAPPER());
  }

  function test_execution() public {
    uint256 initialBalanceGHO = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    assertGe(initialBalanceGHO, 0, 'Collector has 0 GHO');

    uint256 initialAllowanceGHO = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.ALC_SAFE()
    );
    assertEq(initialAllowanceGHO, 0);

    uint256 initialBalanceAUSDC = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 initialBalanceAUSDT = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertGe(initialBalanceAUSDT, proposal.USDT_V2_TO_SWAP(), 'Not enough aUSDT to Withdraw');
    assertGe(initialBalanceAUSDC, proposal.USDC_V2_TO_SWAP(), 'Not enough aUSDC to Withdraw');

    _expectEmits();

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.ALC_SAFE()
      ),
      proposal.GHO_ALLOWANCE()
    );

    uint256 finalBalanceAUSDC = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 finalBalanceAUSDT = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertGe(
      finalBalanceAUSDC,
      initialBalanceAUSDC - proposal.USDC_V2_TO_SWAP(),
      'Did not transfer withdrawn balance'
    );

    assertGe(
      finalBalanceAUSDT,
      initialBalanceAUSDT - proposal.USDT_V2_TO_SWAP(),
      'Did not transfer withdrawn balance'
    );
  }

  function _expectEmits() internal {
    vm.expectEmit(true, true, true, true, AaveV3EthereumAssets.USDC_UNDERLYING);
    emit Transfer(
      address(AaveV2EthereumAssets.USDC_A_TOKEN),
      address(MiscEthereum.AAVE_SWAPPER),
      proposal.USDC_V2_TO_SWAP()
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      proposal.GHO_USD_FEED(),
      proposal.USDC_V2_TO_SWAP(),
      address(AaveV3Ethereum.COLLECTOR),
      100
    );

    vm.expectEmit(true, true, true, true, AaveV3EthereumAssets.USDT_UNDERLYING);
    emit Transfer(
      address(AaveV2EthereumAssets.USDT_A_TOKEN),
      address(MiscEthereum.AAVE_SWAPPER),
      proposal.USDC_V2_TO_SWAP()
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDT_ORACLE,
      proposal.GHO_USD_FEED(),
      proposal.USDT_V2_TO_SWAP(),
      address(AaveV3Ethereum.COLLECTOR),
      100
    );
  }
}
