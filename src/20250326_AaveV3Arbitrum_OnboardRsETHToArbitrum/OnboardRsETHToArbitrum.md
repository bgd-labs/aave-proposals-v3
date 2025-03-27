---
title: " Onboard rsETH to Arbitrum"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboard-rseth-to-arbitrum-and-base-v3-instances/20741"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0x598f7057f445813d75404fae68f3501d76c90064f52ca4b9afb6f20859fa2658"
---

## Simple Summary

This is an ARFC to onboard rsETH to the Aave V3 Arbitrum.

## Motivation

rsETH has seen continued growth across networks, and is currently the only of the onboarded LRT not available on Arbitrum. We expect further growth of this asset with onboarding to this networks. Arbitrum has one of the largest wstETH reserves of any Aave instance. We suggest to onboard rsETH with similar parameters to ezETH and corresponding E-Modes for rsETH / wstETH and rsETH / stablecoins.

## Specification

The table below illustrates the configured risk parameters for **rsETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (rsETH)        |                                        900 |
| Borrow Cap (rsETH)        |                                          1 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                     0.05 % |
| LT                        |                                      0.1 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                       10 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xb4B0cbcA864c2Eb0C0342608D92490C034aC1089 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://arbiscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for rsETH and the corresponding aToken.

### rsETH/wstETH E-Mode on Arbitrum & Base

| Parameter           | Value  | Value  |
| ------------------- | ------ | ------ |
| Asset               | rsETH  | wstETH |
| Collateral          | Yes    | No     |
| Borrowable          | No     | Yes    |
| LTV                 | 92.50% | -      |
| LT                  | 94.50% | -      |
| Liquidation Penalty | 1.00%  | -      |

## References

- Implementation: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250326_AaveV3Arbitrum_OnboardRsETHToArbitrum/AaveV3Arbitrum_OnboardRsETHToArbitrum_20250326.sol)
- Tests: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250326_AaveV3Arbitrum_OnboardRsETHToArbitrum/AaveV3Arbitrum_OnboardRsETHToArbitrum_20250326.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x598f7057f445813d75404fae68f3501d76c90064f52ca4b9afb6f20859fa2658)
- [Discussion](https://governance.aave.com/t/arfc-onboard-rseth-to-arbitrum-and-base-v3-instances/20741)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
