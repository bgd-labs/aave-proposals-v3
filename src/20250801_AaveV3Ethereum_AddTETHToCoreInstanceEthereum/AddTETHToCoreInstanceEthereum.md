---
title: "Add tETH to Core Instance Ethereum"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-add-teth-to-core-instance-ethereum/22594/3"
---

### Summary

This publication proposes onboarding tETH as collateral to the Aave V3 Core Instance.

### Motivation

After successfully onboard tETH to the Prime instance this publication proposes enabling tETH collateral holders to borrow stablecoins via v3.2 Liquid eModes. tETH was listed on the Prime instance on the 28th June 2025 and since then has provided over 129M of User deposit, mostly from four unique addresses, and has been a significant wstETH liquidity consumer.

Discussions with the TreeHouse team indicate there is strong demand for stablecoins. With insufficient stablecoin liquidity on Prime to support growing tETH, this publication proposes onboarding tETH to Core allow users access to stablecoin liquidity.

Subject to Risk Service providers approval, this publication propose enabling tETH users to access stablecoin liquidity on Core instance.

### Specification

The following outlines the initial tETH onboarding parameters.

**tETH Ethereum Address:** `0xd11c452fc99cf405034ee446803b6f6c1f6d5ed8`

#### General Parameters

| Parameter                          | Value                                      |
| ---------------------------------- | ------------------------------------------ |
| Chain (instance)                   | Ethereum (Core)                            |
| Isolation Mode                     | false                                      |
| Borrowable                         | DISABLED                                   |
| Collateral Enabled                 | true                                       |
| Supply Cap (tETH)                  | 10,000                                     |
| Borrow Cap (tETH)                  | 0                                          |
| Debt Ceiling                       | USD 0                                      |
| LTV                                | 0.05 %                                     |
| LT                                 | 0.10 %                                     |
| Liquidation Bonus                  | 7.5 %                                      |
| Liquidation Protocol Fee           | 10 %                                       |
| Reserve Factor                     | 15 %                                       |
| Base Variable Borrow Rate          | 0 %                                        |
| Variable Slope 1                   | 0 %                                        |
| Variable Slope 2                   | 0 %                                        |
| Uoptimal                           | 45 %                                       |
| Stable Borrowing                   | DISABLED                                   |
| Stable Slope1                      | 0 %                                        |
| Stable Slope2                      | 0 %                                        |
| Base Stable Rate Offset            | 0 %                                        |
| Stable Rate Excess Offset          | 0 %                                        |
| Optimal Stable To Total Debt Ratio | 0 %                                        |
| Flashloanable                      | ENABLED                                    |
| Siloed Borrowing                   | DISABLED                                   |
| Borrowable in Isolation            | DISABLED                                   |
| Oracle                             | 0x85968026294b8f8Fb86d6bF3Cda079f9376aD05A |

#### tETH/stablecoins liquid eMode

| Parameter             | Value      |
| --------------------- | ---------- |
| Collateral            | tETH       |
| Borrowable            | USDT, USDC |
| Max LTV               | 72.00%     |
| Liquidation Threshold | 75.00%     |
| Liquidation Penalty   | 7.50%      |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/7a68746f7f5755bffbe21967edf3ed062acf8bbc/src/20250801_AaveV3Ethereum_AddTETHToCoreInstanceEthereum/AaveV3Ethereum_AddTETHToCoreInstanceEthereum_20250801.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/7a68746f7f5755bffbe21967edf3ed062acf8bbc/src/20250801_AaveV3Ethereum_AddTETHToCoreInstanceEthereum/AaveV3Ethereum_AddTETHToCoreInstanceEthereum_20250801.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-add-teth-to-core-instance-ethereum/22594/3)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
