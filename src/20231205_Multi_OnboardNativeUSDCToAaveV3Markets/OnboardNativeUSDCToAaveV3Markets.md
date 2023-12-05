---
title: "Onboard Native USDC to Aave V3 Markets"
author: "Aave Chan Initiative and @EzR3aL"
discussions: "https://governance.aave.com/t/arfc-onboard-native-usdc-to-aave-v3-markets/15720"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **nUSDC**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (nUSDC)                 |                                 50,000,000 |
| Borrow Cap (nUSDC)                 |                                 45,000,000 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                       77 % |
| LT                                 |                                       80 % |
| Liquidation Bonus                  |                                        5 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       10 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                        5 % |
| Variable Slope 2                   |                                       60 % |
| Uoptimal                           |                                       90 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        5 % |
| Stable Slope2                      |                                       60 % |
| Base Stable Rate Offset            |                                        0 % |
| Stable Rate Excess Offset          |                                        0 % |
| Optimal Stable To Total Debt Ratio |                                        0 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0xfE4A8cc5b5B2366C1B58Bea3858e81843581b2F7 |

The table below illustrates the configured risk parameters for **nUSDC**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (nUSDC)                 |                                 25,000,000 |
| Borrow Cap (nUSDC)                 |                                 20,000,000 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                       77 % |
| LT                                 |                                       80 % |
| Liquidation Bonus                  |                                        5 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       10 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                        5 % |
| Variable Slope 2                   |                                       60 % |
| Uoptimal                           |                                       90 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        5 % |
| Stable Slope2                      |                                      300 % |
| Base Stable Rate Offset            |                                        0 % |
| Stable Rate Excess Offset          |                                        0 % |
| Optimal Stable To Total Debt Ratio |                                        0 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0x16a9FA2FDa030272Ce99B29CF780dFA30361E0f3 |

The table below illustrates the configured risk parameters for **nUSDC**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (nUSDC)                 |                                 64,000,000 |
| Borrow Cap (nUSDC)                 |                                 60,000,000 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                       77 % |
| LT                                 |                                       80 % |
| Liquidation Bonus                  |                                        5 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       10 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                        5 % |
| Variable Slope 2                   |                                       60 % |
| Uoptimal                           |                                       90 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        5 % |
| Stable Slope2                      |                                      300 % |
| Base Stable Rate Offset            |                                        0 % |
| Stable Rate Excess Offset          |                                        0 % |
| Optimal Stable To Total Debt Ratio |                                        0 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3 |

The table below illustrates the configured risk parameters for **USDC**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (USDC)                  |                                 10,000,000 |
| Borrow Cap (USDC)                  |                                  9,000,000 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                       77 % |
| LT                                 |                                       80 % |
| Liquidation Bonus                  |                                        5 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       10 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                        5 % |
| Variable Slope 2                   |                                       60 % |
| Uoptimal                           |                                       90 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        5 % |
| Stable Slope2                      |                                      300 % |
| Base Stable Rate Offset            |                                        0 % |
| Stable Rate Excess Offset          |                                        0 % |
| Optimal Stable To Total Debt Ratio |                                        0 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0x7e860098F58bBFC8648a4311b374B1D669a2bc6B |

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/AaveV3Polygon_OnboardNativeUSDCToAaveV3Markets_20231205.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/AaveV3Optimism_OnboardNativeUSDCToAaveV3Markets_20231205.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/AaveV3Base_OnboardNativeUSDCToAaveV3Markets_20231205.sol)
- Tests: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/AaveV3Polygon_OnboardNativeUSDCToAaveV3Markets_20231205.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/AaveV3Optimism_OnboardNativeUSDCToAaveV3Markets_20231205.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/AaveV3Base_OnboardNativeUSDCToAaveV3Markets_20231205.t.sol)
- [Snapshot](No snapshot for Direct-to-AIP)
- [Discussion](https://governance.aave.com/t/arfc-onboard-native-usdc-to-aave-v3-markets/15720)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
