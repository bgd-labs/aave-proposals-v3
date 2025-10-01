---
title: "Launch GHO on Plasma & Set ACI as Emissions Manager for Rewards"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-launch-gho-on-plasma-set-aci-as-emissions-manager-for-rewards/22994"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xeb3572580924976867073ad9c8012cb9e52093c76dafebd7d3aebf318f2576fb"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **GHO**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (GHO)          |                                  5,000,000 |
| Borrow Cap (GHO)          |                                  4,500,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                        0 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      6.5 % |
| Variable Slope 2          |                                       50 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xb0e1c7830aA781362f79225559Aa068E6bDaF1d1 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://plasmascan.to/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for GHO and the corresponding aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250930_Multi_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards/AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930.sol), [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250930_Multi_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards/AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250930_Multi_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards/AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930.t.sol), [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250930_Multi_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards/AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xeb3572580924976867073ad9c8012cb9e52093c76dafebd7d3aebf318f2576fb)
- [Discussion](https://governance.aave.com/t/arfc-launch-gho-on-plasma-set-aci-as-emissions-manager-for-rewards/22994)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
