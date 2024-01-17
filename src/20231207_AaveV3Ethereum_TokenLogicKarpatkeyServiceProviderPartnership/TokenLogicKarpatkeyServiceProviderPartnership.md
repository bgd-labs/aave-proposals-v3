---
title: "TokenLogic & karpatkey Service Provider Partnership"
author: "TokenLogic & karpatkey"
discussions: "https://governance.aave.com/t/arfc-tokenlogic-karpatkey-service-provider-partnership/15755"
---

## Simple Summary

This AIP onboards TokenLogic & karpatkey to provide financial services to the Aave DAO for an initial period of 180 days, with a combined budget of 400k GHO.

# Motivation

## Overview

TokenLogic & karpatkey are responsible for delivering the following services to the Aave DAO:

- Treasury Management;
- Strategic Assets' Liquidity; and
- Safety Module.

This funding will be used to support the TokenLogic and karpatkey teams to deliver the scope as outlined in the [TEMP CHECK](https://governance.aave.com/t/temp-check-financial-services-proposal-karpatkey-tokenlogic/15633).

## What to Expect

This proposal outlines a collaborative framework between TokenLogic and karpatkey to manage the Aave DAO’s treasury. Both parties will work in unison to ensure any future proposals within the agreed scope are jointly developed and endorsed.

### Treasury Management

#### Develop the Architecture for Managing Aave's Assets

We aim to define a robust architecture for asset management. This architecture will enable non-custodial asset management, incorporating role-based access controls preapproved by the community that will enable treasury diversification and yield optimization. This system will ensure the Aave DAO retains full control over fund retrieval and permission management, facilitated through Aave’s “shortExecutor”. Overtime this will lead to fund management delegation and reduced governance overhead.

As the architecture for treasury management is being developed, the TokenLogic and karpatkey partnership will diligently progress with the necessary treasury operations, aligning them with the needs of the DAO and the stipulations of this proposal. All activities will be conducted in accordance with the established AIP model to avoid any disruptions.

#### Financial Security

A key objective is to secure sufficient funds to ensure a one-year runway, aligning with the DAO’s known budget and anticipated expenses.

This approach guarantees financial stability and an operational continuity for Aave DAO. Key components of this objective will include:

- Bridging Aave funds between networks;
- Migrating funds from Aave v2 to Aave v3; and
- Swap asset to align expenses and holdings.

Do note, financial statements have been omitted in order to present a cost conscious, high-impact solution within the current budget. If the Aave DAO wishes to explore having financial statements as part of a broader proposal, we can later expand the funding to include the additional scope.

### Strategic Assets' Liquidity

TokenLogic and karpatkey will lead the Aave Liquidity Committee (ALC) and oversee he management of liquidity incentives and Aave-owned liquidity in alignment with Aave’s strategic asset goals. One of the main focus areas will be supporting GHO’s token price recovery. Key initiatives include:

- Foster concentrated liquidity profiles that support GHO’s price movement towards re-pegging, while maintaining its utility across a full range AMMs.
  - Utilize Maverick’s design to automate liquidity concentration as prices evolve, while reducing the friction caused by liquidity fragmentation in concentrated boosted pools.
  - Optimize incentives on Uniswap v3 for concentrated liquidity, tailored across three categories: fees, GHO, and other USD token liquidity. Prioritize USD liquidity, particularly when GHO is off-peg.
  - Continuously review and adjust incentives on platforms that yield the best results.
  - Initial focus is on skewed liquidity distribution to support regaining the peg. However, it is paramount to ensure existing liquidity providers find sufficient utility on their GHO funds (through sustainable strategies that make use of Aave’s AURA holding) to mitigate selling pressure.
- Post-Repeg Strategy for GHO, explore sustainable approaches that preserve the token’s value and expand its functional role within the ecosystem:
  - Implement optimized liquidity strategies through Maverick and Merkl to achieve balanced liquidity and deeper market depth.
  - Enhance GHO’s extrinsic demand by incentivizing stableswap pools, such as Balancer’s GHO pools, leveraging Aave’s capacity for a significant TVL increase.
  - Work with Gyroscope to deploy liquidity pools that align with Balancer’s architecture, using their advanced bonding curve model for concentrated liquidity AMMs. This strategic integration will use Aave-owned AURA to enhance GHO’s price stability.
  - Deploy and incentivize markets beyond USD-pegged assets, including ETH, ETH LSTs, EUR, and Real World Assets (RWAs). This diversification will open up new investment avenues and attract liquidity providers with varying risk appetites.
  - Collaborate closely with Aave and specialized risk service providers to support the deployment and configuration of the GHO Stability Module (GSM). This coordination will focus on fine-tuning critical parameters, taking into account prevailing market conditions. Our objective is to integrate the GSM with managed capacity, potentially even before GHO achieves full re-pegging, as a strategic mechanism to foster price stability.
- To optimize the utilization of surplus votes resulting from incentivized liquidity, we propose to leverage excess voting power effectively, transforming it into tangible rewards through participation in voting markets such as Curve, Convex, Balancer, and Aura.

For operational simplicity and alignment with the DAO’s strategic objectives, evolving the GHO Liquidity Committee into the Aave Liquidity Committee is a logical step.

### Saftety Module

As part of the scope, karpatkey and TokenLogic will focus on modeling the SM performance during shortfall events and present proposals to diversify asset categories. This proposal will feature how the DAO can utilize the vlAURA position, realize synergies between GHO Liquidity and overall attempt to reduce the DAOs insurance fund spend.

The below outlines at a high level what we intend to deliver:

- Introduce additional asset categories to promote diversification and reduce the dependence on AAVE as a backstop for the protocol.
  - Initial parameter configuration will incorporate feedback from Chaos Labs & Gauntlet.
  - We will explore the feasibility of including GHO LP assets and harness rewards from other protocols.
  - Technical lift associated with creating new categories will be performed by BGD Labs, with a security audit, if required.
- 90-day emission forecast will be provided ahead of each emission cycle for community feedback. TokenLogic and karpatkey will prepare the payload to extend the SM emissions for @bgdlabs for review.
  - Iterative emission cycles enable the DAO to target specific asset categories and improve the correlations between bad debt potential whilst maintaining a base level of insurance. The proposal will feature the ability to reward some categories with non AAVE rewards, like GHO, to support adoption and velocity.
- Capital efficiency, optimize emission schedules to balance attracting and retaining new deposits for each respective category. For example the APR on stkAAVE is expected to continue being reduced given the recent GHO Mint Discount utility being added and the introduction of new categories.
- Analytics, a dashboard will be created/maintained that tracks the effective coverage of the insurance fund under various market conditions. The deposit value, composition of assets, APR over time and impact on the DAOs runway will all be readily available for the community to view. This is expected to create transparency and provide insight into the performance of the SM as an effective insurance fund for the DAO.

# Specification

The AIP will call the createStream() method of the IAaveEcosystemReserveController interface to create two 180-day streams for 220k and 180k of GHO.

The following address will be the recipient of the 220k GHO stream:
Address: `0x58e6c7ab55aa9012eacca16d1ed4c15795669e1c`

The following address will be the recipient of the 180k GHO stream:
Address: `0x3e4A9f478C0c13A15137Fc81e9d8269F127b4B40`

TokenLogic and karpatkey are to be included in the Gas Rebate program that reimburses on-chain voting, calling revenue contracts, deployment and testings costs.

TokenLogic and karpatkey will jointly lead the GLC for the duration of the service provider contract.

Upon execution of this AIP, TokenLogic's Orbit program GHO stream (StreamID 100017) will be cancelled.

# Disclaimer

TokenLogic and karpatkey receive no compensation beyond Aave protocol for the creation of this proposal. TokenLogic and karpatkey are both delegates within the Aave ecosystem.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f50d80c1f5be6e2823ea4b6ffbf292af72268feb/src/20231207_AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnership/AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnership_20231207.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f50d80c1f5be6e2823ea4b6ffbf292af72268feb/src/20231207_AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnership/AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnership_20231207.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x6e57ed54cf803652ab4839ff7b7f7de08ba086fbe99163547c6188a3ee55e209)
- [Discussion](https://governance.aave.com/t/temp-check-financial-services-proposal-karpatkey-tokenlogic/15633)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
