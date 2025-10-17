---
title: "Onboard sUSDe and USDe to Aave V3 Avalanche Instance"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-susde-and-usde-to-aave-v3-avalanche-instance/23081"
---

## Simple Summary

This proposal seeks to onboard sUSDe and USDe to the Aave v3 protocol on Avalanche.

## Motivation

The onboarding of sUSDe and USDe to the Aave Avalanche Instance will provide users with high quality yield bearing stablecoin collateral to help expand stablecoin usage on this instance.

As the Avalanche instance shows promise and potential for significant growth we believe the time is right for expanding collateral options on this network with a focus on those assets which have proven to be in demand on other Aave instances.

Ava Labs has committed 1000 AVAX per week in incentives to bootstrapping usage of these assets on the Avalanche Aave instance.

## Specification

The table below illustrates the configured risk parameters for **USDe** and **sUSDe**

| Parameter                 |       USDe |      sUSDe |
| ------------------------- | ---------: | ---------: |
| Isolation Mode            |      false |      false |
| Borrowable                |    ENABLED |   DISABLED |
| Collateral Enabled        |       true |       true |
| Supply Cap                | 50,000,000 | 50,000,000 |
| Borrow Cap                | 42,500,000 |          1 |
| Debt Ceiling              |      USD 0 |      USD 0 |
| LTV                       |       70 % |       70 % |
| LT                        |       73 % |       73 % |
| Liquidation Bonus         |      8.5 % |      8.5 % |
| Liquidation Protocol Fee  |       10 % |       10 % |
| Reserve Factor            |       25 % |       45 % |
| Base Variable Borrow Rate |        0 % |        0 % |
| Variable Slope 1          |      6.5 % |       10 % |
| Variable Slope 2          |       50 % |      300 % |
| Uoptimal                  |       80 % |       45 % |
| Flashloanable             |    ENABLED |    ENABLED |
| Siloed Borrowing          |   DISABLED |   DISABLED |
| Borrowable in Isolation   |   DISABLED |   DISABLED |

### Oracle details

|                             |                                                                                       USDe |                                                                                                sUSDe |
| --------------------------- | -----------------------------------------------------------------------------------------: | ---------------------------------------------------------------------------------------------------: |
| Oracle                      | [Capped USDT/USD](https://snowtrace.io/address/0x5b7810a910B4a878AaA4800a824E5E5796838009) | [Capped sUSDe / USDe / USD](https://snowtrace.io/address/0x8Fb2db0A3b25db76B9BE2013751F8390ea8E5f0A) |
| PriceCap                    |                                                                                     1.04e8 |                                                                                                    - |
| Exchange Rate Feed          |                                                                                          - |             [CL SUSDe/USDe](https://snowtrace.io/address/0xb7441BBD0298aaeF4f2BbD40E8025Cf59cA6E8D5) |
| Base Feed                   |     [CL USDT/USD](https://snowtrace.io/address/0xEBE676ee90Fe1112671f19b6B7459bC678B67e8a) |           [Capped USDT/USD](https://snowtrace.io/address/0x5b7810a910B4a878AaA4800a824E5E5796838009) |
| MaxYearlyRatioGrowthPercent |                                                                                          - |                                                                                              15.19 % |
| MinimumSnapshotDelay        |                                                                                          - |                                                                                              14 days |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://snowscan.xyz/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for USDe, sUSDe and the corresponding aTokens.

### Emode details

**USDe Stablecoin E-mode Configuration**

| **Parameter**         | **Value** | **Value** | **Value** | **Value** |
| --------------------- | --------- | --------- | --------- | --------- |
| Asset                 | USDe      | USDt      | GHO       | USDC      |
| Collateral            | Yes       | No        | No        | No        |
| Borrowable            | No        | Yes       | Yes       | Yes       |
| Max LTV               | 89%       | -         | -         | -         |
| Liquidation Threshold | 92%       | -         | -         | -         |
| Liquidation Bonus     | 2%        | -         | -         | -         |

**sUSDe Stablecoin E-mode Configuration**

| **Parameter**         | **Value** | **Value** | **Value** | **Value** | **Value** |
| --------------------- | --------- | --------- | --------- | --------- | --------- |
| Asset                 | sUSDe     | USDe      | USDt      | GHO       | USDC      |
| Collateral            | Yes       | No        | No        | No        | No        |
| Borrowable            | No        | Yes       | Yes       | Yes       | Yes       |
| Max LTV               | 89%       | -         | -         | -         | -         |
| Liquidation Threshold | 91%       | -         | -         | -         | -         |
| Liquidation Bonus     | 4%        | -         | -         | -         | -         |

## References

- Implementation: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251013_AaveV3Avalanche_OnboardSUSDeAndUSDeToAaveV3AvalancheInstance/AaveV3Avalanche_OnboardSUSDeAndUSDeToAaveV3AvalancheInstance_20251013.sol)
- Tests: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251013_AaveV3Avalanche_OnboardSUSDeAndUSDeToAaveV3AvalancheInstance/AaveV3Avalanche_OnboardSUSDeAndUSDeToAaveV3AvalancheInstance_20251013.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-susde-and-usde-to-aave-v3-avalanche-instance/23081)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
