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
| Borrowable                |                                    ENABLED |                                    ENABLED |
| Collateral Enabled        |                                       true |                                      false |
| Supply Cap                |                                 35,000,000 |                                 50,000,000 |
| Borrow Cap                |                                 32,500,000 |                                 45,000,000 |
| Debt Ceiling              |                                      USD 0 |                                      USD 0 |
| LTV                       |                                       75 % |                                        0 % |
| LT                        |                                       78 % |                                        0 % |
| Liquidation Bonus         |                                      7.5 % |                                         0% |
| Liquidation Protocol Fee  |                                       10 % |                                       10 % |
| Reserve Factor            |                                       50 % |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |                                     0.75 % |
| Variable Slope 1          |                                        2 % |                                     6.25 % |
| Variable Slope 2          |                                       50 % |                                       75 % |
| Uoptimal                  |                                       92 % |                                       92 % |
| Stable Borrowing          |                                   DISABLED |                                   DISABLED |
| Flashloanable             |                                    ENABLED |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |                                   DISABLED |
| Oracle\*                  | 0x408e905577653430Bb80d91e0ca433b338CEA7C6 | 0x4F01b76391A05d32B20FA2d05dD5963eE8db20E6 |

## USDS (Lido Pool) and sUSDS (Aave V3 Main Instance) Changes

### Oracle Updates:

- **USDS (Lido Pool)**: Implementing a CAPO DAI/USD feed due to expected liquidity conditions on launch and bidirectional migration with DAI.
- **sUSDS (Aave V3 Main Instance)**: Using a CAPO DAI/USD feed combined with the USDS <> sUSDS exchange rate.

### Interest Curve and Reserve Factor Modifications:

Following discussions with Sky teams and Aave DAO service providers, the following parameters have been adjusted to better suit the expected use cases of this integration:

#### USDS (Lido Pool):

- Reserve Factor: Decreased from 25% to 10%
- Base Variable Borrow Rate: Increased from 0% to 0.75%
- Variable Rate Slope 1: Increased from 5.5% to 6.25%
- Optimal Usage Ratio: Increased from 90% to 92%
- Collateral Usage: Disabled
- LTV, Liquidation Threshold, and Liquidation Bonus: All reduced to 0%.

#### sUSDS (Aave V3 Main Instance):

- Reserve Factor: Increased from 25% to 50%
- Variable Rate Slope 1: Decreased from 5.5% to 2%
- Variable Rate Slope 2: Decreased from 75% to 50%
- Optimal Usage Ratio: Increased from 90% to 92%

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240914_Multi_OnboardUSDSAndSUSDS/AaveV3Ethereum_OnboardUSDSAndSUSDS_20240914.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240914_Multi_OnboardUSDSAndSUSDS/AaveV3EthereumLido_OnboardUSDSAndSUSDS_20240914.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240914_Multi_OnboardUSDSAndSUSDS/AaveV3Ethereum_OnboardUSDSAndSUSDS_20240914.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240914_Multi_OnboardUSDSAndSUSDS/AaveV3EthereumLido_OnboardUSDSAndSUSDS_20240914.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-onboard-usds-and-susds-to-aave-v3/18987)
- [Risk Recommendation 1](https://governance.aave.com/t/arfc-onboard-usds-and-susds-to-aave-v3/18987/2)
- [Risk Recommendation 2](https://governance.aave.com/t/arfc-onboard-usds-and-susds-to-aave-v3/18987/3)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
