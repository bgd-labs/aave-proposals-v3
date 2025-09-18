---
title: "Aave V3.5 Plasma Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-deploy-aave-v3-on-plasma/21494"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xa2b9d0717a82a111acc27e514bed07caa9b8636c12dd68fb61ae4dc57503c3cd"
---

## Simple Summary

This proposal allows the Aave governance to activate the Aave V3 Plasma pool (3.5) by completing all the initial setup and listing USDT0, USDe, sUSDe, XAUt0, weETH, WETH as suggested by the risk service providers engaged with the DAO on the governance forum.

All the Aave Plasma V3 addresses can be found in the [aave-address-book](https://github.com/bgd-labs/aave-address-book/blob/a0c2498d496421565ca1a6c87f5b3e10e5bcc65b/src/AaveV3Plasma.sol).

## Motivation

All the governance procedures for the expansion of Aave v3 to Plasma have been finished, said:

- Positive signaling and approval regarding the expansion on the [governance forum](https://governance.aave.com/t/arfc-deploy-aave-v3-on-plasma/21494), and [snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xa2b9d0717a82a111acc27e514bed07caa9b8636c12dd68fb61ae4dc57503c3cd).
- Positive technical evaluation done by BGD Labs of the Plasma network, as described in the [forum](https://governance.aave.com/t/bgd-aave-plasma-infrastructure-technical-evaluation/23133) in detail.
- Positive risk analysis and assets/parameters recommendation by the risk service providers.

## Specification

The proposal will do the following:

- List the following assets on Aave V3 Plasma: USDT0, USDe, sUSDe, XAUt0, weETH, WETH.
- Set the risk steward as the risk admin by executing `ACL_MANAGER.addRiskAdmin()`.
- Set the guardian address as the pool admin by executing `ACL_MANAGER.addPoolAdmin()`. This is following the standard procedure of keeping pool admin on the Aave Guardian during the bootstrap period, for security.
- Set ACI multi-sig as liquidity mining admin for all aTokens and underlying tokens by calling `EMISSION_MANAGER.setEmissionAdmin()` method.

The table below illustrates the configured risk parameters for the assets to be listed:

| Parameter                 |    USDT0 |     USDe |    sUSDe |          XAUt0 |    weETH |     WETH |
| ------------------------- | -------: | -------: | -------: | -------------: | -------: | -------: |
| Isolation Mode            |    false |    false |    false |           true |    false |    false |
| Borrowable                |  ENABLED |  ENABLED | DISABLED |       DISABLED | DISABLED |  ENABLED |
| Collateral Enabled        |     true |     true |     true |           true |     true |     true |
| Supply Cap                |  100,000 |  100,000 |  100,000 |             30 |       20 |       20 |
| Borrow Cap                |   50,000 |   50,000 |        1 |              1 |        1 |       10 |
| Debt Ceiling              |    USD 0 |    USD 0 |    USD 0 | USD 18,000,000 |    USD 0 |    USD 0 |
| LTV                       |     75 % |     72 % |   0.05 % |           70 % |   0.05 % |   80.5 % |
| LT                        |     78 % |     75 % |    0.1 % |           75 % |    0.1 % |     83 % |
| Liquidation Bonus         |    4.5 % |    8.5 % |    8.5 % |          7.5 % |      7 % |    5.5 % |
| Liquidation Protocol Fee  |     10 % |     10 % |     10 % |           10 % |     10 % |     10 % |
| Reserve Factor            |     10 % |     25 % |     20 % |           20 % |     20 % |     15 % |
| Base Variable Borrow Rate |    2.5 % |    2.5 % |      0 % |            0 % |      0 % |      0 % |
| Variable Slope 1          |      4 % |      5 % |      9 % |            9 % |      9 % |     2.7% |
| Variable Slope 2          |     20 % |     50 % |     75 % |           75 % |     75 % |      20% |
| Uoptimal                  |     92 % |     85 % |     60 % |           60 % |     60 % |     92 % |
| Flashloanable             |  ENABLED |  ENABLED |  ENABLED |        ENABLED |  ENABLED |  ENABLED |
| Siloed Borrowing          | DISABLED | DISABLED | DISABLED |       DISABLED | DISABLED | DISABLED |
| Borrowable in Isolation   |  ENABLED | DISABLED | DISABLED |       DISABLED | DISABLED | DISABLED |

**Please note: As a matter of extra caution, XPL will be listed separately at a later time. Additionally, the plasma instance will be activated very limited interim caps, and this AIP also authorizes the Aave Protocol Guardian to increase it to the following pre-approved levels below once technical SP have triple checked everything:**

| Parameter  |         USDT0 |        USDe |       sUSDe | XAUt0 |  weETH |   WETH |
| ---------- | ------------: | ----------: | ----------: | ----: | -----: | -----: |
| Supply Cap | 2,200,000,000 | 500,000,000 | 450,000,000 | 7,000 | 10,000 | 80,000 |
| Borrow Cap | 2,000,000,000 |  50,000,000 |           1 |     1 |      1 | 10,000 |

### Oracle details:

|                             |                                                                                       USDT0 |                                                                                        USDe |                                                                                                 sUSDe |                                                                                                      weETH |                                                                                WETH |                                                                               XAUt0 |
| --------------------------- | ------------------------------------------------------------------------------------------: | ------------------------------------------------------------------------------------------: | ----------------------------------------------------------------------------------------------------: | ---------------------------------------------------------------------------------------------------------: | ----------------------------------------------------------------------------------: | ----------------------------------------------------------------------------------: |
| Oracle                      | [Capped USDT/USD](https://plasmascan.to/address/0xdBbB0b5DD13E7AC9C56624834ef193df87b022c3) | [Capped USDT/USD](https://plasmascan.to/address/0xdBbB0b5DD13E7AC9C56624834ef193df87b022c3) | [Capped sUSDe / USDe / USD](https://plasmascan.to/address/0x40eE40D7332995CACA49Db46B94237Fa64647Bd4) | [Capped weETH / eETH(ETH) / USD](https://plasmascan.to/address/0xA7786e3042435f88869e5a4e384B0AD6B009800b) | [ETH/USD](https://plasmascan.to/address/0x43A7dd2125266c5c4c26EB86cd61241132426Fe7) | [XAU/USD](https://plasmascan.to/address/0x921371Fa4d4A30cD350D29762ccB8A5861724E29) |
| PriceCap                    |                                                                                      1.04e8 |                                                                                      1.04e8 |                                                                                                     - |                                                                                                          - |                                                                                   - |                                                                                   - |
| Exchange Rate Feed          |                                                                                           - |                                                                                           - |             [CL SUSDe/USDe](https://plasmascan.to/address/0x802033dc696B92e5ED5bF68E1750F7Ed3329eabD) |                   [CL weETH/ETH](https://plasmascan.to/address/0x00D7d8816E969EA6cA9125c3f5D279f9a6D253f6) |                                                                                   - |                                                                                   - |
| Base Feed                   |    [CL USDT/USD](https://plasmascan.to/address/0x70b77FcdbE2293423e41AdD2FB599808396807BC/) |    [CL USDT/USD](https://plasmascan.to/address/0x70b77FcdbE2293423e41AdD2FB599808396807BC/) |           [Capped USDT/USD](https://plasmascan.to/address/0xdBbB0b5DD13E7AC9C56624834ef193df87b022c3) |                                                                                                          - |                                                                                   - |                                                                                   - |
| MaxYearlyRatioGrowthPercent |                                                                                           - |                                                                                           - |                                                                                               15.19 % |                                                                                                     8.75 % |                                                                                   - |                                                                                   - |
| MinimumSnapshotDelay        |                                                                                           - |                                                                                           - |                                                                                               14 days |                                                                                                     7 days |                                                                                   - |                                                                                   - |

### EMode Configurations:

#### USDe Stablecoin E-Mode

| **Parameter**         | **Value** | **Value** |
| --------------------- | --------- | --------- |
| Asset                 | USDe      | USDT0     |
| Collateral            | Yes       | No        |
| Borrowable            | No        | Yes       |
| Max LTV               | 90%       | -         |
| Liquidation Threshold | 93%       | -         |
| Liquidation Bonus     | 2%        | -         |

#### sUSDe Stablecoin E-Mode

| **Parameter**         | **Value** | **Value** | **Value** |
| --------------------- | --------- | --------- | --------- |
| Asset                 | USDe      | sUSDe     | USDT0     |
| Collateral            | Yes       | Yes       | No        |
| Borrowable            | No        | No        | Yes       |
| Max LTV               | 90%       | 90%       | -         |
| Liquidation Threshold | 92%       | 92%       | -         |
| Liquidation Bonus     | 4.0%      | 4.0%      | -         |

#### weETH WETH E-Mode

| **Parameter**         | **Value** | **Value** |
| --------------------- | --------- | --------- |
| Asset                 | weETH     | WETH      |
| Collateral            | Yes       | No        |
| Borrowable            | No        | Yes       |
| Max LTV               | 93%       | -         |
| Liquidation Threshold | 95%       | -         |
| Liquidation Bonus     | 1.00%     | -         |

#### weETH Stablecoin E-Mode

| **Parameter**         | **Value** | **Value** |
| --------------------- | --------- | --------- |
| Asset                 | weETH     | USDT0     |
| Collateral            | Yes       | No        |
| Borrowable            | No        | Yes       |
| Max LTV               | 75%       | -         |
| Liquidation Threshold | 78%       | -         |
| Liquidation Bonus     | 7.50%     | -         |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://plasmascan.to/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for the underlying tokens listed and their corresponding aTokens.

### Security procedures:

- The proposal execution is simulated within the tests and the resulting pool configuration is tested for correctness.
- The deployed pool and other permissions have been programmatically verified, which can be found on the [aave-permissions-book](https://github.com/aave-dao/aave-permissions-book/blob/b7eab1b00898a92f8acb84afade0cb01187f5b9c/out/PLASMA-V3.md#contracts).
- In addition, we have also checked the code diffs of the deployed plasma contracts with the production instance, which can be found [here](https://github.com/bgd-labs/aave-v3-origin/pull/4).

## References

- Implementation: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/22de4a777023284c6f2801f58249bba7302dde04/src/20250917_AaveV3Plasma_AaveV35PlasmaActivation/AaveV3Plasma_AaveV35PlasmaActivation_20250917.sol)
- Tests: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/22de4a777023284c6f2801f58249bba7302dde04/src/20250917_AaveV3Plasma_AaveV35PlasmaActivation/AaveV3Plasma_AaveV35PlasmaActivation_20250917.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xa2b9d0717a82a111acc27e514bed07caa9b8636c12dd68fb61ae4dc57503c3cd)
- [Discussion](https://governance.aave.com/t/arfc-deploy-aave-v3-on-plasma/21494)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
