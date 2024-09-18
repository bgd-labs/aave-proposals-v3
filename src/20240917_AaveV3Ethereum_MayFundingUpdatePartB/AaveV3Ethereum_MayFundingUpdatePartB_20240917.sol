// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IScaledBalanceToken} from 'aave-v3-origin/core/contracts/interfaces/IScaledBalanceToken.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title May Funding Update Part B
 * @author karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-may-funding-update/17768/5
 */
contract AaveV3Ethereum_MayFundingUpdatePartB_20240917 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  address public constant COLLECTOR = address(AaveV3Ethereum.COLLECTOR);

  struct Migration {
    address underlying;
    address aToken;
    uint256 leaveBehind;
  }

  function execute() external {
    Migration[] memory migrations = new Migration[](4);
    migrations[0] = Migration({
      underlying: AaveV2EthereumAssets.USDT_UNDERLYING,
      aToken: AaveV2EthereumAssets.USDT_A_TOKEN,
      leaveBehind: 200_000e6
    });
    migrations[1] = Migration({
      underlying: AaveV2EthereumAssets.DAI_UNDERLYING,
      aToken: AaveV2EthereumAssets.DAI_A_TOKEN,
      leaveBehind: 1e18
    });
    migrations[2] = Migration({
      underlying: AaveV2EthereumAssets.USDC_UNDERLYING,
      aToken: AaveV2EthereumAssets.USDC_A_TOKEN,
      leaveBehind: 1e6
    });
    migrations[3] = Migration({
      underlying: AaveV2EthereumAssets.WETH_UNDERLYING,
      aToken: AaveV2EthereumAssets.WETH_A_TOKEN,
      leaveBehind: 1e18
    });

    for (uint i = 0; i < migrations.length; i++) {
      /// transfer aToken
      AaveV3Ethereum.COLLECTOR.transfer(
        migrations[i].aToken,
        address(this),
        IScaledBalanceToken(migrations[i].aToken).scaledBalanceOf(COLLECTOR) -
          migrations[i].leaveBehind
      );

      /// transfer underlying
      AaveV3Ethereum.COLLECTOR.transfer(
        migrations[i].underlying,
        address(this),
        IERC20(migrations[i].underlying).balanceOf(COLLECTOR)
      );

      /// withdraw underlying
      AaveV2Ethereum.POOL.withdraw(migrations[i].underlying, type(uint256).max, address(this));

      uint256 balance = IERC20(migrations[i].underlying).balanceOf(address(this));

      IERC20(migrations[i].underlying).forceApprove(address(AaveV3Ethereum.POOL), balance);

      /// deposit
      AaveV3Ethereum.POOL.deposit(migrations[i].underlying, balance, COLLECTOR, 0);
    }
  }
}
