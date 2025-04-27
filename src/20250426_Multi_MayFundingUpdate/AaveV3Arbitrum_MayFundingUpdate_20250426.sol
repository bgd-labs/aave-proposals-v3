// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IAaveArbEthERC20Bridge} from 'aave-helpers/src/bridges/arbitrum/IAaveArbEthERC20Bridge.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
/**
 * @title May Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: TODO
 */
contract AaveV3Arbitrum_MayFundingUpdate_20250426 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  address public constant DAI = AaveV3ArbitrumAssets.DAI_UNDERLYING;
  address public constant DAI_GATEWAY = 0x467194771dAe2967Aef3ECbEDD3Bf9a310C76C65;

  address public constant USDT = AaveV3ArbitrumAssets.USDT_UNDERLYING;
  address public constant USDT_GATEWAY = 0x14E4A1B13bf7F943c8ff7C51fb60FA964A298D92;

  address public constant USDC = AaveV3ArbitrumAssets.USDC_UNDERLYING;
  address public constant USDC_GATEWAY = 0x096760F208390250649E3e8763348E783AEF5562;

  address public constant BRIDGE = MiscArbitrum.AAVE_ARB_ETH_BRIDGE;
  address public constant COLLECTOR = address(AaveV3Arbitrum.COLLECTOR);

  function execute() external {
    /// DAI
    uint256 daiBalance = IERC20(DAI).balanceOf(COLLECTOR);
    AaveV3Arbitrum.COLLECTOR.transfer(IERC20(DAI), BRIDGE, daiBalance);
    IAaveArbEthERC20Bridge(BRIDGE).bridge(
      DAI,
      AaveV3EthereumAssets.DAI_UNDERLYING,
      DAI_GATEWAY,
      daiBalance
    );

    /// USDT
    uint256 usdtBalance = IERC20(USDT).balanceOf(COLLECTOR);
    AaveV3Arbitrum.COLLECTOR.transfer(IERC20(USDT), BRIDGE, usdtBalance);
    IAaveArbEthERC20Bridge(BRIDGE).bridge(
      USDT,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      USDT_GATEWAY,
      usdtBalance
    );

    /// USDC
    uint256 usdcBalance = IERC20(USDC).balanceOf(COLLECTOR);
    AaveV3Arbitrum.COLLECTOR.transfer(IERC20(USDC), BRIDGE, usdcBalance);
    IAaveArbEthERC20Bridge(BRIDGE).bridge(
      USDC,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      USDC_GATEWAY,
      usdcBalance
    );
  }
}
