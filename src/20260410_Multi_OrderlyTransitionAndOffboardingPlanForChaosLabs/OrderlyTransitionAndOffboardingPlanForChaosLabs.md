---
title: "Orderly Transition and Offboarding Plan for Chaos Labs"
author: "ChaosLabs (implemented by Aavechan Initiative @aci via Skyward)"
discussions: "https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399"
snapshot: direct-to-AIP
---

## Summary

This proposal sets out a structured transition plan for Chaos Labs’ departure from its current role, with the objective of minimizing disruption to the DAO and maintaining continuity across key risk-management functions during the offboarding period.

In contrast to recent service provider departures, Aave has a secondary risk provider, which helps minimize the transition period and ensure a smooth continuation of operations.

As such, our intent is to complete this transition within 30 days. During that period, we will continue supporting the DAO in a clearly defined capacity, complete the handoff of ongoing responsibilities, and ensure that remaining operational dependencies are addressed in an orderly manner.

As part of this transition, Chaos Labs will cancel its outstanding stream and transfer the remaining stream funding corresponding to the 30-day transition period starting from the forum post date (April 8, 2026).

## Transition Timeline

The offboarding process will run for thirty days from the date of the forum post (April 8, 2026).

During the transition window, we will dedicate resources to completing outstanding analyses, finalizing any in-progress deliverables, preparing handoff materials, and supporting an orderly wind-down of responsibilities. Plasma PT oracles will be turned off on June 18th.

## Continuity of Risk Management

The DAO is in a position to transition the majority of ongoing risk-management responsibilities without significant delay. LlamaRisk already exists as a secondary risk provider, and has [stated](https://governance.aave.com/t/llamarisk-ensuring-continuity-of-aaves-risk-management/24397) they are fully ready and prepared to take on all risk management functionality. With the key rotation finalized at their [request](https://governance.aave.com/t/llamarisk-ensuring-continuity-of-aaves-risk-management/24397#p-62730-scope-we-will-absorb-4), they’ll be able to update parameters manually via the risk steward.

In summary, the addresses associated with the current 2/2 multisig for manual Risk Steward purposes do not change, the signers will be rotated from Chaos Labs and BGD to Aave Labs and LlamaRisk, as requested by both, to ensure operational continuity.

## Risk Oracle Transition

Aave risk parameter changes will be fully operational via the Aave Risk Steward framework, mentioned above.

As such, Risk Oracles for Supply Caps, Borrow Caps, Interest Rates, and PT price oracles will be turned off during the transition.

Parameter management for existing PT assets will be executed through LlamaRisk’s manual risk steward framework, similar to other parameters.

## Financial and Administrative Changes

Chaos Labs will immediately cancel its outstanding stream 100073. Stream 100015 is already being canceled due to a stream misconfiguration. We will refund the portion of AAVE tokens corresponding to the remaining stream duration.

In connection with this transition, the remaining portion of the 30-day stream period (calculated from the forum post date of April 8, 2026) will be transferred to Chaos Labs as the final compensation associated with the support and wind-down period described in this proposal. This is intended to align compensation with the defined transition window while avoiding a prolonged or ambiguous tail period.

## Conclusion

- support continues for one month in a transition capacity;
- all remaining outstanding work will then be brought to completion before departure;
- Supply Cap, Borrow Cap, Interest Rate Risk Oracles, and PT Risk Oracles for existing PTs will be shut down immediately;
- the outstanding stream will be canceled immediately;
- the remaining portion of the 30-day transition period, calculated from April 8, 2026 until May 8, 2026, will serve as the final transition-period compensation.

We believe this framework gives the DAO sufficient continuity, predictability, and time to transfer responsibilities in an orderly manner.

## Specification

### Oracle deactivation and RISK_ADMIN revocation

This AIP will disable all the agents operating on the following V3 instances and revoke their RISK_ADMIN role from the respective ACL Manager(s):

- Arbitrum
- Avalanche
- Base
- BNB
- Ethereum (Core and Lido)
- Gnosis
- Linea
- Optimism
- Polygon

### Chainlink Automation robots cancellation

The Chainlink Automation upkeeps registered under the AgentHub automation contract will be cancelled on each chain where agents are deployed. Once cancelled, the freed LINK balance can be withdrawn permissionlessly to the Aave Collector after the registry's cancellation delay (~50 blocks).

### Stream cancellation and bulk payment

The stream 100073 will be canceled (if not already done) and an amount equivalent to the remaining transition period (from proposal execution to April 8 + 30 days) will be transferred from the collector to the following Chaos Labs operated wallet: [0xbC540e0729B732fb14afA240aA5A047aE9ba7dF0](https://etherscan.io/address/0xbC540e0729B732fb14afA240aA5A047aE9ba7dF0)

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260410_Multi_OrderlyTransitionAndOffboardingPlanForChaosLabs/AaveV3Ethereum_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410.sol), [AaveV3Polygon](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260410_Multi_OrderlyTransitionAndOffboardingPlanForChaosLabs/AaveV3Polygon_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410.sol), [AaveV3Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260410_Multi_OrderlyTransitionAndOffboardingPlanForChaosLabs/AaveV3Avalanche_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410.sol), [AaveV3Optimism](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260410_Multi_OrderlyTransitionAndOffboardingPlanForChaosLabs/AaveV3Optimism_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410.sol), [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260410_Multi_OrderlyTransitionAndOffboardingPlanForChaosLabs/AaveV3Arbitrum_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260410_Multi_OrderlyTransitionAndOffboardingPlanForChaosLabs/AaveV3Base_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410.sol), [AaveV3Gnosis](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260410_Multi_OrderlyTransitionAndOffboardingPlanForChaosLabs/AaveV3Gnosis_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410.sol), [AaveV3BNB](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260410_Multi_OrderlyTransitionAndOffboardingPlanForChaosLabs/AaveV3BNB_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410.sol), [AaveV3Linea](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260410_Multi_OrderlyTransitionAndOffboardingPlanForChaosLabs/AaveV3Linea_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260410_Multi_OrderlyTransitionAndOffboardingPlanForChaosLabs/AaveV3Ethereum_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410.t.sol), [AaveV3Polygon](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260410_Multi_OrderlyTransitionAndOffboardingPlanForChaosLabs/AaveV3Polygon_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410.t.sol), [AaveV3Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260410_Multi_OrderlyTransitionAndOffboardingPlanForChaosLabs/AaveV3Avalanche_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410.t.sol), [AaveV3Optimism](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260410_Multi_OrderlyTransitionAndOffboardingPlanForChaosLabs/AaveV3Optimism_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410.t.sol), [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260410_Multi_OrderlyTransitionAndOffboardingPlanForChaosLabs/AaveV3Arbitrum_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410.t.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260410_Multi_OrderlyTransitionAndOffboardingPlanForChaosLabs/AaveV3Base_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410.t.sol), [AaveV3Gnosis](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260410_Multi_OrderlyTransitionAndOffboardingPlanForChaosLabs/AaveV3Gnosis_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410.t.sol), [AaveV3BNB](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260410_Multi_OrderlyTransitionAndOffboardingPlanForChaosLabs/AaveV3BNB_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410.t.sol), [AaveV3Linea](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260410_Multi_OrderlyTransitionAndOffboardingPlanForChaosLabs/AaveV3Linea_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410.t.sol)
- Snapshot: direct-to-AIP
- [Discussion](https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
