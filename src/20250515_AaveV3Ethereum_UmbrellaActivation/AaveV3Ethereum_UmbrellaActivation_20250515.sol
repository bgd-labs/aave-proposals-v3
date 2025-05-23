// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AccessControlUpgradeable} from 'openzeppelin-contracts-upgradeable/contracts/access/AccessControlUpgradeable.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {UmbrellaEthereum} from 'aave-address-book/UmbrellaEthereum.sol';

import {IStataTokenV2} from 'aave-v3-origin/contracts/extensions/stata-token/interfaces/IStataTokenV2.sol';

import {UmbrellaExtendedPayload} from 'aave-umbrella/payloads/UmbrellaExtendedPayload.sol';
import {ISMStructs, IStructs} from 'aave-umbrella/payloads/UmbrellaBasePayload.sol';
import {IRewardsStructs} from 'aave-umbrella/rewards/interfaces/IRewardsStructs.sol';

/**
 * @title UmbrellaActivation
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xbe792a1db33cd7803e23810553e5a6a728c3ac15827ad2652aa6de1858fa5596
 * - Discussion: https://governance.aave.com/t/arfc-aave-umbrella-activation/21521
 * @notice Executes a batch of actions to activate the Aave Umbrella framework.
 *
 * The payload performs the following actions:
 *  - Registers the `Umbrella` contract in the `POOL_ADDRESSES_PROVIDER`
 *  - Eliminates reserve deficits fot USDC, USDT, WETH and GHO
 *  - Deploys four `UmbrellaStakeToken`s:
 *    + Three backed by waTokens
 *    + One (stkGho) backed by GHO
 *  - Configures slashing parameters and reward mechanisms during stkToken setup, increases `deficitOffset`s
 *  - Grants allowance from the `Collector` to the `RewardsController` to fund rewards for the next 180 days
 *  - Assigns the `REWARDS_ADMIN_ROLE` to the `PERMISSIONED_PAYLOADS_CONTROLLER_EXECUTOR`
 *  - Assigns the `COVERAGE_MANAGER_ROLE` to the `DEFICIT_OFFSET_CLINIC_STEWARD`
 *  - Grants allowance to the `DEFICIT_OFFSET_CLINIC_STEWARD` for `deficitOffset` elimination
 */
contract AaveV3Ethereum_UmbrellaActivation_20250515 is
  UmbrellaExtendedPayload(UmbrellaEthereum.UMBRELLA_CONFIG_ENGINE)
{
  uint256 public constant DEFICIT_OFFSET_USDC = 100_000 * 1e6;
  uint256 public constant DEFICIT_OFFSET_USDT = 100_000 * 1e6;
  uint256 public constant DEFICIT_OFFSET_WETH = 50 * 1e18;
  uint256 public constant DEFICIT_OFFSET_GHO = 100_000 * 1e18;

  uint256 public constant DEFAULT_COOLDOWN = 20 days;
  uint256 public constant DEFAULT_UNSTAKE_WINDOW = 2 days;

  uint256 public constant DISTRIBUTION_DURATION = 365 days;

  uint256 public constant USDC_MAX_EMISSION_PER_SECOND = uint256(2_330_000 * 1e6) / 365 days; // ~3_000_000 * 66 / 85
  uint256 public constant USDC_TARGET_LIQUIDITY = 66_000_000 * 1e6; // Will be recalculated during setup considering the exchange rate of stata

  uint256 public constant USDT_MAX_EMISSION_PER_SECOND = uint256(3_670_000 * 1e6) / 365 days; // ~3_000_000 * 104 / 85
  uint256 public constant USDT_TARGET_LIQUIDITY = 104_000_000 * 1e6; // Will be recalculated during setup considering the exchange rate of stata

  uint256 public constant WETH_MAX_EMISSION_PER_SECOND = uint256(550 * 1e18) / 365 days;
  uint256 public constant WETH_TARGET_LIQUIDITY = 25_000 * 1e18; // Will be recalculated during setup considering the exchange rate of stata

  uint256 public constant GHO_MAX_EMISSION_PER_SECOND = uint256(1_200_000 * 1e18) / 365 days;
  uint256 public constant GHO_TARGET_LIQUIDITY = 12_000_000 * 1e18;

  bytes32 public constant REWARDS_ADMIN_ROLE = keccak256('REWARDS_ADMIN_ROLE');
  bytes32 public constant COVERAGE_MANAGER_ROLE = keccak256('COVERAGE_MANAGER_ROLE');

  bytes32 public constant UMBRELLA = 'UMBRELLA';

  address public constant BGD_LABS_MULTISIG = 0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF;
  uint256 public constant TOTAL_COST_OF_AUDITS = 249_000 * 1e6;

  function _preExecute() internal override {
    // Give `UMBRELLA` to the `Umbrella` contract, so `Umbrella` could start eliminating deficit for this `POOL`
    AaveV3Ethereum.POOL_ADDRESSES_PROVIDER.setAddress(UMBRELLA, address(UmbrellaEthereum.UMBRELLA));

    // Cache current reserve deficit amounts
    /////////////////////////////////////////////////////////////////////////////////////////

    uint256 currentReserveDeficitToCoverUSDC = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.USDC_UNDERLYING
    );

    uint256 currentReserveDeficitToCoverUSDT = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.USDT_UNDERLYING
    );

    uint256 currentReserveDeficitToCoverWETH = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.WETH_UNDERLYING
    );

    uint256 currentReserveDeficitToCoverGHO = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.GHO_UNDERLYING
    );

    // Transfer current reserve deficit amounts to this address, so it could be used to eliminate `ReserveDeficit` later
    // +1 to avoid precision error with aToken transfers
    /////////////////////////////////////////////////////////////////////////////////////////

    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN),
      address(this),
      currentReserveDeficitToCoverUSDC + 1
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN),
      address(this),
      currentReserveDeficitToCoverUSDT + 1
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN),
      address(this),
      currentReserveDeficitToCoverWETH + 1
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING),
      address(this),
      currentReserveDeficitToCoverGHO
    );
  }

  function coverReserveDeficit() public view override returns (IStructs.CoverDeficit[] memory) {
    // Will eliminate reserve deficit before configuring anything, using funds, that were transferred during `_preExecute` phase
    IStructs.CoverDeficit[] memory coverReserveDeficits = new IStructs.CoverDeficit[](4);

    coverReserveDeficits[0] = IStructs.CoverDeficit({
      reserve: AaveV3EthereumAssets.USDC_UNDERLYING,
      amount: AaveV3Ethereum.POOL.getReserveDeficit(AaveV3EthereumAssets.USDC_UNDERLYING),
      approve: true
    });

    coverReserveDeficits[1] = IStructs.CoverDeficit({
      reserve: AaveV3EthereumAssets.USDT_UNDERLYING,
      amount: AaveV3Ethereum.POOL.getReserveDeficit(AaveV3EthereumAssets.USDT_UNDERLYING),
      approve: true
    });

    coverReserveDeficits[2] = IStructs.CoverDeficit({
      reserve: AaveV3EthereumAssets.WETH_UNDERLYING,
      amount: AaveV3Ethereum.POOL.getReserveDeficit(AaveV3EthereumAssets.WETH_UNDERLYING),
      approve: true
    });

    coverReserveDeficits[3] = IStructs.CoverDeficit({
      reserve: AaveV3EthereumAssets.GHO_UNDERLYING,
      amount: AaveV3Ethereum.POOL.getReserveDeficit(AaveV3EthereumAssets.GHO_UNDERLYING),
      approve: true
    });

    return coverReserveDeficits;
  }

  function complexTokenCreations() public view override returns (IStructs.TokenSetup[] memory) {
    IStructs.TokenSetup[] memory tokensCreation = new IStructs.TokenSetup[](4);

    // stkwaUSDC.V1 creation
    /////////////////////////////////////////////////////////////////////////////////////////

    ISMStructs.StakeTokenSetup memory stkUsdcSetup = ISMStructs.StakeTokenSetup({
      underlying: AaveV3EthereumAssets.USDC_STATA_TOKEN,
      cooldown: DEFAULT_COOLDOWN,
      unstakeWindow: DEFAULT_UNSTAKE_WINDOW,
      suffix: 'v1'
    });

    IRewardsStructs.RewardSetupConfig[]
      memory stkUsdcRewards = new IRewardsStructs.RewardSetupConfig[](1);

    stkUsdcRewards[0] = IRewardsStructs.RewardSetupConfig({
      reward: AaveV3EthereumAssets.USDC_A_TOKEN,
      rewardPayer: address(AaveV3Ethereum.COLLECTOR),
      maxEmissionPerSecond: USDC_MAX_EMISSION_PER_SECOND,
      distributionEnd: block.timestamp + DISTRIBUTION_DURATION
    });

    tokensCreation[0] = IStructs.TokenSetup({
      stakeSetup: stkUsdcSetup,
      targetLiquidity: (USDC_TARGET_LIQUIDITY *
        IStataTokenV2(AaveV3EthereumAssets.USDC_STATA_TOKEN).previewDeposit(1e6)) / 1e6,
      rewardConfigs: stkUsdcRewards,
      reserve: AaveV3EthereumAssets.USDC_UNDERLYING,
      liquidationFee: 0,
      umbrellaStakeUnderlyingOracle: AaveV3EthereumAssets.USDC_STATA_TOKEN,
      deficitOffsetIncrease: DEFICIT_OFFSET_USDC
    });

    // stkwaUSDT.V1 creation
    /////////////////////////////////////////////////////////////////////////////////////////

    ISMStructs.StakeTokenSetup memory stkUsdtSetup = ISMStructs.StakeTokenSetup({
      underlying: AaveV3EthereumAssets.USDT_STATA_TOKEN,
      cooldown: DEFAULT_COOLDOWN,
      unstakeWindow: DEFAULT_UNSTAKE_WINDOW,
      suffix: 'v1'
    });

    IRewardsStructs.RewardSetupConfig[]
      memory stkUsdtRewards = new IRewardsStructs.RewardSetupConfig[](1);

    stkUsdtRewards[0] = IRewardsStructs.RewardSetupConfig({
      reward: AaveV3EthereumAssets.USDT_A_TOKEN,
      rewardPayer: address(AaveV3Ethereum.COLLECTOR),
      maxEmissionPerSecond: USDT_MAX_EMISSION_PER_SECOND,
      distributionEnd: block.timestamp + DISTRIBUTION_DURATION
    });

    tokensCreation[1] = IStructs.TokenSetup({
      stakeSetup: stkUsdtSetup,
      targetLiquidity: (USDT_TARGET_LIQUIDITY *
        IStataTokenV2(AaveV3EthereumAssets.USDT_STATA_TOKEN).previewDeposit(1e6)) / 1e6,
      rewardConfigs: stkUsdtRewards,
      reserve: AaveV3EthereumAssets.USDT_UNDERLYING,
      liquidationFee: 0,
      umbrellaStakeUnderlyingOracle: AaveV3EthereumAssets.USDT_STATA_TOKEN,
      deficitOffsetIncrease: DEFICIT_OFFSET_USDT
    });

    // stkwaWETH.V1 creation
    /////////////////////////////////////////////////////////////////////////////////////////

    ISMStructs.StakeTokenSetup memory stkWethSetup = ISMStructs.StakeTokenSetup({
      underlying: AaveV3EthereumAssets.WETH_STATA_TOKEN,
      cooldown: DEFAULT_COOLDOWN,
      unstakeWindow: DEFAULT_UNSTAKE_WINDOW,
      suffix: 'v1'
    });

    IRewardsStructs.RewardSetupConfig[]
      memory stkWethRewards = new IRewardsStructs.RewardSetupConfig[](1);

    stkWethRewards[0] = IRewardsStructs.RewardSetupConfig({
      reward: AaveV3EthereumAssets.WETH_A_TOKEN,
      rewardPayer: address(AaveV3Ethereum.COLLECTOR),
      maxEmissionPerSecond: WETH_MAX_EMISSION_PER_SECOND,
      distributionEnd: block.timestamp + DISTRIBUTION_DURATION
    });

    tokensCreation[2] = IStructs.TokenSetup({
      stakeSetup: stkWethSetup,
      targetLiquidity: (WETH_TARGET_LIQUIDITY *
        IStataTokenV2(AaveV3EthereumAssets.WETH_STATA_TOKEN).previewDeposit(1e18)) / 1e18,
      rewardConfigs: stkWethRewards,
      reserve: AaveV3EthereumAssets.WETH_UNDERLYING,
      liquidationFee: 0,
      umbrellaStakeUnderlyingOracle: AaveV3EthereumAssets.WETH_STATA_TOKEN,
      deficitOffsetIncrease: DEFICIT_OFFSET_WETH
    });

    // stkGHO.V1 creation
    /////////////////////////////////////////////////////////////////////////////////////////

    ISMStructs.StakeTokenSetup memory stkGhoSetup = ISMStructs.StakeTokenSetup({
      underlying: AaveV3EthereumAssets.GHO_UNDERLYING,
      cooldown: DEFAULT_COOLDOWN,
      unstakeWindow: DEFAULT_UNSTAKE_WINDOW,
      suffix: 'v1'
    });

    IRewardsStructs.RewardSetupConfig[]
      memory stkGhoRewards = new IRewardsStructs.RewardSetupConfig[](1);

    stkGhoRewards[0] = IRewardsStructs.RewardSetupConfig({
      reward: AaveV3EthereumAssets.GHO_UNDERLYING,
      rewardPayer: address(AaveV3Ethereum.COLLECTOR),
      maxEmissionPerSecond: GHO_MAX_EMISSION_PER_SECOND,
      distributionEnd: block.timestamp + DISTRIBUTION_DURATION
    });

    tokensCreation[3] = IStructs.TokenSetup({
      stakeSetup: stkGhoSetup,
      targetLiquidity: GHO_TARGET_LIQUIDITY,
      rewardConfigs: stkGhoRewards,
      reserve: AaveV3EthereumAssets.GHO_UNDERLYING,
      liquidationFee: 0,
      umbrellaStakeUnderlyingOracle: AaveV3EthereumAssets.GHO_ORACLE,
      deficitOffsetIncrease: DEFICIT_OFFSET_GHO
    });

    return tokensCreation;
  }

  function _postExecute() internal override {
    // Give roles
    /////////////////////////////////////////////////////////////////////////////////////////

    // Give role to limited reward updates inside `RewardsController` for `FinancialCommittee`
    // `FinancialCommittee` is the payload manager inside `PERMISSIONED_PAYLOADS_CONTROLLER`
    AccessControlUpgradeable(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).grantRole(
      REWARDS_ADMIN_ROLE,
      UmbrellaEthereum.PERMISSIONED_PAYLOADS_CONTROLLER_EXECUTOR
    );

    // Give role to cover deficit offset for `FinancialCommittee`
    // `FinancialCommittee` has the `FINANCE_COMMITTEE_ROLE` role inside `DeficitOffsetClinicSteward`
    AccessControlUpgradeable(address(UmbrellaEthereum.UMBRELLA)).grantRole(
      COVERAGE_MANAGER_ROLE,
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    );

    // Give allowance to `DeficitOffsetClinicSteward`
    // So `deficitOffset` could be closed using `Collector` funds
    /////////////////////////////////////////////////////////////////////////////////////////

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN),
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD,
      DEFICIT_OFFSET_USDC
    );

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN),
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD,
      DEFICIT_OFFSET_USDT
    );

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN),
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD,
      DEFICIT_OFFSET_WETH
    );

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING),
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD,
      DEFICIT_OFFSET_GHO
    );

    // Give allowance to `RewardController` for the next 180 days of rewards
    /////////////////////////////////////////////////////////////////////////////////////////

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN),
      UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER,
      USDC_MAX_EMISSION_PER_SECOND * 180 days
    );

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN),
      UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER,
      USDT_MAX_EMISSION_PER_SECOND * 180 days
    );

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN),
      UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER,
      WETH_MAX_EMISSION_PER_SECOND * 180 days
    );

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING),
      UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER,
      GHO_MAX_EMISSION_PER_SECOND * 180 days
    );

    // Cover audits expenses
    /////////////////////////////////////////////////////////////////////////////////////////

    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN),
      BGD_LABS_MULTISIG,
      TOTAL_COST_OF_AUDITS
    );
  }
}
