---
title: "Renew LlamaRisk as Risk Service Provider"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-renew-llamarisk-as-risk-service-provider/19277"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x3c8116f97f990bf61fe63c636c1ae85630ad355e26881285aa4fefaebd8c9c0d"
---

## Simple Summary

This AIP propose to renew Llama risk engagement for the next 6 months and will create a payment stream for 400,000 GHO for the same amount of time.

## Motivation

We’ll keep this short. When we [initially applied](https://governance.aave.com/t/temp-check-onboard-llamarisk-as-aave-risk-service-provider) to serve Aave as a risk service provider, our primary goal was to deliver complementary and collaborative work alongside @ChaosLabs, focusing on qualitative analysis, ad hoc research, and legal/regulatory advisory.

Five months later, we are confident that we have fulfilled this commitment, a sentiment that numerous delegates and service providers have echoed. Our work has made a significant impact on safely integrating newly onboarded assets, and we have fostered a great relationship with @ChaosLabs, holding regular meetings, aligning internally, and driving informed decisions. We place high importance on furthering the common mission of all Aave service providers to promote sustainable growth of the protocol, and to that end we have engaged in collaborations and taken steps to join task forces with numerous ecosystem teams.

Although most of our work is publicly available through [monthly community updates](https://governance.aave.com/t/llamarisk-monthly-community-update/), we have made several positive contributions behind the scenes. These include advocating for bug bounty programs, improved access controls, and increased transparency for end users. A good example of such activity is our work behind the scenes on WBTC to ensure sensible and compliant steps in its custody restructuring partnership with BiT Global. This presented LlamaRisk an opportunity to showcase its expertise in evaluating regulatory risk and to diplomatically navigate a sensitive situation to protect the interests of Aave and its users.

Our staged onboarding plan has allowed us to manage the allocated budget prudently, with a steady increase in workforce and dedicated resources to Aave. As a reminder, LlamaRisk is a community-led, non-profit organization that aligns with Aave in making the protocol as secure and resilient as possible to bolster its capacity for sustainable growth. All funds are directed towards contributor compensation and infra expenses related to Aave.

## Scope

As we enter the next engagement phase, we request a six month engagement for a total of $400,000, to be paid either in GHO or aToken stables, at the DAO’s discretion. While this represents a 60% increase over our initial budget, it amounts to a marginal increase from our current burn rate, which we have prudently managed as we’ve expanded our team and substantially increased our contributions to AAVE DAO. The total amount requested for the engagement is in addition to continuing our current scope, we plan to extend the following services to the Aave DAO:

- **Risk Monitoring**: Liquidity depth monitoring and markets exposure analysis for Aave markets will aid our ad hoc research efforts and inform our team about concerning liquidity trends and inconsistencies in Aave’s exposure between individual assets and asset categories. As with all our research and analysis, we will make Aave markets liquidity data and analysis public through an Aave risk portal dashboard for the benefit of DAO contributors and Aave users. This will also allow us to better collaborate with Chaos Labs to identify and proactively respond to evolving market conditions.
- **Probationary Onboarding Framework**: Typically an asset risk review is conducted prior to onboarding, but especially since Aave may seek to onboard assets with a short history for strategic reasons, an extended 2-month probation period is prudent. LlamaRisk will define and implement a framework for probationary asset offboarding for cases where assets are not satisfying market health and growth expectations. Establishing clear guidelines will also serve protocol teams in setting targets and aligning expectations.
- **Chain Ecosystem Framework**: While BGD Labs can devote resources toward evaluating chain deployments from a security and technical perspective, LlamaRisk can supplement evaluations from an economic perspective. Our Chain Evaluation Framework will detail available DeFi applications, user behaviors, and ecosystem-wide assets review to identify the market risk associated with the proposed chain deployment. The framework guidelines will benefit chain candidates through the establishment of clear expectations around building liquidity and an ecosystem that is minimally eligible for Aave.
- **RWA Integrations**: RWAs present an integration challenge and an opportunity to cross the divide between DeFi and TradFi. The challenges mainly revolve around regulatory hurdles and specialized design requirements to satisfy those limitations. We are leveraging our regulatory expertise in collaboration with Chainlink to develop standards for RWA integrations that are compliant and scalable to meet the requirements of the numerous RWAs coming to market. This will involve research into legal structures (including BORGs) to facilitate such integrations.
- **Legal Research**: Focusing on the MiCA treatment of governance tokens, with a specific emphasis on the amended features of AAVE following the AAVEnomics update. We intend to draft a comprehensive report that will delve into the legal implications of these changes. Additionally, we will closely monitor the mandatory ESMA/EBA guidance issued under MiCA and are committed to producing concise briefs that outline their implications for the AAVE token.

As all indicators suggest that Aave is entering a new growth phase, we wish to continue bringing value as an independent, pragmatic, and stabilizing voice within the DAO. Many of the brightest minds in our industry serve the Aave DAO; we are enthusiastic about being among your ranks and look forward to growth and ongoing collaboration with all of you.

## Specification

Create a payment stream of 400,000 GHO to the address `0xE8555F05b3f5a1F4566CD7da98c4e5F195258B65`, a LlamaRisk controlled multisig, for 6 months starting from the end of the previous engagement (Oct 28th, 2024 / timestamp 1730098043)

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/91a9c28bd302c0e162a34a1d8968f0d5b09745c7/src/20241013_AaveV3Ethereum_RenewLlamaRiskAsRiskServiceProvider/AaveV3Ethereum_RenewLlamaRiskAsRiskServiceProvider_20241013.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/91a9c28bd302c0e162a34a1d8968f0d5b09745c7/src/20241013_AaveV3Ethereum_RenewLlamaRiskAsRiskServiceProvider/AaveV3Ethereum_RenewLlamaRiskAsRiskServiceProvider_20241013.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x3c8116f97f990bf61fe63c636c1ae85630ad355e26881285aa4fefaebd8c9c0d)
- [Discussion](https://governance.aave.com/t/arfc-renew-llamarisk-as-risk-service-provider/19277)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
