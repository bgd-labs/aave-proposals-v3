---
title: "Onboard PT sUSDe July and PT eUSDe May on Core Instance"
author: "ACI and BGD Labs"
discussions: "https://governance.aave.com/t/arfc-onboard-susde-july-expiry-pt-tokens-on-aave-v3-core-instance/21878"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xc039953e4f18804bb017876d27621da1ab3e4de53acd3b32d0f1fe94d4bbb6a0"
---

## Simple Summary

This proposal seeks to onboard pendle [PT-sUSDe-31July2025](https://etherscan.io/address/0x3b3fB9C57858EF816833dC91565EFcd85D96f634) and [PT-eUSDe-29May2025](https://etherscan.io/address/0x50D2C7992b802Eef16c04FeADAB310f31866a545) on the Aave V3 core instance and activate Edge AGRS system to automate updating eMode category params for these assets.

## Motivation

Pendle allows users to split yield bearing tokens into principal (PT) and yield (YT) components. This opens the door to trading yield for the growing number of yield bearing tokens, and gives users additional options for yield farming strategies. A notable feature of the PT tokens is that at the maturity date, the value of the PT equals the value of the underlying asset and can be redeemed for the underlying. This means PT tokens, which can be bought at a discount within Pendle pools, represent the fixed rate part of a Pendle asset pair.

Pendle has seen extremely high growth this year, with current TVL of circa $4.5 billion. Along with this growth has come the desire for yield traders to borrow against their Pendle PT tokens. This represents a multi-billion dollar growth opportunity for Aave, without a large increase in risk if PT tokens are onboarded for already listed assets such as sUSDe. With this, it makes sense to onboard PT-sUSDe-31July2025 and PT-eUSDe-29May2025 assets.

The RiskSteward has been quite successful to update risk params in a controlled way in the past for rates, caps and other params. The new iteration of the RiskSteward allows to update eMode category collateral params such as LT, LTV and LB in a constrained manner, while also allowing to change the discountRate of pendle pt feeds. With this we activate the new RiskSteward on the core instance only for now, gradually migrating to newer RiskSteward on other instances as well.

## Specification

The table below illustrates the configured risk parameters for **PT_sUSDE_31JUL2025** and **\*PT_eUSDe_29MAR2025** assets:

| Parameter                       |                                                                                                    PT_sUSDE_31JUL2025 |                                                                                                    PT_eUSDe_29MAR2025 |
| ------------------------------- | --------------------------------------------------------------------------------------------------------------------: | --------------------------------------------------------------------------------------------------------------------: |
| Borrowable                      |                                                                                                              DISABLED |                                                                                                              DISABLED |
| Collateral Enabled              |                                                                                                                  true |                                                                                                                  true |
| Supply Cap (PT_sUSDE_31JUL2025) |                                                                                                            85,000,000 |                                                                                                           150,000,000 |
| Borrow Cap (PT_sUSDE_31JUL2025) |                                                                                                                     1 |                                                                                                                     1 |
| Isolation Mode                  |                                                                                                                 false |                                                                                                                 false |
| Debt Ceiling                    |                                                                                                                 USD 0 |                                                                                                                 USD 0 |
| LTV                             |                                                                                                                0.05 % |                                                                                                                0.05 % |
| LT                              |                                                                                                                 0.1 % |                                                                                                                 0.1 % |
| Liquidation Bonus               |                                                                                                                 7.5 % |                                                                                                                 7.5 % |
| Liquidation Protocol Fee        |                                                                                                                  10 % |                                                                                                                  10 % |
| Reserve Factor                  |                                                                                                                  20 % |                                                                                                                  20 % |
| Base Variable Borrow Rate       |                                                                                                                   0 % |                                                                                                                   0 % |
| Variable Slope 1                |                                                                                                                   7 % |                                                                                                                   7 % |
| Variable Slope 2                |                                                                                                                 300 % |                                                                                                                 300 % |
| Uoptimal                        |                                                                                                                  45 % |                                                                                                                  45 % |
| Flashloanable                   |                                                                                                               ENABLED |                                                                                                               ENABLED |
| Siloed Borrowing                |                                                                                                              DISABLED |                                                                                                              DISABLED |
| Borrowable in Isolation         |                                                                                                              DISABLED |                                                                                                              DISABLED |
| Oracle                          | [0xfB2d51573d97fEbA5E2Ad7cc447e76CBad153878](https://etherscan.io/address/0xfB2d51573d97fEbA5E2Ad7cc447e76CBad153878) | [0x5292AB3292D076271f853Ed8e05e61cc02F0A2C6](https://etherscan.io/address/0x5292AB3292D076271f853Ed8e05e61cc02F0A2C6) |

The following EMode categories will be created for the assets listed:

**PT-sUSDe Stablecoins E-Mode (id: 8)**:

| Asset             | PT-sUSDe | USDC | USDT | USDS |
| ----------------- | -------- | ---- | ---- | ---- |
| Collateral        | Yes      | No   | No   | No   |
| Borrowable        | No       | Yes  | Yes  | Yes  |
| LTV               | 87.4%    | -    | -    | -    |
| LT                | 89.4%    | -    | -    | -    |
| Liquidation Bonus | 4.6%     | -    | -    | -    |

**PT-eUSDe Stablecoins E-Mode (id: 9)**:

| Asset             | PT-eUSDe | USDC | USDT | USDS |
| ----------------- | -------- | ---- | ---- | ---- |
| Collateral        | Yes      | No   | No   | No   |
| Borrowable        | No       | Yes  | Yes  | Yes  |
| LTV               | 91%      | -    | -    | -    |
| LT                | 93%      | -    | -    | -    |
| Liquidation Bonus | 3.3%     | -    | -    | -    |

The Pendle PT Capo with linear discount have been deployed with the following configurations:

| **Parameter**          | **PT_eUSDe_29MAR2025** | **PT_sUSDE_31JUL2025** |
| ---------------------- | ---------------------- | ---------------------- |
| discountRatePerYear    | 7.87%                  | 7.5124%                |
| maxDiscountRatePerYear | 39.22%                 | 21.22%                 |

<br/>

We activate the next iteration of RiskSteward on core instance (audited by Certora), which allows updating the eMode category and the discount rate of pendle pt feeds. In addition we also activate the Edge AGRS system using a new instance of RiskSteward to automate updating eMode LT, LTV, LB of the new PT-sUSDe Stablecoins and PT-eUSDe Stablecoins Emodes using the [AaveStewardInjectorEMode](https://etherscan.io/address/0x83ab600cE8a61b43e1757b89C0589928f765c1C4) middleware.
Please note, the Automated Edge AGRS system will only be able to do EMode updates on the new pendle eModes categories and no change will be allowed on other eModes. The manual RiskSteward however would be able to change eMode configurations for all the eModes on the core instance within the configured bounds.

The new RiskStewards will have the following configuration:

**Manual RiskSteward**:
|**Parameter**|**Percent change allowed**|**minimumDelay**|
| --- | --- | ---|
|EMode LTV |0.5% absolute change| 3 days |
|EMode LiquidationThreshold|0.1% absolute change| 3 days |
|EMode LiquidationBonus|0.5% absolute change| 3 days |
|Pendle PT Feed Discount Rate|5% relative change| 2 days |

**Automated RiskSteward**:
|**Parameter**|**Percent change allowed**|**minimumDelay**|
| --- | --- | ---|
|EMode LTV |0.5% absolute change| 3 days |
|EMode LiquidationThreshold|0.5% absolute change| 3 days |
|EMode LiquidationBonus|0.5% absolute change| 3 days |

The `RISK_ADMIN` role will be revoked from the legacy RiskSteward via `ACL_MANAGER.removeRiskAdmin()` and the role will be given to the new Manual and Automated RiskSteward via `ACL_MANAGER.addRiskAdmin()`. Please note, all configuration except for EMode and Pendle discount rate will be same on the new RiskSteward as before.

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_sUSDE_31JUL2025, PT_eUSDe_29MAR2025 and the corresponding aTokens.

## References

- Implementation: [PTsUSDeListing](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250423_AaveV3Ethereum_OnboardPTSUSDeJulyAndPTEUSDeMayOnCoreInstance/AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250423.sol), [PTeUSDeListing](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250423_AaveV3Ethereum_OnboardPTSUSDeJulyAndPTEUSDeMayOnCoreInstance/AaveV3Ethereum_OnboardPTEUSDeMayOnCoreInstance_20250423.sol)
  [EdgeAGRSActivation](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250423_AaveV3Ethereum_OnboardPTSUSDeJulyAndPTEUSDeMayOnCoreInstance/AaveV3Ethereum_ActivateAGRS_20250423.sol)
- Tests: [PTsUSDeListing](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250423_AaveV3Ethereum_OnboardPTSUSDeJulyAndPTEUSDeMayOnCoreInstance/AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250423.t.sol), [PTeUSDeListing](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250423_AaveV3Ethereum_OnboardPTSUSDeJulyAndPTEUSDeMayOnCoreInstance/AaveV3Ethereum_OnboardPTEUSDeMayOnCoreInstance_20250423.t.sol)
  [EdgeAGRSActivation](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250423_AaveV3Ethereum_OnboardPTSUSDeJulyAndPTEUSDeMayOnCoreInstance/AaveV3Ethereum_ActivateAGRS_20250423.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xc039953e4f18804bb017876d27621da1ab3e4de53acd3b32d0f1fe94d4bbb6a0)
- [PT-sUSDe-31July2025 Discussion](https://governance.aave.com/t/arfc-onboard-susde-july-expiry-pt-tokens-on-aave-v3-core-instance/21878)
- [PT-eUSDe-29May2025 Discussion](https://governance.aave.com/t/arfc-onboard-eusde-pt-tokens-to-aave-v3-core-instance/21767)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
