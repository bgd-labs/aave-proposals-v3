---
title: "Funding Proposal: TokenLogic Financial Service Provider"
author: "TokenLogic"
discussions: https://governance.aave.com/t/arfc-tokenlogic-financial-services-provider/20182
snapshot: https://snapshot.box/#/s:aave.eth/proposal/0xd1fdca5d69b03ed57848180d62a812ab1a1ff72f85d671c417b5ff8fb2bd0a7c
---

## Simple Summary

TokenLogic proposes to renew its engagement with the Aave DAO for one year, starting on December 15, 2024, upon the conclusion of the current stream.

TokenLogic is to provide the following services to the DAO.

- Treasury and Runway Management;
- Analytics and Performance Metrics;
- GHO's growth across DeFi and CeFi; and,
- Support Aave protocol parameter optimizations.

## Motivation

### Treasury and Runway Management

**Asset Management & Financial Security**

A central area of focus for the Finance Services Provider is to ensure that the DAO’s expenses and strategic initiatives are funded efficiently and without delay. Through the Steward role, or the standard governance process when required, TokenLogic will prioritize maintaining the DAO’s financial stability by ensuring a runway that exceeds six months of its burn rate while optimizing capital efficiency.

Key components of this objective include:

- Bridging Aave funds across networks;
- Allocating assets for capital efficiency, integrating yield bearing assets to the treasury;
- Migrating funds from Aave v2 to Aave v3, and between Aave v3 markets;
- Swapping assets to align expenses with holdings.

### Analytics and Performance Metrics

TokenLogic is establishing itself as the definitive hub for all Aave Protocol and GHO-related data via the [Aave Portal](https://aave.tokenlogic.xyz/). This initiative will be continuously developed and expanded throughout the year, providing access to key metrics on protocol performance, health, GHO dynamics, and market analysis.

Transparency, analytics, and reporting are at the core of this effort, ensuring a clear understanding of the protocol’s financial status and overall performance. The Aave Portal will serve as an important tool for informed decision-making and in-depth analysis of the Aave ecosystem.

To further engage and educate the community, this initiative will be complemented by detailed threads/articles released throughout the mandate, promoting awareness and understanding of the platform’s developments.

### GHO Adoption

**Oversight**

The year 2025 will mark the second year of GHO, solidifying its strength and utility within the ecosystem. This milestone year is set to be a pivotal period of expansion for GHO, as it continues to expand to other networks and remains a cornerstone of the protocol’s revenue model.

As GHO Stewards, TokenLogic will oversee critical configurations, including the Borrow Rate, GSM Caps and Fees, ensuring optimal functionality and sustainability. In our role as Treasury Managers, we will strategically manage GHO swaps to maintain a robust and stable peg, reinforcing GHO’s position as a key asset within the Aave ecosystem.

**Liquidity**

We will continue to spearhead the operations of the Aave Liquidity Committee (ALC), with a primary focus on managing liquidity and driving integrations across diverse protocols.

Our key responsibilities include:

- Strategically adjusting liquidity incentives to ensure robust market depth;
- Designing and implementing direct liquidity incentive programs;
- Leading initiatives to enhance GHO’s utility and adoption;
- Optimizing the deployment of the DAO’s strategic voting assets;
- Supporting future GHO facilitator programs, and Protocol-Owned Liquidity (POL) initiatives;
- Facilitating GHO integration into centralized exchanges, fund management platforms, and the broader DeFi ecosystem; and,
- Support teams seeking to attain a line of credit within the upcoming Emergence instance.

**Parameter Configuration**

TokenLogic will continue to provide detailed insights into GHO's performance and provide parameter recommendations that prioritise price stability whilst balancing the DAO's growth ambitions.

Strategic focus will be placed on managing the borrow rate and peg relationship to maintain the resilience of the peg by retaining funds within the GSMs, whilst promoting the ongoing use of GHO within evolving market dynamics.

The Aave Portal will provide insights into the impact of the parameter adjustments to curate an environment that promotes sustainable growth, adoption and aligns with Aave's broader financial goals.

The TokenLogic team will collaborate closely with other service providers to create balanced, effective solutions that benefit the protocol as a whole.

### Aave Protocol

The evolution of the Aave protocol, including updates to Aave V4, the deployment of Umbrella, and the launch of new Aave markets, will bring transformative changes to the protocol’s operations. Our proposal focuses on providing the financial planning and management essential for navigating these developments and ensuring smooth integration within the broader ecosystem.

In addition, we will support the adaptation of Aave’s tokenomics to meet the requirements of Umbrella and the introduction of new staking pools. Through proactive collaboration, strategic guidance, and consultation, we are committed to ensuring these updates are implemented seamlessly and positioned for long-term success.

## Terms

- 12-month engagement, December 15th 2024 to December 15th 2025;
- $1M, streamed linearly throughout the engagement;
- $1,000,000 is to be withdrawn in aEthLidoGHO (Aave V3 Lido GHO)

## Specification

To support funding the streams, the following is to be performed:

- 0.75M GHO from the Collector deposited into the Lido Prime instance;
- 0.75M aEthUSDC withdrawn from Aave V3 Mainnet and swapped for GHO; and,
- GHO from above swap is to be sent to Collector (Treasury).

Create the following stream allowing TokenLogic to withdraw aEthLidoGHO from the Prime instance.

- Recipient: TokenLogic
- Stream: 1M aEthLidoGHO over 365 days
- Address: `0x3e4A9f478C0c13A15137Fc81e9d8269F127b4B40`

The stream shall commence the next block from when the previous stream finishes.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/8894f1b6ebc87f5e81d8e7cc196e7c43ea5855dc/src/20241213_AaveV3Ethereum_TokenLogicFinancialServiceProvider/AaveV3Ethereum_TokenLogicFinancialServiceProvider_20241213.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/8894f1b6ebc87f5e81d8e7cc196e7c43ea5855dc/src/20241213_AaveV3Ethereum_TokenLogicFinancialServiceProvider/AaveV3Ethereum_TokenLogicFinancialServiceProvider_20241213.t.sol)
  [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0xd1fdca5d69b03ed57848180d62a812ab1a1ff72f85d671c417b5ff8fb2bd0a7c)
- [Discussion](https://governance.aave.com/t/arfc-tokenlogic-financial-services-provider/20182)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
