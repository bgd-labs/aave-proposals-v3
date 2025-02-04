---
title: "Aave v3 Linea Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-deployment-of-aave-on-linea/19852/6"
snapshot: "https://snapshot.org/#/s:aave.eth/proposal/0x5ae276cb67c8d40868916e99f2ef113de02049dd412c3eb47539f97648f50878"
---

## Simple Summary

This proposal allows the Aave governance to activate the Aave V3 Linea pool (3.2) by completing all the initial setup and listing USDC, USDT, WETH, WBTC, wstETH, ezETH, weETH as suggested by the risk service providers engaged with the DAO on the governance [forum](https://governance.aave.com/t/arfc-deployment-of-aave-on-linea/19852/6#p-50536-specification-10).

All the Aave Linea V3 addresses can be found in the [aave-address-book](https://github.com/bgd-labs/aave-address-book/blob/837214a8bfff3c937a6d8fd803d0c88eeaa948a0/src/AaveV3Linea.sol).

## Motivation

All the governance procedures for the expansion of Aave v3 to Linea have been finished, said:

- Positive signaling and approval regarding the expansion on the [governance forum](https://governance.aave.com/t/arfc-deployment-of-aave-on-linea/19852), and [snapshot](https://snapshot.org/#/s:aave.eth/proposal/0x5ae276cb67c8d40868916e99f2ef113de02049dd412c3eb47539f97648f50878).
- Positive technical evaluation done by BGD Labs of the Linea network, as described in the [forum](https://governance.aave.com/t/bgd-aave-linea-infrastructure-technical-evaluation/19903) in detail.
- Positive risk analysis and assets/parameters recommendation by the risk service providers.

## Specification

The proposal will do the following:

- List the following assets on Aave V3 Linea: USDC, USDT, WETH, WBTC, wstETH, ezETH, weETH
- Set the [guardian address](https://lineascan.build/address/0x0BF186764D8333a938f35e5dD124a7b9b9dccDF9) as the pool admin by executing `ACL_MANAGER.addPoolAdmin()`. This is following the standard procedure of keeping pool admin on the Aave Guardian during the bootstrap period, for security.
- Set [ACI multi-sig](https://lineascan.build/address/0xac140648435d03f784879cd789130F22Ef588Fcd) as liquidity mining admin for all aTokens and underlying tokens by calling `EMISSION_MANAGER.setEmissionAdmin()` method.

The table below illustrates the configured risk parameters for the assets to be listed:

| Parameter                 |    [WETH](https://lineascan.build/address/0xe5D7C2a44FfDDf6b295A15c148167daaAf5Cf34f) |    [WBTC](https://lineascan.build/address/0x3aAB2285ddcDdaD8edf438C1bAB47e1a9D05a9b4) |            [USDC](https://lineascan.build/address/0x176211869cA2b568f2A7D4EE941E073a821EE1ff) |            [USDT](https://lineascan.build/address/0xA219439258ca9da29E9Cc4cE5596924745e12B93) |                [wstETH](https://lineascan.build/address/0xB5beDd42000b71FddE22D3eE8a79Bd49A568fC8F) |                [ezETH](https://lineascan.build/address/0x2416092f143378750bb29b79eD961ab195CcEea5) |                [weETH](https://lineascan.build/address/0x1Bf74C010E6320bab11e2e5A532b5AC15e0b8aA6) |
| ------------------------- | ------------------------------------------------------------------------------------: | ------------------------------------------------------------------------------------: | --------------------------------------------------------------------------------------------: | --------------------------------------------------------------------------------------------: | --------------------------------------------------------------------------------------------------: | -------------------------------------------------------------------------------------------------: | -------------------------------------------------------------------------------------------------: |
| Isolation Mode            |                                                                                 false |                                                                                 false |                                                                                         false |                                                                                         false |                                                                                               false |                                                                                              false |                                                                                              false |
| Borrowable                |                                                                               ENABLED |                                                                               ENABLED |                                                                                       ENABLED |                                                                                       ENABLED |                                                                                             ENABLED |                                                                                           DISABLED |                                                                                           DISABLED |
| Collateral Enabled        |                                                                                  true |                                                                                  true |                                                                                          true |                                                                                          true |                                                                                                true |                                                                                               true |                                                                                               true |
| Supply Cap                |                                                                                 1,200 |                                                                                    25 |                                                                                    12,000,000 |                                                                                     7,800,000 |                                                                                                 800 |                                                                                              1,200 |                                                                                              1,200 |
| Borrow Cap                |                                                                                 1,100 |                                                                                    12 |                                                                                    11,000,000 |                                                                                     7,150,000 |                                                                                                 400 |                                                                                                  1 |                                                                                                  1 |
| Debt Ceiling              |                                                                                 USD 0 |                                                                                 USD 0 |                                                                                         USD 0 |                                                                                         USD 0 |                                                                                               USD 0 |                                                                                              USD 0 |                                                                                              USD 0 |
| LTV                       |                                                                                  80 % |                                                                                  73 % |                                                                                          75 % |                                                                                          75 % |                                                                                                75 % |                                                                                               72 % |                                                                                             72.5 % |
| LT                        |                                                                                  83 % |                                                                                  78 % |                                                                                          78 % |                                                                                          78 % |                                                                                                79 % |                                                                                               75 % |                                                                                               75 % |
| Liquidation Bonus         |                                                                                   6 % |                                                                                   7 % |                                                                                           5 % |                                                                                           5 % |                                                                                                 7 % |                                                                                              7.5 % |                                                                                              7.5 % |
| Liquidation Protocol Fee  |                                                                                  10 % |                                                                                  10 % |                                                                                          10 % |                                                                                          10 % |                                                                                                10 % |                                                                                               10 % |                                                                                               10 % |
| Reserve Factor            |                                                                                  15 % |                                                                                  20 % |                                                                                          10 % |                                                                                          10 % |                                                                                                 5 % |                                                                                               45 % |                                                                                               45 % |
| Base Variable Borrow Rate |                                                                                   0 % |                                                                                   0 % |                                                                                           0 % |                                                                                           0 % |                                                                                                 0 % |                                                                                                0 % |                                                                                                0 % |
| Variable Slope 1          |                                                                                 2.7 % |                                                                                   7 % |                                                                                         5.5 % |                                                                                         5.5 % |                                                                                                 7 % |                                                                                                7 % |                                                                                                7 % |
| Variable Slope 2          |                                                                                  80 % |                                                                                 300 % |                                                                                          60 % |                                                                                          60 % |                                                                                               300 % |                                                                                              300 % |                                                                                              300 % |
| Uoptimal                  |                                                                                  90 % |                                                                                  45 % |                                                                                          90 % |                                                                                          90 % |                                                                                                45 % |                                                                                               45 % |                                                                                               45 % |
| Flashloanable             |                                                                               ENABLED |                                                                               ENABLED |                                                                                       ENABLED |                                                                                       ENABLED |                                                                                             ENABLED |                                                                                            ENABLED |                                                                                            ENABLED |
| Siloed Borrowing          |                                                                              DISABLED |                                                                              DISABLED |                                                                                      DISABLED |                                                                                      DISABLED |                                                                                            DISABLED |                                                                                           DISABLED |                                                                                           DISABLED |
| Borrowable in Isolation   |                                                                              DISABLED |                                                                              DISABLED |                                                                                       ENABLED |                                                                                       ENABLED |                                                                                            DISABLED |                                                                                           DISABLED |                                                                                           DISABLED |
| Oracle                    | [ETH/USD](https://lineascan.build/address/0x3c6Cd9Cc7c7a4c2Cf5a82734CD249D7D593354dA) | [BTC/USD](https://lineascan.build/address/0x7A99092816C8BD5ec8ba229e3a6E6Da1E628E1F9) | [Capped USDC/USD](https://lineascan.build/address/0x14ac9f8a8646D11D66fbaA9E9F5A869dC08B5D71) | [Capped USDT/USD](https://lineascan.build/address/0x0dccba847d677d4dc3c22c9dc17dc468226d08ed) | [Capped wstETH/ETH/USD](https://lineascan.build/address/0x96014CA32e2902A5F07c6ADF00eB17D3DE9aC364) | [Capped ezETH/ETH/USD](https://lineascan.build/address/0x1217a8A40cea4dB5429fbF6EDeB3B606b99CC9b0) | [Capped weETH/ETH/USD](https://lineascan.build/address/0x0abf2f5642d945b49B8d2DBC6f85c2D8e0424C85) |

### E-Modes

The followings E-modes will be created:

**wstETH correlated E-Mode**

| **Parameter**         | **Value** | **Value** |
| --------------------- | --------- | --------- |
| Asset                 | wstETH    | WETH      |
| Collateral            | Yes       | No        |
| Borrowable            | No        | Yes       |
| Max LTV               | 93.5%     | -         |
| Liquidation Threshold | 95.5%     | -         |
| Liquidation Penalty   | 1.00%     | -         |

**weETH correlated E-Mode**

| **Parameter**         | **Value** | **Value** |
| --------------------- | --------- | --------- |
| Asset                 | weETH     | WETH      |
| Collateral            | Yes       | No        |
| Borrowable            | No        | Yes       |
| Max LTV               | 90%       | -         |
| Liquidation Threshold | 93%       | -         |
| Liquidation Penalty   | 1.00%     | -         |

**ezETH correlated E-Mode**

| **Parameter**         | **Value** | **Value** |
| --------------------- | --------- | --------- |
| Asset                 | ezETH     | WETH      |
| Collateral            | Yes       | No        |
| Borrowable            | No        | Yes       |
| Max LTV               | 90%       | -         |
| Liquidation Threshold | 93%       | -         |
| Liquidation Penalty   | 1.00%     | -         |

### Security procedures

- The proposal execution is simulated within the tests and the resulting pool configuration is tested for correctness.
- The deployed pool and other permissions have been programmatically verified, which can be found on the [aave-permissions-book](https://github.com/bgd-labs/aave-permissions-book/blob/b944a7480c31961bcdfcd96177c4100e45bb41b9/out/LINEA-V3.md#contracts)
- In addition, we have also checked the code diffs of the deployed linea contracts with the production instance, which can be found [here](https://github.com/bgd-labs/aave-v3-origin/pull/48).

## References

- Implementation: [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/3b2dd51598bd0a06ce56d181f5c33556c911bdbb/src/20250121_AaveV3Linea_AaveV3LineaActivation/AaveV3Linea_AaveV3LineaActivation_20250121.sol)
- Tests: [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/3b2dd51598bd0a06ce56d181f5c33556c911bdbb/src/20250121_AaveV3Linea_AaveV3LineaActivation/AaveV3Linea_AaveV3LineaActivation_20250121.t.sol)
- [Snapshot](https://snapshot.org/#/s:aave.eth/proposal/0x5ae276cb67c8d40868916e99f2ef113de02049dd412c3eb47539f97648f50878)
- [Discussion](https://governance.aave.com/t/arfc-deployment-of-aave-on-linea/19852/6)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
