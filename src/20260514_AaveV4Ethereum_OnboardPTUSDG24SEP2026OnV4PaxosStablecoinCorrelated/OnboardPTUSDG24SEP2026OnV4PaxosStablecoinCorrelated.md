---
title: "Onboard PT-USDG-24SEP2026 on V4 Paxos Hub / Stablecoin Correlated"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-pt-usdg-24sep2026-to-aave-v4-on-ethereum/24942/3"
---

## Simple Summary

This AIP proposes to onboard PT-USDG-24SEP2026 to Aave V4 on Ethereum, listed on a dedicated Paxos Hub with a single Stablecoin Correlated spoke. The Paxos Hub holds native USDC and USDT liquidity alongside PT-USDG collateral, while USDG is sourced from the Core Hub through a cross-hub credit line.

## Motivation

PT-USDG-24SEP2026 is the next listed maturity in the USDG-backed PT series. With PT-USDG-28MAY2026 expired, the September pool serves as the rollover destination for PT-USDG collateral suppliers seeking to maintain fixed-yield exposure, and the pool has since grown to ~$4.15M in liquidity.

This addendum revises the market structure from the originally proposed Plus Hub spoke to a dedicated Paxos Hub. A dedicated hub provides clean risk isolation for USDG-correlated collateral: the market is contained within the Paxos Hub, separate from the Ethena ecosystem markets on the Plus Hub, while Core Hub exposure remains limited to the USDG credit line and its Draw Cap. The single Stablecoin Correlated spoke carries PT-USDG as its sole collateral, with USDC, USDT (supplied natively to the Paxos Hub) and USDG (drawn from the Core Hub) borrowable. PT-USDG redeems 1:1 to USDG at maturity, and USDC, USDT, and USDG are dollar-denominated stablecoins, placing the collateral and the borrowable set within a single correlated group. The venue also positions the hub to host additional USDG-correlated assets over time.

## Specification

**PT-USDG-24SEP2026**: https://etherscan.io/address/0xc1906aecf868749a2dee203f59b904c0cf212140

**Spoke-level liquidation configuration**

| Spoke                       | Target Health Factor | HF for Max Bonus | Liquidation Bonus Factor |
| --------------------------- | -------------------: | ---------------: | -----------------------: |
| Stablecoin Correlated (new) |               1.0277 |             0.99 |                        1 |

**Reserve-level parameters**

| Parameter             | PT-USDG-24SEP2026 |       USDC |       USDT |               USDG |
| --------------------- | ----------------: | ---------: | ---------: | -----------------: |
| Source Hub            |             Paxos |      Paxos |      Paxos | Core (credit line) |
| Asset role            |   Collateral only | Borrowable | Borrowable |         Borrowable |
| Suppliable            |               yes |        yes |        yes |                 no |
| Collateral            |               yes |         no |         no |                 no |
| Borrowable            |                no |        yes |        yes |                yes |
| Add Cap               |        15,000,000 | 13,000,000 | 13,000,000 |                  - |
| Draw Cap              |                 - | 13,000,000 | 13,000,000 |         30,000,000 |
| Collateral Factor     |               95% |          - |          - |                  - |
| Max Liquidation Bonus |                2% |          - |          - |                  - |
| Liquidation Fee       |               10% |          - |          - |                  - |
| Collateral Risk score |                0% |          - |          - |                  - |

**Interest rate configuration (USDC, USDT)**

| Parameter           | Value |
| ------------------- | ----: |
| Base Borrow Rate    |    0% |
| Optimal Utilization |   92% |
| Slope Below Optimal |    4% |
| Slope Above Optimal |   20% |
| Liquidity Fee       |   10% |

**Linear Discount Rate Oracle**

| Parameter                  | Value                                      |
| -------------------------- | ------------------------------------------ |
| initialDiscountRatePerYear | 4.50%                                      |
| maxDiscountRatePerYear     | 10.38%                                     |
| Oracle                     | 0xD2417d928B7649feb50E61D9cCA38e56EFB34902 |

## References

- Implementation: [AaveV4Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260514_AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4PaxosStablecoinCorrelated/AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4PaxosStablecoinCorrelated_20260514.sol)
- Tests: [AaveV4Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260514_AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4PaxosStablecoinCorrelated/AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4PaxosStablecoinCorrelated_20260514.t.sol)
- Snapshot: Direct-To-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-pt-usdg-24sep2026-to-aave-v4-on-ethereum/24942/3)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
