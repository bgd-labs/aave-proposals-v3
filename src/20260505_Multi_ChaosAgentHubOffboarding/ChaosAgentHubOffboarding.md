---
title: ""
author: "Aave Labs"
discussions: "https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399"
---

## Summary

This proposal submits a follow-up payload to complete the AgentHub offboarding actions associated with AIP-479.

The payload removes the remaining Agent permissions on Ethereum mainnet and removes the corresponding AgentHub permissions on Plasma. No new permissions are granted and no market configuration is changed.

## Motivation

AIP-479 was intended to continue the Chaos offboarding process by canceling the relevant AgentHub automation and removing the permissions held by the related Agents.

After AIP-479 was prepared, emergency actions canceled the relevant Robots on Ethereum mainnet before the payload executed. Those actions changed the live contract state but did not remove the associated Agent permissions.

Because the Robots were already canceled, the pending AIP-479 payload may fail before completing the remaining permission cleanup. The DAO still needs the Ethereum Agent permissions removed to reach the intended offboarding state.

This proposal resolves that execution mismatch with a subsequent payload scoped to the remaining cleanup.

It also completes the corresponding Plasma Agent permission removal. Plasma was originally expected to remain active longer, but both LlamaRisk and Plasma have indicated support for removing these permissions early.

This AIP does not introduce a new automation scope, parameter authority, or discretionary role. It completes the offboarding state intended by AIP-479 under current live state.

## Specification

This proposal executes a follow-up payload to complete the AgentHub offboarding actions intended by AIP-479.

The payload will:

- On Ethereum mainnet, remove the remaining Agent permissions that were not removed after the related Robots were canceled through emergency action & cancel stream `100073` (if not already canceled before execution of this payload).
- On Plasma, remove the Agent permissions.

## References

- Original AIP: [Orderly Transition and Offboarding Plan for Chaos Labs](https://app.aave.com/governance/v3/proposal/?proposalId=479)
- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/848c60d3a204b6b1ee46e97866058db3892ab79f/src/20260505_Multi_ChaosAgentHubOffboarding/AaveV3Ethereum_ChaosAgentHubOffboarding_20260505.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/848c60d3a204b6b1ee46e97866058db3892ab79f/src/20260505_Multi_ChaosAgentHubOffboarding/AaveV3Plasma_ChaosAgentHubOffboarding_20260505.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/848c60d3a204b6b1ee46e97866058db3892ab79f/src/20260505_Multi_ChaosAgentHubOffboarding/AaveV3Ethereum_ChaosAgentHubOffboarding_20260505.t.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/848c60d3a204b6b1ee46e97866058db3892ab79f/src/20260505_Multi_ChaosAgentHubOffboarding/AaveV3Plasma_ChaosAgentHubOffboarding_20260505.t.sol)

## Copyright

Copyright and related rights waived via CC0.
