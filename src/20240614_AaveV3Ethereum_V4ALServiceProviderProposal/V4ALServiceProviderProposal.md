---
title: "V4 AL Service Provider Proposal"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/temp-check-service-provider-proposal/17866"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xbf901f4be94a4661dce8217b3b037a8607ea8953cbe32e7dbde6a882819d64b3"
---

## Simple Summary

This AIP proposes a one-year technical contributor engagement for Aave Labs to act as a service provider for development of Aave V4 and a new visual identity.

## Motivation

Aave Labs seeks to be onboarded as a service provider to be one of the technical contributors to the Aave DAO. The specification below outlines the scope of the technical contributions of Aave Labs.

## Specification

The following are the key deliverables within the grant:

#### **Aave Protocol V4**

Key deliverables for the 1 year scope of development include:

**New Modular Architecture**  
An innovative design to enhance flexibility and efficiency, minimizing disruption for integrators.

**Unified Liquidity Layer**  
A flexible liquidity management approach that allows for module modifications without needing to migrate liquidity.

**Fuzzy-controlled Interest Rates**  
Automated rate adjustments based on market conditions, optimizing for both suppliers and borrowers. Utilizing Chainlink for precise data feeds, setting new standards in capital efficiency.

**Liquidity Premiums**  
Adjusted borrowing costs based on collateral risk, ensuring fairer pricing. Higher risks incur higher premiums, while lower risks reduce costs.

**Dynamic Risk Configuration**
Allows dynamic adjustments to risk parameters based on market conditions without governance overhead.

**Smart Accounts and Vaults**  
Simplifies user interactions with the protocol by allowing multiple smart accounts per wallet and enabling borrowing without direct collateral supply.

**Automated Assets Offboarding**  
Streamlines the process of offboarding assets, reducing governance workload and ensuring predictable offboarding plans.

**Enhanced Liquidation Engine**  
Introduces a variable liquidation factor, liquidation strategies, and batch liquidations to improve efficiency and borrower experience.

**Automated Treasury Management**  
Implements a reverse auction mechanism for reserve factor assets, reducing governance overhead.

#### **GHO Features**

**Native GHO Minting**  
Allows for more efficient minting of GHO directly from the liquidity layer.

**GHO “Soft” Liquidations**  
Utilizes a LLAMM model to ease liquidations and manage market downturns, providing options for users to choose which collateral to liquidate to GHO.

**Stablecoin Interest Paid in GHO**  
Suppliers can opt to receive interest payments in GHO, enhancing capital efficiency and providing additional benefits to the protocol.

**Emergency Redemption Mechanism**  
A feature to handle prolonged and heavy depegging of GHO, ensuring stability and reliability.

#### **Visual Identity Assets**

**Provision of Visual Identity Assets**  
Compiling and delivering a package of visual identity assets, including, but are not limited to, logos, color schemes, typography guidelines, various Ronnie illustrations and other graphical elements.

**Usage Guidelines**  
Instructions on how to implement the visual identity assets across various platforms and media, including digital and print formats. Practical examples and best practice scenarios demonstrating the potential usage of the visual identity assets.

**Delivery**  
The assets will be delivered and packaged in a Github repository accessible to everyone and hosted within the Aave DAO Origin organization.

#### **Grant**

$12m GHO, including $3m upfront and $9m streamed over the year.

#### **Renewal**

The DAO may renew the engagement with Aave Labs as a service provider for a technical contributor for a second and third year with that scope of work to be determined at a later date and subject to community input and AFRC approval.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240614_AaveV3Ethereum_V4ALServiceProviderProposal/AaveV3Ethereum_V4ALServiceProviderProposal_20240614.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240614_AaveV3Ethereum_V4ALServiceProviderProposal/AaveV3Ethereum_V4ALServiceProviderProposal_20240614.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xbf901f4be94a4661dce8217b3b037a8607ea8953cbe32e7dbde6a882819d64b3)
- [Discussion](https://governance.aave.com/t/temp-check-service-provider-proposal/17866)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
