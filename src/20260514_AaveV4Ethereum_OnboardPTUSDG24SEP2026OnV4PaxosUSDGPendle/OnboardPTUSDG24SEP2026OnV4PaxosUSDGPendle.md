---
title: "Launch of V4 Paxos Hub and onboard PT-USDG-24SEP2026"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-pt-usdg-24sep2026-to-aave-v4-on-ethereum/24942/3"
---

## Simple Summary

This AIP onboards PT-USDG-24SEP2026 to Aave V4 on Ethereum, listed on a dedicated Paxos Hub with a single USDG Pendle spoke (a correlated stablecoin group). The spoke carries PT-USDG as its sole collateral, borrowable against USDC, USDT, and USDG within that correlated group. USDC and USDT are supplied natively to the Paxos Hub, while USDG is sourced from the Core Hub through a cross-hub credit line. The AIP also replaces the fixed $1.00 USDG price reference with the live Chainlink USDG/USD feed wrapped in a 1.04-capped stablecoin adapter, both for the USDG reserve and as the PT-USDG-24SEP2026 oracle base.

## Motivation

PT-USDG-24SEP2026 is the next listed maturity in the USDG-backed Pendle PT series. USDG is a Paxos-issued stablecoin backed 1:1 by cash, short-dated US Treasuries, and equivalent reserves, with circulating supply of approximately $2.63B across chains ($480M on Ethereum) and a market price within a few basis points of par against the Chainlink USDG/USD feed. USDG is non-yield-bearing by design; its yield is expressed through the Pendle PT structure, where the principal token is purchased at a discount to its 1 USDG face value and redeems 1:1 for USDG at maturity. At assessment the PT traded at an implied yield of 4.50% against a 3.11% underlying USDG yield.

With the prior PT-USDG-28MAY2026 maturity expired, the September pool serves as the rollover destination for PT-USDG collateral suppliers seeking to maintain fixed-yield exposure, and pool liquidity has migrated accordingly, growing from approximately $99.7K at the original assessment to approximately $4.15M. Subsequent PT-USDG maturities can be added to the same spoke as further rollover destinations.

The listing uses a dedicated Paxos Hub rather than a spoke on the existing Plus Hub. A dedicated hub provides clean risk isolation for USDG-correlated collateral: the market is contained within the Paxos Hub, separate from the Ethena ecosystem markets on the Plus Hub, while Core Hub exposure remains limited to the USDG credit line and its Draw Cap. The single USDG Pendle spoke carries PT-USDG as its sole collateral, with USDC, USDT (supplied natively to the Paxos Hub) and USDG (drawn from the Core Hub) borrowable. PT-USDG redeems 1:1 to USDG at maturity, and USDC, USDT, and USDG are all dollar-denominated stablecoins, placing the collateral and the borrowable set within a single correlated group that supports tighter Collateral Factors than a general-purpose spoke. The venue also positions the hub to host additional USDG-correlated assets over time.

PT-USDG is priced with the dynamic linear discount rate oracle, which values the PT as a zero-coupon bond against a capped underlying Chainlink reference (the USDG/USD CAPO, a PriceCapAdapterStable bounding the live USDG/USD Chainlink feed at a 1.04 cap), applying a linear discount that decays to par at maturity. The discount rate is bounded above by `maxDiscountRatePerYear`, providing a deterministic price floor against adverse market dislocations.

## Specification

**PT-USDG-24SEP2026**: [https://etherscan.io/address/0xc1906aecf868749a2dee203f59b904c0cf212140](https://etherscan.io/address/0xc1906aecf868749a2dee203f59b904c0cf212140)

**Spoke-level liquidation configuration**

| Spoke             | Target Health Factor | HF for Max Bonus | Liquidation Bonus Factor |
| ----------------- | -------------------- | ---------------- | ------------------------ |
| USDG Pendle (new) | 1.0277               | 0.99             | 1                        |

**Reserve-level parameters**

| Parameter             | PT-USDG-24SEP2026 | USDC       | USDT       | USDG               |
| --------------------- | ----------------- | ---------- | ---------- | ------------------ |
| Source Hub            | Paxos             | Paxos      | Paxos      | Core (credit line) |
| Asset role            | Collateral only   | Borrowable | Borrowable | Borrowable         |
| Suppliable            | yes               | yes        | yes        | no                 |
| Collateral            | yes               | no         | no         | no                 |
| Borrowable            | no                | yes        | yes        | yes                |
| Add Cap               | 15,000,000        | 13,000,000 | 13,000,000 | -                  |
| Draw Cap              | -                 | 13,000,000 | 13,000,000 | 30,000,000         |
| Collateral Factor     | 94%               | -          | -          | -                  |
| Max Liquidation Bonus | 3.2%              | -          | -          | -                  |
| Liquidation Fee       | 10%               | -          | -          | -                  |
| Collateral Risk score | 0%                | -          | -          | -                  |

**Reserve-level parameters: Tokenization Spoke**

| Parameter             | USDC       | USDT       |
| --------------------- | ---------- | ---------- |
| Suppliable            | yes        | yes        |
| Collateral            | no         | no         |
| Borrowable            | no         | no         |
| Add Cap               | 13,000,000 | 13,000,000 |
| Draw Cap              | -          | -          |
| Collateral Factor     | -          | -          |
| Max Liquidation Bonus | -          | -          |
| Liquidation Fee       | -          | -          |
| Collateral Risk score | -          | -          |

**Interest rate configuration (USDC, USDT)**

| Parameter           | Value |
| ------------------- | ----- |
| Base Borrow Rate    | 0%    |
| Optimal Utilization | 92%   |
| Slope Below Optimal | 4%    |
| Slope Above Optimal | 20%   |
| Liquidity Fee       | 10%   |

**Linear Discount Rate Oracle**

| Parameter                  | Value                                      |
| -------------------------- | ------------------------------------------ |
| initialDiscountRatePerYear | 4.50%                                      |
| maxDiscountRatePerYear     | 10.38%                                     |
| Oracle                     | 0x89F6Eb404AbF19FE817426dD2E2E0F14D1a5712e |

**USDG Price Reference Update**

The USDG price reference is migrated from the fixed $1.00 feed to the live Chainlink USDG/USD market feed ([0x14f0737d6b705259e521EA6E9E3506AC78dBd311](https://etherscan.io/address/0x14f0737d6b705259e521EA6E9E3506AC78dBd311)), wrapped in a `PriceCapAdapterStable` ([0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4](https://etherscan.io/address/0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4)) with a $1.04 upper cap — the same capped-adapter standard used for USDC, USDT, and RLUSD. The cap bounds upside oracle risk at 4% above par while the feed remains market-responsive on the downside, enabling timely liquidations in the event of a genuine depeg. The new reference is applied to the USDG reserve on every spoke that currently uses the fixed feed (Main, Forex, Gold, and the new USDG Pendle spoke) and as the PT-USDG-24SEP2026 oracle base.

| Parameter       | Current               | Proposed                               |
| --------------- | --------------------- | -------------------------------------- |
| USDG reference  | Fixed USDG/USD, $1.00 | Chainlink USDG/USD market feed, capped |
| Upper price cap | None                  | $1.04 (4% above par)                   |

## References

- Implementation: [AaveV4Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/de1d836c2b0377d3248010a43dd1164fc004dab7/src/20260514_AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4PaxosUSDGPendle/AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4PaxosUSDGPendle_20260514.sol)
- Tests: [AaveV4Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/de1d836c2b0377d3248010a43dd1164fc004dab7/src/20260514_AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4PaxosUSDGPendle/AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4PaxosUSDGPendle_20260514.t.sol)
- Snapshot: Direct-To-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-pt-usdg-24sep2026-to-aave-v4-on-ethereum/24942/3)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
