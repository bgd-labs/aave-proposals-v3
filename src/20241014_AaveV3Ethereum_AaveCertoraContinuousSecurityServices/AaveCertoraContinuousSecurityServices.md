---
title: "Aave <> Certora Continuous Security Services"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-aave-certora-continuous-security-services/19262"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xebf0b33be0c3784b2928112414f08e31ac57705f49d46668bfef6fa6f761141d"
---

## Simple Summary

This AIP propose to renew Certora engagement for the next year and will create two payment stream for 1,150,000 GHO and $0.55M worth of Aave scheduled to end on the 11th of september 2025.

## Motivation

With 2.5 years of continuous collaboration and contribution to Aave’s ecosystem behind us, we’re as excited about the protocol’s future as we were on day one!

We offer an extension of our engagement with the DAO for a total period of 12 months. The scope of our offering is divided into 2 parts for transparency on pricing and operational commitment:

1. Extending the [existing services ](https://governance.aave.com/t/arfc-continuous-security-proposal-aave-certora/15732) for Aave V3, which include:
2. A full-time dedicated team available to consult, research, and review maintenance work, and new developments.
3. Full ownership over governance proposal reviews - reviewing every governance proposal initiated on-chain.
4. 24/7 availability for incident response, supporting the technical providers in the investigation and mitigation of emerging bugs.

Note that the scope includes all existing V3 instances and all future EVM-based V3 instances.

The price for the above scope is $1.7M. ⅔ of the price, $1.15M, will be made in Gho and ⅓, $0.55M, in AAVE.

1. Safeguarding transactions against unknown attacks
2. We will develop Safeguard, a modified Ethereum client based on geth client for real-time monitoring and invariant checking for Aave V3.
3. We will write and monitor the invariants in real time to add another layer of security to the protocol and collaborate with the relevant entities to investigate and mitigate any suspicious transactions.

Note that Safeguard is a complementary security service we provide free of charge for all existing AAVE V3 instances and all future EVM-based V3 instances.

Price Explanation

Last year, we reduced our prices from $2.7M to $1.5M to reflect the bear market. This year, we suggest a small increase to cover the rise in our costs.

Our regular annual price for professional services is $2.7M. We decided to reduce the price by 37% to $1.7M, to reflect our commitment to Aave’s security.

As in previous years, we request a ⅔-⅓ price breakdown of stablecoin and AAVE, respectively. As service providers and DAO members, we are strong believers in the alignment of long-term players with the protocol. Over the years, not a single AAVE token we received was sold, and the governance power was put to work through delegation to both ACI and StableLabs, which we track closely.

## Background and Motivation

In March 2022, we presented [a proposal to serve as a DAO security provider ](https://governance.aave.com/t/continuous-formal-verification/6308), collaborating with the other technical contributors to help Aave deploy the finest and most secure product on the market. In the next six months, we collaborated with both BGD Labs and Aave Labs on several high-profile projects, including the AAVE token V3, governance cross-chain bridge, and Gho token.

Since then, we have continuously served the DAO as a security provider, assisting with dozens of new feature deployments and protocol improvement upgrades ([Sept 2022 - Sept 2023](https://governance.aave.com/t/security-and-agility-of-aave-smart-contracts-via-continuous-formal-verification/10181/19), [Sept 2023 - Sept 24](https://docs.google.com/document/d/1RoJPYxxf_9MAlJ6hWdl5JRHHwMW8aXGjTBGX2c3PQv0/edit?usp=sharing)), preventing several critical bugs from going live and assisting with mitigation of live bugs upon emergence.

In addition to conducting security reviews and formal verification, we also:

1. Conducted several focused research and investigation efforts of components and features within the ecosystem, reporting to the developing entities about the results and recommending actions to be taken.
2. Led 6 community efforts to review and formally verify new and existing Aave code. This included extensive education of the independent researchers community on the protocol and ecosystem as a whole.
3. Took full ownership of on-chain governance proposal reviews, reviewing so far 153 proposals, finding 4 bugs since February.
4. We’re also continuously working with BGD Labs to improve their AIP review tooling - [Seatbelt](https://github.com/bgd-labs/seatbelt-gov-v3).
5. In addition to developing a complementary tool that helps highlight potential failure points and ensure the robustness of the layered review process.
6. Assist with incident response investigations and mitigations.
7. Following successful voting, on August 2024 we admitted our roles as signers for both the governance guardian and protocol emergency guardian.
8. We will continue to act in full trust of the DAO and in collaboration with the rest of the contributing parties to train and act according to the DAO’s best interest.

With the current engagement coming to an end, we propose our services for the fourth time, offering new contribution channels to the ecosystem in addition to the existing ones.

## Scope

We present the suggested scope for the following year:

- Year-round availability of a dedicated team for review of new code. This includes manual reviews and [formal verification](https://medium.com/certora/certora-technology-white-paper-cae5ab0bdf1) of smart contracts, as well as the use of additional tools as necessary.
- 24/7 availability for incident response investigations and mitigation. Of course, this is in full collaboration with the relevant developing entities and BGD Labs, the DAO’s security coordinator.
- Full responsibility for reviewing every AIP that goes on-chain, preventing any faulty or malicious proposals from being executed and ensuring the highest-standard procedures are met.
- We will develop an invariant-based monitoring system, called Safeguard, with invariants specifically tailored for Aave. The invariants will be written by Certora, assisted by BGD Labs for Aave V3 related components and Aave Labs for Gho related components. Alerts, results and data will be shared with BGD Labs as the system’s security coordinators.
  - Since development is still in the early stages and it’s still undetermined when Safeguard will be up and running in stable form, bringing value to the DAO, we offer this at no additional cost on a best-effort basis.
- We will continue to develop our governance proposals review tool to improve the overall tooling for the DAO in this domain.
  The tool is currently in an alpha version and used solely by Certora. However, on December 1st, we’re expecting to release a beta version to the other service providers to get their feedback and feature requests. In a later stage, we plan to release the tool for public use.

The annual price for the project is $1.7M: $1.15M is paid in Gho vested linearly over one year, and $550,000 is paid in AAVE tokens vested linearly over one year. A 30-day termination is possible after a vote.

## Specification

The payload will create 2 payment streams to the address 0x0F11640BF66e2D9352d9c41434A5C6E597c5e4c8 for a duration of 365 days starting from the end of the previous engagement (Sept. 11, 2024).

- Create a payment stream of $1.15M Gho to 0x0F11640BF66e2D9352d9c41434A5C6E597c5e4c8 for a total of 365-Delta days.
- Create a payment stream of $0.55M worth of AAVE to 0x0F11640BF66e2D9352d9c41434A5C6E597c5e4c8 for a total of 365-Delta days.

Where Delta is the number of days from September 11th until execution.

Price of AAVE will be determined using a 30-days average.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/b18fe56abfc87578423a9884627070cc23f342e9/src/20241014_AaveV3Ethereum_AaveCertoraContinuousSecurityServices/AaveV3Ethereum_AaveCertoraContinuousSecurityServices_20241014.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/b18fe56abfc87578423a9884627070cc23f342e9/src/20241014_AaveV3Ethereum_AaveCertoraContinuousSecurityServices/AaveV3Ethereum_AaveCertoraContinuousSecurityServices_20241014.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xebf0b33be0c3784b2928112414f08e31ac57705f49d46668bfef6fa6f761141d)
- [Discussion](https://governance.aave.com/t/arfc-aave-certora-continuous-security-services/19262)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
