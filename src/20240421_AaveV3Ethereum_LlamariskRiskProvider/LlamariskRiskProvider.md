---
title: "Onboard Llamarisk as a Risk Provider"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboard-new-risk-service-provider/17348"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x2b7433455b16d50b9b6afdf2e60bfd6e733896224688c9891c371aa2597853a2"
---

## Simple Summary

This AIP will onboard the LlamaRisk team as Aave's second Risk Service Provider and set up the payment stream.

## Motivation

The Aave DAO is using a dual risk provider models, since a spot is vacant and a [snapshot vote](https://snapshot.org/#/aave.eth/proposal/0x2b7433455b16d50b9b6afdf2e60bfd6e733896224688c9891c371aa2597853a2) to choose a new one among three candidates ended with the community voicing their support for the LlamaRisk Team, this AIP is here to make it official and set the payment stream to compensate them with 250,000 GHO over the next 6 months of their engagement.

## Specification

Recognizing the significance of a dual risk provider model, LlamaRisk’s proposal is designed to complement Chaos Labs’ risk services, with whom we plan to collaborate extensively.

The initial 6-month engagement, which may be extended pending DAO approval, involves the following scope:

- **On-demand Risk Assessments:** LlamaRisk will deliver prompt and in-depth risk assessments for assets listed or considered to be listed on Aave with particular emphasis on the collateral types comprising the GHO stablecoin. This will involve developing a custom framework tailored specifically to the categories of relevant assets and Aave’s needs, which will standardize the assessment process.
- **Collaborative Engagement with Chaos Labs:** We plan to collaborate extensively with Chaos Labs, combining our expertise to provide Aave with comprehensive and nuanced risk analysis, enhancing the protocol’s risk management capacity.
- **Active Involvement in DAO Governance:** LlamaRisk will actively participate in Aave’s DAO governance, offering informed insights and strategic recommendations on risk management practices for principal stakeholders and the community.
- **Legal Regulatory Advisory and Policy Work:** We will offer specialized legal research and regulatory guidance, including a thorough analysis of evolving legal frameworks and regulatory policies, and equip Aave with the necessary foresight to navigate the regulatory landscape of the DeFi sector effectively.

Risk vectors are diverse and cannot be fully managed by qualitative risk tools. That is why we specialize in comprehensive risk assessment of tokenized assets and DeFi protocols. Our work supports our partners in making informed decisions that mitigate potential threats and promote a culture of transparency and sustainability. Our team of experts meticulously evaluate various risk factors, including but not limited to:

- Protocol design and architecture
- Tokenomics and economic incentives
- Smart contract security
- Governance mechanisms
- Regulatory compliance

LlamaRisk leverages advanced simulation techniques, including statistical and agent-based modeling, to test and validate DeFi protocols and their collateral assets under various stress scenarios. Our simulations provide valuable insights into potential risks, allowing our partner protocols to set competitive parameters resilient to adverse market conditions.

Our DeFi strategy managers employ data analytics and risk monitoring tools that allow us to maintain high efficiency and safety standards. We support our partners with publications and dashboards that give users the information they need to interact with the protocol responsibly.

Our advisory services cater to the unique needs of DeFi projects, providing strategic guidance and support throughout their lifecycle. From ideation to implementation, our experienced advisors offer expert advice on protocol design, tokenomics, governance, and risk management strategies, ensuring optimal outcomes for our partners.
Comment

Traversing the complex regulatory landscape is crucial for DeFi protocols and projects. Our team of legal experts provides in-depth analysis and guidance to ensure compliance with applicable laws and regulations. We evaluate legal risks, assist with regulatory filings, and help clients develop robust strategies for operating within the evolving regulatory framework.

We actively engage in policy development and legislative processes related to crypto and blockchain at national, supranational, and international levels. This includes participating in specialized working groups, contributing opinions to public discussions on regulatory developments, and involvement in policymaking dialogues. We aim to ensure that DeFi stakeholders are represented and protected in the evolving regulatory landscape, facilitating informed and proactive responses to legislative changes.

## Technical specification

This AIP will have the collector setup a 250 000 GHO stream for 6 months toward the LlamaRisk treasury address.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240421_AaveV3Ethereum_LlamariskRiskProvider/AaveV3Ethereum_LlamariskRiskProvider_20240421.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240421_AaveV3Ethereum_LlamariskRiskProvider/AaveV3Ethereum_LlamariskRiskProvider_20240421.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x2b7433455b16d50b9b6afdf2e60bfd6e733896224688c9891c371aa2597853a2)
- [Discussion](https://governance.aave.com/t/arfc-onboard-new-risk-service-provider/17348)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
