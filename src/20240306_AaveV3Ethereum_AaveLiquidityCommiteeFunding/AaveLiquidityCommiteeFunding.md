---
title: "Aave Liquidity Commitee Funding"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-aave-liquidity-committee-funding/16793"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xd6229e068e755336339bd8a314136e18ef00b22a95430476b6fa3665e9300548"
---

# Summary

This publication proposes funding the Aave Liquidity Committee with 500k GHO to continue supporting GHO's liquidity and DeFi integrations over the next 3 months.

# Motivation

Since its initial [funding in October 2023](https://governance-v2.aave.com/governance/proposal/343/), the Aave Liquidity Committee (previously GLC) has actively supported GHO liquidity across various DEXes by deploying and incentivising liquidity pools.

As a result of these efforts:

- Deeper on-chain liquidity
- Lower slippage, especially for GHO to USDC swaps

In combination with other efforts like stkGHO, ALC's initiatives have played a critical role in supporting GHO's peg recovery.

Throughout the period, the ALC leveraged on both Uniswap v3 and, more frequently, Maverick to tailor liquidity distribution at specific price ranges which helped absorb GHO downward market volatility. A list of active Boosted Positions can be found [here](https://app.mav.xyz/boosted-positions?chain=1).

While some pools are incentivised by voting with pre-existing DAO holdings (e.g. vlAURA), others like Maverick's concentrated liquidity Boosted Positions require additional expenses. It is worth noting, the Aave DAO is expected to benefit from the next airdrop by Maverick. We expect Maverick, and potentially Merkle on Uniswap v3, to remain key tools for supporting tailored liquidity shaping efforts in provided peg resilience.

Concentrated GHO liquidity was [recently introduced in Balancer](https://twitter.com/GyroStable/status/1757365157917815001) with the creation of several E-CLP pools. These pools are being jointly incentivised with use to the Aave DAO's vlAURA holding. When there is excess vlAURA votes, these votes have been delegated to Paladin in return for approximately 70% APR nominated in USDC.

The following charts depict some of the impact these efforts had on GHO's ecosystem, highlights:

- GHO/USDC Maverick pools captured most of the volume
  - 0.2% bin width pool processed most of the volume during high volatility period
  - 0.1% bin width pool is starting to replace the 0.2% bin width pool trading volume. This is due to incentive efforts shifting to Boosted Positions within the 0.1% bin width pool to create deeper liquidity and reducing price volatility
- GHO/USDC/USDT Balancer provides continuous yield source for LP
  - Trading volumes and TVL on Balancer are expected to increase when the BPT is integrated by [other protocols](https://twitter.com/Matthew_Graham_/status/1762076544241955070) and leveraged farming is introduced
- Gyrsocope E-CLP pools on Balancer are starting to capture a larger share of the market volume in recent weeks
  - As the peg improves, one pool will be retained and the dual token deposit requirement will help provide resilience for the peg

The next chapter for GHO focuses on the following key areas:

- 1.00:1.00 peg with USD
- Reducing price volatility
- Deeper liquidity to support DeFi integrations
- Grow non stable-coin-paired liquidity pools
- Targeted liquidity distributions to support Borrow Cap increases

These efforts will need to scale to match GHO's expected growth profile. The primary liquidity pools are to remain stable coins, and we expect to introduce other asset pairs in the future, as well as participation in the launch of various projects like [Ethena](https://app.ethena.fi/liquidity) and [f(x) Protocol's launch](https://x.com/protocol_fx/status/1762822716854354015?s=20).

Though there is inherent uncertainty in future stable coin rates, price volatility, and upcoming opportunities for new DeFi integrations, we believe a high-level budget will look like the following:

| Objective         | Category       | Budget   |
| ----------------- | -------------- | -------- |
| Liquidity         | Peg Resilience | 360k GHO |
| DeFi Integrations | Create Utility | 140k GHO |
| Total             |                | 500k GHO |

It is important to note that this estimation excludes efforts to drive GHO liquidity or integrations beyond Ethereum.

# Performance Indicators

The below details some high level GHO metrics we propose tracking:

| Description                    | Optimal Value                                                                      |
| ------------------------------ | ---------------------------------------------------------------------------------- |
| TVL DEX Liquidity Pools        | 50M                                                                                |
| TVL in Utility Liquidity Pools | 15M excl. stkGHO                                                                   |
| DEX Liquidity Composition      | < 50% GHO (< 33% for 3pools)                                                       |
| Swap Price Impact $5M Swap     | < 0.10% (GHO to USDC)                                                              |
| Annualised Peg Volatility      | < 5.00%                                                                            |
| Price level for > 90% time     | $0.995 using [Redstone Medium Price](https://app.redstone.finance/#/app/token/GHO) |

Please note, each of the above targets has external dependencies beyond the control of the ALC. The above table serves as a North Star for the ALC to strive towards over the next 3 months on the assumption the Borrow Cap is continually increased beyond the current 35M Bucket Size. Having measurable targets provides a clear direction and goal to achieve.

The [stkGHO implementation](https://app.aave.com/staking), [USDe integration](https://app.ethena.fi/liquidity) and coordinated efforts to attract users to acquire GHO are all great examples of how growth initiatives drive GHO utility, adoption and have a positive impact the spot price.

Each of the above metrics, plus more, will be shown on the TokenLogic analytics dashboard.

# Specification

Swap the following assets for GHO:

- Withdraw 250k Aave V2 USDT from the collector
- Withdraw 250k Aave V2 USDC from the collector
- Swap 250k USDT withdrawn above for GHO
- Swap 250k USDC withdrawn above for GHO

Create an allowance of 500k GHO to ALC SAFE.

ALC SAFE: `0x205e795336610f5131Be52F09218AF19f0f3eC60`

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/e7ca7963d0ae0f766845ff30ab4ff17650be0823/src/20240306_AaveV3Ethereum_AaveLiquidityCommiteeFunding/AaveV3Ethereum_AaveLiquidityCommiteeFunding_20240306.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/e7ca7963d0ae0f766845ff30ab4ff17650be0823/src/20240306_AaveV3Ethereum_AaveLiquidityCommiteeFunding/AaveV3Ethereum_AaveLiquidityCommiteeFunding_20240306.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xd6229e068e755336339bd8a314136e18ef00b22a95430476b6fa3665e9300548)
- [Discussion](https://governance.aave.com/t/arfc-aave-liquidity-committee-funding/16793)

# Disclosure

TokenLogic and karpatkey receive no payment for this proposal. TokenLogic and karpatkey are both delegates within the Aave community.

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
