// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {IERC20} from 'aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_RescueTokensFromAdapters_20240916} from './AaveV3Ethereum_RescueTokensFromAdapters_20240916.sol';

/**
 * @dev Test for AaveV3Ethereum_RescueTokensFromAdapters_20240916
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240916_Multi_RescueTokensFromAdapters/AaveV3Ethereum_RescueTokensFromAdapters_20240916.t.sol -vv
 */
contract AaveV3Ethereum_RescueTokensFromAdapters_20240916_Test is ProtocolV3TestBase {
  AaveV3Ethereum_RescueTokensFromAdapters_20240916 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20765423);
    proposal = new AaveV3Ethereum_RescueTokensFromAdapters_20240916();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_RescueTokensFromAdapters_20240916',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_isTokensRescuedV2() external {
    uint256 sUSDPoolAdminInitialBalance = IERC20(AaveV2EthereumAssets.sUSD_UNDERLYING).balanceOf(
      AaveV2Ethereum.POOL_ADMIN
    );
    uint256 USDCPoolAdminInitialBalance = IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(
      AaveV2Ethereum.POOL_ADMIN
    );

    uint256 sUSDTransferred = IERC20(AaveV2EthereumAssets.sUSD_UNDERLYING).balanceOf(
      AaveV2Ethereum.DEBT_SWAP_ADAPTER
    );
    uint256 USDCTransferred = IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(
      AaveV2Ethereum.DEBT_SWAP_ADAPTER
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    // AaveV2Ethereum current
    assertEq(
      IERC20(AaveV2EthereumAssets.sUSD_UNDERLYING).balanceOf(AaveV2Ethereum.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected sUSD_UNDERLYING remaining'
    );
    assertEq(
      sUSDPoolAdminInitialBalance + sUSDTransferred,
      IERC20(AaveV2EthereumAssets.sUSD_UNDERLYING).balanceOf(AaveV2Ethereum.POOL_ADMIN),
      'Unexpected sUSD_UNDERLYING final treasury balance'
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(AaveV2Ethereum.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected USDC_UNDERLYING remaining'
    );
    assertEq(
      USDCPoolAdminInitialBalance + USDCTransferred,
      IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(AaveV2Ethereum.POOL_ADMIN),
      'Unexpected USDC_UNDERLYING final treasury balance'
    );
  }

  function test_isTokensRescuedV3Current() external {
    uint256 USDTAdminInitialBalance = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      AaveV3Ethereum.ACL_ADMIN
    );
    uint256 crvUSDAdminInitialBalance = IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING).balanceOf(
      AaveV3Ethereum.ACL_ADMIN
    );
    uint256 GHOAdminInitialBalance = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      AaveV3Ethereum.ACL_ADMIN
    );
    uint256 rETHAdminInitialBalance = IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(
      AaveV3Ethereum.ACL_ADMIN
    );
    uint256 WBTCAdminInitialBalance = IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING).balanceOf(
      AaveV3Ethereum.ACL_ADMIN
    );

    uint256 USDTTransferred = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      AaveV3Ethereum.DEBT_SWAP_ADAPTER
    );
    uint256 crvUSDTransferred = IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING).balanceOf(
      AaveV3Ethereum.DEBT_SWAP_ADAPTER
    );
    uint256 GHOTransferred = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      AaveV3Ethereum.REPAY_WITH_COLLATERAL_ADAPTER
    );
    uint256 rETHTransferred = IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(
      AaveV3Ethereum.REPAY_WITH_COLLATERAL_ADAPTER
    );
    uint256 WBTCTransferred = IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING).balanceOf(
      AaveV3Ethereum.REPAY_WITH_COLLATERAL_ADAPTER
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    // AaveV3Ethereum current
    assertEq(
      IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(AaveV3Ethereum.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected USDT_UNDERLYING remaining'
    );
    assertEq(
      USDTAdminInitialBalance + USDTTransferred,
      IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(AaveV3Ethereum.ACL_ADMIN),
      'Unexpected USDT_UNDERLYING final treasury balance'
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING).balanceOf(AaveV3Ethereum.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected crvUSD_UNDERLYING remaining'
    );
    assertEq(
      crvUSDAdminInitialBalance + crvUSDTransferred,
      IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING).balanceOf(AaveV3Ethereum.ACL_ADMIN),
      'Unexpected crvUSD_UNDERLYING final treasury balance'
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
        AaveV3Ethereum.REPAY_WITH_COLLATERAL_ADAPTER
      ),
      0,
      'Unexpected GHO_UNDERLYING remaining'
    );
    assertEq(
      GHOAdminInitialBalance + GHOTransferred,
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(AaveV3Ethereum.ACL_ADMIN),
      'Unexpected GHO_UNDERLYING final treasury balance'
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(
        AaveV3Ethereum.REPAY_WITH_COLLATERAL_ADAPTER
      ),
      0,
      'Unexpected rETH_UNDERLYING remaining'
    );
    assertEq(
      rETHAdminInitialBalance + rETHTransferred,
      IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(AaveV3Ethereum.ACL_ADMIN),
      'Unexpected rETH_UNDERLYING final treasury balance'
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING).balanceOf(
        AaveV3Ethereum.REPAY_WITH_COLLATERAL_ADAPTER
      ),
      0,
      'Unexpected WBTC_UNDERLYING remaining'
    );
    assertEq(
      WBTCAdminInitialBalance + WBTCTransferred,
      IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING).balanceOf(AaveV3Ethereum.ACL_ADMIN),
      'Unexpected WBTC_UNDERLYING final treasury balance'
    );
  }
}
