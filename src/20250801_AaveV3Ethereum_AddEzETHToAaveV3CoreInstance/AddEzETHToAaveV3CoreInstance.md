---
title: "Add ezETH to Aave v3 Core Instance"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-add-ezeth-to-aave-v3-core-instance/22732"
snapshot: Direct-to-AIP
---

### Summary

This publication proposes onboarding ezETH as collateral to the Aave V3 Core Instance.

### Motivation

With the recent onboarding of weETH to the Prime instance, the wstETH Borrow Rate has increased to above 0.50% at times and adversely affected the yield strategies utilizing wstETH debt. Whilst rsETH users can migrate to Core, ezETH users are not yet able to migrate positions and optimize for the lowest cost of capital.

Upon listing ezETH on Core and reducing the wstETH borrow rate, users are expected to arbitrage the wstETH borrow rate across the markets, enabling weETH to continue growing on Prime. Given the yield-maximizing nature of the strategies, a degree of size needs to be able to move freely between the markets, which adding ezETH to Core enables.

The Renzo team has expressed specifically that investors are requesting access to USDC and USDT on the Core instance, and only on Ethereum. To support this request, an ezETH stablecoin eMode has been proposed below.

This proposal will be under Direct to AIP, as ezETH is already listed on other Aave instances.

### Specification

**ezETH Ethereum Address:** `0xbf5495efe5db9ce00f80364c8b423567e58d2110`

#### General Parameters

| Parameter                              | Value             |
| :------------------------------------- | :---------------- |
| **Chain (instance)**                   | Ethereum (Core)   |
| **Isolation Mode**                     | No                |
| **Borrowable**                         | No                |
| **Collateral Enabled**                 | Yes               |
| **Supply Cap (ezETH)**                 | 50,000            |
| **Borrow Cap (ezETH)**                 | 0                 |
| **Debt Ceiling**                       | USD 0             |
| **LTV**                                | 0.05%             |
| **LT**                                 | 0.10%             |
| **Liquidation Bonus**                  | 7.5%              |
| **Liquidation Protocol Fee**           | 10%               |
| **Reserve Factor**                     | 15%               |
| **Base Variable Borrow Rate**          | -                 |
| **Variable Slope 1**                   | -                 |
| **Variable Slope 2**                   | -                 |
| **Uoptimal**                           | 45%               |
| **Stable Borrowing**                   | DISABLED          |
| **Stable Slope1**                      | 0%                |
| **Stable Slope2**                      | 0%                |
| **Base Stable Rate Offset**            | 0%                |
| **Stable Rate Excess Offset**          | 0%                |
| **Optimal Stable To Total Debt Ratio** | 0%                |
| **Flashloanable**                      | ENABLED           |
| **Siloed Borrowing**                   | DISABLED          |
| **Borrowable in Isolation**            | DISABLED          |
| **eMode Category**                     | ezETH/wstETH      |
| **eMode Category**                     | ezETH/stablecoins |

#### ezETH/wstETH liquid eMode

| Parameter                 | ezETH  | wstETH |
| :------------------------ | :----- | :----- |
| **Collateral**            | Yes    | No     |
| **Borrowable**            | No     | Yes    |
| **Max LTV**               | 93.00% | -      |
| **Liquidation Threshold** | 95.00% | -      |
| **Liquidation Penalty**   | 1.00%  | -      |

#### ezETH/stablecoin liquid eMode

| Parameter                 | ezETH  | USDC | USDT |
| :------------------------ | :----- | :--- | :--- |
| **Collateral**            | Yes    | No   | No   |
| **Borrowable**            | No     | Yes  | Yes  |
| **Max LTV**               | 75.00% | -    | -    |
| **Liquidation Threshold** | 78.00% | -    | -    |
| **Liquidation Penalty**   | 7.50%  | -    | -    |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250801_AaveV3Ethereum_AddEzETHToAaveV3CoreInstance/AaveV3Ethereum_AddEzETHToAaveV3CoreInstance_20250801.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250801_AaveV3Ethereum_AddEzETHToAaveV3CoreInstance/AaveV3Ethereum_AddEzETHToAaveV3CoreInstance_20250801.t.sol)
  [Snapshot](Direct-to-AIP)
- [Discussion](https://governance.aave.com/t/direct-to-aip-add-ezeth-to-aave-v3-core-instance/22732)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
