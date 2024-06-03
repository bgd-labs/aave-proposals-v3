// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_AprilFinanceUpdatePartB_20240515} from './AaveV3Ethereum_AprilFinanceUpdatePartB_20240515.sol';

/**
 * @dev Test for AaveV3Ethereum_AprilFinanceUpdatePartB_20240515
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240515_AaveV3Ethereum_AprilFinanceUpdatePartB/AaveV3Ethereum_AprilFinanceUpdatePartB_20240515.t.sol -vv
 */
contract AaveV3Ethereum_AprilFinanceUpdatePartB_20240515_Test is ProtocolV3TestBase {
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

  AaveV3Ethereum_AprilFinanceUpdatePartB_20240515 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19879169);
    proposal = new AaveV3Ethereum_AprilFinanceUpdatePartB_20240515();
  }

  function test_swap() public {
    assertGt(
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      proposal.GHO_USD_FEED(),
      499803957060009088221525, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      150
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );
  }

  function test_allowances() public {
    assertEq(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.ALC_SAFE()
      ),
      0
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.ALC_SAFE()
      ),
      0
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.ALC_SAFE()
      ),
      proposal.ALC_ALLOWANCES()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.ALC_SAFE()
      ),
      proposal.ALC_ALLOWANCES()
    );
  }

  function test_depositIntoV3() public {
    assertGt(
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    uint256 balanceAEthUSDCBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceAEthWETHBefore = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceAEthWBTCBefore = IERC20(AaveV3EthereumAssets.WBTC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      proposal.ALC_ALLOWANCES()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    assertGt(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAEthUSDCBefore
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAEthWETHBefore
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.WBTC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAEthWBTCBefore
    );
  }
}
