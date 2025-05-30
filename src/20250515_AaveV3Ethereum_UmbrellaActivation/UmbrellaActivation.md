---
title: "UmbrellaActivation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-aave-umbrella-activation/21521"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xbe792a1db33cd7803e23810553e5a6a728c3ac15827ad2652aa6de1858fa5596"
---

## Simple Summary

This payload activates the `Umbrella` system, introducing new staking tokens tailored for Aave’s risk management needs, along with their reward and slashing configurations. It also includes adjustments to the legacy `Safety Module` to ensure a smooth transition and continued protocol coverage.

## Motivation

The `Umbrella` project was developed to improve capital efficiency and enhance the protocol’s ability to cover potential shortfalls in the event of a bad debt. It represents a significant evolution of the existing `Safety Module`, offering broader coverage, improved fund utilization, and greater operational flexibility — ultimately serving as its full replacement.

## Specification

For simplicity, the payload is divided into 3 parts.

1. **Umbrella Activation**
2. **Legacy stk tokens adjustment**
3. **Robot activation**

### 1. **Umbrella Activation**

This payload handles the deployment and configuration of the new Umbrella system for deficit elimination and staking.

#### Contract registration

- Registers the `Umbrella` contract in the `POOL_ADDRESSES_PROVIDER`.
  - Enables the `Umbrella` to be used for reserve deficit elimination.

#### Reserve Deficit Elimination

- Eliminates existing reserve deficits for the following assets: USDC, USDT, WETH and GHO.
  - Calculates current reserve deficits amounts.
  - Transfers the required amounts from the `Collector` to the `Executor` contract.
  - Executes deficit elimination using the transferred funds.

#### Stk Tokens Creation

- Creates `stk` tokens for the above assets:
  - `stkwaUSDC.V1`, `stkwaUSDT.V1`, `stkwaWETH.V1` are backed by their respective stata tokens.
  - `stkGHO.V1` is backed by the GHO underlying token.

#### Reward Configuration

- Sets up reward emissions for each `stk` token:
  - `stkwaUSDC.V1` -> `aUSDC`, `stkwaUSDT.V1` -> `aUSDT`, `stkwaWETH.V1` -> `aWETH`
  - `stkGHO.V1` -> `GHO`
  - For each:
    - `maxEmissionPerSecond` and `targetLiquidity` are configured using values from the governance discussion, check the [summary table](#summary-table) for more details
    - `distributionEnd` is set to 1 year from the execution.
    - `rewardPayer` is st to the `Collector`.

#### Slashing Configuration

- Sets up `SlashingConfig` for each `stk` token:
  - `reserve`: Corresponds to the base token (e.g., `USDT` for `stkwaUSDT.V1`, `GHO` for `stkGHO.V1`).
  - `liquidationFee`: Set to zero for all stk tokens.
  - `deficitOffset`: Values sourced from the governance discussion.
  - `umbrellaStakeUnderlyingOracle`:
    - For stata-based tokens: the stata token itself.
    - For `GHO`: a `GHO` oracle with a mocked price.

#### Role and Permission Management

- Grants `REWARDS_ADMIN_ROLE` in `RewardsController` to `PERMISSIONED_PAYLOADS_CONTROLLER_EXECUTOR`:
  - Allows the `FinancialCommittee` to limited modification of rewards without requiring governance proposals.
- Grants `COVERAGE_MANAGER_ROLE` to `DEFICIT_OFFSET_CLINIC_STEWARD`.
  - Allows the `FinancialCommittee` to eliminate `deficitOffset` using `Collector` funds directly.

#### Allowances

- `Collector` grants allowance to:
  - `DEFICIT_OFFSET_CLINIC_STEWARD` - for deficit offset amounts as per forum.
  - `RewardsController` - to fund reward emissions for 180 days post-execution.

#### Coverage of audit expenses

- `Collector` transfers 249_000 `aUSDT` to the BGD Labs to cover external security reviews of the entire `Umbrella` system.

#### Summary Table

| Staked asset | Covered asset | Target Liquidity\* | Max emission | Cooldown / Unstake window | Deficit offset |
| :----------: | :-----------: | :----------------: | :----------: | :-----------------------: | :------------: |
|    waUSDC    |     USDC      |     66_000_000     |  2_330_000   |     20 days / 2 days      |    100_000     |
|    waUSDT    |     USDT      |    104_000_000     |  3_670_000   |     20 days / 2 days      |    100_000     |
|    waWETH    |     WETH      |       25_000       |     550      |     20 days / 2 days      |       50       |
|     GHO      |      GHO      |     12_000_000     |  1_200_000   |     20 days / 2 days      |    100_000     |

- Target Liquidity is denominated in the contracts in wrapped aTokens, increasing over time in exchange rate. That means the Target Liquidity itself will grow slightly over time and rewards will need to be periodically adjusted. For the sake of simplicity, the number on the table is in equivalent terms of underlying (USDC, USDT, WETH), not in wrapped aTokens.

### 2. **Legacy stk tokens adjustment**

This payload introduces updates to the legacy Safety Module staking tokens to align with the activation of the new Umbrella system.

#### Emission Reductions

- Reduces (`AAVE`/day) reward emissions for the following tokens:
  - `stkGHO`: 100 -> 0
  - `stkAAVE`: 360 -> 315
  - `stkBPT`: 240 -> 216

#### Slashing Parameter Updates

- Lowers the `maxSlashablePercentage` for the legacy stk tokens:
  - `stkGHO`: 99.00% -> 0%
  - `stkAAVE`: 30.00% -> 20.00%
  - `stkBPT`: 30.00% -> 20.00%

#### stkGHO Deactivation

- Fully stops reward emissions for `stkGho`
- Reduces `cooldown` period to 0, enabling immediate unstaking

#### Summary Table

| Staked asset | Rewards/day |    Rewards/year    | Slashing eligibility |
| :----------: | :---------: | :----------------: | :------------------: |
|     AAVE     | 360 -> 315  | 131_400 -> 114_975 |      30% -> 20%      |
|     BPT      | 240 -> 216  |  87_600 -> 78_840  |      30% -> 20%      |
|     GHO      |  100 -> 0   |    36_500 -> 0     |      100% -> 0%      |

### 3. **Robot activation**

This payload handles the `SlashingRobot` and `UmbrellaPPCRobot` activation process.

- Withdraws 400 `LINK` from `AaveV3` on Ethereum Network.
- Registers `SlashingRobot` and `UmbrellaPPCRobot` in the `AAVE_CL_ROBOT_OPERATOR`.
  - Sets `gasLimit` to `5_000_000`.
  - Funds with all tokens withdrawn.

## Audit Summary of the Aave Umbrella Contracts

The new contracts of the Aave Umbrella system were audited by four independent auditors: MixBytes, Stermi, Certora, and Ackee. The audited and deployed version of the contracts is publicly accessible at the following link: https://github.com/aave-dao/aave-umbrella/tree/62f3850816b257087e92f41a7f37a698f00fa96e.

Subsequent changes made in this GitHub repository (aave-dao/aave-umbrella) pertain either to auxiliary contracts that do not affect the core functionality of the Umbrella system or to interface improvements aimed at enhancing integration with external systems. These updates did not introduce any changes to the deployed core contracts.

The audit reports provided by each auditor can be found at the following links:

- [MixBytes](https://github.com/aave-dao/aave-umbrella/tree/main/audits/MixBytes)
- [Stermi](https://github.com/aave-dao/aave-umbrella/tree/main/audits/Stermi)
- [Certora](https://github.com/aave-dao/aave-umbrella/tree/main/audits/Certora)
- [Ackee](https://github.com/aave-dao/aave-umbrella/tree/main/audits/Ackee)

## References

- Implementation: [AaveV3Ethereum_UmbrellaActivation](https://github.com/bgd-labs/aave-proposals-v3/blob/568d9fec9ed22e7d2b97991e9aacfd8f7dfe19df/src/20250515_AaveV3Ethereum_UmbrellaActivation/AaveV3Ethereum_UmbrellaActivation_20250515.sol), [AaveV3Ethereum_SafetyModuleRewardsDecrease](https://github.com/bgd-labs/aave-proposals-v3/blob/568d9fec9ed22e7d2b97991e9aacfd8f7dfe19df/src/20250515_AaveV3Ethereum_UmbrellaActivation/AaveV3Ethereum_SafetyModuleRewardsDecrease_2025.sol), [AaveV3Ethereum_RobotActivation](https://github.com/bgd-labs/aave-proposals-v3/blob/568d9fec9ed22e7d2b97991e9aacfd8f7dfe19df/src/20250515_AaveV3Ethereum_UmbrellaActivation/AaveV3Ethereum_RobotActivation_20250515.sol)
- Tests: [AaveV3Ethereum_UmbrellaActivation](https://github.com/bgd-labs/aave-proposals-v3/blob/568d9fec9ed22e7d2b97991e9aacfd8f7dfe19df/src/20250515_AaveV3Ethereum_UmbrellaActivation/AaveV3Ethereum_UmbrellaActivation_20250515.t.sol), [AaveV3Ethereum_SafetyModuleRewardsDecrease](https://github.com/bgd-labs/aave-proposals-v3/blob/568d9fec9ed22e7d2b97991e9aacfd8f7dfe19df/src/20250515_AaveV3Ethereum_UmbrellaActivation/AaveV3Ethereum_SafetyModuleRewardsDecrease_2025.t.sol), [AaveV3Ethereum_RobotActivation](https://github.com/bgd-labs/aave-proposals-v3/blob/568d9fec9ed22e7d2b97991e9aacfd8f7dfe19df/src/20250515_AaveV3Ethereum_UmbrellaActivation/AaveV3Ethereum_RobotActivation_20250515.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xbe792a1db33cd7803e23810553e5a6a728c3ac15827ad2652aa6de1858fa5596)
- [Discussion](https://governance.aave.com/t/arfc-aave-umbrella-activation/21521)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
