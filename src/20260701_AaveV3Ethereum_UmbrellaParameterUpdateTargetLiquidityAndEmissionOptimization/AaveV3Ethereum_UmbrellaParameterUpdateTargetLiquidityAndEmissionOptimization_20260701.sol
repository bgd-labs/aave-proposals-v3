// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {UmbrellaEthereum, UmbrellaEthereumAssets} from 'aave-address-book/UmbrellaEthereum.sol';
import {EngineFlags} from 'aave-umbrella/payloads/EngineFlags.sol';
import {IUmbrellaEngineStructs} from 'aave-umbrella/payloads/IUmbrellaEngineStructs.sol';
import {UmbrellaBasePayload} from 'aave-umbrella/payloads/UmbrellaBasePayload.sol';
import {IRewardsStructs} from 'aave-umbrella/rewards/interfaces/IRewardsStructs.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

/**
 * @title Umbrella Parameter Update: Target Liquidity and Emission Optimization
 * @author @TokenLogic
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0x1b262e62f554d2a5a68eb56a267e14ec3aeacad5bd185ef328be8b38aca651ca
 * - Discussion: https://governance.aave.com/t/arfc-umbrella-parameter-update-target-liquidity-and-emission-optimization/25154
 */
contract AaveV3Ethereum_UmbrellaParameterUpdateTargetLiquidityAndEmissionOptimization_20260701 is
  UmbrellaBasePayload
{
  uint256 public constant SECONDS_PER_YEAR = 365 days;

  uint256 public constant STATA_USDT_TARGET_LIQUIDITY = 34_114_525e6; // 34.11M waUSDT, 6 decimals
  uint256 public constant STATA_USDC_TARGET_LIQUIDITY = 32_518_555e6; // 32.52M waUSDC, 6 decimals
  uint256 public constant STATA_WETH_TARGET_LIQUIDITY = 17_437.44e18; // 17,437.44 waWETH, 18 decimals

  uint256 public constant USDT_EMISSION_PER_YEAR = 1_280_000e6; // 1.28M aEthUSDT, 6 decimals
  uint256 public constant USDC_EMISSION_PER_YEAR = 1_220_000e6; // 1.22M aEthUSDC, 6 decimals
  uint256 public constant WETH_EMISSION_PER_YEAR = 470e18; // 470 aEthWETH, 18 decimals

  uint256 public constant GHO_TARGET_LIQUIDITY = 1e18; // 1 GHO, 18 decimals
  uint256 public constant GHO_DEFICIT_OFFSET = 3_000_000e18; // 3M GHO, 18 decimals

  uint256 public constant USDT_RENEWAL_ALLOWANCE = 182_560e6;
  uint256 public constant USDC_RENEWAL_ALLOWANCE = 243_153e6;

  constructor() UmbrellaBasePayload(UmbrellaEthereum.UMBRELLA_CONFIG_ENGINE) {}

  function _postExecute() internal override {
    address collector = address(AaveV3Ethereum.COLLECTOR);
    address rewardsController = UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER;

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN),
      rewardsController,
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(collector, rewardsController) +
        USDT_RENEWAL_ALLOWANCE
    );

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN),
      rewardsController,
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(collector, rewardsController) +
        USDC_RENEWAL_ALLOWANCE
    );
  }

  function configureStakeAndRewards()
    public
    pure
    override
    returns (IUmbrellaEngineStructs.ConfigureStakeAndRewardsConfig[] memory)
  {
    IUmbrellaEngineStructs.ConfigureStakeAndRewardsConfig[]
      memory configs = new IUmbrellaEngineStructs.ConfigureStakeAndRewardsConfig[](4);

    configs[0] = _buildConfig(
      UmbrellaEthereumAssets.STK_WA_USDT_V1,
      AaveV3EthereumAssets.USDT_A_TOKEN,
      STATA_USDT_TARGET_LIQUIDITY,
      USDT_EMISSION_PER_YEAR / SECONDS_PER_YEAR
    );
    configs[1] = _buildConfig(
      UmbrellaEthereumAssets.STK_WA_USDC_V1,
      AaveV3EthereumAssets.USDC_A_TOKEN,
      STATA_USDC_TARGET_LIQUIDITY,
      USDC_EMISSION_PER_YEAR / SECONDS_PER_YEAR
    );
    configs[2] = _buildConfig(
      UmbrellaEthereumAssets.STK_WA_WETH_V1,
      AaveV3EthereumAssets.WETH_A_TOKEN,
      STATA_WETH_TARGET_LIQUIDITY,
      WETH_EMISSION_PER_YEAR / SECONDS_PER_YEAR
    );
    configs[3] = _buildConfig(
      UmbrellaEthereumAssets.STK_GHO_V1,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      GHO_TARGET_LIQUIDITY,
      0
    );

    return configs;
  }

  function setDeficitOffset()
    public
    pure
    override
    returns (IUmbrellaEngineStructs.SetDeficitOffset[] memory)
  {
    IUmbrellaEngineStructs.SetDeficitOffset[]
      memory offsets = new IUmbrellaEngineStructs.SetDeficitOffset[](1);

    offsets[0] = IUmbrellaEngineStructs.SetDeficitOffset({
      reserve: AaveV3EthereumAssets.GHO_UNDERLYING,
      newDeficitOffset: GHO_DEFICIT_OFFSET
    });

    return offsets;
  }

  function _buildConfig(
    address stakeToken,
    address reward,
    uint256 targetLiquidity,
    uint256 maxEmissionPerSecond
  ) internal pure returns (IUmbrellaEngineStructs.ConfigureStakeAndRewardsConfig memory) {
    IRewardsStructs.RewardSetupConfig[]
      memory rewardConfigs = new IRewardsStructs.RewardSetupConfig[](1);
    rewardConfigs[0] = IRewardsStructs.RewardSetupConfig({
      reward: reward,
      rewardPayer: address(AaveV3Ethereum.COLLECTOR),
      maxEmissionPerSecond: maxEmissionPerSecond,
      distributionEnd: EngineFlags.KEEP_CURRENT
    });

    return
      IUmbrellaEngineStructs.ConfigureStakeAndRewardsConfig({
        umbrellaStake: stakeToken,
        targetLiquidity: targetLiquidity,
        rewardConfigs: rewardConfigs
      });
  }
}
