---
title: "Onboard PT-USDG-24SEP2026 on V4 Plus / USDG Correlated"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-pt-usdg-24sep2026-to-aave-v4-on-ethereum/24942/3"
---

## Simple Summary

This AIP proposes to onboard PT-USDG-24SEP2026 to Aave V4 on Ethereum, listed on a new USDG Correlated spoke anchored on the Plus Hub that draws USDG liquidity from the Core Hub.

## Motivation

PT-USDG-24SEP2026 is the next listed maturity in the USDG-backed PT series. With PT-USDG-28MAY2026 reaching expiry on May 28, 2026, the September pool serves as the natural rollover destination for the ~$105.1M of PT-USDG collateral currently held on Aave V3 Core. Onboarding it preserves fixed-rate exposure for existing borrowers and continues the supported PT roadmap on Aave.

The listing is structured as a dedicated correlated spoke on the Plus Hub (joining the existing Ethena Ecosystem and Ethena Correlated spokes). PT-USDG collateral suppliers borrow USDG via a cross-hub credit line into Core, where USDG is already a native asset. The Draw Cap on Core defines the explicit containment boundary for Core USDG suppliers' exposure to the new spoke, and the correlated designation enables a tighter Collateral Factor than a general-purpose configuration.

## Specification

**PT-USDG-24SEP2026**: https://etherscan.io/address/0xc1906aecf868749a2dee203f59b904c0cf212140

**Spoke-level liquidation configuration**

| Spoke                 | Target Health Factor | HF for Max Bonus | Liquidation Bonus Factor |
| --------------------- | -------------------: | ---------------: | -----------------------: |
| USDG Correlated (new) |               1.0277 |             0.99 |                        1 |

**Reserve-level parameters**

| Parameter             | PT-USDG-24SEP2026 |                                    USDG |
| --------------------- | ----------------: | --------------------------------------: |
| Asset role            |   Collateral only | Borrow only (credit line from Core Hub) |
| Suppliable            |               yes |                                      no |
| Collateral            |               yes |                                      no |
| Borrowable            |                no |                                     yes |
| Add Cap               |        15,000,000 |                                       - |
| Draw Cap              |                 - |                              13,000,000 |
| Collateral Factor     |               95% |                                       - |
| Max Liquidation Bonus |                2% |                                       - |
| Liquidation Fee       |               10% |                                       - |
| Collateral Risk score |                0% |                                       - |

**Linear Discount Rate Oracle**

| Parameter                  | Value                                      |
| -------------------------- | ------------------------------------------ |
| initialDiscountRatePerYear | 4.50%                                      |
| maxDiscountRatePerYear     | 10.38%                                     |
| Oracle                     | 0xD2417d928B7649feb50E61D9cCA38e56EFB34902 |

## References

- Implementation: [AaveV4Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260514_AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4CoreUSDGCorrelated/AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4CoreUSDGCorrelated_20260514.sol)
- Tests: [AaveV4Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260514_AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4CoreUSDGCorrelated/AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4CoreUSDGCorrelated_20260514.t.sol)
- Snapshot: Direct-To-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-pt-usdg-24sep2026-to-aave-v4-on-ethereum/24942/3)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
