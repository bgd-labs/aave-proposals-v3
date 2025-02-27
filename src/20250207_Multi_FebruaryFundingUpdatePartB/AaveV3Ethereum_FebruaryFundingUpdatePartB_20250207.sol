// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

import {IGhoToken} from '../interfaces/IGhoToken.sol';
import {IGhoDirectMinter} from './IGhoDirectMinter.sol';

/**
 * @title February Funding Update - Part B
 * @author TokenLogic
 * - Snapshot: Direct-To-AIP
 * - Discussion: https://governance.aave.com/t/arfc-february-funding-update/20712
 */
contract AaveV3Ethereum_FebruaryFundingUpdatePartB_20250207 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  uint256 public constant GHO_DEPOSIT_AMOUNT = 3_000_000e18;

  // https://etherscan.io/address/0x2cE01c87Fec1b71A9041c52CaED46Fc5f4807285
  address public constant FACILITATOR = 0x2cE01c87Fec1b71A9041c52CaED46Fc5f4807285;

  address public constant MERIT_AHAB_SAFE = 0xdeadD8aB03075b7FBA81864202a2f59EE25B312b;
  uint256 public constant GHO_A_ALLOWANCE = 3_000_000 ether;
  uint256 public constant WETH_A_ALLOWANCE = 800 ether;

  function execute() external {
    _depositSwappedAsset();
    _allowance();
  }

  function _depositSwappedAsset() internal {
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

    IGhoDirectMinter(FACILITATOR).withdrawAndBurn(GHO_DEPOSIT_AMOUNT);
    AaveV3Ethereum.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3EthereumLido.POOL),
        underlying: AaveV3EthereumAssets.GHO_UNDERLYING,
        amount: GHO_DEPOSIT_AMOUNT
      })
    );
  }

  function _allowance() internal {
    AaveV3EthereumLido.COLLECTOR.approve(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      MERIT_AHAB_SAFE,
      GHO_A_ALLOWANCE
    );
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN),
      MERIT_AHAB_SAFE,
      WETH_A_ALLOWANCE
    );
  }
}
