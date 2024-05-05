---
title: "Aave V1 Deprecation Phase 3"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/temp-check-bgd-further-aave-v1-deprecation-strategy/15893/7"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x7451f00809986c7cb8cce7ef4587efdfedad06089ebf2851d64122d00b035d9c"
---

## Simple Summary

Approve further steps of Aave v1 off-boarding, to reduce operational overhead on deprecated Aave instances.

## Motivation

The Aave protocol v1 was released in January 2020 and eventually superseded by Aave protocol v2 in December on the same year.

While Aave v1 has been deprecated for a long time, some liquidity is still stuck on the protocol 1. Even if this instance is not covered by the Aave Safety Module, being part of Aave, it still is monitored and evaluated whenever development and/or security decisions are made.

This creates meaningful overhead for all involved development & security teams, which directly adds cost to the Aave DAO. Additionally, the architecture of Aave v1 is quite different to Aave v2 & v3, making it the most ad-hoc instance of Aave.

On [6th of february](https://vote.onaave.com/proposal/?proposalId=15) a first set of measures was implemented by the DAO to accelerate the offboarding process, followed by a second proposal on [3th of march](https://vote.onaave.com/proposal/?proposalId=37&ipfsHash=0xa451c9a2426267673fd125702c99581683426ca5ff1a003b07a3cd129ed30470).

This `Phase 3` is the final phase of the off-boarding as suggested on the [forum](https://governance.aave.com/t/temp-check-bgd-further-aave-v1-deprecation-strategy/15893/7) with some slight modifications:

- the proposal does not inject capital to core. The rational being that:
  - there is enough liquidity for even the biggest account of each asset to withdraw.
  - it's not possible to calculate the **exact** amount of bad debt as some of the debt is collateralized with a basket of relatively small collateral positions.
  - if a situation in which a user cannot withdraw due to liquidity constrains ever occurs the treasury managers can easily inject capital at any point.
- the proposal also replaces the stable asset oracles with the capo oracles introduced on [aave v2](https://vote.onaave.com/proposal/?proposalId=82&ipfsHash=0x4886864ed1dc6cb220f17cd372697218cbb5c2ada41e63d6a1f7664168d59052) for consistency across the pools.

## Specification

Upon execution the proposal upgrades the following contracts:

- POOL: in order to disable all actions, but liquidation, repay & withdraw
- POOL_CORE: in order to update the index upon IR updates
- POOL_LIQUIDATION_MANAGER: in order to increase the static liquidation penalty from 3% to 5%, while reducing the gas overhead

Also, the proposal will change the pool configuration:

- all reserves interest rate strategies will be replaced with a zero interest rate strategy
- the stablecoin oracles are replaced with the capped oracles also used on ethereum v2

## References

- Implementation: [AaveV1Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/016fe7db25ffa0de51b283fc2574762af7aea9e3/src/20240502_AaveV1Ethereum_AaveV1Deprecation/AaveV1Ethereum_AaveV1Deprecation_20240502.sol)
- Tests: [AaveV1Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/016fe7db25ffa0de51b283fc2574762af7aea9e3/src/20240502_AaveV1Ethereum_AaveV1Deprecation/AaveV1Ethereum_AaveV1Deprecation_20240502.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x7451f00809986c7cb8cce7ef4587efdfedad06089ebf2851d64122d00b035d9c)
- [Discussion](https://governance.aave.com/t/temp-check-bgd-further-aave-v1-deprecation-strategy/15893/7)
- [Upgraded V1 Contracts](https://github.com/bgd-labs/v1-offboarding)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
