---
title: "Onboard LBTC & Enable LBTC/WBTC liquid E-Mode on Aave v3 Core Instance"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-enable-lbtc-wbtc-liquid-e-mode-on-aave-v3-core-instance/20142"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0x61f027ea797763c9e01736693570141a27a0a5d4517a6b63d0fd84474e8be995"
---

## Simple Summary

This proposal aims to onboard LBTC and enable LBTC/WBTC liquid E-Mode for the Main Instance. By implementing this change, we seek to enhance capital efficiency for borrowers using LBTC/WBTC as collateral.

[TEMP CHECK](https://governance.aave.com/t/temp-check-onboard-enable-lbtc-wbtc-liquid-e-mode-on-aave-v3-core-instance/19968/7) and [TEMP CHECK Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x8fdee3ec7a301f9fba2e4c048227257070645d636b09a7afb369ee9c002ad764) have passed recently.

## Motivation

The motivation behind this proposal stems from several key factors:

- High Utilization: LBTC/WBTC has demonstrated significant usage as collateral for borrowing stablecoins on other platforms.
- Capital Efficiency: Enabling liquid E-Mode for LBTC/WBTC will allow borrowers to substantially improve their capital efficiency when using this asset as collateral.
- Controlled Growth: Liquid E-Mode provides a mechanism for more precise control over the growth and borrow demand in relation to the overall stablecoin liquidity within Aave v3 on Core Instance.

By implementing this proposal, we aim to optimize the use of LBTC/WBTC within the Aave ecosystem, attracting more liquidity for the protocol and increasing revenues.

## Specification

The table below illustrates the configured risk parameters for **LBTC**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (LBTC)         |                                        800 |
| Borrow Cap (LBTC)         |                                         80 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       70 % |
| LT                        |                                       75 % |
| Liquidation Bonus         |                                      8.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       50 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        4 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for LBTC and the corresponding aToken.

**E-mode**

the following E-mode will be created

| Parameter             | Value | Value |
| --------------------- | ----- | ----- |
| Asset                 | LBTC  | WBTC  |
| Collateral            | Yes   | No    |
| Borrowable            | No    | Yes   |
| Max LTV               | 84%   | -     |
| Liquidation Threshold | 86%   | -     |
| Liquidation Bonus     | 3.00% | -     |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/97f99f8f3e9a0f6b53881ab3dfd8026d55d4b120/src/20241223_AaveV3Ethereum_EnableLBTCWBTCLiquidEModeOnAavev3CoreInstance/AaveV3Ethereum_EnableLBTCWBTCLiquidEModeOnAavev3CoreInstance_20241223.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/97f99f8f3e9a0f6b53881ab3dfd8026d55d4b120/src/20241223_AaveV3Ethereum_EnableLBTCWBTCLiquidEModeOnAavev3CoreInstance/AaveV3Ethereum_EnableLBTCWBTCLiquidEModeOnAavev3CoreInstance_20241223.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x61f027ea797763c9e01736693570141a27a0a5d4517a6b63d0fd84474e8be995)
- [Discussion](https://governance.aave.com/t/arfc-enable-lbtc-wbtc-liquid-e-mode-on-aave-v3-core-instance/20142)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
