// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {IAaveArbEthERC20Bridge} from 'aave-helpers/src/bridges/arbitrum/IAaveArbEthERC20Bridge.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title July 2025 - Funding Update
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-july-2025-funding-update/22555
 */
contract AaveV3Arbitrum_July2025FundingUpdate_20250721 is IProposalGenericExecutor {
  /// https://arbiscan.io/address/0x467194771dAe2967Aef3ECbEDD3Bf9a310C76C65
  address public constant DAI_GATEWAY = 0x467194771dAe2967Aef3ECbEDD3Bf9a310C76C65;

  /// https://arbiscan.io/address/0x096760F208390250649E3e8763348E783AEF5562
  address public constant USDC_GATEWAY = 0x096760F208390250649E3e8763348E783AEF5562;

  function execute() external {
    uint256 daiBalance = IERC20(AaveV3ArbitrumAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );
    AaveV3Arbitrum.COLLECTOR.transfer(
      IERC20(AaveV3ArbitrumAssets.DAI_UNDERLYING),
      MiscArbitrum.AAVE_ARB_ETH_BRIDGE,
      daiBalance
    );

    IAaveArbEthERC20Bridge(MiscArbitrum.AAVE_ARB_ETH_BRIDGE).bridge(
      AaveV3ArbitrumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.DAI_UNDERLYING,
      DAI_GATEWAY,
      daiBalance
    );

    uint256 usdcBalance = IERC20(AaveV3ArbitrumAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );
    AaveV3Arbitrum.COLLECTOR.transfer(
      IERC20(AaveV3ArbitrumAssets.USDC_UNDERLYING),
      MiscArbitrum.AAVE_ARB_ETH_BRIDGE,
      usdcBalance
    );

    IAaveArbEthERC20Bridge(MiscArbitrum.AAVE_ARB_ETH_BRIDGE).bridge(
      AaveV3ArbitrumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      USDC_GATEWAY,
      usdcBalance
    );
  }
}
