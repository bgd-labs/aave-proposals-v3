---
title: "Onboard ezETH to Arbitrum and Base Instances"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboard-ezeth-to-arbitrum-and-base-instances/19622"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0xf9fa710414237636cba11187111773fac04f74eb1a562d2b50fca86cb72a778e"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **ezETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (ezETH)        |                                      1,750 |
| Borrow Cap (ezETH)        |                                        175 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       72 % |
| LT                        |                                       75 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       15 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        7 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612 |

Additionaly [0xac140648435d03f784879cd789130F22Ef588Fcd](https://arbiscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for ezETH and the corresponding aToken.

The table below illustrates the configured risk parameters for **ezETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (ezETH)        |                                      1,200 |
| Borrow Cap (ezETH)        |                                        120 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       72 % |
| LT                        |                                       75 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       15 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        7 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x71041dddad3595F9CEd3DcCFBe3D1F4b0a16Bb70 |

Additionaly [0xac140648435d03f784879cd789130F22Ef588Fcd](https://basescan.org/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for ezETH and the corresponding aToken.

## References

- Implementation: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241221_Multi_OnboardEzETHToArbitrumAndBaseInstances/AaveV3Arbitrum_OnboardEzETHToArbitrumAndBaseInstances_20241221.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241221_Multi_OnboardEzETHToArbitrumAndBaseInstances/AaveV3Base_OnboardEzETHToArbitrumAndBaseInstances_20241221.sol)
- Tests: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241221_Multi_OnboardEzETHToArbitrumAndBaseInstances/AaveV3Arbitrum_OnboardEzETHToArbitrumAndBaseInstances_20241221.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241221_Multi_OnboardEzETHToArbitrumAndBaseInstances/AaveV3Base_OnboardEzETHToArbitrumAndBaseInstances_20241221.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0xf9fa710414237636cba11187111773fac04f74eb1a562d2b50fca86cb72a778e)
- [Discussion](https://governance.aave.com/t/arfc-onboard-ezeth-to-arbitrum-and-base-instances/19622)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
