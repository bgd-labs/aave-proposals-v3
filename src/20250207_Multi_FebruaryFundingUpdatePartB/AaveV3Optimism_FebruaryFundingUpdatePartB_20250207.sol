// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {MiscOptimism} from 'aave-address-book/MiscOptimism.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IAaveOpEthERC20Bridge} from 'aave-helpers/src/bridges/optimism/IAaveOpEthERC20Bridge.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title February Funding Update - Part B
 * @author TokenLogic
 * - Snapshot: Direct-To-AIP
 * - Discussion: https://governance.aave.com/t/arfc-february-funding-update/20712
 */
contract AaveV3Optimism_FebruaryFundingUpdatePartB_20250207 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  function execute() external {
    AaveV3Optimism.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Optimism.POOL),
        underlying: AaveV3OptimismAssets.LUSD_UNDERLYING,
        amount: _getWithdrawableBalance(
          address(AaveV3Optimism.COLLECTOR),
          AaveV3OptimismAssets.LUSD_UNDERLYING,
          AaveV3OptimismAssets.LUSD_A_TOKEN
        ) - 1 ether
      }),
      MiscOptimism.AAVE_OPT_ETH_BRIDGE
    );
    AaveV3Optimism.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Optimism.POOL),
        underlying: AaveV3OptimismAssets.USDC_UNDERLYING,
        amount: _getWithdrawableBalance(
          address(AaveV3Optimism.COLLECTOR),
          AaveV3OptimismAssets.USDC_UNDERLYING,
          AaveV3OptimismAssets.USDC_A_TOKEN
        ) - 100e6
      }),
      MiscOptimism.AAVE_OPT_ETH_BRIDGE
    );

    IAaveOpEthERC20Bridge(MiscOptimism.AAVE_OPT_ETH_BRIDGE).bridge(
      AaveV3OptimismAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      IERC20(AaveV3OptimismAssets.LUSD_UNDERLYING).balanceOf(MiscOptimism.AAVE_OPT_ETH_BRIDGE)
    );

    IAaveOpEthERC20Bridge(MiscOptimism.AAVE_OPT_ETH_BRIDGE).bridge(
      AaveV3OptimismAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      IERC20(AaveV3OptimismAssets.USDC_UNDERLYING).balanceOf(MiscOptimism.AAVE_OPT_ETH_BRIDGE)
    );
  }

  function _getWithdrawableBalance(
    address collector,
    address underlying,
    address aToken
  ) internal view returns (uint256) {
    uint256 collectorBalance = IERC20(aToken).balanceOf(collector);
    uint256 liquidity = IERC20(underlying).balanceOf(aToken);

    return collectorBalance > liquidity ? liquidity : collectorBalance;
  }
}
