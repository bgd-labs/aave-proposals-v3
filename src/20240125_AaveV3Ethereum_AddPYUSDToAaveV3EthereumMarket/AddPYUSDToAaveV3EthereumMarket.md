---
title: "Add PYUSD to Aave v3 Ethereum Market"
author: "JosepBove (ACI)"
discussions: "https://governance.aave.com/t/arfc-add-pyusd-to-aave-v3-ethereum-market/16218/"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **PYUSD**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (PYUSD)                 |                                 10,000,000 |
| Borrow Cap (PYUSD)                 |                                  9,000,000 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                        0 % |
| LT                                 |                                        0 % |
| Liquidation Bonus                  |                                        0 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       20 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                        6 % |
| Variable Slope 2                   |                                       80 % |
| Uoptimal                           |                                       80 % |
| Stable Borrowing                   |                                    ENABLED |
| Stable Slope1                      |                                       13 % |
| Stable Slope2                      |                                      300 % |
| Base Stable Rate Offset            |                                        3 % |
| Stable Rate Excess Offset          |                                        8 % |
| Optimal Stable To Total Debt Ratio |                                       20 % |
| Flashloanable                      |                                   DISABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0x8f1df6d7f2db73eece86a18b4381f4707b918fb1 |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240125_AaveV3Ethereum_AddPYUSDToAaveV3EthereumMarket/AaveV3Ethereum_AddPYUSDToAaveV3EthereumMarket_20240125.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240125_AaveV3Ethereum_AddPYUSDToAaveV3EthereumMarket/AaveV3Ethereum_AddPYUSDToAaveV3EthereumMarket_20240125.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb91949efad61b134b913d93b00f73ca8a122259e6d1458cf793f22a0eebfd5d5)
- [Discussion](https://governance.aave.com/t/arfc-add-pyusd-to-aave-v3-ethereum-market/16218/)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
