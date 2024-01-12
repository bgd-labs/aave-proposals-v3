---
title: "Aave v3 Polygon ZkEvm activation"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-aave-v3-deployment-on-zkevm-l2/12615"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **USDC**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (USDC)                  |                                    525,000 |
| Borrow Cap (USDC)                  |                                    500,000 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                       77 % |
| LT                                 |                                       80 % |
| Liquidation Bonus                  |                                        5 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       10 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                        6 % |
| Variable Slope 2                   |                                       80 % |
| Uoptimal                           |                                       90 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        6 % |
| Stable Slope2                      |                                       80 % |
| Base Stable Rate Offset            |                                        1 % |
| Stable Rate Excess Offset          |                                        8 % |
| Optimal Stable To Total Debt Ratio |                                       20 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                    ENABLED |
| Oracle                             | 0x0167D934CB7240e65c35e347F00Ca5b12567523a |

,The table below illustrates the configured risk parameters for **WETH**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (WETH)                  |                                        350 |
| Borrow Cap (WETH)                  |                                        280 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                       75 % |
| LT                                 |                                       78 % |
| Liquidation Bonus                  |                                        5 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       15 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                      3.3 % |
| Variable Slope 2                   |                                       80 % |
| Uoptimal                           |                                       80 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                      3.3 % |
| Stable Slope2                      |                                       80 % |
| Base Stable Rate Offset            |                                        2 % |
| Stable Rate Excess Offset          |                                        8 % |
| Optimal Stable To Total Debt Ratio |                                       20 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0x97d9F9A00dEE0004BE8ca0A8fa374d486567eE2D |

,The table below illustrates the configured risk parameters for **MATIC**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (MATIC)                 |                                    700,000 |
| Borrow Cap (MATIC)                 |                                    525,000 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                       68 % |
| LT                                 |                                       73 % |
| Liquidation Bonus                  |                                      7.5 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       20 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                        5 % |
| Variable Slope 2                   |                                      100 % |
| Uoptimal                           |                                       75 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        5 % |
| Stable Slope2                      |                                      100 % |
| Base Stable Rate Offset            |                                        2 % |
| Stable Rate Excess Offset          |                                        8 % |
| Optimal Stable To Total Debt Ratio |                                       20 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0x7C85dD6eBc1d318E909F22d51e756Cf066643341 |

## References

- Implementation: [AaveV3PolygonZkEvm](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240112_AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation/AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation_20240112.sol)
- Tests: [AaveV3PolygonZkEvm](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240112_AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation/AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation_20240112.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x8fd34012029bec536f779b7bf46813beb57f42705b24acaf239e42353ddf7b8c)
- [Discussion](https://governance.aave.com/t/arfc-aave-v3-deployment-on-zkevm-l2/12615)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
