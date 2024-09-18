---
title: "Onboard USDS and SUSDS Part I"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-onboard-usds-and-susds-to-aave-v3/18987"
snapshot: "Direct-to-AIP"
---

## Simple Summary

This proposal aims to onboard USDS and sUSDS, the rebranded DAI and sDAI tokens to Aave v3 Ethereum Main Pool.

## Motivation

DAI has been a cornerstone asset in the Aave ecosystem, with a long and successful history of supply across various versions of the protocol. MakerDAO marked a significant milestone with a rebranded to Sky, introducing USDS and sUSDS as the new iterations of DAI and sDAI. Given the established track record and widespread adoption of their predecessors, we propose to onboard these new assets to Aave v3.

By integrating USDS and sUSDS into Aave v3, we aim to maintain continuity for users who have relied on DAI and sDAI while embracing the evolution of these assets under the Sky brand.

### Benefits of listing USDS and sUSDS

DAI and sDAI have been a success and in order to not lose marketshare to other protocols as some DAI holders migrate to the new tokens, it is in the DAO’s interest to capture this demand. As there will be incentive programs running this also provides the opportunity for Aave users to benefit from these.

### Two Part AIP

For easier integration & implementation, this AIP only seeks to onboard USDS & sUSDS on the Aave Ethereum Main pool.

A second part will consider onboarding them on the Lido Instance alongside other stablecoins.

## Specification

The table below illustrates the configured risk parameters for **USDS**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (USDS)         |                                 50,000,000 |
| Borrow Cap (USDS)         |                                 45,000,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       63 % |
| LT                        |                                       72 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       25 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      5.5 % |
| Variable Slope 2          |                                       75 % |
| Uoptimal                  |                                       90 % |
| Stable Borrowing          |                                   DISABLED |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle\*                  | 0x4F01b76391A05d32B20FA2d05dD5963eE8db20E6 |

- Due to expected liquidity conditions on launch of USDS and bidirectional migration venus with DAI, a CAPO DAI/USD feed is used

,The table below illustrates the configured risk parameters for **sUSDS**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (sUSDS)        |                                 35,000,000 |
| Borrow Cap (sUSDS)        |                                          0 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       75 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       25 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      5.5 % |
| Variable Slope 2          |                                       75 % |
| Uoptimal                  |                                       90 % |
| Stable Borrowing          |                                   DISABLED |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle\*                  | 0x408e905577653430Bb80d91e0ca433b338CEA7C6 |

\*\* Similarly as with USDS, sUSDS will use a CAPO DAI/USD combined with the USDS <> sUSDS exchange rate

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/e46b44e5cb294a6dccc7fc80abaf2b9883c58a94/src/20240914_AaveV3Ethereum_OnboardUSDSAndSUSDS/AaveV3Ethereum_OnboardUSDSAndSUSDS_20240914.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/e46b44e5cb294a6dccc7fc80abaf2b9883c58a94/src/20240914_AaveV3Ethereum_OnboardUSDSAndSUSDS/AaveV3Ethereum_OnboardUSDSAndSUSDS_20240914.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-onboard-usds-and-susds-to-aave-v3/18987)
- [Risk Recommendation 1](https://governance.aave.com/t/arfc-onboard-usds-and-susds-to-aave-v3/18987/2)
- [Risk Recommendation 2](https://governance.aave.com/t/arfc-onboard-usds-and-susds-to-aave-v3/18987/3)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
