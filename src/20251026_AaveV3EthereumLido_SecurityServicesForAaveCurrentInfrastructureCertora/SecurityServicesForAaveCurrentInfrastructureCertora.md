---
title: "Security Services for Aave Current Infrastructure <> Certora"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/arfc-security-services-for-aave-current-infrastructure-certora/23221"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xabaa167899193af7aab389c6412d18802845a88b9bb4061952c82ce78e670f71"
---

# Simple Summary

This AIP will open a one year aLidoGHO stream of 238,000$ to compensate Certora for their future work on the currently deployed Aave infrastructure.

# Introduction

Since March 2022, we’ve maintained a continuous partnership with the DAO. Now halfway through our fourth year, Aave is stronger than ever — with continued potential for growth.

We propose a 12-month extension of our engagement as primary security partner for Aave’s current infrastructure, continuing to safeguard protocol governance and assisting with incident response.

Our proposal for supporting Aave v4 is posted separately [here](https://governance.aave.com/t/arfc-security-services-for-aave-v4-certora/23222).

**To support the maintenance of Aave’s current infrastructure, we propose:**

1. Full ownership over AIP reviews - reviewing every AIP initiated on-chain.
2. 24/7 availability for incident response, supporting the technical providers in the investigation and mitigation of emerging bugs.
3. Acting as a signer in both the governance guardian and the protocol emergency guardian.

All reviews of smart contract changes to new or existing infrastructures and products are outside the scope of this agreement, and will be contracted on an as-needed basis at the weekly rate listed below. This proposal also does not include any work on Aave v4, which we have addressed in a separate proposal.

Note that this proposal is based exclusively on BGD Labs’s suggestions and prior discussions related to security needs.

We have currently dedicated a team of 3 full-time equivalents for audits and one part-time resource to governance reviews (~40 days/year or ~0.1 FTE), which we manage as a team of 6 people who are fully ramped and available to support Aave v3, providing the redundancy necessary for 24x7x365 support. In addition, Certora provides a dedicated Technical Account Manager who acts as the single point of contact for all aspects of the engagement.

Looking forward to the coming year, we will allocate 0.2 FTE security engineers for governance reviews, and we will continue to maintain 1 technical account manager who acts as the single point of contact for all parties in the Aave ecosystem. We will also reserve a team of 2 security researchers who are available on demand for bug fix reviews and incident response. We expect this team to be available for consultation ~2.5 days/month.

In addition, we will continue to participate as a signer in both the governance guardian and the protocol emergency guardian.

# Price

The price for the above scope is $238k made in stablecoins. Payment shall be delivered via dedicated payment streams vested linearly over one year. A 30-day termination is possible after a vote.

Smart contract audits for new or existing infrastructure and products are not included within this scope of work given that we do not anticipate any further upgrades to the existing infrastructure. If an upgrade that requires more than 2 days to review is required, we will scope and price such engagements separately using the 32%-discounted price of $20,400/week for a team of 2 experienced security researchers.Certora commits to initiate any requested audit project within two weeks from the date of the request.

**Price Explanation (provided for transparency)**

Our annual price for a dedicated security researcher or formal verification engineer is $780,000. Dedicating 0.2 FTEs to governance reviews and applying a 32% discount to our pricing, we arrive at a final price of $106k for our on-going governance support. We have also added an additional $11k/month for the coming 12 months to ensure Certora’s availability and on-going support for incident response and bug fix reviews. Combining the governance reviews and monthly retainer, we have a final price of $238k. No extra charge has been added for participating as a guardian.

# Disclosures

In the interest of full transparency, we feel it is important to disclose that Certora is now working with the Compound DAO as one of 2 security providers supporting the DAO. To ensure the integrity of our service and to respect the confidentiality of our partners, we have assigned separate teams to each project and implemented internal procedures to ensure that Certora maintains an “ethical wall” to avoid any conflict of interest or information leakage between the teams working with the Aave and Compound DAOs.

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

Create a 365 days payment stream of $238,000 aLidoGHO to 0x0F11640BF66e2D9352d9c41434A5C6E597c5e4c8

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/c7feb526517304d59f3c25333cc9e81b6bef6719/src/20251026_AaveV3EthereumLido_SecurityServicesForAaveCurrentInfrastructureCertora/AaveV3EthereumLido_SecurityServicesForAaveCurrentInfrastructureCertora_20251026.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/c7feb526517304d59f3c25333cc9e81b6bef6719/src/20251026_AaveV3EthereumLido_SecurityServicesForAaveCurrentInfrastructureCertora/AaveV3EthereumLido_SecurityServicesForAaveCurrentInfrastructureCertora_20251026.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xabaa167899193af7aab389c6412d18802845a88b9bb4061952c82ce78e670f71)
- [Discussion](https://governance.aave.com/t/arfc-security-services-for-aave-current-infrastructure-certora/23221)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
