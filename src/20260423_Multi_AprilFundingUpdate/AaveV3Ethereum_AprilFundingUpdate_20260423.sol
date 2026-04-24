// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IWETH} from 'aave-v3-origin/contracts/helpers/interfaces/IWETH.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

interface IMainnetSwapSteward {
  function increaseTokenBudget(address token, uint256 budget) external;
  function setSwappablePair(address fromToken, address toToken, bool allowed) external;
  function setTokenOracle(address token, address oracle) external;
}

/**
 * @title April Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-april-2026-funding-update/24447
 */
contract AaveV3Ethereum_AprilFundingUpdate_20260423 is IProposalGenericExecutor {
  // https://etherscan.io/address/0xAA088dfF3dcF619664094945028d44E779F19894
  address public constant TOKEN_LOGIC = 0xAA088dfF3dcF619664094945028d44E779F19894;
  uint256 public constant REIMBURSEMENTS_GHO_AMOUNT = 21_322.38 ether;

  // https://etherscan.io/address/0xaaf400e4bbc38b5e2136c1a36946bf841a357307
  address public constant AAVE_LABS = 0xAAf400e4Bbc38B5E2136C1a36946Bf841A357307;
  uint256 public constant AAVE_LABS_ALLOWANCE = 1_000_000 ether;

  uint256 public constant WBTC_SWAP_BUDGET_AMOUNT = 80e8;
  uint256 public constant CBBTC_SWAP_BUDGET_AMOUNT = 7e8;
  uint256 public constant WETH_SWAP_BUDGET_AMOUNT = 10_000 ether;
  uint256 public constant USDT_SWAP_BUDGET_AMOUNT = 10_000_000e6;
  uint256 public constant USDC_SWAP_BUDGET_AMOUNT = 10_000_000e6;
  uint256 public constant USDe_SWAP_BUDGET_AMOUNT = 10_000_000 ether;
  uint256 public constant USDS_SWAP_BUDGET_AMOUNT = 10_000_000 ether;
  uint256 public constant DAI_SWAP_BUDGET_AMOUNT = 5_000_000 ether;
  uint256 public constant LINK_SWAP_BUDGET_AMOUNT = 60_000 ether;

  uint256 public constant MERIT_ALLOWANCE = 2_000_000 ether;
  uint256 public constant TYDRO_ALLOWANCE = 200_000 ether;

  uint256 public constant OLD_STREAM = 100015;

  // https://etherscan.io/address/0xa9E6B917F3e0a89664d648B6DF474AB88D0D15ff
  address public constant BUGBOUNTY_RECEIVER = 0xa9E6B917F3e0a89664d648B6DF474AB88D0D15ff;

  // https://etherscan.io/address/0x7119f398b6C06095c6E8964C1f58e7C1BAa79E18
  address public constant IMMUNEFI = 0x7119f398b6C06095c6E8964C1f58e7C1BAa79E18;
  uint256 public constant BUGBOUNTY_AMOUNT = 5_000 ether;
  uint256 public constant BUGBOUNTY_FEE = 500 ether;

  // ETH related allowances
  uint256 public constant AHAB_WETH_ALLOWANCE = 25_000 ether;
  uint256 public constant AHAB_aEthWETH_ALLOWANCE = 4_000 ether;
  uint256 public constant AHAB_weWETH_ALLOWANCE = 600 ether;
  uint256 public constant AHAB_wstETH_ALLOWANCE = 220 ether;
  uint256 public constant AHAB_rETH_ALLOWANCE = 60 ether;

  function execute() external {
    _swapPaths();
    _depositEth();
    _reimbursements();
    _replenishAllowances();
    _merit();
    _ahab();
    _tydro();
    _streams();
    _bugBounty();
  }

  function _ahab() internal {
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.WETH_UNDERLYING),
      MiscEthereum.AHAB_SAFE,
      AHAB_WETH_ALLOWANCE
    );

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN),
      MiscEthereum.AHAB_SAFE,
      AHAB_aEthWETH_ALLOWANCE
    );

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.weETH_UNDERLYING),
      MiscEthereum.AHAB_SAFE,
      AHAB_weWETH_ALLOWANCE
    );

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.rETH_UNDERLYING),
      MiscEthereum.AHAB_SAFE,
      AHAB_rETH_ALLOWANCE
    );

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.wstETH_UNDERLYING),
      MiscEthereum.AHAB_SAFE,
      AHAB_wstETH_ALLOWANCE
    );
  }

  function _depositEth() internal {
    uint256 ethBalance = address(AaveV3Ethereum.COLLECTOR).balance;
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3Ethereum.COLLECTOR.ETH_MOCK_ADDRESS()),
      address(this),
      ethBalance
    );
    IWETH(AaveV3EthereumAssets.WETH_UNDERLYING).deposit{value: ethBalance}();
    IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).transfer(
      address(AaveV3Ethereum.COLLECTOR),
      ethBalance
    );
  }

  function _reimbursements() internal {
    // TL
    uint256 currentAllowance = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      TOKEN_LOGIC
    );
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING),
      TOKEN_LOGIC,
      currentAllowance + REIMBURSEMENTS_GHO_AMOUNT
    );

    // Aave Labs
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      AAVE_LABS,
      AAVE_LABS_ALLOWANCE
    );
  }

  function _replenishAllowances() internal {
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).increaseTokenBudget(
      AaveV3EthereumAssets.WBTC_UNDERLYING,
      WBTC_SWAP_BUDGET_AMOUNT
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).increaseTokenBudget(
      AaveV3EthereumAssets.cbBTC_UNDERLYING,
      CBBTC_SWAP_BUDGET_AMOUNT
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).increaseTokenBudget(
      AaveV3EthereumAssets.WETH_UNDERLYING,
      WETH_SWAP_BUDGET_AMOUNT
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).increaseTokenBudget(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      USDT_SWAP_BUDGET_AMOUNT
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).increaseTokenBudget(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      USDC_SWAP_BUDGET_AMOUNT
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).increaseTokenBudget(
      AaveV3EthereumAssets.USDe_UNDERLYING,
      USDe_SWAP_BUDGET_AMOUNT
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).increaseTokenBudget(
      AaveV3EthereumAssets.USDS_UNDERLYING,
      USDS_SWAP_BUDGET_AMOUNT
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).increaseTokenBudget(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      DAI_SWAP_BUDGET_AMOUNT
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).increaseTokenBudget(
      AaveV3EthereumAssets.LINK_UNDERLYING,
      LINK_SWAP_BUDGET_AMOUNT
    );
  }

  function _merit() internal {
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      MiscEthereum.MERIT_AHAB_SAFE,
      MERIT_ALLOWANCE
    );
  }

  function _tydro() internal {
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      MiscEthereum.AFC_SAFE,
      TYDRO_ALLOWANCE
    );
  }

  function _streams() internal {
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.cancelStream(
      MiscEthereum.ECOSYSTEM_RESERVE,
      OLD_STREAM
    );
  }

  function _bugBounty() internal {
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING),
      BUGBOUNTY_RECEIVER,
      BUGBOUNTY_AMOUNT
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING),
      IMMUNEFI,
      BUGBOUNTY_FEE
    );
  }

  function _swapPaths() internal {
    // Add Oracles

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setTokenOracle(
      AaveV3EthereumAssets.WBTC_UNDERLYING,
      AaveV3EthereumAssets.WBTC_ORACLE
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setTokenOracle(
      AaveV3EthereumAssets.LINK_UNDERLYING,
      AaveV3EthereumAssets.LINK_ORACLE
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setTokenOracle(
      AaveV3EthereumAssets.cbBTC_UNDERLYING,
      AaveV3EthereumAssets.cbBTC_ORACLE
    );

    // wBTC Swap Paths

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.WBTC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      true
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.WBTC_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      true
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.WBTC_UNDERLYING,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      true
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.WBTC_UNDERLYING,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      true
    );

    // cbBTC Swap Paths

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.cbBTC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      true
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.cbBTC_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      true
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.cbBTC_UNDERLYING,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      true
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.cbBTC_UNDERLYING,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      true
    );

    // To wETH

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.WBTC_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      true
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.cbBTC_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      true
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.ONE_INCH_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      true
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDS_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      true
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      true
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      true
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDe_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      true
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      true
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.LINK_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      true
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.SNX_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      true
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.UNI_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      true
    );
  }
}
