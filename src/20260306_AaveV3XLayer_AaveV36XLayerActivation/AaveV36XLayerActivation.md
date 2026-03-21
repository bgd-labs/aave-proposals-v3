---
title: "Aave V3.6 XLayer Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-deploy-aave-v3-on-x-layer/23175/18"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0x251c520f1f1da8287168420fa2d2a73a2eb5342c3c62508553123129dec059b0"
---

## Simple Summary

This proposal allows the Aave governance to activate the Aave V3 XLayer pool (3.6) by completing all the initial setup and listing USDT0, USDG, xBTC, WOKB, xETH, xSOL, xBETH, xOKSOL, GHO as suggested by the risk service providers engaged with the DAO on the governance forum.

All the Aave XLayer V3 addresses can be found in the [aave-address-book](https://github.com/aave-dao/aave-address-book/blob/main/src/AaveV3XLayer.sol).

## Motivation

All the governance procedures for the expansion of Aave v3 to XLayer have been finished, said:

- Positive signaling and approval regarding the expansion on the governance [forum](https://governance.aave.com/t/arfc-deploy-aave-v3-on-x-layer/23175/18), and [snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x251c520f1f1da8287168420fa2d2a73a2eb5342c3c62508553123129dec059b0).
- Positive technical evaluation done by BGD Labs of the XLayer network.
- Positive risk analysis and assets/parameters recommendation by the risk service providers.

## Specification

The proposal will do the following:

- List the following assets on Aave V3 XLayer: USDT0, USDG, xBTC, WOKB, xETH, xSOL, xBETH, xOKSOL, GHO.
- Set the risk steward as the risk admin by executing `ACL_MANAGER.addRiskAdmin()`.
- Set the guardian address as the pool admin by executing `ACL_MANAGER.addPoolAdmin()`. This is following the standard procedure of keeping pool admin on the Aave Guardian during the bootstrap period, for security.
- Set ACI [multi-sig](https://www.oklink.com/xlayer/address/0xac140648435d03f784879cd789130F22Ef588Fcd) as liquidity mining admin for all aTokens and underlying tokens by calling `EMISSION_MANAGER.setEmissionAdmin()` method.

The table below illustrates the configured risk parameters for the assets to be listed:

| Parameter                 |                                                                                          USDT0 |                                                                                           USDG |                   xBTC |                   WOKB |                                  xETH |                                   xSOL |         xBETH |         xOKSOL |                                                                                            GHO |
| ------------------------- | ---------------------------------------------------------------------------------------------: | ---------------------------------------------------------------------------------------------: | ---------------------: | ---------------------: | ------------------------------------: | -------------------------------------: | ------------: | -------------: | ---------------------------------------------------------------------------------------------: |
| Supply Cap                |                                                                                     50,000,000 |                                                                                      5,000,000 |                    150 |                125,000 |                                 5,000 |                                110,000 |         5,700 |        135,000 |                                                                                      5,000,000 |
| Borrow Cap                |                                                                                     48,000,000 |                                                                                      4,250,000 |                     20 |                      1 |                                 1,300 |                                 14,000 |             1 |              1 |                                                                                      4,800,000 |
| Borrowable                |                                                                                        ENABLED |                                                                                        ENABLED |                ENABLED |               DISABLED |                               ENABLED |                                ENABLED |      DISABLED |       DISABLED |                                                                                        ENABLED |
| Collateral Enabled        |                                                                                           true |                                                                                          false |                   true |                  false |                                  true |                                   true |          true |           true |                                                                                          false |
| LTV                       |                                                                                            70% |                                                                                             0% |                    70% |                     0% |                                   70% |                                    60% |           67% |            55% |                                                                                             0% |
| LT                        |                                                                                            75% |                                                                                             0% |                    75% |                     0% |                                   75% |                                    65% |           72% |            60% |                                                                                             0% |
| Liquidation Bonus         |                                                                                           7.5% |                                                                                             0% |                   7.5% |                     0% |                                  7.5% |                                   7.5% |          7.5% |           7.5% |                                                                                             0% |
| Liquidation Protocol Fee  |                                                                                            10% |                                                                                            10% |                    10% |                    10% |                                   15% |                                    10% |           10% |            10% |                                                                                             0% |
| Debt Ceiling              |                                                                                          USD 0 |                                                                                          USD 0 |                  USD 0 |                  USD 0 |                                 USD 0 |                                  USD 0 |         USD 0 |          USD 0 |                                                                                          USD 0 |
| Isolation Mode            |                                                                                          false |                                                                                          false |                  false |                  false |                                 false |                                  false |         false |          false |                                                                                          false |
| Reserve Factor            |                                                                                            10% |                                                                                            10% |                    10% |                    15% |                                   15% |                                    15% |           15% |            15% |                                                                                            10% |
| Uoptimal                  |                                                                                            90% |                                                                                            80% |                    80% |                    45% |                                   90% |                                    80% |           45% |            45% |                                                                                            90% |
| Base Variable Borrow Rate |                                                                                             0% |                                                                                             0% |                     0% |                     0% |                                    0% |                                     0% |            0% |             0% |                                                                                             0% |
| Variable Slope 1          |                                                                                             5% |                                                                                             5% |                  2.75% |                     7% |                                  2.5% |                                     5% |            7% |             7% |                                                                                             5% |
| Variable Slope 2          |                                                                                            40% |                                                                                            45% |                    40% |                   300% |                                   20% |                                    20% |          300% |           300% |                                                                                            45% |
| Flashloanable             |                                                                                        ENABLED |                                                                                        ENABLED |                ENABLED |                ENABLED |                               ENABLED |                                ENABLED |       ENABLED |        ENABLED |                                                                                        ENABLED |
| Siloed Borrowing          |                                                                                       DISABLED |                                                                                       DISABLED |               DISABLED |               DISABLED |                              DISABLED |                               DISABLED |      DISABLED |       DISABLED |                                                                                       DISABLED |
| Borrowable in Isolation   |                                                                                       DISABLED |                                                                                       DISABLED |               DISABLED |               DISABLED |                              DISABLED |                               DISABLED |      DISABLED |       DISABLED |                                                                                       DISABLED |
| E-Mode                    | xBTC\_\_USDT0_USDG_GHO, xETH\_\_USDT0_USDG_GHO, xSOL\_\_USDT0_USDG_GHO, WOKB\_\_USDT0_USDG_GHO | xBTC\_\_USDT0_USDG_GHO, xETH\_\_USDT0_USDG_GHO, xSOL\_\_USDT0_USDG_GHO, WOKB\_\_USDT0_USDG_GHO | xBTC\_\_USDT0_USDG_GHO | WOKB\_\_USDT0_USDG_GHO | xETH\_\_USDT0_USDG_GHO, xBETH\_\_xETH | xSOL\_\_USDT0_USDG_GHO, xOKSOL\_\_xSOL | xBETH\_\_xETH | xOKSOL\_\_xSOL | xBTC\_\_USDT0_USDG_GHO, xETH\_\_USDT0_USDG_GHO, xSOL\_\_USDT0_USDG_GHO, WOKB\_\_USDT0_USDG_GHO |

### E-Mode Configurations:

**xBTC\_\_USDT0_USDG_GHO [EModeId: 1]**

| **Parameter**         |        |       |      |     |
| --------------------- | ------ | ----- | ---- | --- |
| Asset                 | xBTC   | USDT0 | USDG | GHO |
| Collateral            | Yes    | No    | No   | No  |
| Borrowable            | No     | Yes   | Yes  | Yes |
| Max LTV               | 78.00% | -     | -    | -   |
| Liquidation Threshold | 81.00% | -     | -    | -   |
| Liquidation Bonus     | 6.00%  | -     | -    | -   |

**xETH\_\_USDT0_USDG_GHO [EModeId: 2]**

| **Parameter**         |        |       |      |     |
| --------------------- | ------ | ----- | ---- | --- |
| Asset                 | xETH   | USDT0 | USDG | GHO |
| Collateral            | Yes    | No    | No   | No  |
| Borrowable            | No     | Yes   | Yes  | Yes |
| Max LTV               | 78.00% | -     | -    | -   |
| Liquidation Threshold | 80.00% | -     | -    | -   |
| Liquidation Bonus     | 6.00%  | -     | -    | -   |

**xSOL\_\_USDT0_USDG_GHO [EModeId: 3]**

| **Parameter**         |        |       |      |     |
| --------------------- | ------ | ----- | ---- | --- |
| Asset                 | xSOL   | USDT0 | USDG | GHO |
| Collateral            | Yes    | No    | No   | No  |
| Borrowable            | No     | Yes   | Yes  | Yes |
| Max LTV               | 65.00% | -     | -    | -   |
| Liquidation Threshold | 70.00% | -     | -    | -   |
| Liquidation Bonus     | 7.50%  | -     | -    | -   |

**WOKB\_\_USDT0_USDG_GHO [EModeId: 4]**

| **Parameter**         |        |       |      |     |
| --------------------- | ------ | ----- | ---- | --- |
| Asset                 | WOKB   | USDT0 | USDG | GHO |
| Collateral            | Yes    | No    | No   | No  |
| Borrowable            | No     | Yes   | Yes  | Yes |
| Max LTV               | 50.00% | -     | -    | -   |
| Liquidation Threshold | 55.00% | -     | -    | -   |
| Liquidation Bonus     | 10.00% | -     | -    | -   |

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

|                             | USDT0                                                                                               | USDG                                                                                                   | xBTC                                                                                        | WOKB                                                                                        | xETH                                                                                        | xSOL                                                                                        | xBETH                                                                                                | xOKSOL                                                                                                | GHO                                                                                               |
| --------------------------- | --------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| Oracle                      | [Capped USDT/USD](https://www.oklink.com/xlayer/address/0x7ec7e5497eaf312fe82f8307d05eb0e5f0f157d3) | [OneUSDFixedAdapter](https://www.oklink.com/xlayer/address/0xcfcbbf3e0c27b936cf673c4fc8bcc68f721af475) | [BTC/USD](https://www.oklink.com/xlayer/address/0x4D6f6488a2B3a5f7b088f276887f608a1e9805c4) | [OKB/USD](https://www.oklink.com/xlayer/address/0x4Ff345b18a2bF894F8627F41501FBf30d5C5e7BE) | [ETH/USD](https://www.oklink.com/xlayer/address/0x8b85b50535551F8E8cDAF78dA235b5Cf1005907b) | [SOL/USD](https://www.oklink.com/xlayer/address/0xF959E1B5cA535C28aD24F7f672Bf1A93900810cF) | [Capped xBETH/USD](https://www.oklink.com/xlayer/address/0x2c54487c1a94b753987d980f98b13E8F313A7B44) | [Capped xOKSOL/USD](https://www.oklink.com/xlayer/address/0x558891fF1823d6f38A4f2102D357C307a1B09bF6) | [Fixed GHO/USD](https://www.oklink.com/xlayer/address/0x2Ce400703dAcc37b7edFA99D228b8E70a4d3831B) |
| Exchange Rate Feed          | -                                                                                                   | -                                                                                                      | -                                                                                           | -                                                                                           | -                                                                                           | -                                                                                           | [xBETH underlying](https://www.oklink.com/xlayer/address/0xAFeab3B85B6A56cF5F02317F0f7A23340eb983D7) | [xOKSOL underlying](https://www.oklink.com/xlayer/address/0x14a686103854DAB7b8801E31979CAA595835B25d) | -                                                                                                 |
| Base Feed                   | [USDT / USD](https://www.oklink.com/xlayer/address/0xb928a0678352005a2e51F614efD0b54C9830dB80)      | -                                                                                                      | -                                                                                           | -                                                                                           | -                                                                                           | -                                                                                           | [CL ETH/USD](https://www.oklink.com/xlayer/address/0x8b85b50535551F8E8cDAF78dA235b5Cf1005907b)       | [CL SOL/USD](https://www.oklink.com/xlayer/address/0xF959E1B5cA535C28aD24F7f672Bf1A93900810cF)        | -                                                                                                 |
| PriceCap (CAPO)             | 1.04 USD                                                                                            | -                                                                                                      | -                                                                                           | -                                                                                           | -                                                                                           | -                                                                                           | -                                                                                                    | -                                                                                                     | -                                                                                                 |
| MaxYearlyRatioGrowthPercent | -                                                                                                   | -                                                                                                      | -                                                                                           | -                                                                                           | -                                                                                           | -                                                                                           | 9.68%                                                                                                | 13.68%                                                                                                | -                                                                                                 |
| MinimumSnapshotDelay        | -                                                                                                   | -                                                                                                      | -                                                                                           | -                                                                                           | -                                                                                           | -                                                                                           | 14 days                                                                                              | 14 days                                                                                               | -                                                                                                 |
| Latest Answer (6 Mar 2026)  | $1.00025786                                                                                         | $1.00000000                                                                                            | $72,080.25                                                                                  | $92.80437                                                                                   | $2,231.83854847                                                                             | $90.0332                                                                                    | $2,239.2271865                                                                                       | $90.75612718                                                                                          | $1.00000000                                                                                       |

### Security procedures:

- The proposal execution is simulated within the tests and the resulting pool configuration is tested for correctness.
- The deployed pool and other permissions have been programmatically verified.
- In addition, we have also checked the code diffs of the deployed X Layer contracts with the production instance, which can be found [here](https://github.com/bgd-labs/aave-v3-origin/pull/8).

## References

- Implementation: [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/9fcc1e6b8398fc2f166e78e709bccf96917a9acb/src/20260306_AaveV3XLayer_AaveV36XLayerActivation/AaveV3XLayer_AaveV36XLayerActivation_20260306.sol)
- Tests: [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/9fcc1e6b8398fc2f166e78e709bccf96917a9acb/src/20260306_AaveV3XLayer_AaveV36XLayerActivation/AaveV3XLayer_AaveV36XLayerActivation_20260306.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x251c520f1f1da8287168420fa2d2a73a2eb5342c3c62508553123129dec059b0)
- [Discussion](https://governance.aave.com/t/arfc-deploy-aave-v3-on-x-layer/23175/18)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
