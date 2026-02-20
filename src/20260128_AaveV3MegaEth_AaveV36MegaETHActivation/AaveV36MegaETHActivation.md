---
title: "Aave V3.6 MegaETH Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-deploy-aave-v3-to-megaeth/23517"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0xf6e4ca9941805b3c89615df693c657d81eda6a4c8a24d6d2e220020f9c1c5aa7"
---

## Simple Summary

This proposal allows the Aave governance to activate the Aave V3 MegaETH pool (3.6) by completing all the initial setup and listing WETH, BTCb, USDT0, USDm, wstETH, wrsETH, ezETH as suggested by the risk service providers engaged with the DAO on the governance forum.

All the Aave MegaETH V3 addresses can be found in the [aave-address-book](https://github.com/bgd-labs/aave-address-book/blob/eb6cd708bed0033d60e2a7e2fca169bc7c5567a0/src/AaveV3MegaEth.sol).

## Motivation

All the governance procedures for the expansion of Aave v3 to MegaETH have been finished, said:

- Positive signaling and approval regarding the expansion on the governance [forum](https://governance.aave.com/t/arfc-deploy-aave-v3-to-megaeth/23517), and [snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0xf6e4ca9941805b3c89615df693c657d81eda6a4c8a24d6d2e220020f9c1c5aa7).
- Positive technical evaluation done by BGD Labs of the MegaETH network, as described in the [forum](https://governance.aave.com/t/bgd-aave-megaeth-infrastructure-technical-evaluation/23905) in detail.
- Positive risk analysis and assets/parameters recommendation by the risk service providers.

## Specification

The proposal will do the following:

- List the following assets on Aave V3 MegaETH: WETH, BTCb, USDT0, USDm, wstETH, wrsETH, ezETH.
- Set the risk steward as the risk admin by executing `ACL_MANAGER.addRiskAdmin()`.
- Set the guardian address as the pool admin by executing `ACL_MANAGER.addPoolAdmin()`. This is following the standard procedure of keeping pool admin on the Aave Guardian during the bootstrap period, for security.
- Set ACI [multi-sig](https://mega.etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) as liquidity mining admin for all aTokens and underlying tokens by calling `EMISSION_MANAGER.setEmissionAdmin()` method.
- Configure L2 Price Oracle Sentinel by calling `POOL_ADDRESSES_PROVIDER.setPriceOracleSentinel()`

The table below illustrates the configured risk parameters for the assets to be listed:

| Parameter                 |                                                   WETH |              BTCb |                                                   USDT0 |                                                    USDm |                          wstETH |      wrsETH |      ezETH |
| ------------------------- | -----------------------------------------------------: | ----------------: | ------------------------------------------------------: | ------------------------------------------------------: | ------------------------------: | ----------: | ---------: |
| Supply Cap                |                                                     20 |                 2 |                                                  50,000 |                                                  50,000 |                              20 |          20 |         20 |
| Borrow Cap                |                                                     10 |                 1 |                                                  20,000 |                                                  20,000 |                               1 |           1 |          1 |
| Borrowable                |                                               DISABLED |          DISABLED |                                                 ENABLED |                                                 ENABLED |                        DISABLED |    DISABLED |   DISABLED |
| Collateral Enabled        |                                                  false |             false |                                                   false |                                                   false |                           false |       false |      false |
| LTV                       |                                                    0 % |               0 % |                                                     0 % |                                                     0 % |                             0 % |         0 % |        0 % |
| LT                        |                                                    0 % |               0 % |                                                     0 % |                                                     0 % |                             0 % |         0 % |        0 % |
| Liquidation Bonus         |                                                    0 % |               0 % |                                                     0 % |                                                     0 % |                             0 % |         0 % |        0 % |
| Liquidation Protocol Fee  |                                                   10 % |              10 % |                                                    10 % |                                                    10 % |                            10 % |        10 % |       10 % |
| Debt Ceiling              |                                                  USD 0 |             USD 0 |                                                   USD 0 |                                                   USD 0 |                           USD 0 |       USD 0 |      USD 0 |
| Isolation Mode            |                                                  false |             false |                                                   false |                                                   false |                           false |       false |      false |
| Reserve Factor            |                                                   15 % |              20 % |                                                    10 % |                                                    10 % |                            20 % |        20 % |       20 % |
| Uoptimal                  |                                                   90 % |              90 % |                                                    90 % |                                                    90 % |                            90 % |        90 % |       90 % |
| Base Variable Borrow Rate |                                                    0 % |               0 % |                                                     0 % |                                                     0 % |                             0 % |         0 % |        0 % |
| Variable Slope 1          |                                                  2.5 % |               5 % |                                                     5 % |                                                     5 % |                             5 % |         5 % |        5 % |
| Variable Slope 2          |                                                    8 % |              20 % |                                                    10 % |                                                    10 % |                            20 % |        20 % |       20 % |
| Flashloanable             |                                                ENABLED |           ENABLED |                                                 ENABLED |                                                 ENABLED |                         ENABLED |     ENABLED |    ENABLED |
| Siloed Borrowing          |                                               DISABLED |          DISABLED |                                                DISABLED |                                                DISABLED |                        DISABLED |    DISABLED |   DISABLED |
| Borrowable in Isolation   |                                               DISABLED |          DISABLED |                                                 ENABLED |                                                 ENABLED |                        DISABLED |    DISABLED |   DISABLED |
| E-Mode                    | WETH/Stablecoins, wstETH/WETH, wrsETH/WETH, ezETH/WETH | BTC.b/Stablecoins | wstETH/Stablecoins, WETH/Stablecoins, BTC.b/Stablecoins | wstETH/Stablecoins, WETH/Stablecoins, BTC.b/Stablecoins | wstETH/WETH, wstETH/Stablecoins | wrsETH/WETH | ezETH/WETH |

**Please note: As a matter of extra caution, the MegaETH instance will be activated with very limited interim caps, and this AIP authorizes the Aave Protocol Guardian to increase it to the following pre-approved levels below once technical SP have triple checked everything. Additionally, due to the recent stress test, the explorers are not fully indexed, which means that some deployed contracts are not verified. We will verify the contracts before proposal execution once the explorers are fully indexed.**:

| Asset  | Supply Cap  | Borrow Cap |
| ------ | ----------- | ---------- |
| WETH   | 50'000      | 46'000     |
| BTCb   | 120         | 1          |
| USDT0  | 50'000'000  | 46'000'000 |
| USDm   | 100'000'000 | 95'000'000 |
| wstETH | 12'000      | 1          |
| wrsETH | 10'000      | 1          |
| ezETH  | 10'000      | 1          |

### Oracle details:

|                             | wstETH                                                                                                                | wrsETH                                                                                                         | ezETH                                                                                                         | USDT0                                                                                                | USDm                                                                                                    | BTCb                                                                                            | WETH                                                                                            |
| --------------------------- | --------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| Oracle                      | [Capped wstETH / stETH(ETH) / USD](https://megaeth.blockscout.com/address/0x376397e34eA968e79DC6F629E6210ba25311a3ce) | [Capped wrsETH / ETH / USD](https://megaeth.blockscout.com/address/0x6356b92Bc636CCe722e0F53DDc24a86baE64216E) | [Capped ezETH / ETH / USD](https://megaeth.blockscout.com/address/0xd7Da71D3acf07C604A925799B0b48E2Ec607584D) | [Capped USDT/USD](https://megaeth.blockscout.com/address/0xAe95ff42e16468AB1DfD405c9533C9b67d87d66A) | [OneUSDFixedAdapter](https://megaeth.blockscout.com/address/0xe5448B8318493c6e3F72E21e8BDB8242d3299FB5) | [CL BTC/USD](https://megaeth.blockscout.com/address/0xc6E3007B597f6F5a6330d43053D1EF73cCbbE721) | [CL ETH/USD](https://megaeth.blockscout.com/address/0xcA4e254D95637DE95E2a2F79244b03380d697feD) |
| PriceCap                    | -                                                                                                                     | -                                                                                                              | -                                                                                                             | 1.04                                                                                                 | -                                                                                                       | -                                                                                               | -                                                                                               |
| Exchange Rate Feed          | [CL wstETH/stETH](https://megaeth.blockscout.com/address/0xe020C0Abc50E6581A95cb79Ff1021728C9Ec0640?)                 | [CL rsETH/ETH](https://megaeth.blockscout.com/address/0x1de97D40C58AA167b7eaEB922f9801bcd0B12781)              | [CL ezETH/ETH](https://megaeth.blockscout.com/address/0x6d924215a8A8e48651F774312b7bA549c1E09df9)             | -                                                                                                    | -                                                                                                       | -                                                                                               | -                                                                                               |
| Base Feed                   | [CL ETH/USD](https://megaeth.blockscout.com/address/0xcA4e254D95637DE95E2a2F79244b03380d697feD)                       | [CL ETH/USD](https://megaeth.blockscout.com/address/0xcA4e254D95637DE95E2a2F79244b03380d697feD)                | [CL ETH/USD](https://megaeth.blockscout.com/address/0xcA4e254D95637DE95E2a2F79244b03380d697feD)               | -                                                                                                    | -                                                                                                       | -                                                                                               | -                                                                                               |
| MaxYearlyRatioGrowthPercent | 9.68%                                                                                                                 | 6.67%                                                                                                          | 10.89%                                                                                                        | -                                                                                                    | -                                                                                                       | -                                                                                               | -                                                                                               |
| MinimumSnapshotDelay        | 7 days                                                                                                                | 14 days                                                                                                        | 14 days                                                                                                       | -                                                                                                    | -                                                                                                       | -                                                                                               | -                                                                                               |
| Latest Answer (3 Feb 2026)  | $2785.71258297                                                                                                        | $2417.83819495                                                                                                 | $2433.10890108                                                                                                | $0.9993542                                                                                           | $1                                                                                                      | $77930.8237778                                                                                  | $2272.17630772                                                                                  |

### E-Mode Configurations:

**WETH Stablecoins [EModeId: 1]**

| **Parameter**         |        |       |      |
| --------------------- | ------ | ----- | ---- |
| Asset                 | WETH   | USDT0 | USDM |
| Collateral            | Yes    | No    | No   |
| Borrowable            | No     | Yes   | Yes  |
| Max LTV               | 80.50% | -     | -    |
| Liquidation Threshold | 83.00% | -     | -    |
| Liquidation Bonus     | 5.50%  | -     | -    |

**BTC.b Stablecoins [EModeId: 2]**

| **Parameter**         |        |       |      |
| --------------------- | ------ | ----- | ---- |
| Asset                 | BTC.b  | USDT0 | USDM |
| Collateral            | Yes    | No    | No   |
| Borrowable            | No     | Yes   | Yes  |
| Max LTV               | 70.00% | -     | -    |
| Liquidation Threshold | 75.00% | -     | -    |
| Liquidation Bonus     | 6.50%  | -     | -    |

**wstETH Stablecoins [EModeId: 3]**

| **Parameter**         |        |       |      |
| --------------------- | ------ | ----- | ---- |
| Asset                 | wstETH | USDT0 | USDM |
| Collateral            | Yes    | No    | No   |
| Borrowable            | No     | Yes   | Yes  |
| Max LTV               | 75.00% | -     | -    |
| Liquidation Threshold | 79.00% | -     | -    |
| Liquidation Bonus     | 6.50%  | -     | -    |

**wstETH Correlated [EModeId: 4]**

| **Parameter**         |        |      |
| --------------------- | ------ | ---- |
| Asset                 | wstETH | WETH |
| Collateral            | Yes    | No   |
| Borrowable            | No     | Yes  |
| Max LTV               | 94.00% | -    |
| Liquidation Threshold | 96.00% | -    |
| Liquidation Bonus     | 1.00%  | -    |

**wrsETH Correlated [EModeId: 5]**

| **Parameter**         |        |      |
| --------------------- | ------ | ---- |
| Asset                 | wrsETH | WETH |
| Collateral            | Yes    | No   |
| Borrowable            | No     | Yes  |
| Max LTV               | 93.00% | -    |
| Liquidation Threshold | 95.00% | -    |
| Liquidation Bonus     | 1.00%  | -    |

**ezETH Correlated [EModeId: 6]**

| **Parameter**         |        |      |
| --------------------- | ------ | ---- |
| Asset                 | ezETH  | WETH |
| Collateral            | Yes    | No   |
| Borrowable            | No     | Yes  |
| Max LTV               | 93.00% | -    |
| Liquidation Threshold | 95.00% | -    |
| Liquidation Bonus     | 1.00%  | -    |

### Security procedures:

- The proposal execution is simulated within the tests and the resulting pool configuration is tested for correctness.
- The deployed pool and other permissions have been programmatically verified, which can be found on the [aave-permissions-book](https://github.com/aave-dao/aave-permissions-book/blob/71f5d995451a9e21c4ba33cab420861f68aed285/out/MEGAETH-V3.md).

## References

- Implementation: [AaveV3MegaEth](https://github.com/bgd-labs/aave-proposals-v3/blob/55b3f19727a40fd86045222f7d98afc855e6d37e/src/20260128_AaveV3MegaEth_AaveV36MegaETHActivation/AaveV3MegaEth_AaveV36MegaETHActivation_20260128.sol)
- Tests: [AaveV3MegaEth](https://github.com/bgd-labs/aave-proposals-v3/blob/55b3f19727a40fd86045222f7d98afc855e6d37e/src/20260128_AaveV3MegaEth_AaveV36MegaETHActivation/AaveV3MegaEth_AaveV36MegaETHActivation_20260128.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0xf6e4ca9941805b3c89615df693c657d81eda6a4c8a24d6d2e220020f9c1c5aa7)
- [Discussion](https://governance.aave.com/t/arfc-deploy-aave-v3-to-megaeth/23517)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
