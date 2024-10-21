// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
/**
 * @title September Funding Update Part A
 * @author @karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-september-funding-update/19162
 */
contract AaveV3Avalanche_SeptemberFundingUpdatePartA_20241020 is IProposalGenericExecutor {
  struct Migration {
    address underlying;
    address aToken;
    uint256 leaveBehind;
  }

  uint256 public minBalanceLeft = 1 ether;

  function execute() external {
    Migration[] memory migrations = new Migration[](4);
    migrations[0] = Migration({
      underlying: AaveV2AvalancheAssets.DAIe_UNDERLYING,
      aToken: AaveV2AvalancheAssets.DAIe_A_TOKEN,
      leaveBehind: 300_000 ether
    });
    migrations[1] = Migration({
      underlying: AaveV2AvalancheAssets.WAVAX_UNDERLYING,
      aToken: AaveV2AvalancheAssets.WAVAX_A_TOKEN,
      leaveBehind: minBalanceLeft
    });
    migrations[2] = Migration({
      underlying: AaveV2AvalancheAssets.WETHe_UNDERLYING,
      aToken: AaveV2AvalancheAssets.WETHe_A_TOKEN,
      leaveBehind: minBalanceLeft
    });
    migrations[3] = Migration({
      underlying: AaveV2AvalancheAssets.WBTCe_UNDERLYING,
      aToken: AaveV2AvalancheAssets.WBTCe_A_TOKEN,
      leaveBehind: minBalanceLeft
    });

    for (uint i = 0; i < migrations.length; i++) {
      uint256 withdrawAmount = IERC20(migrations[i].aToken).balanceOf(
        address(AaveV3Avalanche.COLLECTOR)
      ) - migrations[i].leaveBehind;
      CollectorUtils.IOInput memory input = CollectorUtils.IOInput(
        address(AaveV2Avalanche.POOL),
        migrations[i].underlying,
        withdrawAmount
      );
      CollectorUtils.withdrawFromV2(
        AaveV3Avalanche.COLLECTOR,
        input,
        address(AaveV3Avalanche.COLLECTOR)
      );

      uint256 balance = IERC20(migrations[i].underlying).balanceOf(
        address(AaveV3Avalanche.COLLECTOR)
      );
      input = CollectorUtils.IOInput(
        address(AaveV3Avalanche.POOL),
        migrations[i].underlying,
        balance
      );
      CollectorUtils.depositToV3(AaveV3Avalanche.COLLECTOR, input);
    }
  }
}
