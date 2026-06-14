// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IWrappedTokenGatewayV3} from 'aave-v3-origin/contracts/helpers/interfaces/IWrappedTokenGatewayV3.sol';

import {IMainnetSwapSteward} from 'src/interfaces/IMainnetSwapSteward.sol';

/**
 * @title May/June 2026 Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-may-june-2026-funding-update/25000
 */
contract AaveV3Ethereum_MayJune2026FundingUpdate_20260601 is IProposalGenericExecutor {
  uint256 public constant AHAB_SAFE_A_GHO_ALLOWANCE = 5_000_000 ether; // 5M aGHO, 18 decimals

  // https://etherscan.io/address/0xAA088dfF3dcF619664094945028d44E779F19894
  address public constant TOKENLOGIC = 0xAA088dfF3dcF619664094945028d44E779F19894;
  uint256 public constant TOKENLOGIC_A_GHO_PAYMENT_AMOUNT = 11_655 ether; // 11,655 aGHO, 18 decimals

  // https://etherscan.io/address/0x1c037b3C22240048807cC9d7111be5d455F640bd
  address public constant AAVE_LABS = 0x1c037b3C22240048807cC9d7111be5d455F640bd;
  uint256 public constant AAVE_LABS_A_GHO_PAYMENT_AMOUNT = 392_746.66 ether; // 392,746.66 aGHO, 18 decimals

  // https://etherscan.io/address/0xcC7383b24631d8BfC8571dbF9c81d6D094688628
  address public constant SECURITY_RESEARCHER = 0xcC7383b24631d8BfC8571dbF9c81d6D094688628;
  uint256 public constant SECURITY_RESEARCHER_GHO_PAYMENT_AMOUNT = 7_500 ether; // 7,500 GHO, 18 decimals

  // https://etherscan.io/address/0x7119f398b6C06095c6E8964C1f58e7C1BAa79E18
  address public constant IMMUNEFI = 0x7119f398b6C06095c6E8964C1f58e7C1BAa79E18;
  uint256 public constant IMMUNEFI_GHO_PAYMENT_AMOUNT = 750 ether; // 750 GHO, 18 decimals

  // https://etherscan.io/address/0x666B8EbFbF4D5f0CE56962a25635CfF563F13161
  address public constant AAVE_V4_BOUNTY_SHERLOCK = 0x666B8EbFbF4D5f0CE56962a25635CfF563F13161;
  uint256 public constant AAVE_V4_BOUNTY_SHERLOCK_GHO_PAYMENT_AMOUNT = 1_100 ether; // 1,100 GHO, 18 decimals

  uint256 public constant SWAP_STEWARD_WETH_ALLOWANCE = 5_000 ether;

  uint256 public constant SWAP_STEWARD_USDT_ALLOWANCE = 10_000_000e6; // 10M USDT, 6 decimals
  uint256 public constant SWAP_STEWARD_USDC_ALLOWANCE = 10_000_000e6; // 10M USDC, 6 decimals
  uint256 public constant SWAP_STEWARD_USDe_ALLOWANCE = 10_000_000 ether; // 10M USDe, 18 decimals
  uint256 public constant SWAP_STEWARD_USDS_ALLOWANCE = 10_000_000 ether; // 10M USDS, 18 decimals
  uint256 public constant SWAP_STEWARD_DAI_ALLOWANCE = 5_000_000 ether; // 5M DAI, 18 decimals

  function execute() external {
    _depositETH();
    _approvals();
    _payments();
  }

  function _depositETH() internal {
    uint256 collectorEthBalance = address(AaveV3Ethereum.COLLECTOR).balance;
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3Ethereum.COLLECTOR.ETH_MOCK_ADDRESS()),
      address(this),
      collectorEthBalance
    );
    IWrappedTokenGatewayV3(AaveV3Ethereum.WETH_GATEWAY).depositETH{value: collectorEthBalance}(
      address(AaveV3Ethereum.POOL),
      address(AaveV3Ethereum.COLLECTOR),
      0
    );
  }

  function _approvals() internal {
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      MiscEthereum.AHAB_SAFE,
      AHAB_SAFE_A_GHO_ALLOWANCE
    );

    IMainnetSwapSteward swapSteward = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD);

    // Replenish Mainnet Swap Steward allowances
    swapSteward.increaseTokenBudget(
      AaveV3EthereumAssets.WETH_UNDERLYING,
      SWAP_STEWARD_WETH_ALLOWANCE
    );

    swapSteward.increaseTokenBudget(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      SWAP_STEWARD_USDT_ALLOWANCE
    );

    swapSteward.increaseTokenBudget(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      SWAP_STEWARD_USDC_ALLOWANCE
    );

    swapSteward.increaseTokenBudget(
      AaveV3EthereumAssets.USDe_UNDERLYING,
      SWAP_STEWARD_USDe_ALLOWANCE
    );

    swapSteward.increaseTokenBudget(
      AaveV3EthereumAssets.USDS_UNDERLYING,
      SWAP_STEWARD_USDS_ALLOWANCE
    );

    swapSteward.increaseTokenBudget(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      SWAP_STEWARD_DAI_ALLOWANCE
    );
  }

  function _payments() internal {
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      TOKENLOGIC,
      TOKENLOGIC_A_GHO_PAYMENT_AMOUNT
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      AAVE_LABS,
      AAVE_LABS_A_GHO_PAYMENT_AMOUNT
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING),
      SECURITY_RESEARCHER,
      SECURITY_RESEARCHER_GHO_PAYMENT_AMOUNT
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING),
      IMMUNEFI,
      IMMUNEFI_GHO_PAYMENT_AMOUNT
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING),
      AAVE_V4_BOUNTY_SHERLOCK,
      AAVE_V4_BOUNTY_SHERLOCK_GHO_PAYMENT_AMOUNT
    );
  }
}
