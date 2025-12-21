---
title: "Listing of PT Ethena April Maturity on Plasma Instance"
author: "ACI"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-usde-susde-april-expiry-pt-tokens-on-aave-v3-plasma-instance/23515"
---

## Simple Summary

This AIP proposes to onboard USDe and sUSDe April expiry PT tokens on Aave V3 Plasma Instance.

## Motivation

The previous USDe and sUSDe PT tokens that were onboarded have brought significant inflows to Aave, in preparation for the expiry and rollover we propose to onboard the next expiry of this PT token. We expect at a minimum that deposits will match those in the current expiry PT token, with potentially some sidelined demand.

### Asset State

#### Asset Growth

Ethena’s USDe supply has recently seen a consolidation. The total supply of USDe is now at 6.561 billion. A significant portion of this is staked as sUSDe, with the total supply of the yield-bearing sUSDe reaching over 3.55 billion, reflecting a staking ratio of approximately 54.25%.

#### Underlying Stability

The market price of USDe remains pegged to $1.00, with no significant deviations from the peg since the 10/10 market crash. From a protocol health perspective, Ethena maintains a solvency ratio of 101.64% and is supported by a Reserve Fund capitalized at over $62.07 million. The historical price chart shows the peg’s stability.

![Underlying Stability](https://europe1.discourse-cdn.com/flex013/uploads/aave/original/2X/a/ab378b3eba7bbbd912e85e70e0d21bdf24b886bf.png)
_Source: LlamaRisk, December 12, 2025_

## Useful Links

https://docs.pendle.finance/ProtocolMechanics/YieldTokenization/PT

## Specification

PT-sUSDE-9APR2026: https://plasmascan.to/address/0xab509448ad489e2e1341e25cc500f2596464cc82

PT-USDe-9APR2026: https://plasmascan.to/address/

### Migration of Existing PTs

To support a seamless migration from other PT-USDe-15JAN2026 and PT-sUSDe-15JAN2026 assets maturing in mid-January to PT-sUSDe-9APR2026 and PT-USDe-9APR2026, we recommend including PT-USDe-15JAN2026 and PT-sUSDe-15JAN2026 in the newly created respective E-Modes.

### PT-USDe-9APR2026

| Parameter                      |                                      Value |
| ------------------------------ | -----------------------------------------: |
| Isolation Mode                 |                                      false |
| Borrowable                     |                                   DISABLED |
| Collateral Enabled             |                                       true |
| Supply Cap (PT_sUSDE_9APR2026) |                                100,000,000 |
| Borrow Cap (PT_sUSDE_9APR2026) |                                          1 |
| Debt Ceiling                   |                                      USD 0 |
| LTV                            |                                     87.2 % |
| LT                             |                                      0.1 % |
| Liquidation Bonus              |                                      7.5 % |
| Liquidation Protocol Fee       |                                       10 % |
| Reserve Factor                 |                                       45 % |
| Base Variable Borrow Rate      |                                        0 % |
| Variable Slope 1               |                                       10 % |
| Variable Slope 2               |                                      300 % |
| Uoptimal                       |                                       45 % |
| Flashloanable                  |                                    ENABLED |
| Siloed Borrowing               |                                   DISABLED |
| Borrowable in Isolation        |                                   DISABLED |
| Oracle                         | 0x13f2EA8dfa948c5247826283079615Ee4d0A1AA5 |
| E-Mode Category                |          PT-USDe Stablecoins, PT-USDe USDe |

**Initial E-mode Risk Oracle**

| **Parameter** | **Value**   | **Value** |
| ------------- | ----------- | --------- |
| E-Mode        | Stablecoins | USDe      |
| LTV           | 86.4%       | 87.2%     |
| LT            | 88.4%       | 89.2%     |
| LB            | 4.7%        | 3.7%      |

**Oracle details**
Linear discount oracle

| **Parameter**          | **Value**                                                                                                                |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| Oracle                 | [PT Capped USDe USDT/USD linear discount](https://plasmascan.to/address/0x37f3a8b02BAbe4dd71acb5f214F22C09AFf607f3#code) |
| USDT/USD Oracle        | [Capped USDT/USD](https://plasmascan.to/address/0xdBbB0b5DD13E7AC9C56624834ef193df87b022c3#readContract)                 |
| discountRatePerYear    | 4.701%                                                                                                                   |
| maxDiscountRatePerYear | 27.276%                                                                                                                  |
| Last Answer            | 98568910 ($0.98568910)                                                                                                   |

**PT-USDe Stablecoins E-mode**

| **Asset**         | **PT-USDe-9APR2026**   | **PT-USDe-15JAN2026**  | **USDe**               | **USDT0** |
| ----------------- | ---------------------- | ---------------------- | ---------------------- | --------- |
| Collateral        | Yes                    | Yes                    | Yes                    | No        |
| Borrowable        | No                     | No                     | Yes                    | Yes       |
| LTV               | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -         |
| LT                | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -         |
| Liquidation Bonus | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -         |

**PT-USDe USDe E-mode**

| **Asset**         | **PT-USDe-9APR2026**   | **PT-USDe-15JAN2026**  | **USDe**               |
| ----------------- | ---------------------- | ---------------------- | ---------------------- |
| Collateral        | Yes                    | Yes                    | Yes                    |
| Borrowable        | No                     | No                     | Yes                    |
| LTV               | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle |
| LT                | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle |
| Liquidation Bonus | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle |

### PT-sUSDe-9APR2026

| Parameter                     |                                      Value |
| ----------------------------- | -----------------------------------------: |
| Isolation Mode                |                                      false |
| Borrowable                    |                                   DISABLED |
| Collateral Enabled            |                                       true |
| Supply Cap (PT_USDe_9APR2026) |                                 40,000,000 |
| Borrow Cap (PT_USDe_9APR2026) |                                          1 |
| Debt Ceiling                  |                                      USD 0 |
| LTV                           |                                     0.05 % |
| LT                            |                                      0.1 % |
| Liquidation Bonus             |                                      7.5 % |
| Liquidation Protocol Fee      |                                       10 % |
| Reserve Factor                |                                       45 % |
| Base Variable Borrow Rate     |                                        0 % |
| Variable Slope 1              |                                       10 % |
| Variable Slope 2              |                                      300 % |
| Uoptimal                      |                                       45 % |
| Flashloanable                 |                                    ENABLED |
| Siloed Borrowing              |                                   DISABLED |
| Borrowable in Isolation       |                                   DISABLED |
| Oracle                        | 0x37f3a8b02BAbe4dd71acb5f214F22C09AFf607f3 |
| E-Mode Category               |        PT-sUSDe Stablecoins, PT-sUSDe USDe |

**Initial E-mode Risk Oracle**

| **Parameter** | **Value**   | **Value** |
| ------------- | ----------- | --------- |
| E-Mode        | Stablecoins | USDe      |
| LTV           | 85.5%       | 87.2%     |
| LT            | 87.5%       | 89.2%     |
| LB            | 5.7%        | 3.7%      |

**Oracle details**
Linear discount oracle

| **Parameter**                 | **Value**                                                                                                                         |
| ----------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| Oracle                        | [PT Capped sUSDe USDT/USD linear discount](https://plasmascan.to/address/0x13f2EA8dfa948c5247826283079615Ee4d0A1AA5#readContract) |
| USDT/USD Oracle               | [Capped USDT/USD](https://plasmascan.to/address/0xdBbB0b5DD13E7AC9C56624834ef193df87b022c3#readContract)                          |
| discountRatePerYear (Initial) | 5.596%                                                                                                                            |
| maxDiscountRatePerYear        | 27.276%                                                                                                                           |
| Last Answer                   | 98303829 ($0.98303829)                                                                                                            |

**PT-sUSDe Stablecoins E-mode**

| **Asset**         | **PT-sUSDe-9APR2026**  | **PT-sUSDe-15JAN2026** | **sUSDe**              | **USDT0** | **USDe** |
| ----------------- | ---------------------- | ---------------------- | ---------------------- | --------- | -------- |
| Collateral        | Yes                    | Yes                    | Yes                    | No        | No       |
| Borrowable        | No                     | No                     | No                     | Yes       | Yes      |
| LTV               | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -         | -        |
| LT                | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -         | -        |
| Liquidation Bonus | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -         | -        |

**PT-sUSDe USDe E-mode**

| **Asset**         | **PT-sUSDe-9APR2026**  | **PT-sUSDe-15JAN2026** | **sUSDe**              | **USDe** |
| ----------------- | ---------------------- | ---------------------- | ---------------------- | -------- |
| Collateral        | Yes                    | Yes                    | Yes                    | No       |
| Borrowable        | No                     | No                     | No                     | Yes      |
| LTV               | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -        |
| LT                | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -        |
| Liquidation Bonus | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -        |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://plasmascan.to/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for both asset listed

### Disclaimer

ACI is not directly affiliated with Pendle and did not receive compensation for the creation of this proposal. Some ACI employees may hold Pendle tokens.

## References

- Implementation: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251217_AaveV3Plasma_ListingOfPTEthenaAprilMaturityOnPlasmaInstance/AaveV3Plasma_ListingOfPTEthenaAprilMaturityOnPlasmaInstance_20251217.sol)
- Tests: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251217_AaveV3Plasma_ListingOfPTEthenaAprilMaturityOnPlasmaInstance/AaveV3Plasma_ListingOfPTEthenaAprilMaturityOnPlasmaInstance_20251217.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-usde-susde-april-expiry-pt-tokens-on-aave-v3-plasma-instance/23515)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
