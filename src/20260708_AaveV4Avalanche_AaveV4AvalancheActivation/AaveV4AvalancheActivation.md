---
title: "Aave V4 Avalanche Activation"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/arfc-deploy-aave-v4-on-avalanche/25165"
snapshot: "https://snapshot.org/#/aavedao.eth/proposal/0xe5c4a9387ce1096075f2ad5c3840a915ef730a1ad9180118be8bd4b6f10dacfe"
---

## Simple Summary

This payload proposes activating Aave Protocol V4 on Avalanche Network.

## Motivation

Aave V4’s next growth phase involves expanding into networks with existing DeFi demand, active Aave usage, and a credible path to protocol revenue. The initial deployment on Ethereum Mainnet validated the Hub and Spoke model in a production environment, making this expansion the logical next step for V4.

Aave Labs proposes deploying Aave V4 on Avalanche, beginning with one Liquidity Hub and three Spokes. A dedicated real-world asset (RWA) hub will be launched in a later phase.

Avalanche has been a supported Aave V3 deployment since 2022, accumulating over five years of production operation. Its track record across liquidations, oracle performance, and market stress events within the Aave ecosystem establishes Avalanche as a proven network for Aave deployments. The existing market brings established distribution, active liquidity, and a mature user base, materially reducing execution risk for the activation of Aave V4 on Avalanche.

## Specification

### Market Design

The recommended launch configuration consists of one hub and three spokes. The Core Hub serves as the sole borrowing environment, structured around three spokes targeting a distinct collateral type, user intent, and risk profile:

image
image
1280×785 67.8 KB
Source: LlamaRisk

Main Spoke: The Main Spoke is the general-purpose lending venue and is expected to host the majority of liquidity within the deployment. It accepts the broadest collateral set and the broadest borrowable set in the deployment, where WAVAX, BTC.b, USDC, USDT, and WETH.e are collateral against which users can borrow stablecoins, WAVAX, BTC.b, and WETH.e. In the future, the Main Spoke can provide credit lines to specialized Hubs, such as an RWA Hub, allowing them to access its liquidity while preserving separate risk profiles.
AVAX Correlated Spoke: This spoke is dedicated to the AVAX LST looping environment, with sAVAX as collateral and WAVAX as the only borrowable asset. This design isolates looping risk and allows spoke-specific add/draw caps.
Forex Spoke: It supports trading and hedging across fiat-pegged stablecoins, with EURC, USDC, and USDT as collateral, which can be borrowed against each other. Due to limited secondary market liquidity for EURC, conservative caps have been set.
In addition to above three spokes a tokenized spoke will also be created which is a supply-only integration layer that tokenizes deposits of the Hub’s borrowable assets (WAVAX, BTC.b, USDC, USDT, WETH.e, and EURC) into composable positions for external vaults, aggregators, and strategies, without enabling borrowing or introducing additional collateral risk to the Core Hub.

### Dynamic Liquidation Bonus Configuration

V4 introduces a dynamic liquidation bonus that increases linearly as the health factor decreases, in contrast to V3’s static bonus. Two spoke-wide parameters shape the bonus curve. The targetHealthFactor is the HF to which a borrower is restored after liquidation; liquidators repay only enough debt to reach this value under normal circumstances. The healthFactorForMaxBonus is the HF at which the maximum liquidation bonus becomes active, with the bonus ramping linearly between HF of 1.0 and this value. The liquidationBonusFactor is a scaling parameter that controls both the steepness of the bonus ramp and, together with the target multiplier, the derived maxLiquidationBonus, ensuring that at an HF of 1.0, the liquidation bonus remains consistent with the corresponding V3 value.

For correlated-asset spokes (AVAX Correlated and Forex), liquidationBonusFactor is set to 1.0 because the health factor (HF) range between liquidation eligibility and bad debt is already narrow. Any reduction below this level would steepen the bonus curve and increase losses for leveraged correlated positions.

For volatile spokes (Main), healthFactorForMaxBonus is set to 0.9, ensuring that maximum liquidator incentives are active well before positions approach bad-debt levels. To maintain incentive continuity with V3, maxLiquidationBonus on the Main Spoke is set to 1.11 times its V3 value. This keeps the liquidation bonus at HF = 1.0 aligned with V3 while allowing higher incentives as positions deteriorate further.

| Chain     | Hub      | Spoke                 | Liquidation Bonus Factor | Target Health Factor | Health Factor For Max Bonus |
| --------- | -------- | --------------------- | ------------------------ | -------------------- | --------------------------- |
| Avalanche | Core Hub | Main Spoke            | 90.00%                   | 1.2400               | 0.90                        |
| Avalanche | Core Hub | AVAX Correlated Spoke | 100.00%                  | 1.0350               | 0.99                        |
| Avalanche | Core Hub | Forex Spoke           | 100.00%                  | 1.0442               | 0.99                        |

### V4 Spoke Parameters

The liquidation protocol fee is proposed to be set at 10% across all assets, aligning with the configuration used for the majority of assets on Aave V3.

| Chain     | Hub      | Spoke                 | Reserve | Collateral Factor | Max Liquidation Bonus | Borrowable | Collateral Risk | Liquidation Fee |
| --------- | -------- | --------------------- | ------- | ----------------- | --------------------- | ---------- | --------------- | --------------- |
| Avalanche | Core Hub | Main Spoke            | WAVAX   | 73.00%            | 10.00%                | TRUE       | 0               | 10.00%          |
| Avalanche | Core Hub | Main Spoke            | BTC.b   | 75.00%            | 7.22%                 | TRUE       | 0               | 10.00%          |
| Avalanche | Core Hub | Main Spoke            | USDC    | 78.00%            | 5.55%                 | TRUE       | 0               | 10.00%          |
| Avalanche | Core Hub | Main Spoke            | USDT    | 78.00%            | 5.55%                 | TRUE       | 0               | 10.00%          |
| Avalanche | Core Hub | Main Spoke            | WETH.e  | 83.00%            | 5.55%                 | TRUE       | 0               | 10.00%          |
| Avalanche | Core Hub | Main Spoke            | EURC    | 0.00%             | -                     | TRUE       | -               | -               |
| Avalanche | Core Hub | AVAX Correlated Spoke | sAVAX   | 95.00%            | 1.00%                 | FALSE      | 0               | 10.00%          |
| Avalanche | Core Hub | AVAX Correlated Spoke | WAVAX   | 0.00%             | -                     | TRUE       | -               | -               |
| Avalanche | Core Hub | Forex Spoke           | EURC    | 90.00%            | 2.00%                 | TRUE       | 0               | 10.00%          |
| Avalanche | Core Hub | Forex Spoke           | USDC    | 90.00%            | 2.00%                 | TRUE       | 0               | 10.00%          |
| Avalanche | Core Hub | Forex Spoke           | USDT    | 90.00%            | 2.00%                 | TRUE       | 0               | 10.00%          |

### Add and Draw Caps

Add and draw caps have been set, keeping in mind the limited liquidity available on Avalanche, with the specifications reflecting the hub-and-spoke structure of Aave V4 and the distinct risk profiles of each spoke.

| Chain     | Hub      | Spoke                       | Reserve | Add Cap   | Draw Cap  |
| --------- | -------- | --------------------------- | ------- | --------- | --------- |
| Avalanche | Core Hub | Main Spoke                  | WAVAX   | 500,000   | 50,000    |
| Avalanche | Core Hub | Main Spoke                  | BTC.b   | 100       | 10        |
| Avalanche | Core Hub | Main Spoke                  | USDC    | 5,000,000 | 5,000,000 |
| Avalanche | Core Hub | Main Spoke                  | USDT    | 5,000,000 | 5,000,000 |
| Avalanche | Core Hub | Main Spoke                  | WETH.e  | 3,000     | 300       |
| Avalanche | Core Hub | Main Spoke                  | EURC    | 500,000   | 400,000   |
| Avalanche | Core Hub | AVAX Correlated Spoke       | sAVAX   | 200,000   | 0         |
| Avalanche | Core Hub | AVAX Correlated Spoke       | WAVAX   | 0         | 250,000   |
| Avalanche | Core Hub | Forex Spoke                 | EURC    | 300,000   | 400,000   |
| Avalanche | Core Hub | Forex Spoke                 | USDC    | 200,000   | 150,000   |
| Avalanche | Core Hub | Forex Spoke                 | USDT    | 200,000   | 150,000   |
| Avalanche | Core Hub | Core Tokenized WAVAX Spoke  | WAVAX   | 150,000   | 0         |
| Avalanche | Core Hub | Core Tokenized BTC.b Spoke  | BTC.b   | 20        | 0         |
| Avalanche | Core Hub | Core Tokenized USDC Spoke   | USDC    | 1,500,000 | 0         |
| Avalanche | Core Hub | Core Tokenized USDT Spoke   | USDT    | 1,500,000 | 0         |
| Avalanche | Core Hub | Core Tokenized WETH.e Spoke | WETH.e  | 600       | 0         |
| Avalanche | Core Hub | Core Tokenized EURC Spoke   | EURC    | 150,000   | 0         |

Tokenized Spokes serve as the standard entry point for integrators, vaults, aggregators, and other strategies routing liquidity into Aave V4 markets. They are supply-only and accept deposits exclusively in each hub’s primary borrowable assets, ensuring a simple, composable tokenized representation.

### Interest Rate Curves

The IRM parameters apply to an asset across all spokes within that hub. The parameters follow the same two-slope utilization curve used in V3, defined by a base variable borrow rate, slope below the optimal usage ratio (Slope 1), slope above it (Slope 2), and the optimal usage ratio itself (Uoptimal). The Liquidity Fee is the fraction of borrower interest captured by the protocol treasury, equivalent to the reserve factor in V3. The goal of the initial configuration is to keep the setup as similar as possible to the one currently used in Aave V3.

| Chain     | Hub      | Reserve | Base  | Slope 1 | Slope 2 | Uoptimal | Liquidity Fee |
| --------- | -------- | ------- | ----- | ------- | ------- | -------- | ------------- |
| Avalanche | Core Hub | WAVAX   | 1.00% | 4.00%   | 144.28% | 65.00%   | 20.00%        |
| Avalanche | Core Hub | BTC.b   | 0.00% | 4.00%   | 80.00%  | 80.00%   | 25.00%        |
| Avalanche | Core Hub | USDC    | 0.00% | 4.00%   | 10.00%  | 90.00%   | 10.00%        |
| Avalanche | Core Hub | USDT    | 0.00% | 4.00%   | 10.00%  | 90.00%   | 10.00%        |
| Avalanche | Core Hub | WETH.e  | 0.00% | 2.50%   | 8.00%   | 90.00%   | 15.00%        |
| Avalanche | Core Hub | EURC    | 0.00% | 5.50%   | 50.00%  | 90.00%   | 10.00%        |

## References

- Implementation: [AaveV4Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260708_AaveV4Avalanche_AaveV4AvalancheActivation/AaveV4Avalanche_AaveV4AvalancheActivation_20260708.sol)
- Tests: [AaveV4Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260708_AaveV4Avalanche_AaveV4AvalancheActivation/AaveV4Avalanche_AaveV4AvalancheActivation_20260708.t.sol)
- [Snapshot](https://snapshot.org/#/aavedao.eth/proposal/0xe5c4a9387ce1096075f2ad5c3840a915ef730a1ad9180118be8bd4b6f10dacfe)
- [Discussion](https://governance.aave.com/t/arfc-deploy-aave-v4-on-avalanche/25165)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
