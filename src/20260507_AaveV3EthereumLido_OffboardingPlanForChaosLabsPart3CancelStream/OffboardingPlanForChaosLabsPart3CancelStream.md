---
title: "Offboarding Plan for Chaos Labs part 3: Cancel stream 100073"
author: "ChaosLabs (performed by Skyward)"
discussions: "https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399"
---

## Simple Summary

Follow-up payload to the orderly offboarding of Chaos Labs. This AIP cancels the outstanding payment stream `100073` on the Aave Prime collector. No other state is modified.

## Context

The original offboarding payload (AIP-479) was unable to execute its mainnet portion in full, leaving stream `100073` active beyond the agreed offboarding window. Concurrently, the receiving address is no longer considered under Chaos Labs' operational control, and at Chaos Labs' request the offboarding is being completed via a direct stream cancellation rather than a continued transfer.

This AIP performs that single action so the offboarding can be closed out cleanly.

## Specification

Cancel stream `100073` on the [Aave Prime collector](https://etherscan.io/address/0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c#writeProxyContract#F2) by calling `cancelStream(100073)`.

## References

- Implementation: [AaveV3EthereumLido](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260507_AaveV3EthereumLido_OffboardingPlanForChaosLabsPart3CancelStream/AaveV3EthereumLido_OffboardingPlanForChaosLabsPart3CancelStream_20260513.sol)
- Tests: [AaveV3EthereumLido](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260507_AaveV3EthereumLido_OffboardingPlanForChaosLabsPart3CancelStream/AaveV3EthereumLido_OffboardingPlanForChaosLabsPart3CancelStream_20260513.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
