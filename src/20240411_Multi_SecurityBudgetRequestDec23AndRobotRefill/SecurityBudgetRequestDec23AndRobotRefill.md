---
title: "Security Budget Request December 2023"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-bgd-security-budget-request-december-2023/15783"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xf95bc210e3e93c2112c694cb158db22c93504155b48c03d9358e4c41c33ee782"
---

## Simple Summary

Proposal to release $151’200 to reimburse BGD Labs for the costs paid towards external security reviews, and 1640 LINK and 4000 MATIC towards the refill of Aave Robot and Aave Delivery Infrastructure.

## Motivation

Part of our [scope Aave <> BGD Phase III](https://governance.aave.com/t/aave-bored-ghosts-developing-phase-3/16893#scope-1-aave-technical-maintenance-improvements-security-coordination-and-tech-advisory-to-the-dao-4) is the planning, engagement, and coordination with security partners of the DAO.
During the previous year and a half, Aave was in a pretty intensive delivery phase (Aave v3 improvements, GHO, Aave Governance v3, a.DI), and we thought it was appropriate to have continuous engagement with 2 security firms like Certora and SigmaPrime.
Even if this worked well, we think that there is room for optimization, and it is a good idea to do more ad-hoc requests for the security budget.

Certain permissionless actions on the aave governance requires interaction (transaction) by someone for the governance system to run. This is done by the Aave Robot, which spends LINK tokens for the gas amount spent during the automation of these permissionless actions.

During the past months BGD labs had spent in total of 1640 LINK for the Aave Robot, and 4000 MATIC for funding the Aave Delivery Infrastructure which is used to pay for the bridging fees in order for the governance system to work.

Considering all the above amounts already paid by BGD, we request the following reimbursement:

- Compensation to [Mixbytes](https://mixbytes.io/) for the review of Governance v3 Tokens: $30'000

- Compensation to Emanuele Ricci ([@stermi](https://twitter.com/StErMi)) for the review done on Aave 3.1 Feature: $12'000

- Engagement with [Spearbit](https://spearbit.com/) for Aave v3 Ad-hoc Review: $109'200

- Compensation regarding past refills on Aave Robot: 1640 LINK, 4000 MATIC

## Specification

This proposal, will release the following, from the Aave Ethereum Collector to BGD Labs:

- Transfer 42'000 aUSDC v2 Ethereum to `0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF`.
- Transfer 109'200 aUSDT v2 Ethereum to `0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF`.
- Transfer 1640 aLINK v2 Ethereum to `0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF`.
- Transfer 4000 aMATIC v2 Polygon to `0xbCEB4f363f2666E2E8E430806F37e97C405c130b`.

_Note: The assets used for transfer has been recommended by the financial contributor to the DAO (TokenLogic & Karpatkey)_

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/be94106008b0e3e1f3fb9679dc7f589855d3cb60/src/20240411_Multi_SecurityBudgetRequestDec23AndRobotRefill/AaveV3Ethereum_SecurityBudgetRequestDec23AndRobotRefill_20240411.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/be94106008b0e3e1f3fb9679dc7f589855d3cb60/src/20240411_Multi_SecurityBudgetRequestDec23AndRobotRefill/AaveV3Polygon_SecurityBudgetRequestDec23AndRobotRefill_20240411.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/be94106008b0e3e1f3fb9679dc7f589855d3cb60/src/20240411_Multi_SecurityBudgetRequestDec23AndRobotRefill/AaveV3Ethereum_SecurityBudgetRequestDec23AndRobotRefill_20240411.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/be94106008b0e3e1f3fb9679dc7f589855d3cb60/src/20240411_Multi_SecurityBudgetRequestDec23AndRobotRefill/AaveV3Polygon_SecurityBudgetRequestDec23AndRobotRefill_20240411.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xf95bc210e3e93c2112c694cb158db22c93504155b48c03d9358e4c41c33ee782)
- [Discussion](https://governance.aave.com/t/arfc-bgd-security-budget-request-december-2023/15783)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
