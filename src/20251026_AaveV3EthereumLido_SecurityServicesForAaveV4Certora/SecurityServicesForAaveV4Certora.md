---
title: "Security Services for Aave v4 <> Certora"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/arfc-security-services-for-aave-v4-certora/23222"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xc84ffd9516f6c5248a4c79224baaf0191c8ce240a0e48482ce16594da6d0196d"
---

# Simple summary

This AIP will create a one year stream of 2,390,000$ aLidoGHO to Certora to compensate them for their future work on Aave V4.

# Introduction

Since March 2022, we’ve maintained a continuous partnership with the DAO. Now halfway through our fourth year, Aave is stronger than ever — with continued potential for growth.

We propose a 12-month engagement as Aave’s primary security partner for Aave v4, safeguarding protocol upgrades, preventing critical bugs, and ensuring smooth governance execution. Our offering includes continuous review, incident response, and tooling improvements, backed by a full-time team and three and a half years of proven results.

Our proposal for continuing our support for Aave’s current infrastructure is posted separately [here](https://governance.aave.com/t/arfc-security-services-for-aave-current-infrastructure-certora/23221).

**We propose to extend our [existing services](https://governance.aave.com/t/arfc-aave-certora-continuous-security-services/19262/1) to Aave V4, while further expanding our engagement to include the Aptos instance and on-going support for V4 pre- and post-release.** The service includes:

1. A full-time dedicated team available to consult, research, and review maintenance work and new developments.
2. Full ownership over AIP reviews after the v4 production release - reviewing every AIP initiated on-chain.
3. 24/7 availability for incident response, supporting the technical providers in the investigation and mitigation of emerging bugs.
4. Acting as a signer in both the governance guardian and the protocol emergency guardian.

Note that the scope includes all currently planned and future v4 instances for all supported blockchains, and our proposal is based exclusively on Aave Labs’ suggestions and prior discussions related to security needs.

We have currently dedicated a team of 3 full-time equivalents and one part-time resource to governance reviews (~40 days/year or ~0.1 FTE), which we manage as a team of 6 people who are fully ramped and available to support Aave, providing the redundancy necessary for 24x7x365 support. Given that Aave v4 is not yet released, we assume that governance proposal review for v4 will not be necessary until later in the term, and we have excluded the cost of v4 governance reviews from our current pricing. However, once v4 is released, we will provide governance reviews for v4, and we will update pricing for the subsequent year based on the volume of governance work.

For the upcoming year of v4 support, we expect:

- 2 full-time equivalent security researchers available for smart contract reviews and governance reviews
- 1 full-time equivalent formal verification engineer

In addition, Certora provides a dedicated Technical Account Manager who acts as the single point of contact for all aspects of the engagement.

Looking forward to the coming year, we also propose the following extensions to our existing scope of work in an effort to continuously improve our security support for the Aave v4 ecosystem:

- Certora will assume responsibility for the configuration and management of all on-chain monitoring solutions. Our team’s in-depth knowledge of the functionality of the protocol and our insight into governance changes positions us uniquely to work with 3rd party monitoring tools to ensure high fidelity on-chain monitoring for the upcoming production release of v4.
- Certora will develop a high-coverage, fuzzed test suite for Aave v4 using the best tools available for invariant-based fuzz testing. Certora will develop and maintain this testsuite as part of our on-going audits of the v4 contracts. Our testsuite is designed to ensure comprehensive coverage of the threat model that we develop for each contract during our manual audits, and it will leverage any existing work already done on the v4 contracts.

The combination of formal verification, manual audit, and fuzzing provide three different vectors of security coverage for each Aave v4 contract. This combined methodology (manual + formal + fuzz) is an innovative approach to ensuring web3 protocol security, and it is an approach that Certora is pioneering to elevate the industry standard for comprehensive protocol security.

The addition of the two service components above adds an additional 1.5 FTE to our service engagement with the Aave DAO. Hence, Certora will be providing a dedicated team of 4.5 FTEs and 1 dedicated technical account manager to support Aave for the duration of this engagement.

# Price

The price for the above scope is $2.39M made in stablecoins. Payment shall be delivered via dedicated payment streams vested linearly over one year. A 30-day termination is possible after a vote.

**Price Explanation (provided for transparency)**

Our annual price for a dedicated security researcher or formal verification engineer is $780,000. Certora will be providing a dedicated team of 4.5 FTEs for this engagement. Our existing engagement reflects a ~32% discount that we offer to Aave to reflect our commitment to Aave’s security.

Unlike previous years, we request full payment using the Gho stablecoin as we believe that aligns best with the DAO’s preferences.

# Disclosures

In the interest of full transparency, we feel it is important to disclose that Certora is now working with the Compound DAO as one of the main two security providers supporting the DAO. To ensure the integrity of our service and to respect the confidentiality of our partners, we have assigned separate teams to each project and implemented internal procedures to ensure that Certora maintains an “ethical wall” to avoid any conflict of interest or information leakage between the teams working with the Aave and Compound DAOs.

# Background and Motivation

In the past 3.5 years we have continuously served the DAO as a security provider, assisting with dozens of new feature deployments and protocol improvement upgrades ([Sept 2022 - Sept 2023](https://governance.aave.com/t/security-and-agility-of-aave-smart-contracts-via-continuous-formal-verification/10181/19), [Sept 2023 - Sept 2024](https://docs.google.com/document/d/1RoJPYxxf_9MAlJ6hWdl5JRHHwMW8aXGjTBGX2c3PQv0/edit?usp=sharing), [Sept 2024 - Sept 2025](https://governance.aave.com/t/certora-monthly-update/20038)), preventing several critical bugs from going live and assisting with mitigation of live bugs upon emergence.

Alongside continuous security reviews and formal verification, we:

1. Conducted several focused research and investigation efforts of components and features within the ecosystem, sharing findings with developing teams and recommending remediations.
2. Led community efforts to review and formally verify new and existing Aave code. This included extensive education of the independent researchers community on the protocol and ecosystem as a whole.
3. Took full ownership of on-chain AIP reviews, reviewing so far 369 proposals, finding 12 bugs.
4. Continuously working with BGD Labs to improve their AIP review tooling - [Seatbelt](https://github.com/bgd-labs/seatbelt-gov-v3).
5. Developed a complementary tool called [Quorum](https://github.com/Certora/Quorum), that helps highlight potential failure points and ensure the robustness of the layered review process.
6. Assist in incident investigations and mitigation efforts.
7. Acting as signers for both the governance guardian and protocol emergency guardian, performing emergency and operational actions on numerous occasions.

With the current engagement coming to an end, we propose our services for the fourth time, offering new contribution channels to the ecosystem in addition to the existing ones.

## Specification

Create a one year payment stream of 2,390,000$ aLidoGho to 0x0F11640BF66e2D9352d9c41434A5C6E597c5e4c8.

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251026_AaveV3EthereumLido_SecurityServicesForAaveV4Certora/AaveV3EthereumLido_SecurityServicesForAaveV4Certora_20251026.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251026_AaveV3EthereumLido_SecurityServicesForAaveV4Certora/AaveV3EthereumLido_SecurityServicesForAaveV4Certora_20251026.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xc84ffd9516f6c5248a4c79224baaf0191c8ce240a0e48482ce16594da6d0196d)
- [Discussion](https://governance.aave.com/t/arfc-security-services-for-aave-v4-certora/23222)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
