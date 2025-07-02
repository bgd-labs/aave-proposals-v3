---
title: "Chaos Labs x Aave DAO — Early Renewal Proposal"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/chaos-labs-x-aave-dao-early-renewal-proposal/22346"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x9722b9690b52a159c0f6d9fb9fe805390031573d87e89a77fe90888f27ab0c3c"
---

## Simple Summary

## Motivation

[quote="ChaosLabs, post:1, topic:22346"]
Chaos Labs proposes a **12-month early renewal** of our risk management partnership with the Aave DAO, starting July 13, 2025. This renewal will be a **new and separate engagement stream**, operating **in parallel with the current engagement**, which remains active through November 12, 2025. The early renewal will **not affect the existing engagement** and will continue independently through July 12, 2026.

This proposal reflects both the expanded scope of work already delivered—including support for new asset classes, implementation of systemic risk mechanisms, and over 1,100 risk parameter updates—and Chaos Labs’ continued commitment to building critical components of Aave’s risk infrastructure.

Our top priority for the upcoming term is the deployment and scaling of the Edge Risk Oracle, which currently secures over $5B in deposits and dynamically manages supply caps, borrow caps, interest rate curves, and PT parameters. Significant functional expansions are underway to further automate and strengthen the protocol’s risk systems.

We are seeking DAO alignment on this strategic direction and resource allocation to ensure the sustained delivery, scalability, and decentralization of Aave’s risk management infrastructure.

### Background & Context

Chaos Labs was appointed by the Aave DAO in November 2022 as its dedicated risk partner and is currently operating under a 12-month engagement that began in November 2024. Since the start of this current term, Aave has experienced substantial growth—doubling its TVL from $12B to $24B and generating over $71.5M in protocol revenue. This rapid expansion has been accompanied by a surge in protocol complexity across assets, deployments, and mechanisms.

Over this same period, Aave has integrated or prepared for several major system upgrades: onboarding of Principal Tokens (PTs); deployment of mechanisms such as Smart Value Recapture (SVR); and the upcoming launch of Umbrella, Aave’s insolvency protection layer.

To meet these evolving needs, Chaos Labs has transitioned from periodic risk reviews to delivering deeply integrated, protocol-native risk automation infrastructure. At the core of this system is our Edge Risk Oracle architecture, which powers automated, governance-bounded updates to supply and borrow caps, interest rate curves, and Principal Token collateral parameters—actively securing over $5B in deposits across Aave markets. In parallel, we’ve expanded our real-time monitoring infrastructure, executed over 1,100 parameter updates via the Risk Stewards, and published targeted research on high-impact risk domains such as Ethereum validator staking penalties, Ethena-related risks, and SVR recapture dynamics.

As Aave prepares to onboard 10+ additional deployments and expand its asset coverage further, the protocol’s resilience and capital efficiency will depend on the continued development of a modular, data-driven risk layer. This renewal enables Chaos Labs to maintain and scale that infrastructure in lockstep with Aave’s accelerating trajectory.

### Enhanced Scope and Value Delivery Highlights

Despite renewing at flat commercials of **$2M** in November, Chaos Labs has significantly expanded its work’s scope, volume, and impact compared to the prior year, delivering substantially more value **without a budget increase**.

Over the past six months of the current engagement, Chaos Labs has provided both tactical execution and strategic risk support, surpassing last year’s outputs across all key metrics:

- **64 asset listing analyses** completed in the past 7 months (vs. 46 in the entire previous year), reflecting a sharp increase in volume and diligence scope.
- **13 new deployment listings**, with 10 scheduled to go live shortly, significantly expanding protocol reach and impact.
- **226 supply cap, 203 borrow cap, and 572 interest rate curve updates** executed through the Risk Stewards, scaling operational coverage.
- **260 total forum posts** spanning proposal authorship, parameter reviews, research, and real-time risk insights, reinforcing Chaos Labs’ governance leadership.

The quality and depth of asset listings have significantly evolved, centered on the fundamental characteristics of each asset and its interaction with Aave’s core mechanisms. Listings incorporate understanding how the asset functions within its native protocol, aligning risk parameters with issuer-specific designs such as redemption logic, staking mechanics, or rebase behavior at a technical level. These are paired with simulation-backed stress testing, modeling systemic interactions, market shocks, and protocol-specific failure modes to ensure resilient integration.

For contrast:

- Earlier listing: [oSETH onboarding](https://governance.aave.com/t/arfc-onboard-oseth-to-aave-v3-on-ethereum/16913/8)
- Current standard: [USR onboarding](https://governance.aave.com/t/arfc-add-usr-to-aave-v3-core-instance/21444/2)

#### Edge Risk Oracle Infrastructure

Chaos Labs has not only deployed a suite of Risk Oracles across the protocol—we have also designed the quantitative methodologies, triggers, and governance guardrails that underpin them. We are the only team in the industry offering end-to-end oracle-driven risk automation, combining bespoke modeling, real-time data integrations, and protocol-native controls.

- **WETH Interest Rate Curve Oracle** on the Prime Instance automatically adjusts Slope1 based on Lido staking rewards and the wstETH supply rate to preserve the profitability of looping strategies and optimize protocol revenues, accounting for $548M in deposits.↳ [[ARFC]. Aave Generalized Risk Stewards (AGRS) activation - #3 by ChaosLabs](https://governance.aave.com/t/arfc-aave-generalized-risk-stewards-agrs-activation/19178/3)
- **Supply & Borrow Cap Oracles** deployed across major V3 deployments (Avalanche, Arbitrum, Base), providing automated risk and utilization-aware cap adjustments for over $3.4B in total deposits.↳ [[ARFC] Supply and Borrow Cap Risk Oracle Activation](https://governance.aave.com/t/arfc-supply-and-borrow-cap-risk-oracle-activation/20834)
- **Principal Token (PT) Risk Oracle** for Pendle and similar assets—featuring quantitative parameterization and automated kill switch logic—now supporting over $1B in integrated PT assets.↳ [ARFC: PT Risk Oracle](https://governance.aave.com/t/arfc-pendle-principal-token-risk-oracle/20962)
- **Stablecoin Interest Rate Curve Risk Oracle**, approved via Snapshot, enabling dynamic interest rate optimization for stablecoin markets with improved efficiency.↳ [ARFC: Curve Oracle](https://governance.aave.com/t/arfc-interest-rate-curve-risk-oracle/21900)

#### Monitoring & Analytics

- Monitoring infrastructure has been significantly expanded, now tracking advanced metrics such as asset collateral distribution over time, user LTV at liquidation, and market liquidity concentration. Over the past six months, support has been extended to 5 additional deployments, bringing the total to 16, with imminent support for upcoming deployments underway.
  ↳ [Aave Risk Monitoring and Alerting Platform](https://community.chaoslabs.xyz/aave/risk/overview)
- **SVR Monitoring Platform**, launched to monitor SVR metrics and liquidation outcomes at a granular level, alongside SVR oracle performance.↳ [SVR Dashboard](https://community.chaoslabs.xyz/aave/risk/svr/liquidations)

#### Key Research Pieces

- **Ethereum staking risk modeling**, quantifying validator slashing impacts on LST/LRT performance and collateralization viability.↳ [Research Post](https://governance.aave.com/t/staking-penalties-on-ethereum-s-consensus-layer-implications-for-wsteth-and-other-lsts-and-lrts/21854)
- **Ethena-related risk simulations**, including funding volatility, depeg risk, and potential contagion scenarios.↳ [Simulation Post](https://governance.aave.com/t/arfc-susde-and-usde-price-feed-update/20495/16)
- **SVR analysis**, evaluating integration feasibility, revenue potential, and liquidation delay risks through detailed oracle delay and bad debt modeling.↳ [SVR Analysis](https://governance.aave.com/t/arfc-aave-chainlink-svr-v1-phase-1-activation/21247/7)

#### **Market Events**

- **Chaos Labs Risk Reports during market events** such as [02/03/25](https://governance.aave.com/t/chaos-labs-risk-report-insights-from-recent-market-events-02-03-25/20919) and [04/07/25](https://governance.aave.com/t/chaos-labs-risk-report-insights-from-recent-market-events-04-07-25/21719), providing real-time analysis of liquidation volume, user behavior, and Aave protocol performance under heightened volatility.
- **Chaos Labs post-mortem on the Bybit security event**, highlighting how CEX-driven price dislocations impacted oracle feeds and outstanding risks in the context of USDe and Ethena, and underscoring the need for more resilient on-chain pricing mechanisms.↳ [Post-Mortem](https://governance.aave.com/t/chaos-labs-update-on-bybit-security-event-and-usde-market-reaction/21158/2)

### Scope

- **Chaos Labs continuation of phased sUSD deprecation on Optimism**, building on prior recommendations in response to structural changes in Synthetix and persistent peg instability. This latest adjustment further tightens risk parameters to responsibly minimize exposure as part of an ongoing wind-down strategy.↳ [ARFC](https://governance.aave.com/t/arfc-further-deprecate-susd-on-aave-v3-optimism/21770)

#### Risk Oracle Infrastructure

Chaos Labs will continue to expand Aave’s Edge Risk Oracle infrastructure to cover additional critical risk surfaces and enhance protocol automation. Building on our existing deployments, the following areas are targeted for upcoming integration:

- **Expansion of Supply & Borrow Cap Oracles** to all Aave V3 instances, ensuring consistent and utilization-optimized cap management across deployments.
- **Deployment of Interest Rate Curve Oracles** across stablecoin and high-volume collateral markets, enabling real-time dynamic pricing to optimize protocol welfare and maintain competitive market conditions.
- **Ongoing Principal Token (PT) Risk Oracle coverage**, ensuring that all new PT listings are automatically supported with live collateral parameter adjustments, while maintaining existing integrations.
- **Automated Kill Switch Integration** for LSTs, LRTs, Ethena-related, and other yield-bearing derivatives, disabling supply or borrow functionality under adverse events such as validator slashing, depegs, or liquidity collapse.
- **Reserve Factor Risk Oracle**, to dynamically optimize DAO revenue through automated reserve factor tuning, aligned with Umbrella’s framework and responsive to shifting market dynamics and liquidity flows.

All updates will continue to be bound by governance-approved parameters and transparently tracked through public dashboards. This upcoming roadmap represents a significant step toward full-spectrum oracle-driven risk automation across the Aave ecosystem.

#### SVR & Real-Time Monitoring Infrastructure

Chaos Labs will continue to operate and enhance Aave’s real-time risk and monitoring infrastructure, which serves as the backbone of protocol-level visibility and operational responsiveness.

We will expand monitoring dashboards to support all future deployments, incorporating detailed liquidation performance analytics across collateral types and borrower segments. This includes real-time tracking of oracle deviations, recapture efficiency, and execution quality, enabling the DAO to evaluate the effectiveness of MEV recapture and broader liquidation outcomes.

Beyond SVR, our infrastructure will maintain wallet-level exposure analysis, surfacing risks related to position concentration, correlated collateral dependencies, and liquidation clustering potential. These insights will be paired with risk alerting systems, flagging real-time anomalies such as overutilized assets, depleted liquidity, or extreme funding dislocations.

We will also continue to publish live Oracle performance logs and full update histories for all automated parameter changes, including caps, LTVs, interest rates, and more. This ensures ongoing transparency, accountability, and governance alignment across all Chaos-managed automation layers within the Aave protocol.

#### Aave Umbrella: Deployment, Maintenance, Monitoring & Parameterization

Chaos Labs is leading the risk management and parameter calibration efforts for Aave Umbrella, a native insolvency protection mechanism that introduces a tranche structure to absorb bad debt under stress scenarios. Umbrella will enhance Aave’s systemic resilience by enabling structured risk-sharing and coordinated protection across markets and deployments.

During this engagement, we will focus on operationalizing Umbrella across active and upcoming deployments. This includes simulation-backed design of exposure caps, freeze conditions, and incentive structures tailored to the unique risk profile of each reserve.

We will provide ongoing support and insights to the Aave Finance Committee in calibrating key parameters such as:

- **`maxEmissionPerYear`**, which reflects the incremental yield required to compensate users for staking into Umbrella. Its calibration will account for factors including foregone collateral utility, prevailing interest rate environments, cooldown risk, and systemic exposure.
- **`Target Liquidity`**, representing the optimal reserve coverage needed to mitigate tail risks, derived using a quantitative Value-at-Risk (VaR) framework. This ensures efficient sizing of Umbrella participation across volatile and composable markets.

To support transparency and community alignment, we are also launching a dedicated Umbrella Dashboard, providing real-time analytics and visualizations on reserve coverage, parameterization status, and system-wide protection metrics.

Umbrella will serve as a key component of Aave’s systemic risk architecture, offering structured insolvency protection and capital efficiency across an increasingly complex multi-deployment environment.

#### Asset Listings & Adaptive Risk Management

As Aave continues to expand across new networks, asset types, and market structures, the protocol requires a more agile, simulation-driven risk framework capable of responding to a constantly evolving landscape. Chaos Labs will continue to lead risk onboarding and configuration for new assets and deployments, adapting to novel pricing mechanisms and composable integrations as they emerge.

Rather than relying solely on fixed parameter templates, our approach is dynamic and context-specific. We evaluate each asset and market instance on its own terms, factoring in liquidity, volatility, composability, and systemic impact. As Aave’s complexity increases, we ensure that risk management scales accordingly, applying both proactive simulations and real-time monitoring to inform governance-aligned recommendations.

All adjustments are implemented through the Risk Steward framework, enabling timely and bounded execution. Each action is paired with transparent rationale and tradeoff analysis, ensuring the community remains informed and aligned as the protocol grows in depth and reach.

#### GHO Risk Management

Chaos Labs will continue managing GHO risk through parameter tuning, peg monitoring, and facilitator oversight. With the launch of sGHO and the Aave Savings Rate (ASR), we are developing a comprehensive quantitative model to optimize ASR parameters—AMP, Premium, and Index Rate—ensuring yields remain competitive, sustainable, and resistant to arbitrage.

We will benchmark sGHO against comparable stablecoins, monitor user behavior, and propose adjustments as needed. All insights will be surfaced via our GHO Risk Dashboard, covering peg health, ASR dynamics, and facilitator activity in real time.

In parallel, we will maintain and expand monitoring of the GHO peg across centralized and decentralized exchanges, analyzing liquidity, volume, and spread behavior under various market conditions. We will continue onboarding support for new GHO facilitators, offering simulations and stress-testing of credit allocation models, collateral design, and associated systemic risk.

#### Incident Response & DAO Support

As Aave’s risk partner, Chaos Labs will remain on call to respond to major market events or protocol-level disruptions. These events may include oracle failures or feed manipulation, validator slashing incidents that impact collateral values, asset-specific volatility (e.g., USDe or stETH depegs), and coordinated liquidation events during systemic stress. With the ongoing integration of the Edge Risk Oracle infrastructure, many of these scenarios can now be proactively addressed through automated parameter adjustments and killswitch logic, reducing manual intervention and minimizing the risk of cascading failures.

Our incident response protocol includes rapid modeling of potential impact, simulation of mitigation paths, coordination with DAO stakeholders and Guardians, and publication of real-time risk updates with proposed governance actions. We will also produce post-incident reports that evaluate event triggers, parameter effectiveness, and potential upgrades to future protections.

Our role as an embedded operational risk steward ensures that Aave can respond with speed, confidence, and clarity when it matters most.

### Community Engagement & Governance

Chaos Labs will:

- Publish monthly updates summarizing progress, simulations, Oracle activity, and dashboard enhancements, which can be observed in [this](https://governance.aave.com/t/chaos-labs-monthly-community-update/11174/27) thread.
- Remain active on the Aave Governance Forum with posts, feedback, and proposal authorship
- Maintain weekly syncs with delegates and contributors
- Share dashboards, documentation, and analysis artifacts for community insight

### Early Renewal Commercial Terms

To ensure continuity and align long-term commitments, we propose executing an early renewal agreement, effective **July 13, 2025, with a 12-month term** running through July 12, 2026.

**This renewal will run concurrently with the existing contract until November 12, 2025, after which it will continue as the sole active agreement through its conclusion on July 12, 2026.**

This proposal reflects both the **expanded scope of work already delivered**—including support for new asset classes, implementation of systemic risk mechanisms, and over **1,100 risk parameter updates**—and Chaos Labs’ continued commitment to building critical components of Aave’s risk infrastructure.

## Specification

- **Renewal Term:** July 13, 2025 – July 12, 2026
- **Duration:** 12 Months
- **Annual Contract Value:** $3,000,000 USD
- 85% - $2,550,000 USD in aEthLidoGHO
- 15% - $450,000 USD in AAVE
  - AAVE price (and corresponding amount of tokens allocated to Chaos) will be determined using a 30-day time-weighted average price (TWAP) based on CoinGecko pricing at the time of Snapshot conclusion.
- **Payment Method:** Streamed linearly via `createStream()` using `IAaveEcosystemReserveController`
- **Recipient Address:** `0xbC540e0729B732fb14afA240aA5A047aE9ba7dF0` (Chaos Labs multisig)

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250625_AaveV3Ethereum_ChaosLabsXAaveDAOEarlyRenewalProposal/AaveV3Ethereum_ChaosLabsXAaveDAOEarlyRenewalProposal_20250625.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250625_AaveV3Ethereum_ChaosLabsXAaveDAOEarlyRenewalProposal/AaveV3Ethereum_ChaosLabsXAaveDAOEarlyRenewalProposal_20250625.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x9722b9690b52a159c0f6d9fb9fe805390031573d87e89a77fe90888f27ab0c3c)
- [Discussion](https://governance.aave.com/t/chaos-labs-x-aave-dao-early-renewal-proposal/22346)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
