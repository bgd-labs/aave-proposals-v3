// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IWETH} from 'aave-v3-origin/contracts/helpers/interfaces/IWETH.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

interface IMainnetSwapSteward {
  function increaseTokenBudget(address token, uint256 budget) external;
}

/**
 * @title December Funding Update
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-december-2025-funding-update/23619
 */
contract AaveV3Ethereum_DecemberFundingUpdate_20251214 is IProposalGenericExecutor {
  // Approvals
  uint256 public constant MERIT_GHO_AMOUNT = 3_000_000 ether;
  uint256 public constant AHAB_WETH_AMOUNT = 2_300 ether;
  uint256 public constant AFC_AAVE_AMOUNT = 20_000 ether;
  uint256 public constant PT_eUSDE_14AUG2025_AMOUNT = 175190155978359917557;
  uint256 public constant PT_sUSDE_25SEP2025_AMOUNT = 304354299785406069585;
  uint256 public constant PT_USDe_31JUL2025_AMOUNT = 1583144136895510331668;

  // Increase Swap Steward Budget
  uint256 public constant USDC_SWAP_BUDGET_AMOUNT = 2_000_000e6;
  uint256 public constant USDT_SWAP_BUDGET_AMOUNT = 4_000_000e6;
  uint256 public constant USDS_SWAP_BUDGET_AMOUNT = 2_000_000 ether;

  function execute() external {
    _ahab();
    _aaveApprovals();
    _depositEth();
    _merit();
    _ptApprovals();
    _replenishAllowances();
  }

  function _ahab() internal {
    AaveV3EthereumLido.COLLECTOR.approve(
      IERC20(AaveV3EthereumLidoAssets.WETH_A_TOKEN),
      MiscEthereum.AHAB_SAFE,
      AHAB_WETH_AMOUNT
    );
  }

  function _aaveApprovals() internal {
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING),
      MiscEthereum.AFC_SAFE,
      AFC_AAVE_AMOUNT
    );

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveSafetyModule.STK_AAVE),
      MiscEthereum.AFC_SAFE,
      IERC20(AaveSafetyModule.STK_AAVE).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );
  }

  function _depositEth() internal {
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3Ethereum.COLLECTOR.ETH_MOCK_ADDRESS()),
      address(this),
      address(AaveV3Ethereum.COLLECTOR).balance
    );
    IWETH(AaveV3EthereumAssets.WETH_UNDERLYING).deposit{value: address(this).balance}();
    IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).transfer(
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(address(this))
    );
  }

  function _merit() internal {
    AaveV3EthereumLido.COLLECTOR.approve(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      MiscEthereum.MERIT_AHAB_SAFE,
      MERIT_GHO_AMOUNT
    );
  }

  function _ptApprovals() internal {
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.PT_eUSDE_14AUG2025_A_TOKEN),
      MiscEthereum.AFC_SAFE,
      PT_eUSDE_14AUG2025_AMOUNT
    );
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.PT_sUSDE_25SEP2025_A_TOKEN),
      MiscEthereum.AFC_SAFE,
      PT_sUSDE_25SEP2025_AMOUNT
    );
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.PT_USDe_31JUL2025_A_TOKEN),
      MiscEthereum.AFC_SAFE,
      PT_USDe_31JUL2025_AMOUNT
    );
  }

  function _replenishAllowances() internal {
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).increaseTokenBudget(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      USDC_SWAP_BUDGET_AMOUNT
    );
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).increaseTokenBudget(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      USDT_SWAP_BUDGET_AMOUNT
    );
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).increaseTokenBudget(
      AaveV3EthereumAssets.USDS_UNDERLYING,
      USDS_SWAP_BUDGET_AMOUNT
    );
  }
}
