---
title: "Onboard Strata srUSDe PT tokens to V3 Core Instance"
author: "Aavechan Initiative @aci"
discussions: "https://governance.aave.com/t/arfc-onboard-strata-srusde-pt-tokens-to-v3-core-instance/23481"
snapshot: "https://snapshot.org/#/aavedao.eth/proposal/0x064b74d6b55b4cdabd6233555cf29e6fcc6118ed8c9050f1807c8db8525d7ae5"
---

## Simple Summary

This proposal seeks to onboard the Strata srUSDe PT tokens to the Aave V3 Core Instance. This specific AIP is onboarding the April expiry PT token.

## Motivation

Given both the popularity of PT token collateral on Aave and the adoption of the srUSDe PT token by LPs on Pendle, we believe this would be an attractive collateral token for Aave users.

We believe that Aave users would welcome the addition of a PT token from the Ethena ecosystem with circa 50% higher yields than sUSDe PT tokens at the time of writing.

## Specification

The table below illustrates the configured risk parameters for **PT_srUSDe_2APR2026**

| Parameter                       |      Value |
| ------------------------------- | ---------: |
| Isolation Mode                  |      false |
| Borrowable                      |   DISABLED |
| Collateral Enabled              |       true |
| Supply Cap (PT_srUSDe_2APR2026) | 50,000,000 |
| Borrow Cap (PT_srUSDe_2APR2026) |          1 |
| Debt Ceiling                    |      USD 0 |
| LTV                             |        0 % |
| LT                              |        0 % |
| Liquidation Bonus               |        0 % |
| Liquidation Protocol Fee        |       10 % |
| Reserve Factor                  |       50 % |
| Base Variable Borrow Rate       |        0 % |
| Variable Slope 1                |       10 % |
| Variable Slope 2                |      300 % |
| Uoptimal                        |       45 % |
| Flashloanable                   |    ENABLED |
| Siloed Borrowing                |   DISABLED |
| Borrowable in Isolation         |   DISABLED |

### Oracle

Linear discount oracle

| **Parameter**          | **Value**                                                                                                                      |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| Oracle                 | [PT Capped srUSDe USDT/USD linear discount 02APR2026](https://etherscan.io/address/0xB539C6C0fc36ff1572B13ACec343B854937db576) |
| USDT/USD Oracle        | [Capped USDT/USD](https://etherscan.io/address/0x260326c220E469358846b187eE53328303Efe19C)                                     |
| discountRatePerYear    | 6.72%                                                                                                                          |
| maxDiscountRatePerYear | 24.01%                                                                                                                         |
| Last Answer (Dec 31th) | 98578086 ($0.98578086)                                                                                                         |

| Oracle | 0xB539C6C0fc36ff1572B13ACec343B854937db576 |

### Emodes

**PT-srUSDe Stablecoins E-mode**

| **Asset**         | **PT-srUSDe-1APR2026** | **sUSDe**              | **USDT** | **USDe** | USDC |
| ----------------- | ---------------------- | ---------------------- | -------- | -------- | ---- |
| Collateral        | Yes                    | Yes                    | No       | No       | No   |
| Borrowable        | No                     | No                     | Yes      | Yes      | Yes  |
| LTV               | Subject to Risk Oracle | Subject to Risk Oracle | -        | -        | -    |
| LT                | Subject to Risk Oracle | Subject to Risk Oracle | -        | -        | -    |
| Liquidation Bonus | Subject to Risk Oracle | Subject to Risk Oracle | -        | -        | -    |

**PT-srUSDe USDe E-mode**

| **Asset**         | **PT-srUSDe-1APR2026** | **sUSDe**              | **USDe** |
| ----------------- | ---------------------- | ---------------------- | -------- |
| Collateral        | Yes                    | Yes                    | No       |
| Borrowable        | No                     | No                     | Yes      |
| LTV               | Subject to Risk Oracle | Subject to Risk Oracle | -        |
| LT                | Subject to Risk Oracle | Subject to Risk Oracle | -        |
| Liquidation Bonus | Subject to Risk Oracle | Subject to Risk Oracle | -        |

**Initial E-Mode Risk Oracle**

| **Parameter** | **Value**   | **Value** |
| ------------- | ----------- | --------- |
| E-Mode        | Stablecoins | USDe      |
| LTV           | 89.5%       | 91.2%     |
| LT            | 91.5%       | 93.2%     |
| LB            | 4.5%        | 2.6%      |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_srUSDe_2APR2026 and the corresponding aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260120_AaveV3Ethereum_OnboardStrataSrUSDePTTokensToV3CoreInstance/AaveV3Ethereum_OnboardStrataSrUSDePTTokensToV3CoreInstance_20260120.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260120_AaveV3Ethereum_OnboardStrataSrUSDePTTokensToV3CoreInstance/AaveV3Ethereum_OnboardStrataSrUSDePTTokensToV3CoreInstance_20260120.t.sol)
- [Snapshot](https://snapshot.org/#/aavedao.eth/proposal/0x064b74d6b55b4cdabd6233555cf29e6fcc6118ed8c9050f1807c8db8525d7ae5)
- [Discussion](https://governance.aave.com/t/arfc-onboard-strata-srusde-pt-tokens-to-v3-core-instance/23481)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
