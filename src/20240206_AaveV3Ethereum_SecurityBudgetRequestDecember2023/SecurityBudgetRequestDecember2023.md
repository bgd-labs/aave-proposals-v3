---
title: "Security Budget Request December 2023"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-bgd-security-budget-request-december-2023/15783"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xf95bc210e3e93c2112c694cb158db22c93504155b48c03d9358e4c41c33ee782"
---

## Simple Summary

Proposal to release a total of $151’200 to reimburse BGD Labs for the costs paid towards external security reviews.

## Motivation

Part of our [scope Aave <> BGD Phase II](https://governance.aave.com/t/aave-bored-ghosts-developing-phase-2/14484#scope-6) is the planning, engagement, and coordination with security partners of the DAO.
During the previous year and a half, Aave was in a pretty intensive delivery phase (Aave v3 improvements, GHO, Aave Governance v3, a.DI), and we thought it was appropriate to have continuous engagement with 2 security firms like Certora and SigmaPrime.
Even if this worked well, we think that there is room for optimization, and it is a good idea to do more ad-hoc requests for the security budget.

Considering this, the following security researchers have been paid by BGD Labs for the reviews, for which we request the reimbursement:

- Compensation to [Mixbytes](https://mixbytes.io/) for the review of Governance v3 Tokens: $30'000

- Compensation to Emanuele Ricci ([@stermi](https://twitter.com/StErMi)) for the review done on Aave 3.1 Feature: $12'000

- Engagement with [Spearbit](https://spearbit.com/) for Aave v3 Ad-hoc Review: $109'200

## Specification

This proposal, will release a total of $151’200, from the Aave Ethereum Collector to BGD Labs:

- Transfer 42'000 aUSDC v2 Ethereum to `0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF`.
- Transfer 109'200 aUSDT v2 Ethereum to `0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF`.

_Note: The assets used for transfer has been recommended by the financial contributor to the DAO (TokenLogic & Karpatkey)_

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240206_AaveV3Ethereum_SecurityBudgetRequestDecember2023/AaveV3Ethereum_SecurityBudgetRequestDecember2023_20240206.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240206_AaveV3Ethereum_SecurityBudgetRequestDecember2023/AaveV3Ethereum_SecurityBudgetRequestDecember2023_20240206.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xf95bc210e3e93c2112c694cb158db22c93504155b48c03d9358e4c41c33ee782)
- [Discussion](https://governance.aave.com/t/arfc-bgd-security-budget-request-december-2023/15783)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
