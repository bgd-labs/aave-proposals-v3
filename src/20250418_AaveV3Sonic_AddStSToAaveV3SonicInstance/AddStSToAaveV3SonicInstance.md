---
title: "Add stS to Aave v3 Sonic Instance"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-add-sts-to-aave-v3-sonic-instance/21445"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xb49491fa374865c309723a992da4d2b1f24e96f310b8842a01cf6215a48e5c6d"
---

## Simple Summary

The proposal aims to onboard [Beets](https://beets.fi/)’s stS, to Aave v3 Sonic instance.

## Motivation

Launched in December 2024, Beets Staked Sonic (stS) is an ERC-20 Liquid Staked Token offering seamless exposure to Sonic network staking rewards via validator delegation, while remaining fully liquid in users’ wallets.

Similar to wstETH, stS passively accrues value—each time delegation rewards are added to the staking pool, the stS-to-S exchange rate increases automatically, with no action needed from holders. The underlying S delegation enhances Sonic’s decentralization across a [diverse set of validators](https://dune.com/queries/4534324/7569460) and strengthens the network’s economic security.

Previously known as sFTMx, the leading LST on Fantom Opera, stS quickly established itself as the kingmaker LST in the Sonic ecosystem, capturing over [12% of all staked S liquidity and 76% of S LST liquidity](https://www.defiwars.xyz/wars/sonic). Demand for leverage looping strategies using stS has been steadily rising, with over $160 million already deployed across other lending markets. Despite this strong demand for leveraged positions, stS has maintained a solid peg, currently trading at [99.72%](https://www.defiwars.xyz/wars/sonic).

Users can easily convert their S into stS via the [Beets minting UI](https://beets.fi/stake) and redeem their stS with a 14-day unbonding period. Alternatively, they can trade stS directly on any of the following DEXs:

- [Odos](https://www.odos.xyz/)
- [Beets](https://beets.fi/swap/sonic/0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee)
- [Shadow](https://www.shadow.so/trade)

### Security Considerations

Security is at the forefront of stS operations. Beets Staked Sonic was launched in December 2024, with its contracts originally audited by [Spearbit](https://cantina.xyz/portfolio/71a6f59b-7533-4ae9-87c5-d1d1bf6d675a), and then further audited by [Trail of Bits](https://github.com/trailofbits/publications/blob/master/reviews/2025-01-beethovenx-sonicstaking-securityreview.pdf) in January. Beets maintains an Immunefi bug bounty of up to $200,000.

Regarding Oracles stS currently integrates a Redstone, Pyth, and Stork stS/S price feed, with a Api3 and Chainlink Oracle integration currently being worked on. Aave will use a CAPO oracle leveraging chainlink’s infrastructure.

### Beets in numbers

Beets Staked Sonic has seen continuous growth since launching on December 16th 2024, with 138.65m S and $86.20m currently staked within the protocol.

Beets Staked Sonic is growing at a steady rate and is currently the number one spot by TVL on [Defillama](https://defillama.com/protocols/Liquid%20Staking/Sonic) for LST projects on Sonic, with over 3.4x as much TVL as the second largest protocol:

Beets also runs a DEX on Sonic, resulting in it being the 2nd largest source of TVL across [all protocols](https://defillama.com/chain/Sonic) on Sonic:

### Points program

Due to both the underlying exposure to APR (currently ~5%), and the current Sonic points program which offers 4x passive points and 8x activity points on stS, S borrows vs stS have a seen continuous growth with users seeking efficient means to leverage capital.

Being the largest LST on the network, stS is integrated into a variety of protocol verticals, including DEXs, Vaults, Yield Tokenization, and Lending markets:

- [Spectra](https://app.spectra.finance/pools/sonic:0xb2b0b641af3efbb495837323f74d962c534c1f51)
- [Shadow](https://www.shadow.so/liquidity)
- [Beefy](https://app.beefy.com/)
- [Stability](https://stability.farm/vaults/vault/146/0x709833e5b4b98aab812d175510f94bc91cfabd89)
- [Vicuna](https://vicunafinance.com/vaults)
- [Silo v2](https://v2.silo.finance/)
- [Euler](https://app.euler.finance/vault/0x2De851E60e428106fC98fE94017466F8D71793d1?network=sonic)
- [Stablejack](https://app.stablejack.xyz/markets/stS/token?name=yield)

### Benefits of listing Beets Staked Sonic

Adding lending and borrowing support for stS on Aave would allow users to supply, borrow, and leverage Sonic’s flagship LST.

A dedicated stS market on Aave’s Sonic deployment would drive meaningful TVL growth and generate additional revenue for the Aave DAO through active S loans and liquidations. This integration would also position Aave as the go-to venue for risk-adjusted capital efficiency, enabling advanced looping strategies while providing exposure to Sonic points.

It’s worth noting that Beets also operates a DEX on Sonic, powered by Balancer technology. Beets contributors operate as technical Service Providers to the Balancer DAO and have played a key role in the development and deployment of [100% Boosted Pools](https://www.theblock.co/post/330379/balancer-v3-launches-aave), which have successfully re-hypothicated over [$50M](https://balancer.fi/pools?poolTags=BOOSTED) in liquidity to Aave.

With the launch of Aave on Sonic, Beets will deploy Aave Boosted Pools, creating a highly efficient mechanism for simultaneously growing Aave’s supply-side liquidity and strengthening Sonic Swap markets.

Alongside stablecoin liquidity such as USDC.e, scUSD and GHO, an stS | S Boosted Pool would likely see strong adoption from Sonic users—helping bootstrap supply while keeping borrowing costs low in leverage markets.

### Proof of Liquidity (POL) and Deposit Commitments

As mentioned, Beets can deploy Aave Boosted Pools to help seed Aave’s capital markets on Sonic. While Beets would not directly supply stS or S POL to Aave, it would deposit POL from the DAO treasury into these pools, effectively routing 100% of capital straight to Aave.

Additionally, Beets is in discussions with Sonic Money Managers regarding the bootstrapping of the stS market through stS <> S looping strategies, as well as Boosted Pool POL deposits. Specific amounts will be determined in collaboration with the Aave team and the ACI.

## Specification

The table below illustrates the configured risk parameters for **stS**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (stS)          |                                 30,000,000 |
| Borrow Cap (stS)          |                                          1 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       66 % |
| LT                        |                                       68 % |
| Liquidation Bonus         |                                       10 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                       10 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x5BA5D5213B47DFE020B1F8d6fB54Db3F74F9ea9a |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://sonicscan.org/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for stS and the corresponding aToken.

**stS/wS Liquid E-mode Configuration**

| **Parameter**         | **Value** | **Value** |
| --------------------- | --------- | --------- |
| Asset                 | stS       | wS        |
| Collateral            | Yes       | No        |
| Borrowable            | No        | Yes       |
| Max LTV               | 87%       | -         |
| Liquidation Threshold | 90%       | -         |
| Liquidation Bonus     | 1%        | -         |

**CAPO**

| **maxYearlyRatioGrowthPercent** | **ratioReferenceTime** | **MINIMUM_SNAPSHOT_DELAY** |
| ------------------------------- | ---------------------- | -------------------------- |
| 11.04%                          | monthly                | 7                          |

## References

- Implementation: [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250418_AaveV3Sonic_AddStSToAaveV3SonicInstance/AaveV3Sonic_AddStSToAaveV3SonicInstance_20250418.sol)
- Tests: [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250418_AaveV3Sonic_AddStSToAaveV3SonicInstance/AaveV3Sonic_AddStSToAaveV3SonicInstance_20250418.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xb49491fa374865c309723a992da4d2b1f24e96f310b8842a01cf6215a48e5c6d)
- [Discussion](https://governance.aave.com/t/arfc-add-sts-to-aave-v3-sonic-instance/21445)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
