// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @title Treasury Management - Add to rETH Holding (resubmission)
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x80493cdca3b1893e198802cd245e6e3c00f5fcd0b37c09aa41765b17419a71fe
 * - Discussion: https://governance.aave.com/t/arfc-treasury-management-add-to-reth-holding/15123
 */
contract AaveV3Ethereum_TreasuryManagementAddToRETHHoldingResubmission_20231123 is
  IProposalGenericExecutor
{
  AaveSwapper public constant SWAPPER = AaveSwapper(MiscEthereum.AAVE_SWAPPER);
  address public constant COLLECTOR = address(AaveV3Ethereum.COLLECTOR);
  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;
  address public constant RETH_ORACLE = 0xb031a238940e8051852b156f3efDc462fc34f37B;

  function execute() external {
    uint256 wEthBalance = IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(COLLECTOR);

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.WETH_UNDERLYING,
      address(SWAPPER),
      wEthBalance
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      AaveV3EthereumAssets.rETH_UNDERLYING,
      AaveV3EthereumAssets.WETH_ORACLE,
      RETH_ORACLE,
      COLLECTOR,
      wEthBalance,
      100
    );
  }
}
