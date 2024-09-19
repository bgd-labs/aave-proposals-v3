---
title: "Onboard USDS and SUSDS"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-onboard-usds-and-susds-to-aave-v3/18987"
snapshot: "Direct-to-AIP"
---

## Simple Summary

This proposal aims to onboard USDS and sUSDS, the rebranded DAI and sDAI tokens to Aave v3 Ethereum Main and Lido Pool.

## Motivation

DAI has been a cornerstone asset in the Aave ecosystem, with a long and successful history of supply across various versions of the protocol. MakerDAO marked a significant milestone with a rebranded to Sky, introducing USDS and sUSDS as the new iterations of DAI and sDAI. Given the established track record and widespread adoption of their predecessors, we propose to onboard these new assets to Aave v3.

By integrating USDS and sUSDS into Aave v3, we aim to maintain continuity for users who have relied on DAI and sDAI while embracing the evolution of these assets under the Sky brand.

## Specification

### Risk Parameters for **sUSDS** (Aave V3 Main Instance) and **USDS** (Lido Pool)

| Parameter                 |          **sUSDS** (Aave V3 Main Instance) |                       **USDS** (Lido Pool) |
| ------------------------- | -----------------------------------------: | -----------------------------------------: |
| Isolation Mode            |                                      false |                                      false |
| Borrowable                |                                   DISABLED |                                    ENABLED |
| Collateral Enabled        |                                       true |                                       true |
| Supply Cap                |                                 35,000,000 |                                 50,000,000 |
| Borrow Cap                |                                          0 |                                 45,000,000 |
| Debt Ceiling              |                                      USD 0 |                                      USD 0 |
| LTV                       |                                       75 % |                                       63 % |
| LT                        |                                       78 % |                                       72 % |
| Liquidation Bonus         |                                      7.5 % |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |                                       10 % |
| Reserve Factor            |                                       25 % |                                       25 % |
| Base Variable Borrow Rate |                                        0 % |                                        0 % |
| Variable Slope 1          |                                      5.5 % |                                      5.5 % |
| Variable Slope 2          |                                       75 % |                                       75 % |
| Uoptimal                  |                                       90 % |                                       90 % |
| Stable Borrowing          |                                   DISABLED |                                   DISABLED |
| Flashloanable             |                                    ENABLED |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |                                   DISABLED |
| Oracle\*                  | 0x408e905577653430Bb80d91e0ca433b338CEA7C6 | 0x4F01b76391A05d32B20FA2d05dD5963eE8db20E6 |

#### Oracle Comments:

- For **USDS** (Lido Pool): Due to expected liquidity conditions on launch of USDS and bidirectional migration with DAI, a CAPO DAI/USD feed is used.
- For **sUSDS** (Aave V3 Main Instance): Similarly to USDS, sUSDS will use a CAPO DAI/USD feed combined with the USDS <> sUSDS exchange rate.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240914_Multi_OnboardUSDSAndSUSDS/AaveV3Ethereum_OnboardUSDSAndSUSDS_20240914.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240914_Multi_OnboardUSDSAndSUSDS/AaveV3EthereumLido_OnboardUSDSAndSUSDS_20240914.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240914_Multi_OnboardUSDSAndSUSDS/AaveV3Ethereum_OnboardUSDSAndSUSDS_20240914.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240914_Multi_OnboardUSDSAndSUSDS/AaveV3EthereumLido_OnboardUSDSAndSUSDS_20240914.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-onboard-usds-and-susds-to-aave-v3/18987)
- [Risk Recommendation 1](https://governance.aave.com/t/arfc-onboard-usds-and-susds-to-aave-v3/18987/2)
- [Risk Recommendation 2](https://governance.aave.com/t/arfc-onboard-usds-and-susds-to-aave-v3/18987/3)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
