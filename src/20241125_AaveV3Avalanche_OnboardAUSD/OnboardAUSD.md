---
title: "Onboard AUSD"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-onboard-ausd-to-aave-v3-on-avalanche/19689"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x021b40c7042ce770c0ce1ee5ff63591c132a9f0f12e3a1cb92fa209299793dec"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **AUSD**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (AUSD)         |                                 19,000,000 |
| Borrow Cap (AUSD)         |                                 17,400,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                        0 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      5.5 % |
| Variable Slope 2          |                                       75 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x5C2d58627Fbe746f5ea24Ef6D618f09f8e3f0122 |

Additionaly [0xac140648435d03f784879cd789130F22Ef588Fcd](https://snowtrace.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for AUSD and the corresponding aToken.

## References

- Implementation: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241125_AaveV3Avalanche_OnboardAUSD/AaveV3Avalanche_OnboardAUSD_20241125.sol)
- Tests: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241125_AaveV3Avalanche_OnboardAUSD/AaveV3Avalanche_OnboardAUSD_20241125.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x021b40c7042ce770c0ce1ee5ff63591c132a9f0f12e3a1cb92fa209299793dec)
- [Discussion](https://governance.aave.com/t/arfc-onboard-ausd-to-aave-v3-on-avalanche/19689)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
