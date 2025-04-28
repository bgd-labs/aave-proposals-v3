// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {IAaveArbEthERC20Bridge} from 'aave-helpers/src/bridges/arbitrum/IAaveArbEthERC20Bridge.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
/**
 * @title May Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-may-2025-funding-update/21906
 */
contract AaveV3Arbitrum_MayFundingUpdate_20250426 is IProposalGenericExecutor {
  /// https://arbiscan.io/address/0x467194771dAe2967Aef3ECbEDD3Bf9a310C76C65
  address public constant DAI_GATEWAY = 0x467194771dAe2967Aef3ECbEDD3Bf9a310C76C65;

  /// https://arbiscan.io/address/0x096760F208390250649E3e8763348E783AEF5562
  address public constant USDC_GATEWAY = 0x096760F208390250649E3e8763348E783AEF5562;

  address public constant BRIDGE = MiscArbitrum.AAVE_ARB_ETH_BRIDGE;
  address public constant COLLECTOR = address(AaveV3Arbitrum.COLLECTOR);

  function execute() external {
    /// DAI
    uint256 daiBalance = IERC20(AaveV3ArbitrumAssets.DAI_UNDERLYING).balanceOf(COLLECTOR);
    AaveV3Arbitrum.COLLECTOR.transfer(
      IERC20(AaveV3ArbitrumAssets.DAI_UNDERLYING),
      BRIDGE,
      daiBalance
    );
    IAaveArbEthERC20Bridge(BRIDGE).bridge(
      AaveV3ArbitrumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.DAI_UNDERLYING,
      DAI_GATEWAY,
      daiBalance
    );

    /// USDC
    uint256 usdcBalance = IERC20(AaveV3ArbitrumAssets.USDC_UNDERLYING).balanceOf(COLLECTOR);
    AaveV3Arbitrum.COLLECTOR.transfer(
      IERC20(AaveV3ArbitrumAssets.USDC_UNDERLYING),
      BRIDGE,
      usdcBalance
    );
    IAaveArbEthERC20Bridge(BRIDGE).bridge(
      AaveV3ArbitrumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      USDC_GATEWAY,
      usdcBalance
    );
  }
}
