// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {MiscOptimism} from 'aave-address-book/MiscOptimism.sol';
import {IAaveOpEthERC20Bridge} from 'aave-helpers/src/bridges/optimism/IAaveOpEthERC20Bridge.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title November Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-november-2025-funding-update/23339
 */
contract AaveV3Optimism_NovemberFundingUpdate_20251110 is IProposalGenericExecutor {
  uint256 public constant SUSD_AMOUNT = 55_000 ether;
  uint256 public constant WETH_AMOUNT = 195 ether;

  function execute() external {
    AaveV3Optimism.COLLECTOR.approve(
      IERC20(AaveV3OptimismAssets.sUSD_UNDERLYING),
      MiscOptimism.AFC_SAFE,
      SUSD_AMOUNT
    );

    AaveV3Optimism.COLLECTOR.approve(
      IERC20(AaveV3OptimismAssets.WETH_UNDERLYING),
      MiscOptimism.AFC_SAFE,
      WETH_AMOUNT
    );
  }
}
