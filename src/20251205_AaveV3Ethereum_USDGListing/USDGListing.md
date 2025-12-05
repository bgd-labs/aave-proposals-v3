---
title: "USDG Listing"
author: "Paxos (implemented and written by ACI via Skyward)"
discussions: "https://governance.aave.com/t/arfc-onboard-usdg-to-aave-v3-core-instance/23271"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0x31a6ca3a958d1d9f0d560b90487a72af28780a9b19bc6398444c06ee9d3a96fb"
---

## Simple Summary

We propose the onboarding of USDG, a USD-backed stablecoin issued by Paxos, on Aave V3 Core Instance. This listing would initially enable users to deposit USDG to earn yield and borrow USDG as a stable asset. Collateral usage will be considered at a later date following review by Aave's Risk Management teams. TEMP CHECK has passed [[TEMP CHECK] Onboard USDG to Aave V3 Core Instance](https://governance.aave.com/t/temp-check-onboard-usdg-to-aave-v3-core-instance/23014) as well as [TEMP CHECK Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x4a9b7b0e64d20a9a7903ef82d20c7d3bc8e1612907187c55b41af66d5e0ec162).

## Motivation

USDG is a regulated stablecoin backed 1:1 by cash and short-term U.S. Treasuries, designed with regulatory compliance and transparency as core principles.

As a trusted stablecoin from Paxos, a regulated financial institution with a strong track record, USDG has gained significant adoption across various platforms, demonstrating market confidence and growing utility.

Key differentiators:

1. Regulatory compliance: USDG is fully regulated and issued by Paxos, a New York State Department of Financial Services regulated entity.
2. Transparency: Regular attestations verify USDG's reserves are fully backed by cash and short-term U.S. Treasuries.
3. Paxos plan to rollout a public bug bounty program in Q1 2026 on a major bug bounty platform.
   This program will cover all Paxos tokens and our full platform (APIs, UIs, etc.). We will share more details as they we get closer to launch.

## Specification

| **Parameter**            | Value      |
| ------------------------ | ---------- |
| Asset                    | USDG       |
| Isolation Mode           | No         |
| Borrowable               | Yes        |
| Collateral Enabled       | No         |
| Supply Cap               | 30,000,000 |
| Borrow Cap               | 25,000,000 |
| Debt Ceiling             | -          |
| LTV                      | -          |
| LT                       | -          |
| Liquidation Bonus        | -          |
| Liquidation Protocol Fee | -          |
| Variable Base            | 0%         |
| Variable Slope1          | 6.00%      |
| Variable Slope2          | 50%        |
| Uoptimal                 | 80%        |
| Reserve Factor           | 20%        |

USDG Overview:

- Ticker: USDG
- Fiat backed stablecoin
- Issuer: Paxos
- Backing assets: USD cash and short-term U.S treasuries.
- Audits: Multiple third-party audits
- Price Oracle: Chainlink
- USDG Listed on: Major centralized and decentralized exchanges.

Use Cases:

1. Deposits enabled for yield generation
2. Borrowing enabled as a low-volatility asset

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for USDG and the corresponding aToken.

## Disclosure

The current proposal has been powered by Skywards. ACI is not affiliated with Paxos and has not received compensation for the creation and review of this proposal.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251205_AaveV3Ethereum_USDGListing/AaveV3Ethereum_USDGListing_20251205.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251205_AaveV3Ethereum_USDGListing/AaveV3Ethereum_USDGListing_20251205.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x31a6ca3a958d1d9f0d560b90487a72af28780a9b19bc6398444c06ee9d3a96fb)
- [Discussion](https://governance.aave.com/t/arfc-onboard-usdg-to-aave-v3-core-instance/23271)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
