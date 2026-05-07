---
title: "Orderly Transition and Offboarding Plan for Chaos Labs part2"
author: "ChaosLabs (implemented by Aavechan Initiative @aci via Skyward)"
discussions: "https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399"
---

## Simple Summary

This proposal sets out a structured transition plan for Chaos Labs’ departure from its current role, with the objective of minimizing disruption to the DAO and maintaining continuity across key risk-management functions during the offboarding period.

This AIP will cancel its outstanding stream and transfer the remaining stream funding corresponding to the 30-day transition period starting from the forum post date (April 8, 2026).

## Transition Timeline

The offboarding process will run for thirty days from the date of the forum post (April 8, 2026).

During the transition window, we will dedicate resources to completing outstanding analyses, finalizing any in-progress deliverables, preparing handoff materials, and supporting an orderly wind-down of responsibilities.

## Continuity of Risk Management

The DAO is in a position to transition the majority of ongoing risk-management responsibilities without significant delay. LlamaRisk already exists a secondary risk provider, and has [stated](https://governance.aave.com/t/llamarisk-ensuring-continuity-of-aaves-risk-management/24397) they are fully ready and prepared to take on all risk management functionality. With the key rotation finalized at their [request](https://governance.aave.com/t/llamarisk-ensuring-continuity-of-aaves-risk-management/24397#p-62730-scope-we-will-absorb-4), they’ll be able to update parameters manually via the risk steward.

In summary, the addresses associated with the current 2/2 multisig for manual Risk Steward purposes will be rotated from Chaos Labs and BGD to Aave Labs and LlamaRisk, as requested by both, to ensure operational continuity.

## Specification

This AIP will cancel the stream 100073 from the [Aave Prime collector](https://etherscan.io/address/0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c#writeProxyContract#F2)

## References

- Implementation: [AaveV3EthereumLido](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260507_AaveV3EthereumLido_OrderlyTransitionAndOffboardingPlanForChaosLabsPart2/AaveV3EthereumLido_OrderlyTransitionAndOffboardingPlanForChaosLabsPart2_20260507.sol)
- Tests: [AaveV3EthereumLido](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260507_AaveV3EthereumLido_OrderlyTransitionAndOffboardingPlanForChaosLabsPart2/AaveV3EthereumLido_OrderlyTransitionAndOffboardingPlanForChaosLabsPart2_20260507.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
