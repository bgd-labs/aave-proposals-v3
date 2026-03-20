// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {UmbrellaEthereum} from 'aave-address-book/UmbrellaEthereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_UmbrellaDeficitUpdates_Part_1_20260313} from './AaveV3Ethereum_UmbrellaDeficitUpdates_Part_1_20260313.sol';

/**
 * @dev Test for AaveV3Ethereum_UmbrellaDeficitUpdates_Part_1_20260313
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260313_AaveV3Ethereum_UmbrellaDeficitUpdates/AaveV3Ethereum_UmbrellaDeficitUpdates_Part_1_20260313.t.sol -vv
 */
contract AaveV3Ethereum_UmbrellaDeficitUpdates_Part_1_20260313_Test is ProtocolV3TestBase {
  AaveV3Ethereum_UmbrellaDeficitUpdates_Part_1_20260313 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24699000);
    proposal = new AaveV3Ethereum_UmbrellaDeficitUpdates_Part_1_20260313();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_UmbrellaDeficitUpdates_Part_1_20260313',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_reserveDeficitCoverage() public {
    uint256 usdtDeficit = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.USDT_UNDERLYING
    );
    uint256 usdcDeficit = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.USDC_UNDERLYING
    );
    uint256 wethDeficit = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.WETH_UNDERLYING
    );

    // Deficit should be greater than indicated in the proposal
    assertGt(usdtDeficit, 10_134 * 1e6);
    assertGt(usdcDeficit, 51_185 * 1e6);
    assertGt(wethDeficit, 8.1 * 1e18);

    uint256 aUsdtBalance = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 aUsdcBalance = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 aWethBalance = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    assertEq(AaveV3Ethereum.POOL.getReserveDeficit(AaveV3EthereumAssets.USDT_UNDERLYING), 0);
    assertEq(AaveV3Ethereum.POOL.getReserveDeficit(AaveV3EthereumAssets.USDC_UNDERLYING), 0);
    assertEq(AaveV3Ethereum.POOL.getReserveDeficit(AaveV3EthereumAssets.WETH_UNDERLYING), 0);

    assertApproxEqAbs(
      aUsdtBalance - usdtDeficit,
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1
    );

    assertApproxEqAbs(
      aUsdcBalance - usdcDeficit,
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1
    );

    assertApproxEqAbs(
      aWethBalance - wethDeficit,
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1
    );
  }

  function test_deficitOffsets() public {
    executePayload(vm, address(proposal));

    assertEq(
      UmbrellaEthereum.UMBRELLA.getDeficitOffset(AaveV3EthereumAssets.USDT_UNDERLYING),
      proposal.USDT_DEFICIT_OFFSET()
    );
    assertEq(
      UmbrellaEthereum.UMBRELLA.getDeficitOffset(AaveV3EthereumAssets.USDC_UNDERLYING),
      proposal.USDC_DEFICIT_OFFSET()
    );
    assertEq(
      UmbrellaEthereum.UMBRELLA.getDeficitOffset(AaveV3EthereumAssets.WETH_UNDERLYING),
      proposal.WETH_DEFICIT_OFFSET()
    );
    assertEq(
      UmbrellaEthereum.UMBRELLA.getDeficitOffset(AaveV3EthereumAssets.GHO_UNDERLYING),
      proposal.GHO_DEFICIT_OFFSET()
    );
  }
}
