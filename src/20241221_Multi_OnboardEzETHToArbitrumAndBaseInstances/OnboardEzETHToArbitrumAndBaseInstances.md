---
title: "Onboard ezETH to Arbitrum and Base Instances"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboard-ezeth-to-arbitrum-and-base-instances/19622"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0xf9fa710414237636cba11187111773fac04f74eb1a562d2b50fca86cb72a778e"
---

## Simple Summary

This is an AIP for adding borrow/lend support for Renzo Protocol and its Liquid Restaking Token (LRT) ezETH on AAVE V3 Base and Arbitrum.

## Motivation

As productive assets, staking tokens are high quality collateral to borrow against. ezETH is one of the largest liquid restaking tokens. With strong demand for ezETH on mainnet this proposal seeks to provide the opportunity for Aave users to make use of ezETH on leading Layer 2 networks: Base and Arbitrum.

The onboarding of ezETH on these L2s will create increased ezETH demand and increased revenues for both Aave and Renzo Protocol, whilst also bolstering the liquidity and peg stability of ezETH.

## Specification

The table below illustrates the configured risk parameters for **ezETH** on Arbitrum and Base instances

| Parameter                   |                                      Value |
| --------------------------- | -----------------------------------------: |
| Isolation Mode              |                                      false |
| Borrowable                  |                                   DISABLED |
| Collateral Enabled          |                                       true |
| Supply Cap (ezETH) Arbitrum |                                      1,750 |
| Supply Cap (ezETH) Base     |                                      1,200 |
| Borrow Cap (ezETH)          |                                          1 |
| Debt Ceiling                |                                      USD 0 |
| LTV                         |                                     0.05 % |
| LT                          |                                     0.10 % |
| Liquidation Bonus           |                                      7.5 % |
| Liquidation Protocol Fee    |                                       10 % |
| Reserve Factor              |                                       15 % |
| Base Variable Borrow Rate   |                                        0 % |
| Variable Slope 1            |                                        7 % |
| Variable Slope 2            |                                      300 % |
| Uoptimal                    |                                       45 % |
| Flashloanable               |                                    ENABLED |
| Siloed Borrowing            |                                   DISABLED |
| Borrowable in Isolation     |                                   DISABLED |
| Oracle (Arbitrum)           | 0x8Ed37B72300683c0482A595bfa80fFb793874b15 |
| Oracle (Base)               | 0x438e24f5FCDC1A66ecb25D19B5543e0Cb91A44D4 |

The following CAPO and E-Mode parameters are applied to both instances

### CAPO

| **maxYearlyRatioGrowthPercent** | **ratioReferenceTime** | **MINIMUM_SNAPSHOT_DELAY** |
| ------------------------------- | ---------------------- | -------------------------- |
| 10.89%                          | monthly                | 14 days                    |

### E-mode: ezETH / wstETH

| Parameter             | Value | Value  |
| --------------------- | ----- | ------ |
| Asset                 | ezETH | wstETH |
| Collateral            | Yes   | No     |
| Borrowable            | No    | Yes    |
| Max LTV               | 93%   | 93%    |
| Liquidation Threshold | 95%   | 95%    |
| Liquidation Penalty   | 1.00% | 1.00%  |

### E-mode: ezETH / stablecoin

| Parameter             | Value | Value | Value (only on Arbitrum) |
| --------------------- | ----- | ----- | ------------------------ |
| Asset                 | ezETH | USDC  | USDT                     |
| Collateral            | Yes   | No    | No                       |
| Borrowable            | No    | Yes   | Yes                      |
| Max LTV               | 72%   | 72%   | 72%                      |
| Liquidation Threshold | 75%   | 75%   | 75%                      |
| Liquidation Penalty   | 7.50% | 7.50% | 7.50%                    |

Additionaly [0xac140648435d03f784879cd789130F22Ef588Fcd](https://debank.com/profile/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for ezETH and the corresponding aToken on both instances.

## References

- Implementation: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241221_Multi_OnboardEzETHToArbitrumAndBaseInstances/AaveV3Arbitrum_OnboardEzETHToArbitrumAndBaseInstances_20241221.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241221_Multi_OnboardEzETHToArbitrumAndBaseInstances/AaveV3Base_OnboardEzETHToArbitrumAndBaseInstances_20241221.sol)
- Tests: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241221_Multi_OnboardEzETHToArbitrumAndBaseInstances/AaveV3Arbitrum_OnboardEzETHToArbitrumAndBaseInstances_20241221.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241221_Multi_OnboardEzETHToArbitrumAndBaseInstances/AaveV3Base_OnboardEzETHToArbitrumAndBaseInstances_20241221.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0xf9fa710414237636cba11187111773fac04f74eb1a562d2b50fca86cb72a778e)
- [Discussion](https://governance.aave.com/t/arfc-onboard-ezeth-to-arbitrum-and-base-instances/19622)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
