---
title: "Onboard rsETH to Aave V3 Linea Instance"
author: "ACI"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-rseth-to-aave-v3-linea-instance/22172"
---

## Simple Summary

This proposal seeks to onboard rsETH to the Aave V3 deployment on the Linea network.

As the onboarding of rsETH has already been approved and executed on the Ethereum, Arbitrum, and Base Aave V3 instances, this proposal follows the Direct-to-AIP path to extend rsETH support to the Linea instance without repeating the full ARFC process.

## Motivation

rsETH is a liquid staking token issued by Kelp DAO, offering users access to rewards from ETH staking while maintaining liquidity and DeFi composability. Its integrations on Aave across other networks have proven successful in terms of risk profile and utility.

Given that:

- rsETH has already passed governance and risk assessments for Ethereum, Arbitrum, and Base,

- Linea is a supported Aave V3 deployment with growing activity and integration potential,

- A precedent has been set for using the Direct-to-AIP path when onboarding previously approved assets to new instances,

This proposal aims to onboard rsETH to Linea V3 under the same configuration parameters used for other L2s, adjusted for market conditions where appropriate.

## Specification

The table below illustrates the configured risk parameters for **wrsETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (wrsETH)       |                                        400 |
| Borrow Cap (wrsETH)       |                                          0 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       70 % |
| LT                        |                                       73 % |
| Liquidation Bonus         |                                       10 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       45 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                       20 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x444f25c5E73fED92B91F3ECB1bD27003C3CDdeE7 |

Oracle and CAPO parameters:

| Parameter                     | Value                                                                                                          |
| ----------------------------- | -------------------------------------------------------------------------------------------------------------- |
| **Oracle**                    | [Capped wrsETH / rsETH(ETH) / USD](https://lineascan.build/address/0x444f25c5E73fED92B91F3ECB1bD27003C3CDdeE7) |
| **Ratio Provider**            | [Chainlink wrsETH / rsETH Exchange Rate](https://lineascan.build/address/0xEEDF0B095B5dfe75F3881Cb26c19DA209A27463a)                 |
| **Underlying Feed**           | [Chainlink ETH / USD](https://lineascan.build/address/0x3c6Cd9Cc7c7a4c2Cf5a82734CD249D7D593354dA)            |
| **Oracle Latest Answer**      | _(Aug-12-2025)_ 462685069182                                                                                   |
| **Snapshot Ratio**            | 1.03                                                                                                           |
| **Snapshot Timestamp**        | March 9, 2025, 17:27:19 UTC                                                                                    |
| **Max Yearly Ratio Growth %** | 9.83%                                                                                                          |

Additionally [0xdef1FA4CEfe67365ba046a7C630D6B885298E210](https://lineascan.build/address/0xdef1FA4CEfe67365ba046a7C630D6B885298E210) has been set as the emission admin for wrsETH and the corresponding aToken.

## References

- Implementation: [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250811_AaveV3Linea_OnboardRsETHToAaveV3LineaInstance/AaveV3Linea_OnboardRsETHToAaveV3LineaInstance_20250811.sol)
- Tests: [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250811_AaveV3Linea_OnboardRsETHToAaveV3LineaInstance/AaveV3Linea_OnboardRsETHToAaveV3LineaInstance_20250811.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-rseth-to-aave-v3-linea-instance/22172)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
