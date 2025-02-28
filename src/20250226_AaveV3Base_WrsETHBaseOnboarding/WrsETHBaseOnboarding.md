---
title: "wrsETH Base Onboarding"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-onboard-rseth-to-arbitrum-and-base-v3-instances/20741"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0x598f7057f445813d75404fae68f3501d76c90064f52ca4b9afb6f20859fa2658"
---

## Simple Summary

This is an AIP to onboard rsETH to the Aave V3 Base Instance allowing Aave users to supply wrsETH as collateral. This proposal will be under Direct to AIP, as rsETH is already listed on other Aave instances.

## Motivation

rsETH has seen continued growth across networks, and is currently the only of the onboarded LRT not available on Base. We expect further growth of this asset with onboarding to this networks.

## Specification

The table below illustrates the configured risk parameters for **wrsETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (wrsETH)       |                                        400 |
| Borrow Cap (wrsETH)       |                                          1 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                     0.05 % |
| LT                        |                                      0.1 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        1 % |
| Variable Slope 1          |                                        7 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x567E7f3DB2CD4C81872F829C8ab6556616818580 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://basescan.org/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for wrsETH and the corresponding aToken.

Moreover the following e-mode will be added:

| Parameter           | Value  | Value  |
| ------------------- | ------ | ------ |
| Asset               | wrsETH | wstETH |
| Collateral          | Yes    | No     |
| Borrowable          | No     | Yes    |
| LTV                 | 92.50% | -      |
| LT                  | 94.50% | -      |
| Liquidation Penalty | 1.00%  | -      |

## References

- Implementation: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250226_AaveV3Base_WrsETHBaseOnboarding/AaveV3Base_WrsETHBaseOnboarding_20250226.sol)
- Tests: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250226_AaveV3Base_WrsETHBaseOnboarding/AaveV3Base_WrsETHBaseOnboarding_20250226.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x598f7057f445813d75404fae68f3501d76c90064f52ca4b9afb6f20859fa2658)
- [Discussion](https://governance.aave.com/t/arfc-onboard-rseth-to-arbitrum-and-base-v3-instances/20741)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
