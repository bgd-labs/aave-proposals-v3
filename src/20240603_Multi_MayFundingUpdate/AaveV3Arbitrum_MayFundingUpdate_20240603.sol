// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

interface IAaveArbEthERC20Bridge {
  function bridge(address token, address l1token, address gateway, uint256 amount) external;
}

/**
 * @title May Funding Update
 * @author karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-may-funding-update/17768
 */
contract AaveV3Arbitrum_MayFundingUpdate_20240603 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  IAaveArbEthERC20Bridge public constant BRIDGE =
    IAaveArbEthERC20Bridge(0x0335ffa9af5CE05590d6C9A75B645470e07744a9);
  address public constant USDC_GATEWAY = 0x096760F208390250649E3e8763348E783AEF5562;

  function execute() external {
    AaveV3Arbitrum.COLLECTOR.transfer(
      AaveV3ArbitrumAssets.USDC_UNDERLYING,
      address(BRIDGE),
      IERC20(AaveV3ArbitrumAssets.USDC_UNDERLYING).balanceOf(address(AaveV3Arbitrum.COLLECTOR))
    );

    AaveV3Arbitrum.COLLECTOR.transfer(
      AaveV3ArbitrumAssets.USDC_A_TOKEN,
      address(this),
      IERC20(AaveV3ArbitrumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Arbitrum.COLLECTOR)) - 1e6
    );

    AaveV3Arbitrum.POOL.withdraw(
      AaveV3ArbitrumAssets.USDC_UNDERLYING,
      type(uint256).max,
      address(BRIDGE)
    );

    uint256 usdcBalance = IERC20(AaveV3ArbitrumAssets.USDC_UNDERLYING).balanceOf(address(BRIDGE));

    BRIDGE.bridge(
      AaveV3ArbitrumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      USDC_GATEWAY,
      usdcBalance
    );
  }
}
