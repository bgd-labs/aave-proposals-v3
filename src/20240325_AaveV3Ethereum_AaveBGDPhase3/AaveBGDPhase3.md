---
title: "Aave BGD Phase 3"
author: "BGD Labs"
discussions: "https://governance.aave.com/t/aave-bored-ghosts-developing-phase-3/16893"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xf453667458e093dcd5bd986e0a62b4ef9dc914dca56ef97a8dc28ca89af6c8d3"
---

## Simple Summary

Engagement for technical services of BGD Labs with the Aave DAO, covering 2 separate scopes.

## Motivation

After successful collaboration with the Aave DAO on the previous BGD Labs <> Aave Phase 1 and BGD Labs <> Aave Phase 2 engagement for services, we propose a pair of new scopes.

## Specification

This proposal includes 2 scopes:

<br>

### SCOPE 1. Aave technical maintenance, improvements, security coordination and tech advisory to the DAO

This scope is the continuist component historically performed by BGD for the DAO, and will be composed of the following items:

- Maintain, improve and consolidate all the Aave tooling introduced in Phases I & II, including but not limited to Aave Address Book, Aave Helpers, Aave Proposals, Risk Stewards, Seatbelt and Killswitch.
- Maintain and improve Aave Governance v3, a.DI and Aave Robot, together with the tooling surrounding them.
  The following new items will be delivered, consequence of the research done on Phase 2:
  - Extend coverage of voting networks to rollups, apart from the current Polygon PoS and Avalanche C-Chain.
  - Allow voting with AAVE tokens held in non-Ethereum networks.
  - Granular and generalised consensus rules for a.DI, together with different planned optimisations.
- Propose further improvements on top of the upcoming Aave 3.1.
- Different v3 maintenance tasks with important development requirements, including:
  - Improve asset off-boarding procedures.
  - Complete removal of stable debt logic.
- Act as reviewers of Aave <> Immunefi for all current Aave ecosystem, not including GHO (Avara currently being the reviewer). Additionally, doing proper maintenance of the bug bounty program.
- Act as security coordinator of the Aave ecosystem, including:
  - Continuously evaluate potential technical risks for Aave.
  - Design specific protection strategies in the event of any vulnerability affecting Aave.
  - If arising, create governance proposals to mitigate any type of problem affecting Aave.
  - Coordinate with the Aave Guardian for protective emergency actions.
- Support with further technical off-boarding strategies for legacy versions of Aave (v1, v2) in a safe manner, both for the DAO and the users of the protocol.
- Advise other contributors on which security procedures to apply for their developments, when required.
- Evaluate new upcoming high-level technical implications/risks for the protocol, for example, new types of assets being listed.
- Generally advise other contributors, whenever feedback from an entity expert on the Aave protocol is required. This includes but is not limited to contributors on the risk, treasury, security reviews and miscellaneous fields.
- Review governance proposals on pre-onchain stage, not as a full security audit, but in order to verify that we don’t see any integration problem with Aave’s smart contracts and good practises.

<br>

**What is NOT part of the scope**

- We are a technical provider of the community, we don’t do any type of business development and/or growth, that should be responsibility of other parties.
- We don’t do security reviews on major developments of other contributors. We offer our security advisory for minor projects solely benefiting the Aave DAO, but on bigger scopes (e.g. something like GHO), that is up to parties engaged specifically on security, like Certora.
- We will provide feedback on design of projects that we don’t lead only whenever the project is 1. of technical nature and 2. the final design is flagged as “ready” by the contributor.
  Given our expertise, we have pretty strong stand in architecture and design decisions, which can create conflicts if no framework is defined.
- We only work on projects with TEMP CHECK Snapshot passed (e.g. reviews). With the activity on the DAO increasing day by day, unless a filtering of projects is applied, it is not really manageable for us to support any project in pre-TEMP CHECK stage, unless we identified a clear need from our side.
- We are not running services on behalf of the DAO, we design them to be ran in a decentralised manner, or by parties with the proper role to do so.
  Any tool we decide to run on our infrastructure (e.g. hosting of one instance of the Aave Governance v3 interface) is our own decision, outside of the scope of engagement.

<br>

---

_Scope 1. Aave technical maintenance, improvements, security coordination and tech advisory to the DAO_

**DURATION**: same as with Phase 2, 6 months, starting from proposal execution.

**BUDGET**: as some items are not included in the scope (more later), the budget has been reduced from Phase 2. 1’600’000 in stablecoins and 5’000 AAVE, 60% paid up-front and 40% streamed during the 6 months engagement.

---

<br>

### SCOPE 2. Aave Safety Module - Code A

As commented before, we believe now the Aave DAO is in a really solid stage of their current systems, quite future-proof and ready to scale:

- Aave v3 is a solid liquidity layer, on which is possible to iterate and improve.
- Aave Governance v3 is probably the most advanced on-chain governance system in production.
- a.DI is a totally generic bridging layer, that can be used for any cross-chain communication need on the Aave ecosystem, in a secure and scalable manner.
- Aave Robot is a solid automation layer, integrated with Chainlink Automation, but flexible enough for any technology.

More in the line of innovative projects like Aave Governance v3, we propose to create a completely new system in an Aave component which requires improvement: the Aave Safety Module.

<br>

**Aave Safety Module: Code A**

Safety Module Code A is the major project on the innovation side of this scope, but different to previous cases, our proposed approach is different: at the moment, we will not disclose a detailed description of it, as we think this is the right strategic approach for the DAO.

However, we can say the following about Code A:

- It will change completely the dynamics of the Safety Module and its components, including stkGHO, stkAAVE and stkABPT.
- More efficient mechanism than the current.
- Improved use experience.
- Heavily improved dynamics for builders to build on top, but still batteries included.
- Affecting importantly AAVE tokenomics.
- Holistically designed, taking into account Aave v3 and GHO.
- Directly/indirectly benefiting any future project of the DAO.

We are aware this requires some trust by the community on our research and execution capabilities (which is reflected on the payment schedule), but considering that the main beneficiary will be explicitly the DAO and our history of services, we think it is acceptable.

<br>
<br>

---

_Scope 2. Safety Module Code A_

**DURATION**: this scope is not continuous like Scope 1, but our estimation is similar for full completion, approximately during the next 6 months to have everything fully ready and in production.
However, delivery and communications will definitely be iterative, with extensive details of Project A to be disclosed in the first 2 months, and highly probably some of its components.

**BUDGET**: 1’900’000 in stablecoins and 7’500 AAVE, with the following schedule:

- 40% upfront.
- 60% in a delayed payment in 4-months from now, when we estimate to be in good stage of completion.

---

<br>

### Technical specification

The proposal payload sets up the payment schedule for the 2 scopes, interacting with the Aave Ethereum Collector for the stablecoins components and the AAVE Ecosystem Collector for the AAVE ones:

- Transfer of 960'000 aUSDT v2 Ethereum; 60% upfront part of the 1'600'000 total stablecoins component in Scope 1.
- Transfer of 760'000 aUSDC v3 Ethereum; 40% upfront part of the 1'900'000 total stablecoins component in Scope 2.
- Transfer of 6'000 AAVE; 3'000 as 60% of the 5'000 total AAVE component in Scope 1, and 3'000 as 40% of the 7'500 total AAVE component in Scope 2.
- Creation of a 640'000 GHO stream for 6 months; 40% of the 1'600'000 total stablecoins component in Scope 1.
- Creation of a 2'000 AAVE stream for 6 months; 40% of the 5'000 total AAVE component in Scope 1.
- Creation of a 1'140'000 aUSDC v3 Ethereum 4-months deferred payment; 60% of the 1'900'000 total stablecoins component in Scope 2.
- Creation of a 4'500 AAVE 4-months deferred payment; 60% of the 7'500 total AAVE component in Scope 2.

<br>
<br>

_Disclaimer_

- If approved, this governance proposal will act as a binding agreement between BGD Labs Technology and the Aave DAO for the previously defined scope.
- We are a third-party and completely independent service provider to the Aave DAO.
- We compromise to collaborate with any other contributors engaged by our customer, the Aave DAO.
- We develop technical solutions, but the usage and activation of them will need to be always decided and executed by the Aave DAO and its governance systems. We assume no liability for misusage of the technology we produced.
- We compromise to apply industry-standard security procedures to be as certain as possible that our software is without flaws. As with any other software, it is not possible to have full certainty of the lack of bugs, so we assume no liability for bugs appearing after security procedures were properly applied.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240325_AaveV3Ethereum_AaveBGDPhase3/AaveV3Ethereum_AaveBGDPhase3_20240325.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240325_AaveV3Ethereum_AaveBGDPhase3/AaveV3Ethereum_AaveBGDPhase3_20240325.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xf453667458e093dcd5bd986e0a62b4ef9dc914dca56ef97a8dc28ca89af6c8d3)
- [Discussion](https://governance.aave.com/t/aave-bored-ghosts-developing-phase-3/16893)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
