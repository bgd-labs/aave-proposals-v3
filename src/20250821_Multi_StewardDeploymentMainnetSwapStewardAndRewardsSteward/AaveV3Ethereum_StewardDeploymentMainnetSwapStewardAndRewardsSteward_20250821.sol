// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {EmissionManager} from 'aave-v3-origin/contracts/rewards/EmissionManager.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

interface IMainnetSwapSteward {
  function increaseTokenBudget(address token, uint256 budget) external;
  function setSwappablePair(address fromToken, address toToken, bool allowed) external;
  function setTokenOracle(address token, address oracle) external;
}

/**
 * @title Steward Deployment: MainnetSwapSteward and RewardsSteward
 * @author @TokenLogic
 * - Snapshot: PENDING
 * - Discussion: PENDING
 */
contract AaveV3Ethereum_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821 is
  IProposalGenericExecutor
{
  // https://etherscan.io/address/0x2C7f01A1322ce99EEB331d6Eb73Aff400f11C5CB
  address public constant REWARDS_STEWARD = 0x2C7f01A1322ce99EEB331d6Eb73Aff400f11C5CB;

  // https://etherscan.io/address/0xb7D402138Cb01BfE97d95181C849379d6AD14d19
  address public constant SWAP_STEWARD = 0xb7D402138Cb01BfE97d95181C849379d6AD14d19;

  uint256 public constant USD_STABLE_BUDGET = 5_000_000;
  uint256 public constant DAI_BUDGET = 3_000_000 ether;
  uint256 public constant RLUSD_BUDGET = 1_000_000 ether;

  function execute() external {
    // RewardsSteward
    EmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setClaimer(
      address(AaveV3Ethereum.COLLECTOR),
      REWARDS_STEWARD
    );

    // MainnetSwapSteward
    // Token: USDC
    _setOracleAndBudget(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      USD_STABLE_BUDGET * 10 ** AaveV3EthereumAssets.USDC_DECIMALS
    );
    // Token: USDT
    _setOracleAndBudget(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.USDT_ORACLE,
      USD_STABLE_BUDGET * 10 ** AaveV3EthereumAssets.USDT_DECIMALS
    );
    // Token: USDe
    _setOracleAndBudget(
      AaveV3EthereumAssets.USDe_UNDERLYING,
      AaveV3EthereumAssets.USDe_ORACLE,
      USD_STABLE_BUDGET * 10 ** AaveV3EthereumAssets.USDe_DECIMALS
    );
    // Token: USDS
    _setOracleAndBudget(
      AaveV3EthereumAssets.USDS_UNDERLYING,
      AaveV3EthereumAssets.USDS_ORACLE,
      USD_STABLE_BUDGET * 10 ** AaveV3EthereumAssets.USDS_DECIMALS
    );
    // Token: DAI
    _setOracleAndBudget(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      DAI_BUDGET
    );
    // Token: RLUSD
    _setOracleAndBudget(
      AaveV3EthereumAssets.RLUSD_UNDERLYING,
      AaveV3EthereumAssets.RLUSD_ORACLE,
      RLUSD_BUDGET
    );

    // IMainnetSwapSteward(SWAP_STEWARD).setSwappablePair();
  }

  function _setOracleAndBudget(address token, address oracle, uint256 budget) internal {
    IMainnetSwapSteward(SWAP_STEWARD).setTokenOracle(token, oracle);
    IMainnetSwapSteward(SWAP_STEWARD).increaseTokenBudget(token, budget);
  }
}
