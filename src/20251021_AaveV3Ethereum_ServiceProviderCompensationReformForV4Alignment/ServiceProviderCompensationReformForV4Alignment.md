---
title: "Service Provider Compensation Reform for V4 Alignment"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/arfc-service-provider-compensation-reform-for-v4-alignment/23246"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xdf44cfaac72f0413d639d017c299a6491ba74a55fffcfdf74debfba51932891b"
---

## Simple Summary

This AIP proposes a comprehensive reset of all active Aave service provider compensation streams to better align contributors with the success of the Aave ecosystem ahead of the Aave V4 launch.

The proposal maintains the same total annual compensation levels for each provider while introducing a one-year vesting component tied to clear key performance indicators (KPIs).

## Motivation

As stated in the [_State of the Union_](https://governance.aave.com/t/aave-dao-s-state-of-the-union-by-aci/23124) post, Aave DAO should seek to ensure that the service providers who contributed significantly to Aave’s success are directly aligned with the protocol’s growth and long-term sustainability.

The goal of this reform is to reset and unify the compensation framework for all key service providers, ensuring alignment with Aave V4 delivery milestones and improving transparency around deliverables.

Key motivations:

1. **Alignment with AAVE performance** – linking compensation to measurable outcomes.
2. **Preparation for V4** – establishing a synchronized, goal-driven working structure across contributors.
3. **Simplicity and fairness** – resetting all streams equally for a one-year term.
4. **Long-term alignment** – variable revenue sharing proposed in the State of the Union will be postponed to V4 rollout and finalized thereafter.

Note: While aligned and considered a key service provider of the Aave DAO, BGD Labs has preferred to opted out of the compensation reform and crafted its own proposals. The ACI respects their decision and will support their standalone proposal.

## Specification

The following structure will apply to all primary Aave service providers:

| Provider   | Annual Stream (Reset)   | Immediate Grant       |
| ---------- | ----------------------- | --------------------- |
| ACI        | Same as previous stream | $250K AAVE (30d TWAP) |
| TokenLogic | 2.5M GHO                | $250K AAVE (30d TWAP) |
| LlamaRisk  | Same as previous stream | $250K AAVE (30d TWAP) |
| Chaos Labs | Same as previous stream | $250K AAVE (30d TWAP) |

For service providers allowed to have concurrent streams (Chaos Labs & TokenLogic), the oldest stream will not be reset.

The TWAP price used for AAVE is 263.15$

The vesting mentioned in the original discussion will be handled separately by the AFC

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251021_AaveV3Ethereum_ServiceProviderCompensationReformForV4Alignment/AaveV3Ethereum_ServiceProviderCompensationReformForV4Alignment_20251021.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251021_AaveV3Ethereum_ServiceProviderCompensationReformForV4Alignment/AaveV3Ethereum_ServiceProviderCompensationReformForV4Alignment_20251021.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xdf44cfaac72f0413d639d017c299a6491ba74a55fffcfdf74debfba51932891b)
- [Discussion](https://governance.aave.com/t/arfc-service-provider-compensation-reform-for-v4-alignment/23246)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
