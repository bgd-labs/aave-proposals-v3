---
title: "Onboard USDe to the Aave V3 MegaETH Instance"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-usde-to-the-aave-v3-megaeth-instance/24389"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **USDe**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (USDe)         |                                 50,000,000 |
| Borrow Cap (USDe)         |                                 40,000,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       25 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        3 % |
| Variable Slope 2          |                                       12 % |
| Uoptimal                  |                                       85 % |
| Flashloanable             |                                   DISABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x6B00ffb3852E87c13b7f56660a7dfF64191180B3 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://mega.etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for USDe and the corresponding aToken.

## References

- Implementation: [AaveV3MegaEth](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260425_AaveV3MegaEth_OnboardUSDeToTheAaveV3MegaETHInstance/AaveV3MegaEth_OnboardUSDeToTheAaveV3MegaETHInstance_20260425.sol)
- Tests: [AaveV3MegaEth](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260425_AaveV3MegaEth_OnboardUSDeToTheAaveV3MegaETHInstance/AaveV3MegaEth_OnboardUSDeToTheAaveV3MegaETHInstance_20260425.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-usde-to-the-aave-v3-megaeth-instance/24389)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
