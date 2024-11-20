---
title: "Enable tBTC/WBTC liquid E-Mode on Aave v3 Mainnet"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-enable-tbtc-wbtc-liquid-e-mode-on-aave-v3-mainnet/19704"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x317dc7303f98a6363d7aa4284b75e5779cde127c73e815a941a503619575deb6"
---

## Simple Summary

This proposal aims to enable tBTC/WBTC liquid E-Mode for the Main Instance. By implementing this change, we seek to enhance capital efficiency for borrowers using tBTC/WBTC as collateral, particularly for borrowing other stablecoins.

## Motivation

The motivation behind this proposal stems from several key factors:

- High Utilization: tBTC/WBTC has demonstrated significant usage as collateral for borrowing stablecoins on the platform.
- Capital Efficiency: Enabling liquid E-Mode for tBTC/WBTC will allow borrowers to substantially improve their capital efficiency when using this asset as collateral.
- Controlled Growth: Liquid E-Mode provides a mechanism for more precise control over the growth and borrow demand in relation to the overall stablecoin liquidity within Aave v3 on Mainnet.
- Enhanced Borrowing Capacity: This change will enable users to borrow larger amounts of other stablecoins against their tBTC/WBTC collateral, potentially increasing platform utilization and revenue.

By implementing this proposal, we aim to optimize the use of tBTC/WBTC within the Aave ecosystem, attracting more liquidity for stablecoins.

## Specification

This proposal will add tBTC/WBTC liquid E-Mode

### tBTC/WBTC E-Mode

| Parameter             | Value | Value |
| --------------------- | ----- | ----- |
| Asset                 | tBTC  | WBTC  |
| Collateral            | Yes   | No    |
| Borrowable            | No    | Yes   |
| Max LTV               | 93%   | -     |
| Liquidation Threshold | 95%   | -     |
| Liquidation Bonus     | 1.50% | -     |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241120_AaveV3Ethereum_EnableTBTCWBTCLiquidEModeOnAaveV3Mainnet/AaveV3Ethereum_EnableTBTCWBTCLiquidEModeOnAaveV3Mainnet_20241120.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241120_AaveV3Ethereum_EnableTBTCWBTCLiquidEModeOnAaveV3Mainnet/AaveV3Ethereum_EnableTBTCWBTCLiquidEModeOnAaveV3Mainnet_20241120.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x317dc7303f98a6363d7aa4284b75e5779cde127c73e815a941a503619575deb6)
- [Discussion](https://governance.aave.com/t/arfc-enable-tbtc-wbtc-liquid-e-mode-on-aave-v3-mainnet/19704)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
