---
title: "Aave Liquidity Committee Funding Phase VI"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-aave-liquidity-committee-funding-phase-vi/21682"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x2af009587f8c624f798ec36e20572a69be7fc6321882b1ba19143da29d45f1ac"
---

## Simple Summary

This publication presents the Aave Liquidity Committee (ALC) Phase VI Funding request.

## Motivation

### Phase V Update

#### GHO Supply

Over the course of the last quarter, the market dynamics surrounding GHO experienced a notable shift. As yield opportunities in the broader DeFi landscape became less attractive due to declining funding rates, users began redirecting their capital in search of alternative sources of return.

GHO, particularly through its liquidity provision use cases, emerged as a compelling destination. This resurgence in interest was further reinforced by the reactivation and full replenishment of the GSMs, which had previously been nearly emptied. These modules went from holding negligible balances to over $28M in total during the period.

![Screenshot 2025-04-03 at 20.01.51](https://hackmd.io/_uploads/BkpQj8ha1e.png)

### Ethereum

#### DEX Liquidity

On Ethereum, GHO's peg has been resilient and consistent during Q1 of 2025 and the deeper DEX liquidity has enabled larger swap sizes to be processed with minimal price impact.

With perp funding rates and broader DeFi liquidity costs trending lower, Liquidity Provider (LPs) deposits across GHO DEX pools experienced significant growth, surpassing $85M.

![Screenshot 2025-04-03 at 19.28.53](https://hackmd.io/_uploads/HJs_7Un6kl.png)

In addition, USDT volatility helped grow GSM TVL to over $28M, ensuring continuous, on-demand support for GHO's peg.

![Screenshot 2025-04-03 at 19.37.44](https://hackmd.io/_uploads/rJUtSIh6yg.png)

#### Balancer v3

GHO became the centerpiece asset within the new generation of Balancer pools, reflecting its growing systemic importance. On Ethereum, the primary GHO 3pool successfully migrated to the v3 boosted model, is approaching $30M in TVL.

The new Aave Boosted 3pool has exceeded the previous v2 pool’s performance, whilst also delivering superior capital efficiency and deeper liquidity provisioning. On Arbitrum liquidity was migrated from v2 to v3 liquidity and new v3 pools created on Base.

On Arbitrum and Base, these pools incorporated the new “surge” pricing mechanism, which dynamically increases swap fees as the pool diverges from the peg. This mechanism adds an additional layer of price defense, reinforcing the GHO's peg on L2s.

![Screenshot 2025-04-03 at 19.43.34](https://hackmd.io/_uploads/HJQywLh6Jl.png)

#### Prime Instance

Another major milestone during Phase V was the introduction of the GHO and the Gho Mint facilitator on the Prime instance. This new market brought new multifaceted utility to GHO.

- Created a structure in which GHO could be pre-minted and held by the DAO, providing operational flexibility and improving responsiveness to market demand.
- Enables GHO to earn yield directly through variable-rate borrow mechanisms, enabling more capital-efficient stablecoin management.
- Unlocked additional yield opportunities for Balancer v3 pools to deposit into, incentivizing further liquidity provisioning.

Lastly, the Prime instance permitted a portion of the GHO allowances allocated to service providers and ecosystem initiatives to be deposited into yield-bearing positions, improving overall capital efficiency of the assets held in the DAO's treasury.

![Screenshot 2025-04-03 at 19.46.58](https://hackmd.io/_uploads/S1G3vI261g.png)

#### Fluid and Rings Integration

Fluid has been whitelisted to be the home of GHO from the backing of scUSD. It has grown to over 6M without incentive on Fluid directly with a very low acquisition cost due to a deposit campaign featuring Bungee to encourage GHO deposits in Rings.

Over the coming weeks, Rings is expected to onboard Gearbox by Veda. As GHO deposits continue to grow, GHO liquidity is expected to be distributed across Fluid and Gearbox.

Reference: https://x.com/Token_Logic/status/1905352281027166589

#### PYUSD/GHO Liquidity

7.5M liquidity was sourced for the PYUSD/GHO Balancer v3 liquidity pool.

#### Resolv Collaboration

One of the most innovative integrations of the quarter was GHO’s entry into the Resolv ecosystem. In collaboration with Resolv, the ALC deployed a campaign centered on the Curve GHO/USR LP token, and worked with both Pendle and Spectra to create yield markets enabling the ALC to receive a higher ROI on bribe spend, ~x2.2-2.4 multiplier compared to x1.1-1.3 directly on DEXs.

This was a great success knowing that no other asset of its kind had previously gained such traction in structured yield products. The campaign was enhanced by a one-month point-boost from Resolv, supplemented by strategic incentives from the ALC. The result was unprecedented: the initiative led to the formation of the largest GHO and USR liquidity pools, reaching up to $35 million in TVL.

![Screenshot 2025-04-03 at 19.48.37](https://hackmd.io/_uploads/Sk_zuLhTJg.png)

#### Arbitrum

Despite the broader success seen on Ethereum and Base, GHO’s growth on Arbitrum remains modest. The lack of meaningful traction can be attributed to delays in strategic integrations, most notably the anticipated collaboration with Synthetix, which ultimately opted to shift its primary focus and development efforts to the Base network. As a result, the GHO ecosystem on Arbitrum has yet to reach critical mass, although foundational infrastructure remains in place for future expansion.

#### Base

Phase V also saw the deployment of GHO on Base, a move that has already begun to bear fruit. GHO’s main liquidity pool on Base, the Balancer v3 GHO/USDC pool, has surpassed $13.5 million in TVL within a relatively short period. This rapid growth reflects strong initial interest and suggests high potential for deeper integrations. One such opportunity lies in the upcoming collaboration with Synthetix, which is now in advanced planning stages with Odos soon to integrate the stataToken factory enabling the waBasGHO integration to advance with Synthetixs.

## Phase VI Lookahead

### Ethereum

GHO has already secured a strong presence on Ethereum mainnet, with integrations across a wide range of protocols. It is now actively used within lending protocols such as Gearbox and Fluid, offering users capital-efficient strategies centered on GHO. In the DEX landscape, GHO is supported across Balancer, Curve, Maverick, and Fluid, demonstrating its growing utility and liquidity footprint across various automated market makers.

GHO will remain at the front stage of Ethereum's DeFi, ALC members are actively looking for collaboration with promising projects at early stage to give access to interesting opportunities for GHO holders. The latest best example was the Resolv collaboration. This will continue during Phase VI as well.

#### L2s and Multichain Strategies

A core priority for Phase VI will be the continued development of GHO’s multichain strategy, centered around the use of one facilitator on mainnet, the use of the CCIP bridge, and the implementation of GSMs on destination chains. These Stability Modules will be pre-filled by the mainnet facilitator, enabling native swaps into GHO on arrival chains and eliminating the need for inefficient bridging.

This architecture significantly enhances capital efficiency by allowing users to mint or swap GHO directly on their preferred chain. It also addresses one of the key friction points observed in Phase V, as bridging has proven to be a major brake on growth. By enabling native, trust-minimized GHO access across chains, the stataGSMs will remove barriers to adoption and improve user experience across ecosystems.

The modified stataGSM is currently in the last stages of review with @TokenLogic and @AaveLabs.

#### Sonic, Avalanche and Gnosis

Three key chains are being targeted for GHO deployment in the near future: Sonic, Avalanche, and Gnosis. Each of these networks offers a unique opportunity to tailor GHO’s integration to the strengths of the local ecosystem.

On Sonic with @TokenLogic leading the deployment, the ALC plans to position GHO at the heart of one of the most innovative DeFi environments currently emerging. The goal is to create strong synergies with leading protocols such as Pendle, Rings, Beets, and Silo. Sonic offers a highly composable, fast-moving landscape where GHO can fit perfectly.

On Avalanche, with @AaveLabs leading the deployment, GHO will benefit from the support of the Avalanche Foundation, which is preparing to launch new incentive programs at the chain level. The ALC is working to ensure that GHO is a key participant in these initiatives. The playbook established with Balancer v3 on Ethereum may be replicated here, with additional attention to exploring synergies with Avalanche’s native stablecoin AUSD. This deployment will be focused on ecosystem-wide coordination.

On Gnosis, the vision is centered on integrating GHO into the Gnosis Card ecosystem. The objective is to streamline both on- and off-ramping processes. The ALC will work closely with KPK and the Gnosis Foundation to facilitate this integration, creating a seamless user experience for payments, transfers, and financial access via GHO on Gnosis.

### Performance Metrics

The below details some high-level GHO metrics:

| Description                                |           Ethereum           |           Arbitrum           |          Avalanche           |             Base             |
| ------------------------------------------ | :--------------------------: | :--------------------------: | :--------------------------: | :--------------------------: |
| TVL DEX Liquidity Pools                    |             85M              |             10M              |             10M              |             20M              |
| TVL Utility Liquidity Pools (Excl. stkGHO) |             15M              |              5M              |              5M              |              5M              |
| DEX Liquidity Composition                  | < 50% GHO (< 33% for 3pools) | < 50% GHO (< 33% for 3pools) | < 50% GHO (< 33% for 3pools) | < 50% GHO (< 33% for 3pools) |
| Swap Price Impact $5M Swap (GHO to USDC)   |           < 0.10%            |           < 0.25%            |           < 0.25%            |           < 0.25%            |
| Annualised Peg Volatility                  |           < 5.00%            |           < 5.00%            |           < 5.00%            |           < 5.00%            |
| Price level for >90% time                  |            $0.995            |            $0.995            |            $0.995            |            $0.995            |

Please note, each of the above targets has external dependencies beyond the control of the ALC. The above table serves as a North Star for the ALC to strive towards over the next three months. Having measurable targets provides a clear direction and goal to achieve.

## Specification

Create allowance for the ALC to withdraw 3,500,000 GHO from the Ethereum collector.

ALC Ethereum SAFE: `0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b`

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/e44edff6d616bd1f2073339c00b13acbf13d5f56/src/20250410_AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseVI/AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseVI_20250410.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/e44edff6d616bd1f2073339c00b13acbf13d5f56/src/20250410_AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseVI/AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseVI_20250410.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x2af009587f8c624f798ec36e20572a69be7fc6321882b1ba19143da29d45f1ac)
- [Discussion](https://governance.aave.com/t/arfc-aave-liquidity-committee-funding-phase-vi/21682)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
