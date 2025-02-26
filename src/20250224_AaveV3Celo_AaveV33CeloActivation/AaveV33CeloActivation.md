---
title: "Aave V3.3 Celo Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-aave-deployment-on-celo/17636"
snapshot: "https://snapshot.box/#/aave.eth/proposal/0x645981c18f5dc61c07324a39d57bcb873ebd8fb9e4a435280cac57cb07a8090b"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **USDC**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (USDC)         |                                  2,000,000 |
| Borrow Cap (USDC)         |                                  1,800,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       75 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                        5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        7 % |
| Variable Slope 2          |                                       75 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                    ENABLED |
| Oracle                    | 0xBF704f2FfdB856805cE64D085cD50427823696D7 |

,The table below illustrates the configured risk parameters for **USDT**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (USDT)         |                                    700,000 |
| Borrow Cap (USDT)         |                                    650,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       75 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                        5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        7 % |
| Variable Slope 2          |                                       75 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                    ENABLED |
| Oracle                    | 0x6e3d991C965364481796116dE68A8036d1b3Ecd0 |

,The table below illustrates the configured risk parameters for **cEUR**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (cEUR)         |                                    800,000 |
| Borrow Cap (cEUR)         |                                    700,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       15 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        7 % |
| Variable Slope 2          |                                       75 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                    ENABLED |
| Oracle                    | 0x3D207061Dbe8E2473527611BFecB87Ff12b28dDa |

,The table below illustrates the configured risk parameters for **cUSD**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (cUSD)         |                                  2,000,000 |
| Borrow Cap (cUSD)         |                                  1,800,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       15 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        7 % |
| Variable Slope 2          |                                       75 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                    ENABLED |
| Oracle                    | 0xdCdA3E7E90fe827776b8FDaEa3C5977F123354DA |

,The table below illustrates the configured risk parameters for **CELO**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                       true |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (CELO)         |                                  1,000,000 |
| Borrow Cap (CELO)         |                                    500,000 |
| Debt Ceiling              |                                USD 500,000 |
| LTV                       |                                       55 % |
| LT                        |                                       61 % |
| Liquidation Bonus         |                                       10 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                       10 % |
| Variable Slope 2          |                                      150 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x0568fD19986748cEfF3301e55c0eb1E729E0Ab7e |

## References

- Implementation: [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250224_AaveV3Celo_AaveV33CeloActivation/AaveV3Celo_AaveV33CeloActivation_20250224.sol)
- Tests: [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250224_AaveV3Celo_AaveV33CeloActivation/AaveV3Celo_AaveV33CeloActivation_20250224.t.sol)
- [Snapshot](https://snapshot.box/#/aave.eth/proposal/0x645981c18f5dc61c07324a39d57bcb873ebd8fb9e4a435280cac57cb07a8090b)
- [Discussion](https://governance.aave.com/t/arfc-aave-deployment-on-celo/17636)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
