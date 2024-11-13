---
title: "Onboard and Enable sUSDe liquid E-Mode on Aave v3 Mainnet and Lido Instances"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-enable-susde-liquid-e-mode-on-aave-v3-mainnet-and-lido-instance/19703"
snapshot: "Direct-to-AIP"
---

## Simple Summary

This proposal aims to enable sUSDe liquid E-Mode on Aave v3 Mainnet for the Main and Lido instances. By implementing this change, we seek to enhance capital efficiency for borrowers using sUSDe as collateral, particularly for borrowing other stablecoins. This is a Direct to AIP proposal.

## Motivation

The motivation behind this proposal stems from several key factors:

- High Utilization: sUSDe has demonstrated significant usage as collateral for borrowing stablecoins on the platform.
  Capital Efficiency: Enabling liquid E-Mode for sUSDe will allow borrowers to substantially improve their capital efficiency when using this asset as collateral.
- Controlled Growth: Liquid E-Mode provides a mechanism for more precise control over the growth and borrow demand in relation to the overall stablecoin liquidity within Aave v3 on Mainnet.
- Enhanced Borrowing Capacity: This change will enable users to borrow larger amounts of other stablecoins against their sUSDe collateral, potentially increasing platform utilization and revenue.
  By implementing this proposal, we aim to optimize the use of sUSDe within the Aave ecosystem, attracting more liquidity for stablecoins.

## Specification

The table below illustrates the configured risk parameters for **sUSDe** on Aave V3 Lido Instance:

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (sUSDe)        |                                 20,000,000 |
| Borrow Cap (sUSDe)        |                                       1000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                     0.05 % |
| LT                        |                                      0.1 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                     0.05 % |
| Variable Slope 1          |                                      0.1 % |
| Variable Slope 2          |                                        3 % |
| Uoptimal                  |                                        1 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xb37aE8aBa6C0C1Bf2c509fc06E11aa4AF29B665A |

Additionaly [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for sUSDe and the corresponding aToken.

The table below illustrate the configured "sUSDe Stablecoins" Liquid E-mode

| Parameter             | Value | Value | Value |
| --------------------- | ----- | ----- | ----- |
| Asset                 | sUSDe | USDS  | USDC  |
| Collateral            | Yes   | No    | No    |
| Borrowable            | No    | Yes   | Yes   |
| Max LTV               | 90%   | -     | -     |
| Liquidation Threshold | 92%   | -     | -     |
| Liquidation Bonus     | 3.0%  | -     | -     |

Finally, sUSDe on Aave V3 Mainnet will be removed from Isolation Mode on Aave v3 instance.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241108_Multi_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances/AaveV3Ethereum_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances_20241108.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241108_Multi_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances/AaveV3EthereumLido_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances_20241108.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241108_Multi_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances/AaveV3Ethereum_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances_20241108.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241108_Multi_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances/AaveV3EthereumLido_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances_20241108.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-enable-susde-liquid-e-mode-on-aave-v3-mainnet-and-lido-instance/19703)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
