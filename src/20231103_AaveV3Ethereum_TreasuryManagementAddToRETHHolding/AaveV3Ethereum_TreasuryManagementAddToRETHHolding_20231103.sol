// SPDX-License-Identifier: MIT
/*
   _      ΞΞΞΞ      _
  /_;-.__ / _\  _.-;_\
     `-._`'`_/'`.-'
         `\   /`
          |  /
         /-.(
         \_._\
          \ \`;
           > |/
          / //
          |//
          \(\
           ``
     defijesus.eth
*/
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

/**
 * @title Treasury Management - Add to rETH Holding
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x80493cdca3b1893e198802cd245e6e3c00f5fcd0b37c09aa41765b17419a71fe
 * - Discussion: https://governance.aave.com/t/arfc-treasury-management-add-to-reth-holding/15123
 */
contract AaveV3Ethereum_TreasuryManagementAddToRETHHolding_20231103 is IProposalGenericExecutor {
  AaveSwapper public constant SWAPPER = AaveSwapper(MiscEthereum.AAVE_SWAPPER);
  address public constant COLLECTOR = address(AaveV3Ethereum.COLLECTOR);
  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;

  function execute() external {
    uint256 wethV2Balance = IERC20(AaveV2EthereumAssets.WETH_A_TOKEN).balanceOf(COLLECTOR);
    uint256 wethV3Balance = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(COLLECTOR);
    uint256 wEthBalance = IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(COLLECTOR);

    // Transfer all wETH to swapper
    AaveV3Ethereum.COLLECTOR.transfer(AaveV3EthereumAssets.WETH_UNDERLYING, address(SWAPPER), wEthBalance);
    
    // Withdraw all awETH to wETH
    AaveV2Ethereum.COLLECTOR.transfer(AaveV2EthereumAssets.WETH_A_TOKEN, address(this), wethV2Balance);
    wEthBalance += 
      AaveV2Ethereum.POOL.withdraw(AaveV2EthereumAssets.WETH_UNDERLYING, type(uint256).max, address(SWAPPER));

    // Withdraw all but 100 aEthWETH to wETH
    AaveV3Ethereum.COLLECTOR.transfer(AaveV3EthereumAssets.WETH_A_TOKEN, address(this), wethV3Balance - 100 ether);
    wEthBalance +=
      AaveV3Ethereum.POOL.withdraw(AaveV3EthereumAssets.WETH_UNDERLYING, type(uint256).max, address(SWAPPER));

    // Swap all ETH into RocketPool’s rETH
    // we use aave swap and not a deposit due to new deposits being restricted
    // rocketpool have a router to help with this but this is preferable for reviewing
    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      AaveV3EthereumAssets.rETH_UNDERLYING,
      AaveV3EthereumAssets.WETH_ORACLE,
      AaveV3EthereumAssets.rETH_ORACLE,
      COLLECTOR,
      wEthBalance,
      100
    );
  }
}
