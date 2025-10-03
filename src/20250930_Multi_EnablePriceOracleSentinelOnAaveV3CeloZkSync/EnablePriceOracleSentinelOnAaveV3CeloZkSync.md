---
title: "Enable Price Oracle Sentinel on Aave V3 Celo, ZkSync"
author: "BGD Labs (@bgdlabs)"
discussions: TODO
---

## Simple Summary

Maintenance proposal to activate Price Oracle Sentinel functionality on Aave V3 ZkSync and Celo instances.

## Motivation

Aave v3 has a mechanism called “Price Oracle Sentinel” by which if the network infrastructure is down (mainly the sequencer on rollups), new borrowings and liquidations are not processed, and a grace period is given to the user to refill their positions and avoid liquidation.
This mechanism is part of Aave v3, but its activation depends on having an underlying oracle providing the “health check” of the network infrastructure.
Aave uses the [L2 Sequencer Uptime Feeds](https://docs.chain.link/data-feeds/l2-sequencer-feeds) for various networks since day 0, but at that point, Celo, ZkSync was not available.
Following its introduction on Celo, ZkSync network, this proposal will activate its Price Oracle Sentinel on those networks.

## Specification

To configure the PriceOracleSentinel, `POOL_ADDRESSES_PROVIDER.setPriceOracleSentinel()` method will be called to set the price oracle sentinel on the pool addresses provider.

| Network | PriceOracleSentinel                                                                                                         |
| ------- | --------------------------------------------------------------------------------------------------------------------------- |
| Celo    | [0x06c5c197edfdf2ed0a3757880242b2264ef7c3c2](https://celoscan.io/address/0x06c5c197edfdf2ed0a3757880242b2264ef7c3c2)        |
| ZkSync  | [0xbb57eaaefe94fb6850941e360cf0939189f73ce5](https://era.zksync.network/address/0xbb57eaaefe94fb6850941e360cf0939189f73ce5) |

## References

- Implementation: [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20250930_Multi_EnablePriceOracleSentinelOnAaveV3CeloZkSync/AaveV3ZkSync_EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930.sol), [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250930_Multi_EnablePriceOracleSentinelOnAaveV3CeloZkSync/AaveV3Celo_EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930.sol)
- Tests: [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20250930_Multi_EnablePriceOracleSentinelOnAaveV3CeloZkSync/AaveV3ZkSync_EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930.t.sol), [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250930_Multi_EnablePriceOracleSentinelOnAaveV3CeloZkSync/AaveV3Celo_EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930.t.sol)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
