// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';

interface IAaveArbEthERC20Bridge {
  function bridge(address token, address l1token, address gateway, uint256 amount) external;
}

/**
 * @title September Funding Update - Part A
 * @author karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-september-funding-update/19162
 */
contract AaveV3Arbitrum_SeptemberFundingUpdatePartA_20241113 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;
  using CollectorUtils for ICollector;

  IAaveArbEthERC20Bridge public constant BRIDGE =
    IAaveArbEthERC20Bridge(MiscArbitrum.AAVE_ARB_ETH_BRIDGE);
  // https://arbiscan.io/address/0x096760F208390250649E3e8763348E783AEF5562
  address public constant USDC_GATEWAY = 0x096760F208390250649E3e8763348E783AEF5562;
  // https://arbiscan.io/address/0x09e9222E96E7B4AE2a407B98d48e330053351EEe
  address public constant LUSD_GATEWAY = 0x09e9222E96E7B4AE2a407B98d48e330053351EEe;

  function execute() external {
    AaveV3Arbitrum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Arbitrum.POOL),
        underlying: AaveV3ArbitrumAssets.USDC_UNDERLYING,
        amount: IERC20(AaveV3ArbitrumAssets.USDC_A_TOKEN).balanceOf(
          address(AaveV3Arbitrum.COLLECTOR)
        ) - 100e6
      }),
      address(BRIDGE)
    );

    BRIDGE.bridge(
      AaveV3ArbitrumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      USDC_GATEWAY,
      IERC20(AaveV3ArbitrumAssets.USDC_UNDERLYING).balanceOf(address(BRIDGE))
    );

    AaveV3Arbitrum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Arbitrum.POOL),
        underlying: AaveV3ArbitrumAssets.LUSD_UNDERLYING,
        amount: IERC20(AaveV3ArbitrumAssets.LUSD_A_TOKEN).balanceOf(
          address(AaveV3Arbitrum.COLLECTOR)
        ) - 1e18
      }),
      address(BRIDGE)
    );

    BRIDGE.bridge(
      AaveV3ArbitrumAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      LUSD_GATEWAY,
      IERC20(AaveV3ArbitrumAssets.LUSD_UNDERLYING).balanceOf(address(BRIDGE))
    );
  }
}
