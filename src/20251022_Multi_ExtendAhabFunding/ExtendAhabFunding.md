---
title: "Extend Ahab Funding"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-extend-ahab-funding/23213/2"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xa1cb3c88f8c30a05dca3c767a60abc31b4f48fe36a4175f421ac0f2e8ab7dbac"
---

## Simple Summary

In collaboration with Aave’s Growth teams, this proposal introduces a flexible funding mechanism to support incentive commitments made by Service Providers in the establishment of strategic partnerships.

## Motivation

In recent months, Aave DAO Service Providers have secured a number of strategic opportunities that reinforce Aave Protocol’s leadership position across the broader DeFi ecosystem. These initiatives align with the _Road to 80%_ north star and are designed to ensure sustainable medium-term growth. Partnerships with Kraken, Binance, Plasma, X Layer, and others each require a level of DAO contribution during their initial bootstrapping phases.

To reduce governance overhead from repeated, one-off funding requests, this proposal introduces a flexible funding mechanism that supports bootstrapping efforts across key ecosystems while strengthening Aave’s market presence. With Plasma, Ink, X Layer, and other deployments already live or nearing launch, this proposal seeks to make near-term funding available as a wider, long-term framework is prepared. Importantly, it aims to address immediate operational priorities.

With a preference to retain ETH and distribute rewards in GHO where practical—or in assets aligned with each bootstrapped market—the proposal adjusts Ahab’s budget to better support near-term growth. This approach increases flexibility in how the DAO’s capital is deployed. For example, the DAO may borrow capital at near-zero cost (in GHO), distribute incentives to users while continuing to earn yield on existing stablecoins (e.g., USDT0 on Plasma), and later use protocol revenue (e.g., GHO on Core) to settle liabilities. This structure enables the DAO to capture yield on idle assets while efficiently managing funding costs.

By maintaining sufficient collateral and conservative health factors, the DAO gains improved cashflow management flexibility. Through the distribution of GHO, new user segments are introduced to the stablecoin, with future GHO revenue expected to offset liabilities. If required, additional allowances—such as those detailed in the Specification—can be utilised to manage Aave’s positions and support the GHO peg when necessary.

With prudent oversight and existing safeguards, the Aave Finance Committee (AFC) can actively optimise swap timing and manage liquidity to balance stability and growth across the ecosystem.

## Specification

Upon AIP execution, this proposal implements the following actions:

### Aave Helper Asset Budget (Ahab)

**Ethereum**

- **Asset:** aEthWETH — `0x4d5F47FA6A74757f35C14fD3a6Ef8E3C9BC514E8`
- **Amount:** 6,000
- **Spender:** Ahab — `0xAA2461f0f0A3dE5fEAF3273eAe16DEF861cf594e`
- **Method:** `approve()` aEthWETH on the Aave Collector contract to the Ahab address

**Plasma (USDT0)**

- **Asset:** aPlaUSDT0 — `0x5D72a9d9A9510Cd8cBdBA12aC62593A58930a948`
- **Amount:** 3,000,000
- **Spender:** Ahab — `0xAA2461f0f0A3dE5fEAF3273eAe16DEF861cf594e`
- **Method:** `approve()` aPlaUSDT0 on the Aave Collector contract to the Ahab address

**Plasma (USDe)**

- **Asset:** aPlaUSDe — `0x7519403E12111ff6b710877Fcd821D0c12CAF43A`
- **Amount:** 2,000,000
- **Spender:** Ahab — `0xAA2461f0f0A3dE5fEAF3273eAe16DEF861cf594e`
- **Method:** `approve()` aPlaUSDe on the Aave Collector contract to the Ahab address

**Ethereum (GHO)**

- **Asset:** aEthGHO — `0x00907f9921424583e7ffBfEdf84F92B7B2Be4977`
- **Amount:** 10,000,000
- **Spender:** Ahab — `0xAA2461f0f0A3dE5fEAF3273eAe16DEF861cf594e`
- **Method:** `approve()` aEthGHO on the Aave Collector contract to the Ahab address

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251022_Multi_ExtendAhabFunding/AaveV3Ethereum_ExtendAhabFunding_20251022.sol), [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251022_Multi_ExtendAhabFunding/AaveV3Plasma_ExtendAhabFunding_20251022.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251022_Multi_ExtendAhabFunding/AaveV3Ethereum_ExtendAhabFunding_20251022.t.sol), [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251022_Multi_ExtendAhabFunding/AaveV3Plasma_ExtendAhabFunding_20251022.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xa1cb3c88f8c30a05dca3c767a60abc31b4f48fe36a4175f421ac0f2e8ab7dbac)
- [Discussion](https://governance.aave.com/t/arfc-extend-ahab-funding/23213/2)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
