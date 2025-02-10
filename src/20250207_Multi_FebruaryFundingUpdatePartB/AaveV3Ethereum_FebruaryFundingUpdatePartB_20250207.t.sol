// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_FebruaryFundingUpdatePartB_20250207} from './AaveV3Ethereum_FebruaryFundingUpdatePartB_20250207.sol';

/**
 * @dev Test for AaveV3Ethereum_FebruaryFundingUpdatePartB_20250207
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250207_Multi_FebruaryFundingUpdatePartB/AaveV3Ethereum_FebruaryFundingUpdatePartB_20250207.t.sol -vv
 */
contract AaveV3Ethereum_FebruaryFundingUpdatePartB_20250207_Test is ProtocolV3TestBase {
  AaveV3Ethereum_FebruaryFundingUpdatePartB_20250207 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21794826);
    proposal = new AaveV3Ethereum_FebruaryFundingUpdatePartB_20250207();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_FebruaryFundingUpdatePartB_20250207',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
    defaultTest(
      'AaveV3Ethereum_FebruaryFundingUpdatePartB_20250207',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_balance() public {
    uint256 wethCollectorBalanceBefore = IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 usdsCollectorBalanceBefore = IERC20(AaveV3EthereumAssets.USDS_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 ghoCollectorBalanceBefore = IERC20(AaveV3EthereumLidoAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3EthereumLido.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    uint256 wethCollectorBalanceAfter = IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 usdsCollectorBalanceAfter = IERC20(AaveV3EthereumAssets.USDS_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 ghoCollectorBalanceAfter = IERC20(AaveV3EthereumLidoAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3EthereumLido.COLLECTOR)
    );

    assertGt(wethCollectorBalanceBefore, 0);
    assertEq(wethCollectorBalanceAfter, 0);
    assertGt(usdsCollectorBalanceBefore, 0);
    assertEq(usdsCollectorBalanceAfter, 0);
    assertGt(ghoCollectorBalanceBefore, 0);
    assertEq(ghoCollectorBalanceAfter, 0);
  }
}
