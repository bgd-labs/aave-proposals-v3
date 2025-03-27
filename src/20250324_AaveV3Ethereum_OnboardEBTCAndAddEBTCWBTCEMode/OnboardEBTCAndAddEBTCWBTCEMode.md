---
title: "Onboard eBTC and Add eBTC/WBTC E-Mode"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-enable-ebtc-wbtc-liquid-e-mode-on-aave-v3-core-instance/20141"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0x564a45f0a2855799d9be329942fa1f5e849058ff4b950f4027ec4666f4b61d9c"
---

## Simple Summary

This proposal aims to onboard eBTC for the Core Instance, and add a WBTC liquid E-Mode. By implementing this change, we seek to enhance capital efficiency for borrowers using eBTC/WBTC as collateral.

Both [TEMP CHECK](https://governance.aave.com/t/temp-check-onboard-enable-ebtc-wbtc-liquid-e-mode-on-aave-v3-core-instance/19969) and [TEMP CHECK Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x60c360b61812b9ae96b2f785f9fca7a5461ab45e295f55a695638aef18d96d50) have passed recently.

## Motivation

The motivation behind this proposal stems from several key factors:

- High Utilization: eBTC/WBTC has demonstrated significant usage as collateral for borrowing stablecoins on the platform.
- Capital Efficiency: Enabling liquid E-Mode for eBTC/WBTC will allow borrowers to substantially improve their capital efficiency when using this asset as collateral.
- Controlled Growth: Liquid E-Mode provides a mechanism for more precise control over the growth and borrow demand in relation to the overall stablecoin liquidity within Aave v3 on Core Instance.
- Enhanced Borrowing Capacity: This change will enable users to borrow larger amounts of other stablecoins against their eBTC/WBTC collateral, potentially increasing platform utilization and revenue.

By implementing this proposal, we aim to optimize the use of eBTC/WBTC within the Aave ecosystem, attracting more liquidity.

## Specification

The table below illustrates the configured risk parameters for **eBTC**

| Parameter                | Value                                      |
| ------------------------ | ------------------------------------------ |
| Network                  | Ethereum                                   |
| Isolation Mode           | No                                         |
| Borrowable               | No                                         |
| Collateral Enabled       | Yes                                        |
| Supply Cap               | 750                                        |
| Borrow Cap               | 1                                          |
| Debt Ceiling             | 0                                          |
| LTV                      | 67%                                        |
| LT                       | 72%                                        |
| Liquidation Bonus        | 10%                                        |
| Liquidation Protocol Fee | 10%                                        |
| Variable Base            | 0%                                         |
| Variable Slope1          | 4%                                         |
| Variable Slope2          | 300%                                       |
| Uoptimal                 | 45%                                        |
| Reserve Factor           | 50%                                        |
| Flashloanable            | No                                         |
| Siloed Borrowing         | No                                         |
| Oracle                   | 0x95a85D0d2f3115702d813549a80040387738A430 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for eBTC and the corresponding aToken.

Finally, this proposal will add eBTC/WBTC liquid E-Mode

| Parameter             | Value | Value |
| --------------------- | ----- | ----- |
| Asset                 | eBTC  | WBTC  |
| Collateral            | Yes   | No    |
| Borrowable            | No    | Yes   |
| Max LTV               | 83%   | -     |
| Liquidation Threshold | 85%   | -     |
| Liquidation Bonus     | 3.0%  | -     |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250324_AaveV3Ethereum_OnboardEBTCAndAddEBTCWBTCEMode/AaveV3Ethereum_OnboardEBTCAndAddEBTCWBTCEMode_20250324.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250324_AaveV3Ethereum_OnboardEBTCAndAddEBTCWBTCEMode/AaveV3Ethereum_OnboardEBTCAndAddEBTCWBTCEMode_20250324.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x564a45f0a2855799d9be329942fa1f5e849058ff4b950f4027ec4666f4b61d9c)
- [Discussion](https://governance.aave.com/t/arfc-enable-ebtc-wbtc-liquid-e-mode-on-aave-v3-core-instance/20141)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
