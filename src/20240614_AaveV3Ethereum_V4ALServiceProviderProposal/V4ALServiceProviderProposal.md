---
title: "AL Service Provider Proposal"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/arfc-al-service-provider-proposal/17974"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x70dfd865b78c4c391e2b0729b907d152e6e8a0da683416d617d8f84782036349"
---

## Summary

This AIP proposes a one-year technical contributor engagement for the Aave Labs to act as a service provider for development of Aave V4 and a new visual identity.

## Motivation

Aave Labs seeks to be onboarded as a service provider to be one of the technical contributors to the Aave DAO. The specification below outlines the scope of the technical contributions of Aave Labs.

## Specification

The following are the key deliverables within the grant:

### Aave Protocol V4

Key deliverables for the 1 year scope of development include:

- New Modular Architecture

  - An innovative design to enhance flexibility and efficiency, minimizing disruption for integrators.

- Unified Liquidity Layer

  - A flexible liquidity management approach that allows for module modifications without needing to migrate liquidity.

- Fuzzy-controlled Interest Rates

  - Automated rate adjustments based on market conditions, optimizing for both suppliers and borrowers. Utilizing Chainlink for precise data feeds, setting new standards in capital efficiency.

- Liquidity Premiums

  - Adjusted borrowing costs based on collateral risk, ensuring fairer pricing. Higher risks incur higher premiums, while lower risks reduce costs.

- Dynamic Risk Configuration

  - Allows dynamic adjustments to risk parameters based on market conditions without governance overhead.

- Smart Accounts and Vaults

  - Simplifies user interactions with the protocol by allowing multiple smart accounts per wallet and enabling borrowing without direct collateral supply.

- Automated Assets Offboarding

  - Streamlines the process of offboarding assets, reducing governance workload and ensuring predictable offboarding plans.

- Enhanced Liquidation Engine

  - Introduces a variable liquidation factor, liquidation strategies, and batch liquidations to improve efficiency and borrower experience.

- Automated Treasury Management

  - Implements a reverse auction mechanism for reserve factor assets, reducing governance overhead.

- GHO Features

  - Native GHO Minting

    - Allows for more efficient minting of GHO directly from the liquidity layer.

  - GHO “Soft” Liquidations

    - Utilizes a LLAMM model to ease liquidations and manage market downturns, providing options for users to choose which collateral to liquidate to GHO.

  - Stablecoin Interest Paid in GHO

    - Suppliers can opt to receive interest payments in GHO, enhancing capital efficiency and providing additional benefits to the protocol.

  - Emergency Redemption Mechanism
    - A feature to handle prolonged and heavy depegging of GHO, ensuring stability and reliability.

### Visual Identity Assets

[Aave Visual Identity Guidelines | 2024](https://www.youtube.com/watch?v=TQHLCACwnbE)

Deliverables include:

- Provision of Visual Identity Assets: Compiling and delivering a package of visual identity assets, including, but are not limited to, logos, color schemes, typography guidelines, various Ronnie illustrations and other graphical elements.

- Usage Guidelines: Instructions on how to implement the visual identity assets across various platforms and media, including digital and print formats. Practical examples and best practice scenarios demonstrating the potential usage of the visual identity assets.

- Delivery: The assets will be delivered and packaged in a Github repository accessible to everyone and hosted within the Aave DAO Origin organization.

## Pospective Second and Third Year Scope

The DAO may renew the engagement with Aave Labs as a service provider for a technical contributor for a second and third year with that scope of work to be determined at a later date and subject to community input and ARFC approval.

## Grant

$12m GHO, including $3m upfront and $9m streamed over the year.

## Evaluation Metrics

- Monthly reporting of contributions to the Aave DAO.
- Solicitation of feedback from other service providers working as technical contributors and DAO members.
- Direct and transparent engagement with the DAO via the governance forum.

## Principles

- Aave Labs shall strictly adhere to the scope of its designated role as one of the service providers working as a technical contributor, ensuring all decisions and actions remain within our areas of the engagement.
- Aave Labs shall prioritize the security and robustness of its technical contributions.
- Any production-ready code written within the scope of the proposal will be moved to the Aave DAO’s GitHub repository.
- Aave Labs shall engage with the DAO like all other contributors within the established working relationships and procedures of the Aave DAO. For example, decisions concerning risk configurations, DAO treasury, code audits, and other matters not covered by this proposal will need to be separately approved by the Aave DAO via TEMP CHECKs and Snapshots.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/02a12b149705d2ab32bdec871058d5b8a956c0f0/src/20240614_AaveV3Ethereum_V4ALServiceProviderProposal/AaveV3Ethereum_V4ALServiceProviderProposal_20240614.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/02a12b149705d2ab32bdec871058d5b8a956c0f0/src/20240614_AaveV3Ethereum_V4ALServiceProviderProposal/AaveV3Ethereum_V4ALServiceProviderProposal_20240614.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x70dfd865b78c4c391e2b0729b907d152e6e8a0da683416d617d8f84782036349)
- [Discussion](https://governance.aave.com/t/arfc-al-service-provider-proposal/17974)

## Copyright

The text of this AIP is released under the [CC0 license](https://creativecommons.org/publicdomain/zero/1.0/). The visuals and the New Visual identity are subject to and governed by the license specified in the approved governance proposal by the Aave DAO.
