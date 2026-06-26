---
title: "Aave V3.7 Monad Activation"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/arfc-deploy-aave-protocol-on-monad/24943"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6"
---

## Simple Summary

This proposal activates the Aave V3.7 Monad pool by completing the initial setup and listing USDT0, USDC, GHO, USDe, mUSD, AUSD, WETH, cbBTC, wstETH, weETH, syrupUSDC, and sUSDe, following the parameters recommended by the Risk Service Providers engaged with the DAO on the governance forum. GHO is also added as a borrowable asset to the syrupUSDC\_\_Stablecoins and USDe_sUSDe\_\_Stablecoins eModes.

## Motivation

All the governance procedures for the expansion of Aave V3.7 to Monad have been completed:

- Positive signaling and approval regarding the expansion on the governance [forum](https://governance.aave.com/t/arfc-deploy-aave-protocol-on-monad/24943) and [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6).
- Positive risk analysis and asset and parameter recommendations by the Risk Service Providers.

Monad's pipelined EVM architecture delivers high-throughput performance while remaining fully compatible with Ethereum, positioning Aave V3.7 as a core liquidity venue within the Monad ecosystem.

## Specification

The proposal will do the following:

- List the following assets on Aave V3.7 Monad: USDT0, USDC, GHO, USDe, mUSD, AUSD, WETH, cbBTC, wstETH, weETH, syrupUSDC, and sUSDe.
- Create the syrupUSDC\_\_Stablecoins, USDe_sUSDe\_\_Stablecoins, wstETH\_\_WETH, and weETH\_\_WETH eModes, as detailed in the table below. GHO is added as a borrowable asset to the syrupUSDC\_\_Stablecoins and USDe_sUSDe\_\_Stablecoins eModes as part of the second payload.
- Complete the initial pool configuration, keeping the pool admin on the Aave Guardian during the bootstrap period, following the standard procedure for security.

The table below illustrates the configured risk parameters for **USDT0**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (USDT0)        |                                100,000,000 |
| Borrow Cap (USDT0)        |                                100,000,000 |
| LTV                       |                                       75 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        4 % |
| Variable Slope 2          |                                       40 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Oracle                    | 0x8761dBf0aDACFB5A87Db75905cc02Dc1b6355560 |

The table below illustrates the configured risk parameters for **USDC**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (USDC)         |                                 75,000,000 |
| Borrow Cap (USDC)         |                                 50,000,000 |
| LTV                       |                                       75 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        4 % |
| Variable Slope 2          |                                       40 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Oracle                    | 0x978a045fa9ac4E4367053945F9f03E06DD834da5 |

The table below illustrates the configured risk parameters for **GHO**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (GHO)          |                                 20,000,000 |
| Borrow Cap (GHO)          |                                 18,000,000 |
| LTV                       |                                       75 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        4 % |
| Variable Slope 2          |                                       40 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Oracle                    | 0x26cBccD96502D2EfDb612737bD6aECe19f65109c |

The table below illustrates the configured risk parameters for **USDe**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (USDe)         |                                 60,000,000 |
| Borrow Cap (USDe)         |                                 50,000,000 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       25 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        4 % |
| Variable Slope 2          |                                       40 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Oracle                    | 0xa751D193E506d4eCea7B5c3f6C2A8260b5d15730 |

The table below illustrates the configured risk parameters for **mUSD**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (mUSD)         |                                100,000,000 |
| Borrow Cap (mUSD)         |                                 50,000,000 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                        0 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        4 % |
| Variable Slope 2          |                                       40 % |
| Uoptimal                  |                                       80 % |
| Flashloanable             |                                    ENABLED |
| Oracle                    | 0xbbb58AA3a251c9f19653771c44481c39500b71A3 |

The table below illustrates the configured risk parameters for **AUSD**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (AUSD)         |                                 20,000,000 |
| Borrow Cap (AUSD)         |                                 18,000,000 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                        0 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        4 % |
| Variable Slope 2          |                                       40 % |
| Uoptimal                  |                                       80 % |
| Flashloanable             |                                    ENABLED |
| Oracle                    | 0xc5fC05824c6abeA7335c940a81d5612b45FC8181 |

The table below illustrates the configured risk parameters for **WETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (WETH)         |                                     40,000 |
| Borrow Cap (WETH)         |                                     36,000 |
| LTV                       |                                     80.5 % |
| LT                        |                                       84 % |
| Liquidation Bonus         |                                      5.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       15 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      2.2 % |
| Variable Slope 2          |                                       20 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Oracle                    | 0x1B1414782B859871781bA3E4B0979b9ca57A0A04 |

The table below illustrates the configured risk parameters for **cbBTC**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (cbBTC)        |                                      1,000 |
| Borrow Cap (cbBTC)        |                                          1 |
| LTV                       |                                       73 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                        7 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                        7 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                       10 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Oracle                    | 0x3dDc1bAE752aaEe31b577bF844c799C349A1d6BD |

The table below illustrates the configured risk parameters for **wstETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (wstETH)       |                                     35,000 |
| Borrow Cap (wstETH)       |                                          1 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                        5 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                       10 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Oracle                    | 0xF29C1B8b98f51ae2d2552F75FD4a7c381122a462 |

The table below illustrates the configured risk parameters for **weETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (weETH)        |                                     30,000 |
| Borrow Cap (weETH)        |                                          1 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       45 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                       10 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Oracle                    | 0x6e7Cc80a9Ef22788B7beA1D5026E177c8dfA20DA |

The table below illustrates the configured risk parameters for **syrupUSDC**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (syrupUSDC)    |                                 40,000,000 |
| Borrow Cap (syrupUSDC)    |                                          1 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                       10 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Oracle                    | 0x47e9aB97A82cA1778FD04820255224bE837B5539 |

The table below illustrates the configured risk parameters for **sUSDe**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (sUSDe)        |                                 60,000,000 |
| Borrow Cap (sUSDe)        |                                          1 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                       10 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Oracle                    | 0x372EdA3f11AECb1bA5c44982f30C13b311c549f1 |

The table below illustrates the configured E-Mode categories

| E-Mode Category           |  LTV |   LT | Liquidation Bonus | Collaterals | Borrowables                  |
| ------------------------- | ---: | ---: | ----------------: | ----------- | ---------------------------- |
| syrupUSDC\_\_Stablecoins  | 90 % | 92 % |               4 % | syrupUSDC   | USDT0, USDC, mUSD, AUSD, GHO |
| USDe_sUSDe\_\_Stablecoins | 90 % | 92 % |               4 % | USDe, sUSDe | USDT0, USDC, AUSD, GHO       |
| wstETH\_\_WETH            | 94 % | 96 % |               1 % | wstETH      | WETH                         |
| weETH\_\_WETH             | 93 % | 95 % |               1 % | weETH       | WETH                         |

## References

- Implementation: [AaveV3Monad Activation](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260623_AaveV3Monad_AaveV3MonadActivation/AaveV3Monad_AaveV3MonadActivation_20260623.sol), [AaveV3Monad GHO Listing](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260623_AaveV3Monad_AaveV3MonadActivation/AaveV3Monad_AaveV3MonadGHOListing_20260623.sol)
- Tests: [AaveV3Monad Activation](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260623_AaveV3Monad_AaveV3MonadActivation/AaveV3Monad_AaveV3MonadActivation_20260623.t.sol), [AaveV3Monad GHO Listing](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260623_AaveV3Monad_AaveV3MonadActivation/AaveV3Monad_AaveV3MonadGHOListing_20260623.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6)
- [Discussion](https://governance.aave.com/t/arfc-deploy-aave-protocol-on-monad/24943)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
