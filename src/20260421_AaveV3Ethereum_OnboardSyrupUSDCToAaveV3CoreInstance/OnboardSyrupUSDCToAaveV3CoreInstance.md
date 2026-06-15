---
title: "Onboard syrupUSDC to Aave V3 Core Instance"
author: "Aavechan Initiative @aci"
discussions: "https://governance.aave.com/t/arfc-onboard-syrupusdc-to-aave-v3-core-instance/22456"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0xf5951af5d6d7d70be998a72c531708db3ff9c46b033e3e27bfd59fb87542d0ea"
---

## Simple Summary

This proposal seeks to onboard syrupUSDC — a USDC-based yield-bearing token issued by Maple Finance — as a collateral asset on Aave V3 Core Instance. syrupUSDC is built on top of Maple's infrastructure and offers access to overcollateralized, fixed-rate institutional loans, which provide high and consistent yields to DeFi users.

Maple, launched in 2021, is an on-chain asset manager whose team has decades of traditional finance and crypto experience. As of June 2025, Maple has $2.3b in AUM. Maple combines deep capital markets expertise with DeFi innovation to offer digital asset lending and yield products.

## Motivation

Onboarding syrupUSDC to Aave V3 Core Instance provides:

- New Token Type: A new collateral option backed by real yield from fixed-rate institutional lending strategies
- AAVE TVL: Maple has a large network of institutional capital allocators, ready to allocate $500M+ USDC/USDT into syrupUSDC if it is available on Aave as collateral to loop it and get to their hurdle rates.
- Higher Rates and Utilization: Increases USDC rates and utilization due to strong expected borrower demand.
- Growth Incentives: Maple has $250k of incentives available to bootstrap the growth for Aave users.

The Aave and Maple partnership will enable:

- New Yield Opportunities: Commercial alignment with Maple's large institutional network, unlocking additional yield generation opportunities for Aave.
- GHO Adoption: Maple can help with growing other strategic priorities for Aave, including GHO adoption. E.g., GHO lending to institutions.
- Future Collaboration: Future asset listings, including the Maple liquid yielding Bitcoin asset.

## Specification

It's a USDC-based, yield-bearing token whose principal and yield are backed by the secured lending strategy of Maple. (More details below).

Technical details: ERC-4626 token standard built on top of Maple's smart contracts.
High Yield. Maple has a track record of generating consistently high underlying yields of 7-15% net APY.

Loans are fully collateralized by digital assets ensuring lending positions are protected, even if borrowers default or asset prices fall. More on: https://app.maple.finance/earn.

The table below illustrates the configured risk parameters for **syrupUSDC**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (syrupUSDC)    |                                200,000,000 |
| Borrow Cap (syrupUSDC)    |                                          1 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       50 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                       10 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xe4e9d021d3a44e8bc9949690e298c6b41c6ef354 |

### E-Mode

| **Parameter**         | **Value** | **Value** | **Value** |
| --------------------- | --------- | --------- | --------- |
| Asset                 | syrupUSDC | USDC      | USDT      |
| Collateral            | Yes       | No        | No        |
| Borrowable            | No        | Yes       | Yes       |
| Max LTV               | 90.00%    | -         | -         |
| Liquidation Threshold | 92.00%    | -         | -         |
| Liquidation Bonus     | 4.00%     | -         | -         |

**CAPO**

| **maxYearlyRatioGrowthPercent** | **ratioReferenceTime** | **MINIMUM_SNAPSHOT_DELAY** |
| ------------------------------- | ---------------------- | -------------------------- |
| 19.94%                          | monthly                | 7                          |

### Oracle details

| **Parameter**          | **Value**                                                                                                                          |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| Oracle                 | [0xE4E9d021D3A44E8bc9949690E298C6b41C6EF354](https://etherscan.io/address/0xE4E9d021D3A44E8bc9949690E298C6b41C6EF354#readContract) |
| Ratio Provider         | [syrupUSDC-USDC Exchange Rate](https://etherscan.io/address/0x80ac24aA929eaF5013f6436cdA2a7ba190f5Cc0b#readContract)               |
| Underlying oracle      | [USDC/USD](https://etherscan.io/address/0xB6557F02F0a5dA7b9D3C2d979cc19e00e756F6dA#readContract)                                   |
| Minimum Snapshot delay | 7 days                                                                                                                             |
| Max yearly growth      | 1994 (19.94%)                                                                                                                      |
| Last Answer            | 116045418 ($1.16045418 on April 21st)                                                                                              |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for syrupUSDC and the corresponding aToken, vToken and underlying token.

## Disclosure

ACI (Aave Chan Initiative) is not affiliated with Maple Finance and has not received compensation for creating this proposal.

### Useful links:

Website: https://maple.finance/
App: https://app.maple.finance/earn/details

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260421_AaveV3Ethereum_OnboardSyrupUSDCToAaveV3CoreInstance/AaveV3Ethereum_OnboardSyrupUSDCToAaveV3CoreInstance_20260421.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260421_AaveV3Ethereum_OnboardSyrupUSDCToAaveV3CoreInstance/AaveV3Ethereum_OnboardSyrupUSDCToAaveV3CoreInstance_20260421.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0xf5951af5d6d7d70be998a72c531708db3ff9c46b033e3e27bfd59fb87542d0ea)
- [Discussion](https://governance.aave.com/t/arfc-onboard-syrupusdc-to-aave-v3-core-instance/22456)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
