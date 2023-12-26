---
title: "Security Budget Dec 2023"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-bgd-security-budget-request-december-2023/15783"
---

## Simple Summary

Request for a security budget of $151’200: $42'000 to compensate BGD for already-completed reviews by Mixbytes and Emanuele Ricci (StErMi), and $109'200 to pay for a Spearbit security procedure.

## Motivation

Currently, the Aave ecosystem has a continuous engagement for security services with Certora, but in addition, ad-hoc extra security reviews of the system are necessary.

Part of the service provider engagement of BGD with Aave is to evaluate security needs, and organise/coordinate the different procedures with external third-parties. This requires requests for budget, for the Aave DAO (counterparty of the services) to compensate the security firms.

This one is the first of said budget requests.

## Specification

The budget request in this case cover 3 security needs:

**Compensation for Mixbytes review of Governance v3 tokens**

During the activation of Aave Governance v3 on October 17th 1, we detected a problem with the voting assets, which required the cancellation of the proposal, the development of a fix, and re-apply security procedures.

Given that it was already audited code, we also decided to do an extra security review by another security firm, Mixbytes.

For the sake of speed and reducing bureaucratic blockers, BGD paid for the cost of said security review of $30’000, and now we will include on this proposal a refund request for that amount.

**Compensation for security review on a feature of Aave 3.1**

Also part of our Phase 2 scope is to do a series of improvements to Aave v3, in order to reach a 3.1 version, from the current 3.0.2.

Generally, we are confident with Certora reviewing all the planned items until now, but there is one exception (an specific feature) to which we thought an extra review was required, and we engaged Emanuele Ricci (@StErMi), a top-level security researcher with knowledge of Aave to do it.
We will be publishing soon everything to be included into v3.1.

Same as with Mixbytes, BGD has paid the cost of said security review of $12’000, and now we include the refund request on this proposal.

**Engagement with Spearbit for Aave v3 ad-hoc review**

Aave v2/v3 is a production system with billions of dollars in size, and one of the most evaluated protocols security-wise.
However, security is a continuous process, and always worth it to improve whenever it feels necessary.

During the last 1-2 months, we have noticed different security exploits in the space following similar patterns. None of them affected Aave, but apart from our continuous analysis of the system security-wise, we think it is necessary to do an extra round of review in critical parts of Aave, for additional assurance.

We have coordinated an engagement for this review scope with Spearbit, one of the leading security firms in the space, that will involve 3 of their top researchers checking in-depth different components that we identify as critical on Aave.

This engagement is scheduled to start in the second part of December, and different from the others, the payment requested in the proposal will be direct to Spearbit, for an amount of $109’200.

---

From a technical perspective, the proposal payload does the following:

1. Transfer 42'000 aDAI v3 Ethereum to BGD from the Aave Ethereum Collector, as compensation for the $30'000 + $12'000 already paid by BGD to the security firms.
2. Transfer 109'200 USDC to Spearbit, redeeming aUSDC v3 Ethereum from the Aave Ethereum Collector too.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231218_AaveV3Ethereum_SecurityBudgetDec2023/AaveV3Ethereum_SecurityBudgetDec2023_20231218.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231218_AaveV3Ethereum_SecurityBudgetDec2023/AaveV3Ethereum_SecurityBudgetDec2023_20231218.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xf95bc210e3e93c2112c694cb158db22c93504155b48c03d9358e4c41c33ee782)
- [Discussion](https://governance.aave.com/t/arfc-bgd-security-budget-request-december-2023/15783)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
