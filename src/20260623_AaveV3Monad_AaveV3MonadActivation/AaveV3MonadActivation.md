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
- Grant the Risk Admin role to the Aave Risk Stewards ([0x98217A06721Ebf727f2C8d9aD7718ec28b7aAe34](https://monadscan.com/address/0x98217A06721Ebf727f2C8d9aD7718ec28b7aAe34)), allowing risk parameter updates within the preconfigured safety bounds.

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
| Oracle                    | 0x3c187a25f0f05E009DA794069682653e40062730 |

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
| Oracle                    | 0x787962943811D279d01eC973Bd3A15f1b3e1F0D9 |

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
| Oracle                    | 0x3abA25B23378A84FD7638E20F9Af86A66000f090 |

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
| Oracle                    | 0x6b7c151653c35845a5826b15435fc055A9Db1D0C |

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
| Oracle                    | 0x47F1D18329Ae59341617B7a5BE59605B63f0e373 |

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
| Oracle                    | 0x48692d15DA2636E1b0335344104Ce9d92f231DdA |

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
| Oracle                    | 0x7c1DbD7879C421ebd1A2dE397Ea6Bedb5D3795A5 |

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
| Oracle                    | 0x53E2d62Cd8c36104DEC69bA0CB3Bb599d6D42FE1 |

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
| Oracle                    | 0xB1f36c815761a3F77CE26c013F646cdCdCd06384 |

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
| Oracle                    | 0x99946Fe1a49D8650a31eFE0fcFee0508892742f0 |

The table below illustrates the configured E-Mode categories

| E-Mode Category           |  LTV |   LT | Liquidation Bonus | Collaterals | Borrowables                  | Isolated |
| ------------------------- | ---: | ---: | ----------------: | ----------- | ---------------------------- | -------- |
| syrupUSDC\_\_Stablecoins  | 90 % | 92 % |               4 % | syrupUSDC   | USDT0, USDC, mUSD, AUSD, GHO | false    |
| USDe_sUSDe\_\_Stablecoins | 90 % | 92 % |               4 % | USDe, sUSDe | USDT0, USDC, AUSD, GHO       | false    |
| wstETH\_\_WETH            | 94 % | 96 % |               1 % | wstETH      | WETH                         | true     |
| weETH\_\_WETH             | 93 % | 95 % |               1 % | weETH       | WETH                         | true     |

## Price Feed Configuration

Each listed asset is priced through a Chainlink feed on Monad. The underlying Chainlink feeds are Smart Value Recapture (SVR) feeds, which recapture oracle-extractable value and report in 18 decimals; a USD-scaling conversion adapter normalizes them to the 8-decimal USD format the Aave oracle expects. On top of this base layer:

- **Stablecoins** (USDT0, USDC, USDe, AUSD) use a CAPO stable adapter that bounds the upward price deviation at $1.04. USDe is priced via the USDT0/USD feed.
- **mUSD** and **GHO** use a fixed feed pegged at $1, so there is no underlying SVR feed.
- **WETH** and **cbBTC** use the USD-scaling conversion adapter directly over the ETH/USD and cbBTC/USD feeds.
- **Correlated assets** (wstETH, weETH, syrupUSDC, sUSDe) use a CAPO adapter that prices the asset against its base feed and caps the exchange-rate growth, following the LlamaRisk recommendation.

| Asset     | Listed Price Feed                          | Adapter         | Underlying SVR Feed                                      |
| --------- | ------------------------------------------ | --------------- | -------------------------------------------------------- |
| USDT0     | 0x3c187a25f0f05E009DA794069682653e40062730 | CAPO Stable     | USDT0 / USD — 0xaAF8D304F82e386f7c777bd61724B8015B087d1d |
| USDC      | 0x787962943811D279d01eC973Bd3A15f1b3e1F0D9 | CAPO Stable     | USDC / USD — 0x6789f81a983AfE7bd4C2a557c27084Ab705e56AB  |
| GHO       | 0x26cBccD96502D2EfDb612737bD6aECe19f65109c | Fixed $1        | —                                                        |
| USDe      | 0x3abA25B23378A84FD7638E20F9Af86A66000f090 | CAPO Stable     | USDT0 / USD — 0xaAF8D304F82e386f7c777bd61724B8015B087d1d |
| mUSD      | 0xbbb58AA3a251c9f19653771c44481c39500b71A3 | Fixed $1        | —                                                        |
| AUSD      | 0x6b7c151653c35845a5826b15435fc055A9Db1D0C | CAPO Stable     | AUSD / USD — 0xEd21588eA25ADC77384d47A466F0F75EEa58eBf3  |
| WETH      | 0x47F1D18329Ae59341617B7a5BE59605B63f0e373 | Conversion      | ETH / USD — 0xcE6538287B42D833f294662edad8B3dA070C6902   |
| cbBTC     | 0x48692d15DA2636E1b0335344104Ce9d92f231DdA | Conversion      | cbBTC / USD — 0x1AF85c71aa71cA1138308012400cc0D784A88e8A |
| wstETH    | 0x7c1DbD7879C421ebd1A2dE397Ea6Bedb5D3795A5 | CAPO Correlated | ETH / USD — 0xcE6538287B42D833f294662edad8B3dA070C6902   |
| weETH     | 0x53E2d62Cd8c36104DEC69bA0CB3Bb599d6D42FE1 | CAPO Correlated | ETH / USD — 0xcE6538287B42D833f294662edad8B3dA070C6902   |
| syrupUSDC | 0xB1f36c815761a3F77CE26c013F646cdCdCd06384 | CAPO Correlated | USDC / USD — 0x6789f81a983AfE7bd4C2a557c27084Ab705e56AB  |
| sUSDe     | 0x99946Fe1a49D8650a31eFE0fcFee0508892742f0 | CAPO Correlated | USDT0 / USD — 0xaAF8D304F82e386f7c777bd61724B8015B087d1d |

The correlated-asset CAPO adapters enforce a maximum yearly exchange-rate growth with a 7-day snapshot delay, as recommended by LlamaRisk:

| Asset     | Max Yearly Growth |
| --------- | ----------------: |
| sUSDe     |           11.17 % |
| wstETH    |           10.70 % |
| weETH     |            9.53 % |
| syrupUSDC |            8.05 % |

## References

- Implementation: [AaveV3Monad Activation](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260623_AaveV3Monad_AaveV3MonadActivation/AaveV3Monad_AaveV3MonadActivation_20260623.sol), [AaveV3Monad GHO Listing](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260623_AaveV3Monad_AaveV3MonadActivation/AaveV3Monad_AaveV3MonadGHOListing_20260623.sol)
- Tests: [AaveV3Monad Activation](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260623_AaveV3Monad_AaveV3MonadActivation/AaveV3Monad_AaveV3MonadActivation_20260623.t.sol), [AaveV3Monad GHO Listing](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260623_AaveV3Monad_AaveV3MonadActivation/AaveV3Monad_AaveV3MonadGHOListing_20260623.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6)
- [Discussion](https://governance.aave.com/t/arfc-deploy-aave-protocol-on-monad/24943)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
