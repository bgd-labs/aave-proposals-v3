---
title: "Onboard fdUSD to Aave v3 on BNB chain"
author: "ACI (Aave Chan Initiative)"
discussions: "https://governance.aave.com/t/arfc-onboard-fdusd-to-aave-v3-on-bsc/16364"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xedacc2aab061dbb187ef705ffee8a8f35ab3f53670e4d8e432eed9dfd2c31958"
---

## Simple Summary

The proposal aims to onboard fdUSD, a fiat-backed stablecoin, to the Aave v3 protocol on the BNB Chain.

## Motivation

fdUSD is a dollar-pegged stablecoin that provides stability and value preservation for users on the BNB Chain. It is issued by FD121 Ltd. (First Digital Labs), a subsidiary of First Digital Group that is incorporated in Hong Kong.

As part of the approved deployment on BNB chain, fdUSD will be a key asset for supply liquidity and borrow demand. The proposal seeks to leverage the strong demand for stablecoins and the growing popularity of the BNB ecosystem to provide users with enhanced liquidity options.

Benefits of listing fdUSD:

- Enhanced liquidity options for Aave users on the BNB deployment
- Increased utility for fdUSD as it becomes available for lending and borrowing
- Strengthened collaboration between Aave and the BNB ecosystem, fostering growth and innovation

Aave’s BNB deployment will be integrated with Binance’s web3 wallet, making easy access for Binance users to deposit fdUSD in Aave through the Earn program.

## Specification

Ticker: fdUSD

Contract Address: [0xc5f0f7b66764f6ec8c8dff7ba683102295e16409](https://bscscan.com/address/0xc5f0f7b66764f6ec8c8dff7ba683102295e16409)

Chainlink Oracle: [0x390180e80058a8499930f0c13963ad3e0d86bfc9](https://bscscan.com/address/0x390180e80058a8499930f0c13963ad3e0d86bfc9)

The table below illustrates the configured risk parameters for **FDUSD**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (FDUSD)                 |                                  8,000,000 |
| Borrow Cap (FDUSD)                 |                                  7,500,000 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                       70 % |
| LT                                 |                                       75 % |
| Liquidation Bonus                  |                                        5 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       20 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                        6 % |
| Variable Slope 2                   |                                       75 % |
| Uoptimal                           |                                       90 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                       13 % |
| Stable Slope2                      |                                      300 % |
| Base Stable Rate Offset            |                                        3 % |
| Stable Rate Excess Offset          |                                        8 % |
| Optimal Stable To Total Debt Ratio |                                       20 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                    ENABLED |
| Oracle                             | 0x390180e80058a8499930f0c13963ad3e0d86bfc9 |

## References

- Implementation: [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/670e6221c853857f7c7e86f9cd87ebef5890d5e7/src/20240201_AaveV3BNB_OnboardFdUSDToAaveV3OnBSC/AaveV3BNB_OnboardFdUSDToAaveV3OnBSC_20240201.sol)
- Tests: [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/670e6221c853857f7c7e86f9cd87ebef5890d5e7/src/20240201_AaveV3BNB_OnboardFdUSDToAaveV3OnBSC/AaveV3BNB_OnboardFdUSDToAaveV3OnBSC_20240201.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xedacc2aab061dbb187ef705ffee8a8f35ab3f53670e4d8e432eed9dfd2c31958)
- [Discussion](https://governance.aave.com/t/arfc-onboard-fdusd-to-aave-v3-on-bsc/16364)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
