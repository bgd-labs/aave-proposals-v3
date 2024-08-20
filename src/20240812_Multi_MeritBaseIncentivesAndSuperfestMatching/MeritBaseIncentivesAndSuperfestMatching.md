---
title: "Merit Base Incentives and Superfest Matching"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-merit-base-incentives-and-superfest-matching/18450"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x15cbc6b6c5b4ef76a1fb8cf8747460bf327c459fa01b69907fab0119457939a8"
---

## Simple Summary

This AIP seeks to plan and implement an incentive program on Base with the goal of increasing Aave’s market share and matching additional incentives from Optimism foundation. The program will involve the following key actions:

1. Inclusion of Base in Merit boosters for round 7
2. Incentives matching, up to 150k OP, (at max $2 per OP)

These will be in service of the eventual launch of GHO on Base and Umbrella coverage of aUSD and awETH for Aave v3 Base.

## Motivation

The primary motivation behind this proposal is to strengthen Aave’s position on Base by leveraging incentive programs that can attract more users and liquidity.

The addition of Superfest incentives and weETH has been a success and push Aave v3 to the largest lending protocol on Base. To continue momentum, this proposal will allocate Merit program incentives as well as additional incentives given by Optimism Foundation. These include incentives from Superfest and Optimism’s Retro Grants Round 4.

Base will be a good network to continue expansion of GHO and the upcoming Umbrella coverage program. By deploying GHO and providing umbrella coverage for key assets, as well as including Base in the Merit program, Aave can capitalize on the growth potential of the Base ecosystem. Additionally, offering matching incentives will help align with Superfest and further drive user engagement.

The GHO and Umbrella deployments will take some time, so we propose starting with initial Merit incentives to continue attracting liquidity to the network ahead of these launches.

Incentives will be set up as follows:

- Supply wETH will receive all OP incentives from Superfest program.
- Borrow USDC will receive USDC incentives funded by the Merit program.

## Specification

1. **Inclusion of Base in Merit:**

- Add Base to the Merit program to recognize and reward users who contribute to the growth and stability of the Aave ecosystem on Base this will be done by the ad-hoc proposal to create new boosters in round 7.

2. **Incentives Matching:**

- Match incentives up to 150k OP (Optimism tokens), with a maximum value of $2 per OP. This will provide additional motivation for users to engage with Aave on Base and align Aave DAO with the Superchain ecosystem.
- This will be funded with 100,000 USDC first batch, sourced from the Aave Collector on Base to be “reinvested” in the ecosystem.
- The ACI treasury will receive allowance for a total of 200,000 USDC from the Mainnet collector contract, and will be responsible from claim and bridging this funds to match futher incentives from the superfest program up to a total of 300k$
- to allow this LM program, the AIP will appoint the ACI multisig `0xac140648435d03f784879cd789130F22Ef588Fcd` as emission_admin to handle the distribution on behalf of the DAO
- The ACI multisig will be whitelisted for USDC, aUSDC, wETH and aWETH tokens as rewards tokens to allow for some flexibility in distribution.

We invite Aave Finance service providers to finance the remaining amount according to Superfest matching.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/5c2397e4f7acf16aea0a7f86a21fdebfaf74986e/src/20240812_Multi_MeritBaseIncentivesAndSuperfestMatching/AaveV3Ethereum_MeritBaseIncentivesAndSuperfestMatching_20240812.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/5c2397e4f7acf16aea0a7f86a21fdebfaf74986e/src/20240812_Multi_MeritBaseIncentivesAndSuperfestMatching/AaveV3Base_MeritBaseIncentivesAndSuperfestMatching_20240812.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/5c2397e4f7acf16aea0a7f86a21fdebfaf74986e/src/20240812_Multi_MeritBaseIncentivesAndSuperfestMatching/AaveV3Ethereum_MeritBaseIncentivesAndSuperfestMatching_20240812.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/5c2397e4f7acf16aea0a7f86a21fdebfaf74986e/src/20240812_Multi_MeritBaseIncentivesAndSuperfestMatching/AaveV3Base_MeritBaseIncentivesAndSuperfestMatching_20240812.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x15cbc6b6c5b4ef76a1fb8cf8747460bf327c459fa01b69907fab0119457939a8)
- [Discussion](https://governance.aave.com/t/arfc-merit-base-incentives-and-superfest-matching/18450)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
