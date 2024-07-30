---
title: "Onboard USDC.e on Gnosis"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboard-usdc-e-to-aave-v3-gnosis-chain/17948/3"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xefdd7d915acc3a179c756295ad6583645dfc491424cda08916e80c8551e30943"
---

## Simple Summary

This proposal aims to onboard USDC.e into the Aave V3 pools on Gnosis.

## Motivation

Gnosis will be deploying a new version of USDC, following the Bridge Token Standard. The migration from the older version of USDC allows for more flexibility and paves the way for deeper integration with Circle and native USDC implementations.

This proposal aims to onboard USDC.e into the Aave V3 pools on Gnosis in support of this migration, allowing Aave users to transition to the new version of USDC.

## Specification

The table below illustrates the configured risk parameters for **USDCe**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (USDCe)        |                                  1,500,000 |
| Borrow Cap (USDCe)        |                                  1,400,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       75 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                        5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        9 % |
| Variable Slope 2          |                                       75 % |
| Uoptimal                  |                                       90 % |
| Stable Borrowing          |                                   DISABLED |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                    ENABLED |
| Oracle                    | 0x0a2d05bc646C65A029e602c257DfA14adF8BfAd2 |

## References

- Implementation: [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240717_AaveV3Gnosis_OnboardUSDCEOnGnosis/AaveV3Gnosis_OnboardUSDCEOnGnosis_20240717.sol)
- Tests: [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240717_AaveV3Gnosis_OnboardUSDCEOnGnosis/AaveV3Gnosis_OnboardUSDCEOnGnosis_20240717.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xefdd7d915acc3a179c756295ad6583645dfc491424cda08916e80c8551e30943)
- [Discussion](https://governance.aave.com/t/arfc-onboard-usdc-e-to-aave-v3-gnosis-chain/17948/3)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
