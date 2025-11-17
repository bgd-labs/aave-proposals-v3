// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

interface IMainnetSwapSteward {
  function setSwappablePair(address fromToken, address toToken, bool allowed) external;
  function tokenBudget(address token) external view returns (uint256);
  function increaseTokenBudget(address token, uint256 budget) external;
}

/**
 * @title November Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-november-2025-funding-update/23339
 */
contract AaveV3Ethereum_NovemberFundingUpdate_20251110 is IProposalGenericExecutor {
  // https://etherscan.io/address/0x1bab804803159ad84b8854581aa53ac72455614e
  address public constant SYND = 0x1bAB804803159aD84b8854581AA53AC72455614E;
  uint256 public constant SYND_APPROVAL_AMOUNT = 200_000 ether;

  // https://etherscan.io/address/0xc20059e0317DE91738d13af027DfC4a50781b066
  address public constant SPK = 0xc20059e0317DE91738d13af027DfC4a50781b066;

  // https://etherscan.io/address/0x5aFE3855358E112B5647B952709E6165e1c1eEEe
  address public constant SAFE = 0x5aFE3855358E112B5647B952709E6165e1c1eEEe;

  // https://etherscan.io/address/0x455e53CBB86018Ac2B8092FdCd39d8444aFFC3F6
  address public constant POL = 0x455e53CBB86018Ac2B8092FdCd39d8444aFFC3F6;

  // https://etherscan.io/address/0xAAf400e4Bbc38B5E2136C1a36946Bf841A357307
  address public constant AUDITS_SAFE = 0xAAf400e4Bbc38B5E2136C1a36946Bf841A357307;
  uint256 public constant AUDITS_GHO_AMOUNT = 1_500_000 ether;

  uint256 public constant MERIT_GHO_AMOUNT = 3_000_000 ether;

  // https://etherscan.io/address/0xAA088dfF3dcF619664094945028d44E779F19894
  address public constant TOKEN_LOGIC = 0xAA088dfF3dcF619664094945028d44E779F19894;
  uint256 public constant REIMBURSEMENTS_GHO_AMOUNT = 71_698 ether;

  // stkAAVE
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_AAVE = uint128(260 ether) / 1 days;

  // stkABPT
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_BPT = uint128(130 ether) / 1 days;

  // Increase Swap Steward Budget
  uint256 public constant USDC_SWAP_BUDGET_AMOUNT = 2_000_000e6;
  uint256 public constant DAI_SWAP_BUDGET_AMOUNT = 1_000_000 ether;

  function execute() external {
    _runway();
    _v4Audits();
    _merit();
    _reimbursements();
    _ecosystemReserve();
    _swapPathsAndBudget();
    _emissionsIncrease();
    _replenishAllowances();
  }

  function _runway() internal {
    AaveV3Ethereum.COLLECTOR.approve(IERC20(SYND), MiscEthereum.AFC_SAFE, SYND_APPROVAL_AMOUNT);

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(SPK),
      MiscEthereum.AFC_SAFE,
      IERC20(SPK).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(SAFE),
      MiscEthereum.AFC_SAFE,
      IERC20(SAFE).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(POL),
      MiscEthereum.AFC_SAFE,
      IERC20(POL).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );
  }

  function _v4Audits() internal {
    AaveV3EthereumLido.COLLECTOR.approve(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      AUDITS_SAFE,
      AUDITS_GHO_AMOUNT
    );
  }

  function _merit() internal {
    AaveV3EthereumLido.COLLECTOR.approve(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      MiscEthereum.MERIT_AHAB_SAFE,
      MERIT_GHO_AMOUNT
    );
  }

  function _reimbursements() internal {
    AaveV3EthereumLido.COLLECTOR.approve(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      TOKEN_LOGIC,
      REIMBURSEMENTS_GHO_AMOUNT
    );
  }

  function _ecosystemReserve() internal {
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING),
      MiscEthereum.ECOSYSTEM_RESERVE,
      IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );
  }

  function _swapPathsAndBudget() internal {
    // To pyUSD
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      true
    );
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      true
    );
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      true
    );
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDS_UNDERLYING,
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      true
    );
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      true
    );
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      true
    );
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDe_UNDERLYING,
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      true
    );
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.RLUSD_UNDERLYING,
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      true
    );

    // To rlUSD
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.RLUSD_UNDERLYING,
      true
    );
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.RLUSD_UNDERLYING,
      true
    );
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.RLUSD_UNDERLYING,
      true
    );
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDS_UNDERLYING,
      AaveV3EthereumAssets.RLUSD_UNDERLYING,
      true
    );
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.RLUSD_UNDERLYING,
      true
    );
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.RLUSD_UNDERLYING,
      true
    );
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDe_UNDERLYING,
      AaveV3EthereumAssets.RLUSD_UNDERLYING,
      true
    );
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      AaveV3EthereumAssets.RLUSD_UNDERLYING,
      true
    );
  }

  function _emissionsIncrease() internal {
    // Excess allowance that has not been claimed
    uint256 allowanceToKeep = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      address(MiscEthereum.ECOSYSTEM_RESERVE),
      AaveSafetyModule.STK_AAVE
    );

    uint256 newAllowance = allowanceToKeep + 14 days * AAVE_EMISSION_PER_SECOND_STK_AAVE;

    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveSafetyModule.STK_AAVE,
      0
    );

    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveSafetyModule.STK_AAVE,
      newAllowance
    );

    // Excess allowance that has not been claimed
    allowanceToKeep = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      address(MiscEthereum.ECOSYSTEM_RESERVE),
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    );

    newAllowance = allowanceToKeep + 14 days * AAVE_EMISSION_PER_SECOND_STK_BPT;

    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2,
      0
    );

    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2,
      newAllowance
    );
  }

  function _replenishAllowances() internal {
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).increaseTokenBudget(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      USDC_SWAP_BUDGET_AMOUNT
    );
    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).increaseTokenBudget(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      DAI_SWAP_BUDGET_AMOUNT
    );
  }
}
