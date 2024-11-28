// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscOptimism} from 'aave-address-book/MiscOptimism.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';

interface IAaveOpEthERC20Bridge {
  function bridge(address token, address l1Token, uint256 amount) external;
}

/**
 * @title September Funding Update - Part A
 * @author karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-september-funding-update/19162
 */
contract AaveV3Optimism_SeptemberFundingUpdatePartA_20241113 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;
  using CollectorUtils for ICollector;

  IAaveOpEthERC20Bridge public constant BRIDGE =
    IAaveOpEthERC20Bridge(MiscOptimism.AAVE_OPT_ETH_BRIDGE);

  function execute() external override {
    AaveV3Optimism.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Optimism.POOL),
        underlying: AaveV3OptimismAssets.USDC_UNDERLYING,
        amount: IERC20(AaveV3OptimismAssets.USDC_A_TOKEN).balanceOf(
          address(AaveV3Optimism.COLLECTOR)
        ) - 100e6
      }),
      address(BRIDGE)
    );

    BRIDGE.bridge(
      AaveV3OptimismAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      IERC20(AaveV3OptimismAssets.USDC_UNDERLYING).balanceOf(address(BRIDGE))
    );

    AaveV3Optimism.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Optimism.POOL),
        underlying: AaveV3OptimismAssets.LUSD_UNDERLYING,
        amount: IERC20(AaveV3OptimismAssets.LUSD_A_TOKEN).balanceOf(
          address(AaveV3Optimism.COLLECTOR)
        ) - 1e18
      }),
      address(BRIDGE)
    );

    BRIDGE.bridge(
      AaveV3OptimismAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      IERC20(AaveV3OptimismAssets.LUSD_UNDERLYING).balanceOf(address(BRIDGE))
    );
  }
}
