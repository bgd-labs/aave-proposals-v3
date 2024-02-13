// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';
import {DepositV3SwapPayload} from 'aave-helpers/swaps/DepositV3SwapPayload.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

import {OrbitProgramData} from './OrbitProgramData.sol';

/// Helper interface to withdraw ETH
interface IWETH {
  function withdraw(uint256) external;
}

/**
 * @title Treasury Management - GSM Funding & RWA Strategy Preparations (Part 2)
 * @author karpatkey_TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb39537e468eef8c212c67a539cdc6d802cd857f186a4f66aefd44faaadd6ba19
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x412b38c7a0cf1840b102e28ea7ef0373e3ab4b9544873e8cc1544972b777d9a1
 * - Discussion: https://governance.aave.com/t/arfc-treasury-management-gsm-funding-rwa-strategy-preparations/16128
 * - Discussion: https://governance.aave.com/t/arfc-orbit-program-renewal/16550
 */
contract AaveV3Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart2_20240209 is
  DepositV3SwapPayload
{
  using SafeERC20 for IERC20;

  uint256 public constant USDC_TO_SWAP = 700_000e6;
  AaveSwapper public constant SWAPPER = AaveSwapper(MiscEthereum.AAVE_SWAPPER);
  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;

  function execute() external {
    _swap();
    _orbit();
  }

  function deposit(address token, uint256 amount) external {
    _deposit(token, amount);
  }

  function _swap() internal {
    uint256 usdcBalance = IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 daiBalance = IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      address(this),
      usdcBalance - USDC_TO_SWAP
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      address(SWAPPER),
      USDC_TO_SWAP
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      address(SWAPPER),
      daiBalance
    );

    IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).forceApprove(
      address(AaveV3Ethereum.POOL),
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(address(this))
    );

    AaveV3Ethereum.POOL.deposit(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(address(this)),
      address(AaveV3Ethereum.COLLECTOR),
      0
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      AaveV3EthereumAssets.USDT_ORACLE,
      SELF,
      daiBalance,
      50
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      AaveV3EthereumAssets.USDT_ORACLE,
      SELF,
      USDC_TO_SWAP,
      50
    );
  }

  function _orbit() internal {
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.WETH_UNDERLYING,
      address(this),
      OrbitProgramData.TOTAL_WETH_REBATE
    );

    IWETH(AaveV3EthereumAssets.WETH_UNDERLYING).withdraw(OrbitProgramData.TOTAL_WETH_REBATE);

    OrbitProgramData.GasUsage[] memory usage = OrbitProgramData.getGasUsageData();
    uint256 usageLength = usage.length;
    for (uint256 i = 0; i < usageLength; i++) {
      (bool ok, ) = usage[i].account.call{value: usage[i].usage}('');
    }

    uint256 actualStreamAmount = (OrbitProgramData.STREAM_AMOUNT /
      OrbitProgramData.STREAM_DURATION) * OrbitProgramData.STREAM_DURATION;

    address[] memory orbitAddresses = OrbitProgramData.getOrbitAddresses();
    uint256 orbitAddressesLength = orbitAddresses.length;
    for (uint256 i = 0; i < orbitAddressesLength; i++) {
      AaveV3Ethereum.COLLECTOR.transfer(
        AaveV3EthereumAssets.GHO_UNDERLYING,
        orbitAddresses[i],
        OrbitProgramData.RETRO_PAYMENT
      );

      AaveV3Ethereum.COLLECTOR.createStream(
        orbitAddresses[i],
        actualStreamAmount,
        AaveV3EthereumAssets.GHO_UNDERLYING,
        block.timestamp,
        block.timestamp + OrbitProgramData.STREAM_DURATION
      );
    }
  }

  receive() external payable {}
}
