---
title: "USDS borrow rate update on Core and Prime Instances"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-usds-borrow-rate-update-on-core-and-prime-instances/19901"
---

## Simple Summary

This proposal recommends increasing the USDS Core Instance Base Rate (currently at 6.25%) and Slope1 (currently at 6.25%) on Prime Market.

Raising USDS borrowing rates ensures the SSR remains competitive, attracting demand while discouraging excessive borrowing at unsustainable levels.

We also propose pausing sUSDe operations in the Prime instance to focus on scaling USDS liquidity in the Core Market, where there is significant demand.

This is a Direct to AIP Proposal.

## Motivation

Recent observations in the market have highlighted issues stemming from **sUSDe** in the Prime instance:

1. **sUSDe’s Impact on USDS Borrow Rate**:The presence of sUSDe is driving up the USDS Borrow Rate, creating pressure in the Prime Instance. The high rates pose a risk of cascading rebalances, particularly:

- wstETH collateral migrates to Spark for USDS liquidity.
- ezETH loopers exit due to spiking wstETH borrow rates.
- Resulting in a significant outflow of AUM from the market.

2. **Mismatch Between Liquidity and Risk**:

- The liquidity needs of sUSDe are not being met effectively, leading to imbalance.
- The market is unable to accommodate the current sUSDe scale without affecting overall stability.

While at same time there is substantial **Untapped Demand in the Core Instance**:

- The substantial demand in the Core Instance presents an opportunity to scale USDS aggressively while mitigating risk.

## Specification

### 1. **Increase USDS Base Rate 3% on Core Instance and 3% Slope1 on Prime Instance**

- Adjusting the borrow rate is a necessary step to manage the borrowing cost dynamics and balance the market risk posed by sUSDe.
- This adjustment should be implemented across both the Prime and Core Instances.

| **Parameter**  | **Current** | **Proposed** | **Change** |
| -------------- | ----------- | ------------ | ---------- |
| _Prime Market_ |             |              |            |
| Base           | 0.75%       | 0.75%        | No change  |
| Slope1         | 6.25%       | 9.25%        | +3%        |
| Slope2         | 75%         | 75%          | No change  |
| _Core Market_  |             |              |            |
| Base           | 6.25%       | 9.25%        | +3%        |
| Slope1         | 0.75%       | 0.75%        | No change  |
| Slope2         | 75%         | 75%          | No change  |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/e2930ccf4ebec53708aec1b09e430430c701a24e/src/20241122_Multi_USDSBorrowRateUpdateOnCoreAndPrimeInstances/AaveV3Ethereum_USDSBorrowRateUpdateOnCoreAndPrimeInstances_20241122.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/e2930ccf4ebec53708aec1b09e430430c701a24e/src/20241122_Multi_USDSBorrowRateUpdateOnCoreAndPrimeInstances/AaveV3EthereumLido_USDSBorrowRateUpdateOnCoreAndPrimeInstances_20241122.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/e2930ccf4ebec53708aec1b09e430430c701a24e/src/20241122_Multi_USDSBorrowRateUpdateOnCoreAndPrimeInstances/AaveV3Ethereum_USDSBorrowRateUpdateOnCoreAndPrimeInstances_20241122.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/e2930ccf4ebec53708aec1b09e430430c701a24e/src/20241122_Multi_USDSBorrowRateUpdateOnCoreAndPrimeInstances/AaveV3EthereumLido_USDSBorrowRateUpdateOnCoreAndPrimeInstances_20241122.t.sol)
- Snapshot : Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-usds-borrow-rate-update-on-core-and-prime-instances/19901)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
