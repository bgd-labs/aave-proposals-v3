---
title: "Add rlUSD to Core Instance"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-add-rlusd-to-core-instance/20214"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x539ad30f3d3d531702bb7619fc0a9a44dc2da6a8e022eff7ffdc678032e0a8b9"
---

## Simple Summary

This AIP seeks governance approval to onboard Ripple’s rlUSD stablecoin to the Core instance of Aave v3 on Ethereum.

## Motivation

rlUSD is Ripple's stablecoin it's onboarding in the Aave ecosystem is a strategic growth opportunity to reach new audiences.

## Specification

The table below illustrates the configured risk parameters for **RLUSD**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (RLUSD)        |                                 50,000,000 |
| Borrow Cap (RLUSD)        |                                  5,000,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                        0 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      6.5 % |
| Variable Slope 2          |                                       50 % |
| Uoptimal                  |                                       80 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xf0eaC18E908B34770FDEe46d069c846bDa866759 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for RLUSD and the corresponding aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/0a32d800b0425cdbf163787daf34c4b72fd2e69d/src/20250409_AaveV3Ethereum_AddRlUSDToCoreInstance/AaveV3Ethereum_AddRlUSDToCoreInstance_20250409.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/0a32d800b0425cdbf163787daf34c4b72fd2e69d/src/20250409_AaveV3Ethereum_AddRlUSDToCoreInstance/AaveV3Ethereum_AddRlUSDToCoreInstance_20250409.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x539ad30f3d3d531702bb7619fc0a9a44dc2da6a8e022eff7ffdc678032e0a8b9)
- [Discussion](https://governance.aave.com/t/arfc-add-rlusd-to-core-instance/20214)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
