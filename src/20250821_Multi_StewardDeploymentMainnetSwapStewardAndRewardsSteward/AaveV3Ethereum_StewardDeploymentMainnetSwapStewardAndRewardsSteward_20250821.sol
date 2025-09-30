// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {EmissionManager} from 'aave-v3-origin/contracts/rewards/EmissionManager.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

interface IMainnetSwapSteward {
  function increaseTokenBudget(address token, uint256 budget) external;
  function setSwappablePair(address fromToken, address toToken, bool allowed) external;
  function setTokenOracle(address token, address oracle) external;
}

/**
 * @title Steward Deployment: MainnetSwapSteward and RewardsSteward
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xdc005c2385a548143bbeb35b8bb92e5f0ed29829a445f5e986a2b010bc349c6a
 * - Discussion: https://governance.aave.com/t/arfc-steward-deployment-mainnetswapsteward-and-rewardssteward/23070
 */
contract AaveV3Ethereum_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821 is
  IProposalGenericExecutor
{
  // https://etherscan.io/address/0x2C7f01A1322ce99EEB331d6Eb73Aff400f11C5CB
  address public constant REWARDS_STEWARD = 0x2C7f01A1322ce99EEB331d6Eb73Aff400f11C5CB;

  // https://etherscan.io/address/0xb7D402138Cb01BfE97d95181C849379d6AD14d19
  address public constant SWAP_STEWARD = 0xb7D402138Cb01BfE97d95181C849379d6AD14d19;

  /// https://etherscan.io/address/0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC
  address public constant GHO_USD_FEED = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC;

  uint256 public constant USD_STABLE_BUDGET = 5_000_000;
  uint256 public constant DAI_BUDGET = 3_000_000 ether;
  uint256 public constant RLUSD_BUDGET = 1_000_000 ether;
  uint256 public constant LUSD_BUDGET = 500_000 ether;
  uint256 public constant FRAX_BUDGET = 150_000 ether;
  uint256 public constant PYUSD_BUDGET = 20_000e6;
  uint256 public constant UNI_BUDGET = 15_000 ether;
  uint256 public constant MKR_BUDGET = 100 ether;
  uint256 public constant ONEINCH_BUDGET = 50_000 ether;
  uint256 public constant ENS_BUDGET = 200 ether;
  uint256 public constant SNX_BUDGET = 150_000 ether;

  function execute() external {
    // RewardsSteward
    EmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setClaimer(
      address(AaveV3Ethereum.COLLECTOR),
      REWARDS_STEWARD
    );

    // MainnetSwapSteward
    IAccessControl(address(AaveV3Ethereum.COLLECTOR)).grantRole('FUNDS_ADMIN', SWAP_STEWARD);

    _configureAssets();
    _setSwappablePairs();
  }

  function _configureAssets() internal {
    // Token: GHO (Only Oracle)
    IMainnetSwapSteward(SWAP_STEWARD).setTokenOracle(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      GHO_USD_FEED
    );

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

    // Token: LUSD
    _setOracleAndBudget(
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.LUSD_ORACLE,
      LUSD_BUDGET
    );

    // Token: FRAX
    _setOracleAndBudget(
      AaveV3EthereumAssets.FRAX_UNDERLYING,
      AaveV3EthereumAssets.FRAX_ORACLE,
      FRAX_BUDGET
    );

    // Token: pyUSD
    _setOracleAndBudget(
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      AaveV3EthereumAssets.PYUSD_ORACLE,
      PYUSD_BUDGET
    );

    // Token: UNI
    _setOracleAndBudget(
      AaveV3EthereumAssets.UNI_UNDERLYING,
      AaveV3EthereumAssets.UNI_ORACLE,
      UNI_BUDGET
    );

    // Token: MKR
    _setOracleAndBudget(
      AaveV3EthereumAssets.MKR_UNDERLYING,
      AaveV3EthereumAssets.MKR_ORACLE,
      MKR_BUDGET
    );

    // Token: 1INCH
    _setOracleAndBudget(
      AaveV3EthereumAssets.ONE_INCH_UNDERLYING,
      AaveV3EthereumAssets.ONE_INCH_ORACLE,
      ONEINCH_BUDGET
    );

    // Token: ENS
    _setOracleAndBudget(
      AaveV3EthereumAssets.ENS_UNDERLYING,
      AaveV3EthereumAssets.ENS_ORACLE,
      ENS_BUDGET
    );

    // Token: SNX
    _setOracleAndBudget(
      AaveV3EthereumAssets.SNX_UNDERLYING,
      AaveV3EthereumAssets.SNX_ORACLE,
      SNX_BUDGET
    );
  }

  function _setSwappablePairs() internal {
    // To GHO
    IMainnetSwapSteward(SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      true
    );
    IMainnetSwapSteward(SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      true
    );
    IMainnetSwapSteward(SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDe_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      true
    );
    IMainnetSwapSteward(SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDS_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      true
    );
    IMainnetSwapSteward(SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      true
    );

    // To USDC
    IMainnetSwapSteward(SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDe_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      true
    );
    IMainnetSwapSteward(SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.USDS_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      true
    );
    IMainnetSwapSteward(SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      true
    );
    IMainnetSwapSteward(SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.RLUSD_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      true
    );
    IMainnetSwapSteward(SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      true
    );
    IMainnetSwapSteward(SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.FRAX_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      true
    );
    IMainnetSwapSteward(SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      true
    );
    IMainnetSwapSteward(SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.UNI_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      true
    );
    IMainnetSwapSteward(SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.MKR_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      true
    );
    IMainnetSwapSteward(SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.ONE_INCH_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      true
    );
    IMainnetSwapSteward(SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.ENS_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      true
    );
    IMainnetSwapSteward(SWAP_STEWARD).setSwappablePair(
      AaveV3EthereumAssets.SNX_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      true
    );
  }

  function _setOracleAndBudget(address token, address oracle, uint256 budget) internal {
    IMainnetSwapSteward(SWAP_STEWARD).setTokenOracle(token, oracle);
    IMainnetSwapSteward(SWAP_STEWARD).increaseTokenBudget(token, budget);
  }
}
