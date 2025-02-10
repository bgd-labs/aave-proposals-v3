// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IAaveArbEthERC20Bridge} from 'aave-helpers/src/bridges/arbitrum/IAaveArbEthERC20Bridge.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title February Funding Update - Part B
 * @author TokenLogic
 * - Snapshot: Direct-To-AIP
 * - Discussion: https://governance.aave.com/t/arfc-february-funding-update/20712
 */
contract AaveV3Arbitrum_FebruaryFundingUpdatePartB_20250207 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  // https://arbiscan.io/address/0x09e9222E96E7B4AE2a407B98d48e330053351EEe
  address public constant LUSD_GATEWAY = 0x09e9222E96E7B4AE2a407B98d48e330053351EEe;
  // https://arbiscan.io/address/0x096760F208390250649E3e8763348E783AEF5562
  address public constant USDC_GATEWAY = 0x096760F208390250649E3e8763348E783AEF5562;

  function execute() external {
    AaveV3Arbitrum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Arbitrum.POOL),
        underlying: AaveV3ArbitrumAssets.LUSD_UNDERLYING,
        amount: IERC20(AaveV3ArbitrumAssets.LUSD_A_TOKEN).balanceOf(
          address(AaveV3Arbitrum.COLLECTOR)
        ) - 1 ether
      }),
      MiscArbitrum.AAVE_ARB_ETH_BRIDGE
    );
    AaveV3Arbitrum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Arbitrum.POOL),
        underlying: AaveV3ArbitrumAssets.USDC_UNDERLYING,
        amount: IERC20(AaveV3ArbitrumAssets.USDC_A_TOKEN).balanceOf(
          address(AaveV3Arbitrum.COLLECTOR)
        ) - 1e6
      }),
      MiscArbitrum.AAVE_ARB_ETH_BRIDGE
    );

    IAaveArbEthERC20Bridge(MiscArbitrum.AAVE_ARB_ETH_BRIDGE).bridge(
      AaveV3ArbitrumAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      LUSD_GATEWAY,
      IERC20(AaveV3ArbitrumAssets.LUSD_UNDERLYING).balanceOf(MiscArbitrum.AAVE_ARB_ETH_BRIDGE)
    );

    IAaveArbEthERC20Bridge(MiscArbitrum.AAVE_ARB_ETH_BRIDGE).bridge(
      AaveV3ArbitrumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      USDC_GATEWAY,
      IERC20(AaveV3ArbitrumAssets.USDC_UNDERLYING).balanceOf(MiscArbitrum.AAVE_ARB_ETH_BRIDGE)
    );
  }
}
