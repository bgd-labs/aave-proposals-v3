---
title: "Aave V1 Deprecation"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/temp-check-bgd-further-aave-v1-deprecation-strategy/15893"
---

## Simple Summary

Approve further steps of Aave v1 off-boarding, to reduce operational overhead on deprecated Aave instances.
Therefore the proposal suggests to upgrade the pool logic to allow liquidation of healthy positions with a fixed 1% bonus.

## Motivation

The Aave protocol v1 was released in January 2020 and eventually superseded by Aave protocol v2 in December on the same year.

While Aave v1 has been deprecated for a long time, some liquidity is still stuck on the protocol 1. Even if this instance is not covered by the Aave Safety Module, being part of Aave, it still is monitored and evaluated whenever development and/or security decisions are made.

This creates meaningful overhead for all involved development & security teams, which directly adds cost to the Aave DAO. Additionally, the architecture of Aave v1 is quite different to Aave v2 & v3, making it the most ad-hoc instance of Aave.

## Specification

The proposal contract calls:

- ADDRESSES_PROVIDER.setLendingPoolLiquidationManager(LIQUIDATION_MANAGER_IMPL);
- ADDRESSES_PROVIDER.setLendingPoolImpl(POOL_IMPL);

to update the implementations accordingly.

## References

- Implementation: [AaveV1Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240115_AaveV1Ethereum_AaveV1Deprecation/AaveV1Ethereum_AaveV1Deprecation_20240115.sol)
- Tests: [AaveV1Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240115_AaveV1Ethereum_AaveV1Deprecation/AaveV1Ethereum_AaveV1Deprecation_20240115.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x7451f00809986c7cb8cce7ef4587efdfedad06089ebf2851d64122d00b035d9c)
- [Discussion](https://governance.aave.com/t/temp-check-bgd-further-aave-v1-deprecation-strategy/15893)
- [Updated Implementations](https://github.com/bgd-labs/v1-offboarding)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).