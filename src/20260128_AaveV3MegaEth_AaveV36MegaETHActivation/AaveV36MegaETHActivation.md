---
title: "Aave V3.6 MegaETH Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-deploy-aave-v3-to-megaeth/23517"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0xab1d9c42264c89e1b8f0d807c9ff971f8c3f9f5cc0323072d9e970c110d1e39b"
---

## Simple Summary

This proposal allows the Aave governance to activate the Aave V3 MegaETH pool (3.6) by completing all the initial setup and listing WETH, BTCb, USDT0, USDm, wstETH, wrsETH, ezETH as suggested by the risk service providers engaged with the DAO on the governance forum.

All the Aave MegaETH V3 addresses can be found in the [aave-address-book](https://github.com/bgd-labs/aave-address-book/blob/eb6cd708bed0033d60e2a7e2fca169bc7c5567a0/src/AaveV3MegaEth.sol).

## Motivation

All the governance procedures for the expansion of Aave v3 to MegaETH have been finished, said:

- Positive signaling and approval regarding the expansion on the governance [forum](https://governance.aave.com/t/arfc-deploy-aave-v3-to-megaeth/23517), and [snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0xab1d9c42264c89e1b8f0d807c9ff971f8c3f9f5cc0323072d9e970c110d1e39b).
- Positive technical evaluation done by BGD Labs of the MegaETH network, as described in the [forum](https://governance.aave.com/t/bgd-aave-megaeth-infrastructure-technical-evaluation/23905) in detail.
- Positive risk analysis and assets/parameters recommendation by the risk service providers.

## Specification

The proposal will do the following:

- List the following assets on Aave V3 Mantle: WETH, BTCb, USDT0, USDm, wstETH, wrsETH, ezETH.
- Set the risk steward as the risk admin by executing `ACL_MANAGER.addRiskAdmin()`.
- Set the guardian address as the pool admin by executing `ACL_MANAGER.addPoolAdmin()`. This is following the standard procedure of keeping pool admin on the Aave Guardian during the bootstrap period, for security.
- Set ACI [multi-sig](https://mega.etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) as liquidity mining admin for all aTokens and underlying tokens by calling `EMISSION_MANAGER.setEmissionAdmin()` method.
- Configure L2 Price Oracle Sentinel by calling `POOL_ADDRESSES_PROVIDER.setPriceOracleSentinel()`

The table below illustrates the configured risk parameters for the assets to be listed:

| Parameter                 |                                                   WETH |              BTCb |                                                   USDT0 |                                                    USDm |                          wstETH |      wrsETH |      ezETH |
| ------------------------- | -----------------------------------------------------: | ----------------: | ------------------------------------------------------: | ------------------------------------------------------: | ------------------------------: | ----------: | ---------: |
| Supply Cap                |                                                 50,000 |               120 |                                              50,000,000 |                                              50,000,000 |                          12,000 |      10,000 |     10,000 |
| Borrow Cap                |                                                 46,000 |                 1 |                                              46,000,000 |                                              46,000,000 |                               1 |           1 |          1 |
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

### Oracle details:

TODO

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
| Asset                 | wrsETH | WETH |
| Collateral            | Yes    | No   |
| Borrowable            | No     | Yes  |
| Max LTV               | 93.00% | -    |
| Liquidation Threshold | 95.00% | -    |
| Liquidation Bonus     | 1.00%  | -    |

## References

- Implementation: [AaveV3MegaEth](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260128_AaveV3MegaEth_AaveV36MegaETHActivation/AaveV3MegaEth_AaveV36MegaETHActivation_20260128.sol)
- Tests: [AaveV3MegaEth](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260128_AaveV3MegaEth_AaveV36MegaETHActivation/AaveV3MegaEth_AaveV36MegaETHActivation_20260128.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0xab1d9c42264c89e1b8f0d807c9ff971f8c3f9f5cc0323072d9e970c110d1e39b)
- [Discussion](https://governance.aave.com/t/arfc-deploy-aave-v3-to-megaeth/23517)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
