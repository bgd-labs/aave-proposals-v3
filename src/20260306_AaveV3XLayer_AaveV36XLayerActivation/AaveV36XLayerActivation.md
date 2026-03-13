---
title: "Aave V3.6 XLayer Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-deploy-aave-v3-on-x-layer/23175/18"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0x251c520f1f1da8287168420fa2d2a73a2eb5342c3c62508553123129dec059b0"
---

## Simple Summary

This proposal allows the Aave governance to activate the Aave V3 XLayer pool (3.6) by completing all the initial setup and listing USDT0, USDG, xBTC, WOKB, xETH, xSOL as suggested by the risk service providers engaged with the DAO on the governance forum.

All the Aave XLayer V3 addresses can be found in the [aave-address-book](https://github.com/bgd-labs/aave-address-book/blob/main/src/AaveV3XLayer.sol).

## Motivation

All the governance procedures for the expansion of Aave v3 to XLayer have been finished, said:

- Positive signaling and approval regarding the expansion on the governance [forum](https://governance.aave.com/t/arfc-deploy-aave-v3-on-x-layer/23175/18), and [snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x251c520f1f1da8287168420fa2d2a73a2eb5342c3c62508553123129dec059b0).
- Positive technical evaluation done by BGD Labs of the XLayer network.
- Positive risk analysis and assets/parameters recommendation by the risk service providers.

## Specification

The proposal will do the following:

- List the following assets on Aave V3 XLayer: USDT0, USDG, xBTC, WOKB, xETH, xSOL, xBETH, xOKSOL.
- Set the risk steward as the risk admin by executing `ACL_MANAGER.addRiskAdmin()`.
- Set the guardian address as the pool admin by executing `ACL_MANAGER.addPoolAdmin()`. This is following the standard procedure of keeping pool admin on the Aave Guardian during the bootstrap period, for security.
- Set ACI [multi-sig](https://www.oklink.com/xlayer/address/0xac140648435d03f784879cd789130F22Ef588Fcd) as liquidity mining admin for all aTokens and underlying tokens by calling `EMISSION_MANAGER.setEmissionAdmin()` method.

The table below illustrates the configured risk parameters for the assets to be listed:

| Parameter                 |                                                                          USDT0 |                                                                           USDG |               xBTC |               WOKB |                              xETH |                               xSOL |         xBETH |         xOKSOL |
| ------------------------- | -----------------------------------------------------------------------------: | -----------------------------------------------------------------------------: | -----------------: | -----------------: | --------------------------------: | ---------------------------------: | ------------: | -------------: |
| Supply Cap                |                                                                     50,000,000 |                                                                      5,000,000 |                150 |            125,000 |                             5,000 |                            110,000 |         5,700 |        135,000 |
| Borrow Cap                |                                                                     48,000,000 |                                                                      4,250,000 |                 20 |                  1 |                             1,300 |                             14,000 |             1 |              1 |
| Borrowable                |                                                                        ENABLED |                                                                        ENABLED |            ENABLED |           DISABLED |                           ENABLED |                            ENABLED |      DISABLED |       DISABLED |
| Collateral Enabled        |                                                                           true |                                                                          false |               true |              false |                              true |                               true |         false |          false |
| LTV                       |                                                                            70% |                                                                             0% |                70% |                 0% |                               70% |                                60% |            0% |             0% |
| LT                        |                                                                            75% |                                                                             0% |                75% |                 0% |                               75% |                                65% |            0% |             0% |
| Liquidation Bonus         |                                                                           7.5% |                                                                             0% |               7.5% |                 0% |                              7.5% |                               7.5% |            0% |             0% |
| Liquidation Protocol Fee  |                                                                            10% |                                                                            10% |                10% |                10% |                               15% |                                10% |           10% |            10% |
| Debt Ceiling              |                                                                          USD 0 |                                                                          USD 0 |              USD 0 |              USD 0 |                             USD 0 |                              USD 0 |         USD 0 |          USD 0 |
| Isolation Mode            |                                                                          false |                                                                          false |              false |              false |                             false |                              false |         false |          false |
| Reserve Factor            |                                                                            10% |                                                                            10% |                10% |                15% |                               15% |                                15% |           15% |            15% |
| Uoptimal                  |                                                                            90% |                                                                            80% |                80% |                45% |                               90% |                                80% |           45% |            45% |
| Base Variable Borrow Rate |                                                                             0% |                                                                             0% |                 0% |                 0% |                                0% |                                 0% |            0% |             0% |
| Variable Slope 1          |                                                                             5% |                                                                             5% |              2.75% |                 7% |                              2.5% |                                 5% |            7% |             7% |
| Variable Slope 2          |                                                                            40% |                                                                            45% |                40% |               300% |                               20% |                                20% |          300% |           300% |
| Flashloanable             |                                                                        ENABLED |                                                                        ENABLED |            ENABLED |            ENABLED |                           ENABLED |                            ENABLED |       ENABLED |        ENABLED |
| Siloed Borrowing          |                                                                       DISABLED |                                                                       DISABLED |           DISABLED |           DISABLED |                          DISABLED |                           DISABLED |      DISABLED |       DISABLED |
| Borrowable in Isolation   |                                                                       DISABLED |                                                                       DISABLED |           DISABLED |           DISABLED |                          DISABLED |                           DISABLED |      DISABLED |       DISABLED |
| E-Mode                    | xBTC\_\_USDT0_USDG, xETH\_\_USDT0_USDG, xSOL\_\_USDT0_USDG, WOKB\_\_USDT0_USDG | xBTC\_\_USDT0_USDG, xETH\_\_USDT0_USDG, xSOL\_\_USDT0_USDG, WOKB\_\_USDT0_USDG | xBTC\_\_USDT0_USDG | WOKB\_\_USDT0_USDG | xETH\_\_USDT0_USDG, xBETH\_\_xETH | xSOL\_\_USDT0_USDG, xOKSOL\_\_xSOL | xBETH\_\_xETH | xOKSOL\_\_xSOL |

### E-Mode Configurations:

**xBTC\_\_USDT0_USDG [EModeId: 1]**

| **Parameter**         |        |       |      |
| --------------------- | ------ | ----- | ---- |
| Asset                 | xBTC   | USDT0 | USDG |
| Collateral            | Yes    | No    | No   |
| Borrowable            | No     | Yes   | Yes  |
| Max LTV               | 78.00% | -     | -    |
| Liquidation Threshold | 81.00% | -     | -    |
| Liquidation Bonus     | 6.00%  | -     | -    |

**xETH\_\_USDT0_USDG [EModeId: 2]**

| **Parameter**         |        |       |      |
| --------------------- | ------ | ----- | ---- |
| Asset                 | xETH   | USDT0 | USDG |
| Collateral            | Yes    | No    | No   |
| Borrowable            | No     | Yes   | Yes  |
| Max LTV               | 78.00% | -     | -    |
| Liquidation Threshold | 80.00% | -     | -    |
| Liquidation Bonus     | 6.00%  | -     | -    |

**xSOL\_\_USDT0_USDG [EModeId: 3]**

| **Parameter**         |        |       |      |
| --------------------- | ------ | ----- | ---- |
| Asset                 | xSOL   | USDT0 | USDG |
| Collateral            | Yes    | No    | No   |
| Borrowable            | No     | Yes   | Yes  |
| Max LTV               | 65.00% | -     | -    |
| Liquidation Threshold | 70.00% | -     | -    |
| Liquidation Bonus     | 7.50%  | -     | -    |

**WOKB\_\_USDT0_USDG [EModeId: 4]**

| **Parameter**         |        |       |      |
| --------------------- | ------ | ----- | ---- |
| Asset                 | WOKB   | USDT0 | USDG |
| Collateral            | Yes    | No    | No   |
| Borrowable            | No     | Yes   | Yes  |
| Max LTV               | 50.00% | -     | -    |
| Liquidation Threshold | 55.00% | -     | -    |
| Liquidation Bonus     | 10.00% | -     | -    |

**xBETH\_\_xETH [EModeId: 5]**

| **Parameter**         |        |      |
| --------------------- | ------ | ---- |
| Asset                 | xBETH  | xETH |
| Collateral            | Yes    | No   |
| Borrowable            | No     | Yes  |
| Max LTV               | 88.00% | -    |
| Liquidation Threshold | 90.00% | -    |
| Liquidation Bonus     | 2.00%  | -    |

**xOKSOL\_\_xSOL [EModeId: 6]**

| **Parameter**         |        |      |
| --------------------- | ------ | ---- |
| Asset                 | xOKSOL | xSOL |
| Collateral            | Yes    | No   |
| Borrowable            | No     | Yes  |
| Max LTV               | 88.00% | -    |
| Liquidation Threshold | 90.00% | -    |
| Liquidation Bonus     | 2.00%  | -    |

### Oracle details:

|                            | USDT0                                                                                               | USDG                                                                                                   | xBTC                                                                                        | WOKB                                                                                        | xETH                                                                                        | xSOL                                                                                        | xBETH                                                                                              | xOKSOL                                                                                              |
| -------------------------- | --------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| Oracle                     | [Capped USDT/USD](https://www.oklink.com/xlayer/address/0x7ec7e5497eaf312fe82f8307d05eb0e5f0f157d3) | [OneUSDFixedAdapter](https://www.oklink.com/xlayer/address/0xcfcbbf3e0c27b936cf673c4fc8bcc68f721af475) | [BTC/USD](https://www.oklink.com/xlayer/address/0x4D6f6488a2B3a5f7b088f276887f608a1e9805c4) | [OKB/USD](https://www.oklink.com/xlayer/address/0x4Ff345b18a2bF894F8627F41501FBf30d5C5e7BE) | [ETH/USD](https://www.oklink.com/xlayer/address/0x8b85b50535551F8E8cDAF78dA235b5Cf1005907b) | [SOL/USD](https://www.oklink.com/xlayer/address/0xF959E1B5cA535C28aD24F7f672Bf1A93900810cF) | [xBETH/USD CAPO](https://www.oklink.com/xlayer/address/0xd07b7ef776329e284c43b41c460ab6e95e7d9b22) | [xOKSOL/USD CAPO](https://www.oklink.com/xlayer/address/0x5c6f87B4e96A94c042aEC2eBCD78B2e91b770920) |
| PriceCap (CAPO)            | 1.04 USD                                                                                            | -                                                                                                      | -                                                                                           | -                                                                                           | -                                                                                           | -                                                                                           | 9.68% max yearly growth                                                                            | 13.68% max yearly growth                                                                            |
| Latest Answer (6 Mar 2026) | $1.00008230                                                                                         | $1.00000000                                                                                            | $68,906.45                                                                                  | $95.07                                                                                      | $2,003.63                                                                                   | $85.33                                                                                      | $2,158.76                                                                                          | $90.64                                                                                              |

### Security procedures:

- The proposal execution is simulated within the tests and the resulting pool configuration is tested for correctness.
- The deployed pool and other permissions have been programmatically verified.

## References

- Implementation: [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260306_AaveV3XLayer_AaveV36XLayerActivation/AaveV3XLayer_AaveV36XLayerActivation_20260306.sol)
- Tests: [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260306_AaveV3XLayer_AaveV36XLayerActivation/AaveV3XLayer_AaveV36XLayerActivation_20260306.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x251c520f1f1da8287168420fa2d2a73a2eb5342c3c62508553123129dec059b0)
- [Discussion](https://governance.aave.com/t/arfc-deploy-aave-v3-on-x-layer/23175/18)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
