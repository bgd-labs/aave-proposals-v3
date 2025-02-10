// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
/**
 * @title February Funding Update - Part B
 * @author TokenLogic
 * - Snapshot: Direct-To-AIP
 * - Discussion: https://governance.aave.com/t/arfc-february-funding-update/20712
 */
contract AaveV3Ethereum_FebruaryFundingUpdatePartB_20250207 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.WETH_UNDERLYING,
        amount: type(uint256).max
      })
    );

    AaveV3Ethereum.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.USDS_UNDERLYING,
        amount: type(uint256).max
      })
    );

    AaveV3EthereumLido.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3EthereumLido.POOL),
        underlying: AaveV3EthereumLidoAssets.GHO_UNDERLYING,
        amount: type(uint256).max
      })
    );
  }
}
