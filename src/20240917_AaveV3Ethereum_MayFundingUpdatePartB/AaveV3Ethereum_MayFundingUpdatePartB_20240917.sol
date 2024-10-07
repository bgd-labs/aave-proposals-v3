// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';

/**
 * @title May Funding Update Part B
 * @author karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-may-funding-update/17768/5
 */
contract AaveV3Ethereum_MayFundingUpdatePartB_20240917 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  address public constant COLLECTOR = address(AaveV3Ethereum.COLLECTOR);
  address public constant POOL_V2 = address(AaveV2Ethereum.POOL);
  address public constant POOL_V3 = address(AaveV3Ethereum.POOL);
  address public constant RECIPIENT_500 = 0x1770776deB0A5CA58439759FAdb5cAA014501241;
  address public constant RECIPIENT_1000 = 0x7dF98A6e1895fd247aD4e75B8EDa59889fa7310b;
  address public constant IMMUNEFI = 0x7119f398b6C06095c6E8964C1f58e7C1BAa79E18;

  struct Migration {
    address underlying;
    address aToken;
    uint256 leaveBehind;
  }

  function execute() external {
    AaveV3Ethereum.COLLECTOR.transfer(AaveV3EthereumAssets.GHO_UNDERLYING, RECIPIENT_500, 500e18);

    AaveV3Ethereum.COLLECTOR.transfer(AaveV3EthereumAssets.GHO_UNDERLYING, RECIPIENT_1000, 1000e18);

    AaveV3Ethereum.COLLECTOR.transfer(AaveV3EthereumAssets.GHO_UNDERLYING, IMMUNEFI, 150e18);

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
      // withdraw underlying
      uint256 withdrawAmount = IERC20(migrations[i].aToken).balanceOf(COLLECTOR) -
        migrations[i].leaveBehind;
      CollectorUtils.IOInput memory input = CollectorUtils.IOInput(
        POOL_V2,
        migrations[i].underlying,
        withdrawAmount
      );
      CollectorUtils.withdrawFromV2(AaveV3Ethereum.COLLECTOR, input, COLLECTOR);

      /// deposit
      uint256 balance = IERC20(migrations[i].underlying).balanceOf(COLLECTOR);
      input = CollectorUtils.IOInput(POOL_V3, migrations[i].underlying, balance);
      CollectorUtils.depositToV3(AaveV3Ethereum.COLLECTOR, input);
    }
  }
}
