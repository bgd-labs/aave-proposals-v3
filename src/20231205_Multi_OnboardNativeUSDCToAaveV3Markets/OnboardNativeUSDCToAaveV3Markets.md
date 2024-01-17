---
title: "Onboard Native USDC to Aave V3 Markets"
author: "Aave Chan Initiative and @EzR3aL"
discussions: "https://governance.aave.com/t/arfc-onboard-native-usdc-to-aave-v3-markets/15720"
---

## Simple Summary

There are currently multiple proposals in discussion to onboard native USDC to the Aave v3 markets where it is currently not listed. This meta-proposal will onboard native USDC into the Aave V3 pools on Base, OP Mainnet and Polygon PoS.

## Motivation

With the evolution of L2 networks, adopting native USDC versions becomes vital for efficiency. This proposal seeks a balanced transition from USDC.e to native USDC on all Aave v3 pools where native USDC is not already onboarded. TEMP CHECK proposals and some ARFC proposals have already been created on the forum, this proposal aims to combine these into a single meta-proposal for voting and execution to reduce governance overhead and speed up the onboarding process.

You can see the existing proposals on the forum below.

TEMP CHECK forum post stage:

- [Base](https://governance.aave.com/t/temp-check-add-native-usdc-to-aave-v3-base-market/15655)
- [Polygon PoS ](https://governance.aave.com/t/temp-check-add-native-usdc-to-aave-v3-polygon-market/15659)

ARFC forum post stage:

- [OP Mainnet ](https://governance.aave.com/t/arfc-onboard-native-usdc-to-aave-v3-optimism-market/15463)

To streamline the process, we propose moving the Base and Polygon PoS native USDC onboarding proposals straight to ARFC, then combine all three ARFC proposals into a single AIP.
This proposal also include similar change for USDC on Arbitrum.

Note that as part of the risk parameter harmonization, the liquidation threshold for some USDC.e markets will decrease. Risk managers gave their feedback on the matter accordingly.

Finaly, native USDC on base won't get added to E-Mode as it doesn't exist yet for this market.

## Specification

### Assets listing

The table below illustrates the configured risk parameters for **USDC** on Polygon POS

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                      false |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (USDC)                  |                                 50,000,000 |
| Borrow Cap (USDC)                  |                                 45,000,000 |
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

The table below illustrates the configured risk parameters for **USDC** on base

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                      false |
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

### Native USDC modification

The following changes will be implemented for the native version of USDC:

**Optimism:**

- **LTV:**
  - USDC: Decrease to 77% to match the others aave markets
- **LT:**
  - USDC: Decrease to 80% to match the others aave markets
- **Slope1:**
  - USDC: Increase to 5% to match the others aave markets.

**Arbitrum:**

- **LTV:**
  - USDC: Decrease to 77% to match the others aave markets
- **LT:**
  - USDC: Decrease to 80% to match the others aave markets

### Bridged USDC modification

The following changes will be implemented for the bridged version of USDC:

**Base:**

- **Supply Cap:** 2m
- **Borrow Cap:** 2m
- **Reserve Factor (RF):**
  - USDC.e: Increase to 20% to incentivize native USDC usage.
- **Slope1:**
  - USDC.e: Increase to 7% to incentivize native USDC usage.
- **Slope2:**
  - USDC.e: Increase to 80% to incentivize native USDC usage.

**Optimism:**

- **Supply Cap:** 18m
- **Borrow Cap:** 15.5m
- **Reserve Factor (RF):**
  - USDC.e: Increase to 20% to incentivize native USDC usage.
- **Slope1:**
  - USDC.e: Increase to 7% to incentivize native USDC usage.
- **Slope2:**
  - USDC.e: Increase to 80% to incentivize native USDC usage.

**Polygon:**

- **Supply Cap:** 40m
- **Borrow Cap:** 36m
- Loan To Value (LTV): 77%
- LT: 80%
- LB: 5%
- **Reserve Factor (RF):**
  - USDC.e: Increase to 20% to incentivize native USDC usage.
- **Slope1:**
  - USDC.e: Increase to 7% to incentivize native USDC usage.
- **Slope2:**
  - USDC.e: Increase to 80% to incentivize native USDC usage.

**Arbitrum:**

- **Supply Cap:** 26m
- **Borrow Cap:** 24m
- Loan To Value (LTV): 77%
- LT: 80%
- LB: 5%
- **Reserve Factor (RF):**
- USDC.e: Increase to 20% to incentivize native USDC usage.
- **Slope1:**
- USDC.e: Increase to 7% to incentivize native USDC usage.
- **Slope2:**
- USDC.e: Increase to 80% to incentivize native USDC usage.

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/9ef190b2c7989cd3268f36daf01139d47b240205/src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/AaveV3Polygon_OnboardNativeUSDCToAaveV3Markets_20231205.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/9ef190b2c7989cd3268f36daf01139d47b240205/src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/AaveV3Optimism_OnboardNativeUSDCToAaveV3Markets_20231205.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/9ef190b2c7989cd3268f36daf01139d47b240205/src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/9ef190b2c7989cd3268f36daf01139d47b240205/src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/AaveV3Base_OnboardNativeUSDCToAaveV3Markets_20231205.sol)
- Tests: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/9ef190b2c7989cd3268f36daf01139d47b240205/src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/AaveV3Polygon_OnboardNativeUSDCToAaveV3Markets_20231205.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/9ef190b2c7989cd3268f36daf01139d47b240205/src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/AaveV3Optimism_OnboardNativeUSDCToAaveV3Markets_20231205.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/9ef190b2c7989cd3268f36daf01139d47b240205/src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/9ef190b2c7989cd3268f36daf01139d47b240205/src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/AaveV3Base_OnboardNativeUSDCToAaveV3Markets_20231205.t.sol)
- Snapshot: No Snapshot for Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-onboard-native-usdc-to-aave-v3-markets/15720)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
