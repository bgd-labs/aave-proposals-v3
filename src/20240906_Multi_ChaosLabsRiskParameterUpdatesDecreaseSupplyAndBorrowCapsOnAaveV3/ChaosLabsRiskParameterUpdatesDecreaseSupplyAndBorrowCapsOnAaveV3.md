---
title: "Chaos Labs Risk Parameter Updates - Decrease Supply and Borrow Caps on Aave V3 "
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-decrease-supply-and-borrow-caps-on-aave-v3-08-28-2024/18793"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x1ea388307b70d30c040f63e8a09d49276c5c8c9ef2fd809809f253654e5f5f06"
---

## Simple Summary

Decrease supply and borrow caps for underutilized stablecoins on Aave V3.

## Motivation

As part of our ongoing strategy to optimize risk management on Aave, this proposal aims to address the low utilization of certain stablecoins by significantly reducing their supply cap and borrow cap values.

We recommend reducing the caps for various stablecoins that have consistently shown low supply and borrow demand over an extended period. All targeted stablecoins have demonstrated an average supply and borrow cap utilization below 15% for the last month. By keeping tighter caps relative to current demand, we aim to protect the protocol from potential risks associated with abnormal or unexpected events. These risks include significant stablecoin depegging and major hacks, which could result in an unexpected surge of risk in the protocol.

Should demand for these stablecoins increase, we can adjust the caps accordingly based on our established supply and borrow cap methodology.

This approach seeks to enhance the protocol’s resilience and stability in fluctuating market conditions, protecting the interests of Aave users and stakeholders.

### Notable Low Utilization Stablecoins (crvUSD, LUSD)

There is currently low demand and utilization for crvUSD and LUSD across multiple Aave markets, highlighting a need for reassessment of borrow caps to match the reduced activity:

- crvUSD on Ethereum has a current supply utilization of only 0.85%, which saw spikes up to only 4% in the last six months.
- LUSD on Optimism also continues to experience low utilization rates, with just 7.83% supply utilization.

### Ethena sUSDe

The supply utilization of Ethena sUSDe spiked to 4% during the listing and later stabilized around 1%. Maintaining a supply cap so high exposes the protocol to unnecessary risk.

### Highly Liquid Stablecoins (DAI, USDC)

While DAI on AAVE V3 Optimism and USDC on AAVE V3 BNB Chain are highly liquid safe assets, the high supply cap causes the markets to be underutilized.

## Specification

The target recommendations are calculated as twice the highest demand observed over the past six months or as 75% of the on-chain supply, whichever is lower. We suggest lowering the supply and borrow caps for the following assets, as outlined below.

| Market   | Asset  | Current Supply Cap | Current Supply Utilization | Recommended Supply Cap | Current Borrow Cap | Current Borrow Utilization | Recommended Borrow Cap |
| -------- | ------ | ------------------ | -------------------------- | ---------------------- | ------------------ | -------------------------- | ---------------------- |
| Ethereum | crvUSD | 60,000,000         | 0.85%                      | 5,000,000              | 50,000,000         | 0.80%                      | 2,500,000              |
| Optimism | LUSD   | 3,000,000          | 7.83%                      | 2,000,000              | 1,210,000          | 11.33%                     | 500,000                |
| Ethereum | sUSDe  | 85,000,000         | 1.14%                      | 4,000,000              | -                  | -                          | -                      |
| Optimism | DAI    | 25,000,000         | 12.17%                     | 10,000,000             | 16,000,000         | 17.00%                     | 7,000,000              |
| BNB      | USDC   | 50,000,000         | 6.02%                      | 15,000,000             | 45,000,000         | 5.39%                      | 10,000,000             |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240906_Multi_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3/AaveV3Ethereum_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240906_Multi_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3/AaveV3Optimism_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240906_Multi_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3/AaveV3BNB_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240906_Multi_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3/AaveV3Ethereum_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240906_Multi_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3/AaveV3Optimism_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240906_Multi_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3/AaveV3BNB_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x1ea388307b70d30c040f63e8a09d49276c5c8c9ef2fd809809f253654e5f5f06)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-decrease-supply-and-borrow-caps-on-aave-v3-08-28-2024/18793)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
