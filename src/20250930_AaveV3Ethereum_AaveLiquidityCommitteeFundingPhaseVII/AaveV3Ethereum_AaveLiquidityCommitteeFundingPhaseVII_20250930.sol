// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Aave Liquidity Committee Funding Phase VII
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x2d105bc85e7805faa1d43e8a069b5c1ae2ee792d6f80cb62ce0e2aeb5b75d713
 * - Discussion: https://governance.aave.com/t/arfc-aave-liquidity-committee-funding-phase-vii/23143
 */
contract AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseVII_20250930 is IProposalGenericExecutor {
  //https://etherscan.io/address/0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b
  address public constant ALC_SAFE = 0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b;

  uint256 public constant ALLOWANCE_AMOUNT = 2_500_000 ether;

  function execute() external override {
    address aEthLidoGHO = AaveV3EthereumLidoAssets.GHO_A_TOKEN;

    AaveV3Ethereum.COLLECTOR.approve(IERC20(aEthLidoGHO), ALC_SAFE, ALLOWANCE_AMOUNT);
  }
}
