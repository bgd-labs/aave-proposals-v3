---
title: "sGho Launch"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-sgho-launch-configuration/24346"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xb9e9b01efcf6151bade78546d0f51f11d7961939b649fb7717e82ea3d43d4f47"
---

## Simple Summary

This publication provides an overview of the new native on-chain yield-accruing sGHO savings product upgrade. Within, we define the initial parameter configuration, present the migration process from the current sGHO (stkGHO rebranded), and introduce the new sGHO admin steward role.

The proposal sets a fixed Aave Savings Rate (ASR) of `4.25% APR` (50 basis points above the Sky Savings Rate), refines the boost program from 8 boosts to 1 transitional boost, establishes the sGHO Steward as the rate governance mechanism, and defines an aggressive migration schedule from the legacy sGHO contract.

## Motivation

GHO has reached an all-time high circulating supply of 404.7M across eight chains, with sGHO deposits totalling 304.6M. This growth, driven primarily by the @ACI powered savings product, validates the demand for a yield-bearing GHO instrument. The Aave Team has done a tremendous job managing the Merit-based reward system that fuelled this trajectory.

However, the current sGHO implementation presents structural limitations that constrain further growth:

Composability unlock. The current Merit-based distribution, while highly effective for bootstrapping, relies on an off-chain reward model, making it difficult for external protocols to integrate natively. Moving to ERC-4626 means yield accrues directly in the share-to-asset conversion rate, making sGHO instantly composable across DeFi lending protocols, yield aggregators, and centralised exchanges.

Streamlined yield story. The eight-boost system ACI designed was instrumental in driving targeted behaviours during the growth phase. With sGHO now at scale, consolidating seven of those boosts into the native rate creates a simpler, more legible value proposition for the next wave of integrators and depositors, while retaining one strategic boost to continue rewarding core Aave ecosystem alignment.

Frictionless onboarding. The introduction of the GhoRouter contract eliminates multi-step conversion friction. Users can go from USDC to sGHO in a single transaction, dramatically lowering the barrier to entry for new depositors and enabling seamless integration paths for partners.

Market opportunity. With the Sky Savings Rate at 3.75% APR and broader DeFi yields compressed, a competitive fixed rate positions sGHO to absorb significant stablecoin demand. At the current sGHO deposit base of ~305M, incoming large allocations would compress the Merit-based yield from ~4.68% to approximately 3.70% at a deposit base of 385 M. Setting the native rate at 4.25% APR provides a clear premium over the competing sUSDS product while remaining sustainable within the DAO’s revenue framework and other yield products in this rate environment.

## Specification

| Parameter                    | Value                                             |
| ---------------------------- | ------------------------------------------------- |
| Target Rate (ASR)            | 4.25% APR (425 basis points)                      |
| Rate Type                    | Fixed                                             |
| Sky Savings Rate (reference) | 3.75% APR                                         |
| Premium over SSR             | 50 basis points                                   |
| Steward Formula              | amplification = 0, floatRate = 0, fixedRate = 425 |
| Maximum Rate (contract cap)  | 50% APR (5,000 bps)                               |
| Supply Cap                   | 400,000,000                                       |
| Pause Guardian               | 0x2CFe3ec4d5a6811f4B8067F0DE7e47DfA938Aa30        |

Create a 10M Allowance of GHO from the Collector to the AFC SAFE in order to handle rewards distribution.

Grant the sGho PAUSE_GUARDIAN_ROLE to the PROTOCOL_GUARDIAN SAFE.
Grant the sGho YIELD_MANAGER_ROLE to the sGhoSteward contract.

Grant the sGhoSteward FIXED_RATE_MANAGER_ROLE to the Governance LVL 1 Executor.
Grant the sGhoSteward SUPPLY_CAP_MANAGER_ROLE to the Governance LVL 1 Executor.
Grant the sGho TOKEN_RESCUER_ROLE to the Governance LVL 1 Executor.

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/6c017b9eadccd099dfe4d9d8491833cb69305de9/src/20260427_AaveV3Ethereum_SGhoLaunch/AaveV3Ethereum_SGhoLaunch_20260427.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/6c017b9eadccd099dfe4d9d8491833cb69305de9/src/20260427_AaveV3Ethereum_SGhoLaunch/AaveV3Ethereum_SGhoLaunch_20260427.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xb9e9b01efcf6151bade78546d0f51f11d7961939b649fb7717e82ea3d43d4f47)
- [Discussion](https://governance.aave.com/t/arfc-sgho-launch-configuration/24346)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
