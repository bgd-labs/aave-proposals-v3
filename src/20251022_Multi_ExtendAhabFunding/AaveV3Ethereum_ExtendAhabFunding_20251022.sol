// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
interface IMainnetSwapSteward {
  function setSwappablePair(address fromToken, address toToken, bool allowed) external;
}
/**
 * @title Extend Ahab Funding
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xa1cb3c88f8c30a05dca3c767a60abc31b4f48fe36a4175f421ac0f2e8ab7dbac
 * - Discussion: https://governance.aave.com/t/arfc-extend-ahab-funding/23213/2
 */
contract AaveV3Ethereum_ExtendAhabFunding_20251022 is IProposalGenericExecutor {
  function execute() external override {
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN),
      MiscEthereum.AHAB_SAFE,
      6_000 ether
    );

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.GHO_A_TOKEN),
      MiscEthereum.AHAB_SAFE,
      10_000_000 ether
    );

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDS_A_TOKEN),
      MiscEthereum.AFC_SAFE,
      5_000_000 ether
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      true
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      true
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDS_UNDERLYING,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      true
    );
  }
}
