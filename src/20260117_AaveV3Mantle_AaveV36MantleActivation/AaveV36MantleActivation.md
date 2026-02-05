---
title: "Aave V3.6 Mantle Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-deploy-aave-v3-on-mantle/20542/12"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0x2f9378770f1838f0ea8d483239af1530c9fbea98d648e0b11e4647dcb722d119"
---

## Simple Summary

This proposal allows the Aave governance to activate the Aave V3 Mantle pool (3.6) by completing all the initial setup and listing WETH, WMNT, USDT0, USDC, USDe, sUSDe, FBTC, syrupUSDT, wrsETH as suggested by the risk service providers engaged with the DAO on the governance forum.

All the Aave Mantle V3 addresses can be found in the [aave-address-book](https://github.com/bgd-labs/aave-address-book/blob/04ee5b91ffeac4b7695babb59da3a9c426b8b35e/src/AaveV3Mantle.sol).

## Motivation

All the governance procedures for the expansion of Aave v3 to Mantle have been finished, said:

- Positive signaling and approval regarding the expansion on the [governance forum](https://governance.aave.com/t/arfc-deploy-aave-v3-on-mantle/20542), and [snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x2f9378770f1838f0ea8d483239af1530c9fbea98d648e0b11e4647dcb722d119).
- Positive technical evaluation done by BGD Labs of the Mantle network, as described in the [forum](https://governance.aave.com/t/bgd-aave-mantle-infrastructure-technical-evaluation/21628) in detail.
- Positive risk analysis and assets/parameters recommendation by the risk service providers.

## Specification

The proposal will do the following:

- List the following assets on Aave V3 Mantle: WETH, WMNT, USDT0, USDC, USDe, sUSDe, FBTC, syrupUSDT, wrsETH.
- Set the risk steward as the risk admin by executing `ACL_MANAGER.addRiskAdmin()`.
- Set the guardian address as the pool admin by executing `ACL_MANAGER.addPoolAdmin()`. This is following the standard procedure of keeping pool admin on the Aave Guardian during the bootstrap period, for security.
- Set ACI [multi-sig](https://mantlescan.xyz/address/0xac140648435d03f784879cd789130F22Ef588Fcd) as liquidity mining admin for all aTokens and underlying tokens by calling `EMISSION_MANAGER.setEmissionAdmin()` method.

The table below illustrates the configured risk parameters for the assets to be listed:

| Parameter                 |           WETH |          WMNT |      USDT0 |       USDC |       USDe |        GHO |      sUSDe |     FBTC |  syrupUSDT |   wrsETH |
| ------------------------- | -------------: | ------------: | ---------: | ---------: | ---------: | ---------: | ---------: | -------: | ---------: | -------: |
| Isolation Mode            |           true |          true |      false |      false |      false |      false |      false |    false |      false |    false |
| Borrowable                |        ENABLED |      DISABLED |    ENABLED |    ENABLED |    ENABLED |    ENABLED |   DISABLED | DISABLED |   DISABLED | DISABLED |
| Collateral Enabled        |           true |          true |      false |      false |      false |      false |      false |    false |      false |    false |
| Supply Cap                |         30,000 |     5,000,000 | 50,000,000 | 10,000,000 | 40,000,000 | 20,000,000 | 80,000,000 |       50 | 70,000,000 |   18,000 |
| Borrow Cap                |         28,000 |             1 | 47,500,000 |  9,500,000 | 36,000,000 | 18,000,000 |          1 |        1 |          1 |        1 |
| Debt Ceiling              | USD 30,000,000 | USD 2,000,000 |      USD 0 |      USD 0 |      USD 0 |      USD 0 |      USD 0 |    USD 0 |      USD 0 |    USD 0 |
| LTV                       |         80.5 % |          40 % |        0 % |        0 % |        0 % |        0 % |        0 % |      0 % |        0 % |      0 % |
| LT                        |           83 % |          45 % |        0 % |        0 % |        0 % |        0 % |        0 % |      0 % |        0 % |      0 % |
| Liquidation Bonus         |          5.5 % |          10 % |        0 % |        0 % |        0 % |        0 % |        0 % |      0 % |        0 % |      0 % |
| Liquidation Protocol Fee  |           10 % |          10 % |       10 % |       10 % |       10 % |       10 % |       10 % |     10 % |       10 % |     10 % |
| Reserve Factor            |           15 % |          20 % |       10 % |       10 % |       25 % |       10 % |       20 % |     20 % |       20 % |     20 % |
| Base Variable Borrow Rate |            0 % |           0 % |        0 % |        0 % |        0 % |        2 % |        0 % |      0 % |        0 % |      0 % |
| Variable Slope 1          |          2.5 % |           5 % |        5 % |        5 % |     5.25 % |        3 % |        5 % |      5 % |        5 % |      5 % |
| Variable Slope 2          |            8 % |          20 % |       10 % |       10 % |       12 % |       40 % |       20 % |     20 % |       20 % |     20 % |
| Uoptimal                  |           90 % |          90 % |       90 % |       90 % |       85 % |       90 % |       90 % |     90 % |       90 % |     90 % |
| Flashloanable             |        ENABLED |       ENABLED |    ENABLED |    ENABLED |    ENABLED |    ENABLED |    ENABLED |  ENABLED |    ENABLED |  ENABLED |
| Siloed Borrowing          |       DISABLED |      DISABLED |   DISABLED |   DISABLED |   DISABLED |   DISABLED |   DISABLED | DISABLED |   DISABLED | DISABLED |
| Borrowable in Isolation   |       DISABLED |      DISABLED |    ENABLED |    ENABLED |    ENABLED |    ENABLED |   DISABLED | DISABLED |   DISABLED | DISABLED |

### Oracle details:

|                             | sUSDe                                                                                              | syrupUSDT                                                                                              | wrsETH                                                                                             | USDT0                                                                                        | USDC                                                                                         | USDe                                                                                         | GHO                                                                                           | FBTC                                                                                 | WETH                                                                                | WMNT                                                                                 |
| --------------------------- | -------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| Oracle                      | [Capped sUSDe/USDT/USD](https://mantlescan.xyz/address/0x8b47ec48ac560793861d94a997d020872c1ce3f5) | [Capped SyrupUSDT/USDT/USD](https://mantlescan.xyz/address/0xcf1700ee060ab65fa16d5f44a6fbf16721eb0d9b) | [Capped wrsETH/ETH/USD](https://mantlescan.xyz/address/0xfed794060d37391d966f931b9509378063c5b0fb) | [Capped USDT/USD](https://mantlescan.xyz/address/0xFA5dEcEd7cdCEAB065addd0E32D9527ABd1069Ee) | [Capped USDC/USD](https://mantlescan.xyz/address/0x3876FB349c14613e0633b5cAe08C4E3B1d4904fB) | [Capped USDT/USD](https://mantlescan.xyz/address/0xFA5dEcEd7cdCEAB065addd0E32D9527ABd1069Ee) | [Fixed GHO Oracle](https://mantlescan.xyz/address/0x360d8aa8f6b09b7bc57af34db2eb84dd87bf4d12) | [BTC/USD](https://mantlescan.xyz/address/0x7db2275279F52D0914A481e14c4Ce5a59705A25b) | [ETH/USD](http://mantlescan.xyz/address/0x5bc7Cf88EB131DB18b5d7930e793095140799aD5) | [MNT/USD](https://mantlescan.xyz/address/0xD97F20bEbeD74e8144134C4b148fE93417dd0F96) |
| PriceCap                    | -                                                                                                  | -                                                                                                      | -                                                                                                  | 1.04                                                                                         | 1.04                                                                                         | 1.04                                                                                         | -                                                                                             | -                                                                                    | -                                                                                   | -                                                                                    |
| Exchange Rate Feed          | [CL sUSDe/USDe](https://mantlescan.xyz/address/0x1D28137b7695d1Dcd122E5Bf0ce7eE92360e83b7)         | [CL syrupUSDT/USDT](https://mantlescan.xyz/address/0xdDEaeAdF319bd363120Af02fBdb1e2C5A3Ce172a)         | [CL rsETH/ETH](https://mantlescan.xyz/address/0xAa7B3679db156d3773620eBce98E38Cd87544C0e)          | -                                                                                            | -                                                                                            | -                                                                                            | -                                                                                             | -                                                                                    | -                                                                                   | -                                                                                    |
| Base Feed                   | [Capped USDT/USD](https://mantlescan.xyz/address/0xFA5dEcEd7cdCEAB065addd0E32D9527ABd1069Ee)       | [Capped USDT/USD](https://mantlescan.xyz/address/0xFA5dEcEd7cdCEAB065addd0E32D9527ABd1069Ee)           | [CL ETH/USD](https://mantlescan.xyz/address/0x5bc7Cf88EB131DB18b5d7930e793095140799aD5)            | -                                                                                            | -                                                                                            | -                                                                                            | -                                                                                             | -                                                                                    | -                                                                                   | -                                                                                    |
| MaxYearlyRatioGrowthPercent | 15.19%                                                                                             | 8.45%                                                                                                  | 6.67%                                                                                              | -                                                                                            | -                                                                                            | -                                                                                            | -                                                                                             | -                                                                                    | -                                                                                   | -                                                                                    |
| MinimumSnapshotDelay        | 14 days                                                                                            | 7 days                                                                                                 | 14 days                                                                                            | -                                                                                            | -                                                                                            | -                                                                                            | -                                                                                             | -                                                                                    | -                                                                                   | -                                                                                    |
| Latest Answer (19 Jan 2026) | $1.21612359                                                                                        | $1.11193853                                                                                            | $3390.23237648                                                                                     | $0.9995361                                                                                   | $0.99974                                                                                     | $0.9995361                                                                                   | $1                                                                                            | $92,523.93                                                                           | $3,189.416319                                                                       | $0.93201554                                                                          |

### E-Mode Configurations

**sUSDe Stablecoins [EModeId: 1]**

| **Parameter**         |        |        |       |      |     |
| --------------------- | ------ | ------ | ----- | ---- | --- |
| Asset                 | sUSDe  | USDe   | USDT0 | USDC | GHO |
| Collateral            | Yes    | Yes    | No    | No   | No  |
| Borrowable            | No     | No     | Yes   | Yes  | Yes |
| Max LTV               | 90.00% | 90.00% | -     | -    | -   |
| Liquidation Threshold | 92.00% | 92.00% | -     | -    | -   |
| Liquidation Bonus     | 4.00%  | 4.00%  | -     | -    | -   |

**USDe Stablecoins [EModeId: 2]**

| **Parameter**         |        |       |      |
| --------------------- | ------ | ----- | ---- |
| Asset                 | USDe   | USDT0 | USDC |
| Collateral            | Yes    | No    | No   |
| Borrowable            | No     | Yes   | Yes  |
| Max LTV               | 90.00% | -     | -    |
| Liquidation Threshold | 93.00% | -     | -    |
| Liquidation Bonus     | 2.00%  | -     | -    |

**fBTC Stablecoins [EModeId: 3]**

| **Parameter**         |        |       |      |      |
| --------------------- | ------ | ----- | ---- | ---- |
| Asset                 | fBTC   | USDT0 | USDC | USDe |
| Collateral            | Yes    | No    | No   | No   |
| Borrowable            | No     | Yes   | Yes  | Yes  |
| Max LTV               | 75.00% | -     | -    | -    |
| Liquidation Threshold | 79.00% | -     | -    | -    |
| Liquidation Bonus     | 8.00%  | -     | -    | -    |

**syrupUSDT Stablecoins [EModeId: 4]**

| **Parameter**         |           |       |      |
| --------------------- | --------- | ----- | ---- |
| Asset                 | syrupUSDT | USDT0 | USDC |
| Collateral            | Yes       | No    | No   |
| Borrowable            | No        | Yes   | Yes  |
| Max LTV               | 90.00%    | -     | -    |
| Liquidation Threshold | 92.00%    | -     | -    |
| Liquidation Bonus     | 4.00%     | -     | -    |

**wrsETH Correlated [EModeId: 5]**

| **Parameter**         |        |      |
| --------------------- | ------ | ---- |
| Asset                 | wrsETH | WETH |
| Collateral            | Yes    | No   |
| Borrowable            | No     | Yes  |
| Max LTV               | 93.00% | -    |
| Liquidation Threshold | 95.00% | -    |
| Liquidation Bonus     | 1.00%  | -    |

### Security procedures:

- The proposal execution is simulated within the tests and the resulting pool configuration is tested for correctness.
- The deployed pool and other permissions have been programmatically verified, which can be found on the [aave-permissions-book](https://github.com/aave-dao/aave-permissions-book/blob/61ca23a69b755b7883066ee8cadc75a0ef34f401/out/MANTLE-V3.md#contracts).
- In addition, we have also checked the code diffs of the deployed Mantle contracts with the production instance, which can be found [here](https://github.com/bgd-labs/aave-v3-origin/pull/6).

## References

- Implementation: [AaveV3Mantle](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260117_AaveV3Mantle_AaveV36MantleActivation/AaveV3Mantle_AaveV36MantleActivation_20260117.sol)
- Tests: [AaveV3Mantle](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260117_AaveV3Mantle_AaveV36MantleActivation/AaveV3Mantle_AaveV36MantleActivation_20260117.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x2f9378770f1838f0ea8d483239af1530c9fbea98d648e0b11e4647dcb722d119)
- [Discussion](https://governance.aave.com/t/arfc-deploy-aave-v3-on-mantle/20542/12)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
