// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {IWrappedTokenGatewayV3} from 'aave-v3-origin/contracts/helpers/interfaces/IWrappedTokenGatewayV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title July 2026 Funding Update
 * @author TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x2f86020fc038694a5c4738e3982e4fa92eb315aaa4d3ce2fa2be2a5808a9280b
 * - Discussion: https://governance.aave.com/t/direct-to-aip-july-2026-funding-update/25277
 */
contract AaveV3Arbitrum_July2026FundingUpdate_20260715 is IProposalGenericExecutor {
  uint256 public constant WETH_ALLOWANCE = 160 ether;
  uint256 public constant USDCn_ALLOWANCE = 150_000e6;
  uint256 public constant USDT_ALLOWANCE = 50_000e6;
  uint256 public constant GHO_ALLOWANCE = 55_000 ether;

  function execute() external {
    _cancelOldAllowances();
    _depositEth();
    _allowances();
  }

  function _depositEth() internal {
    uint256 collectorEthBalance = address(AaveV3Arbitrum.COLLECTOR).balance;
    AaveV3Arbitrum.COLLECTOR.transfer(
      IERC20(AaveV3Arbitrum.COLLECTOR.ETH_MOCK_ADDRESS()),
      address(this),
      collectorEthBalance
    );
    IWrappedTokenGatewayV3(AaveV3Arbitrum.WETH_GATEWAY).depositETH{value: collectorEthBalance}(
      address(AaveV3Arbitrum.POOL),
      address(AaveV3Arbitrum.COLLECTOR),
      0
    );
  }

  function _allowances() internal {
    uint256 currentAllowanceWeth = IERC20(AaveV3ArbitrumAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Arbitrum.COLLECTOR),
      MiscArbitrum.AFC_SAFE
    );
    AaveV3Arbitrum.COLLECTOR.approve(
      IERC20(AaveV3ArbitrumAssets.WETH_A_TOKEN),
      MiscArbitrum.AFC_SAFE,
      currentAllowanceWeth + WETH_ALLOWANCE
    );

    uint256 currentAllowanceUsdc = IERC20(AaveV3ArbitrumAssets.USDCn_A_TOKEN).allowance(
      address(AaveV3Arbitrum.COLLECTOR),
      MiscArbitrum.AFC_SAFE
    );
    AaveV3Arbitrum.COLLECTOR.approve(
      IERC20(AaveV3ArbitrumAssets.USDCn_A_TOKEN),
      MiscArbitrum.AFC_SAFE,
      currentAllowanceUsdc + USDCn_ALLOWANCE
    );

    uint256 currentAllowanceUsdt = IERC20(AaveV3ArbitrumAssets.USDT_A_TOKEN).allowance(
      address(AaveV3Arbitrum.COLLECTOR),
      MiscArbitrum.AFC_SAFE
    );
    AaveV3Arbitrum.COLLECTOR.approve(
      IERC20(AaveV3ArbitrumAssets.USDT_A_TOKEN),
      MiscArbitrum.AFC_SAFE,
      currentAllowanceUsdt + USDT_ALLOWANCE
    );

    uint256 currentAllowanceGho = IERC20(AaveV3ArbitrumAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Arbitrum.COLLECTOR),
      MiscArbitrum.AFC_SAFE
    );
    AaveV3Arbitrum.COLLECTOR.approve(
      IERC20(AaveV3ArbitrumAssets.GHO_A_TOKEN),
      MiscArbitrum.AFC_SAFE,
      currentAllowanceGho + GHO_ALLOWANCE
    );
  }

  function _cancelOldAllowances() internal {
    AaveV3Arbitrum.COLLECTOR.approve(
      IERC20(AaveV3ArbitrumAssets.weETH_A_TOKEN),
      MiscArbitrum.AFC_SAFE,
      0
    );
  }
}
