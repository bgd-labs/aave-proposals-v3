---
title: "TokenLogic + karpatkey - Phase II"
author: "TokenLogic karpatkey"
discussions: "https://governance.aave.com/t/arfc-tokenlogic-karpatkey-financial-service-providers-phase-ii/18285"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xc44ec840f8f7f6ca3ef2f2a4289882c4cdc1a8b3e6e9ad6b811a640097a8016a"
---

![TL + kpk 2](https://hackmd.io/_uploads/Bkwva6C80.jpg)

# Summary

This publication proposes the continuation of the collaboration with karpatkey and TokenLogic for an additional 6 months, with a proposed budget of 500k GHO. The proposed contributions extend over the three themes detailed below: Treasury Management, GHO adoption and the Aave Stack.

# Motivation

The TokenLogic and karpatkey partnership has created significant value for the Aave DAO across all three focus areas detailed [here](https://governance.aave.com/t/phase-i-summary-karpatkey-tokenlogic/17962). GHO's peg, liquidity, and growth prospects have each improved dramatically over the last 6 months. The DAO's finances are more transparent than ever before and the DAO is firmly positioned for growth.

Building on the success of Phase I, we seek to extend our collaboration with the Aave Community for another 6 months. Phase II of our engagement is to focus on enabling GHO and Aave to grow market share through prudent financial management and contributing to numerous growth initiatives. Our three primary focus areas are summarized below:

- Treasury Management
- GHO Adoption
- Aave Stack

## What to Expect

### Treasury Management

**Asset Management**

The Aave DAO receives revenue in the form of revenue-generating aTokens for each deployed lending market. Whilst that reduces the need to deploy assets beyond the protocol itself, this creates a need for continual rebalancing of asset holdings.

To facilitate streamlining routine operational tasks, the [Finance Steward](https://governance.aave.com/t/arfc-aave-finance-steward/17570) role, which has been already introduced to the Aave community, will be developed. Given the ability to create allowances, streams, perform transfers, assets bridging, and swaps within pre-approved guidelines and without AIPs, we expect the governance overhead around treasury management to decrease significantly.

The GHO Finance Steward's capacity to perform swaps will also be improved by the implementation of the [Aave Swap](https://governance.aave.com/t/arfc-aave-swap-upgrade/15311) contract. With this tool, the DAO will be able to acquire assets in a timely and targeted manner, and to support GHO's peg during turbulent market conditions with the ability to create limit orders.

**Financial Security**

A key objective is to define the DAO's annual budget and secure sufficient funds to ensure DAO operations under stressfull market conditions. As the DAO's revenues have exceeded the burn-rate and currently holds more assets (about $145M at [end of June](https://reports.karpatkey.com/?dao=9&month=6&year=2024&currency=USD)) than planned expenses, this proposal will target to cover a [six months' runway](https://aave.tokenlogic.xyz/runway) matching holdings with expense tokens or token class as deemed appropriate for capital efficiency. This approach guarantees financial stability and operational continuity for Aave DAO.

Key components of this objective will include:

- Deploying bridging contracts (as required);
- Bridging Aave funds between networks;
- Alocating assets for capital efficiency. In particular, migrating funds from Aave v2 to Aave v3; and
- Swapping assets to align expenses and holdings.

**Aave Analytics**

Reporting and analytics functions will be expanded to provide the utmost transparency into the DAO's financial status and overall performance of the protocol, and to support informed decision-making and analysis of the Aave ecosystem. This includes the [Aave Portal](https://aave.tokenlogic.xyz/) and the [Aave Treasury Report](https://reports.karpatkey.com/), which shows detailed information on DAO holdings and treasury performance.

The Aave Portal will continue to evolve to showcase the performance of the Aave Protocol and GHO's adoption. Over the next 6 months, the portal will expand to include all revenue sources (incl. Accrued), assets holdings and expenses (incl. budgets) in granular detail, whilst also beginning to include high-level performance tracking across existing covered deployments.
Several legacy community Dune Dashboards will be integrated into the Aave Portal, where they will be maintained and expanded upon over time.

### GHO Adoption

**Oversight**

During Phase II, GHO's growth is expected to accelerate and expand to several networks. To nurture and maximize the growth potential of GHO, its success hinges on the ability to hold its peg and scale simultaneously.

As a GHO Steward, we will continue to manage key GHO and GSM configurations, including Borrow Rate, GSM Caps, and GSM fees. As the Treasury Managers, we will ensure the GSM is adequately funded, targetting a collateralization in the range of 5% to 10% of total supply, and that GHO swaps are performed in a manner supportive of retaining a tight peg.

**Liquidity**

We will continue to lead the operations of the Aave Liquidity Committee (ALC), overseeing the liquidity growth across different protocols. This includes

- Adjusting liquidity incentives to maintain sufficient market depth;
- Defining and executing direct liquidity incentives;
- Leading initiatives that create utility for GHO;
- Optimizing the utilization of the DAO's strategic voting assets;
- Supporting GSM Integrations with aggregators;
- Ensuring GSM are adequately funded;
- Supporting future D3M, Facilitator, and Protocol Owned Liquidity (POL) initiatives; and
- Support efforts to integrate GHO to Centralized Exchanges, and fund managers.

**Growth**

As GHO continues to grow beyond Ethereum, our efforts will expand to support those new deployments to ensure adequate liquidity and peg stability is maintained. We will continue to work with teams that build with GHO and advocate for the adoption of GHO wherever practical.

When GHO is mature enough to support deploying Protocol Owned Liquidity, we will actively contribute to the creation of sGHO and balancing the needs for sGHO and stkGHO within the Aave ecosystem.

Our goal is to keep the consistent growth rate and surpass the GHO borrowed supply of 180M by the end of this new term.

### Aave Stack

**Safety Module Management and Optimisation**

The Safety Module (SM) currently presents exposure risks due to its reliance on the DAO's native token and its deployment solely on the Ethereum blockchain.

With multiple instances of the SM being deployed, we will continue to perform the following:

- Transition from AAVE emissions;
- Introduce new categories;
- Amend emission schedules; and,
- Progressively align protocol exposure with SM holdings;

**Aave Liquidity Network**

With upcoming changes in the Aave product stack, including the Liquidity Network and the stablecoin's multichain deployment, new challenges will arise in integrating these aspects with other products. We will actively participate in coordination and consulting to support the streamlined and successful deployment of these features.

Where practical, sunsetting of legacy v2 markets will be supported through continual parameter adjustments to encourage users to migrate to the latest instance of Aave Protocol.

By addressing these challenges, our team aims to support the DAO in achieving sustainable growth and resilience in a rapidly changing environment.

# Specification

The transfer() method of the Collector will be called to send the backdated token to the two address below, and then the createStream() method of the Collector will be called to create two streams when the payload gets executed:

**karpatkey**
Transfer and Stream: Total 250k GHO over 180 days from 1718673864
Address: `0x58e6c7ab55aa9012eacca16d1ed4c15795669e1c`

**TokenLogic**
Transfer and Stream: Total 250k GHO over 180 days from 1718673864
Address: `0x3e4A9f478C0c13A15137Fc81e9d8269F127b4B40`

TokenLogic and karpatkey are to be included in the Gas Rebate program that reimburses deployment and testings costs.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/70b12def0769deca4e39058c4df53ddfb389f95a/src/20240723_AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnershipPhase2/AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnershipPhase2_20240723.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/70b12def0769deca4e39058c4df53ddfb389f95a/src/20240723_AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnershipPhase2/AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnershipPhase2_20240723.t.sol)
- [Snapshot for TokenLogic + karpatkey - Phase II](https://snapshot.org/#/aave.eth/proposal/0xc44ec840f8f7f6ca3ef2f2a4289882c4cdc1a8b3e6e9ad6b811a640097a8016a)
- [Discussion](https://governance.aave.com/t/arfc-tokenlogic-karpatkey-financial-service-providers-phase-ii/18285)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
