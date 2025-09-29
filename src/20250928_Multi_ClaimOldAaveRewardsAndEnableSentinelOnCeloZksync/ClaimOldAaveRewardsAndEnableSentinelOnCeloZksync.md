---
title: "Claim old Aave rewards and enable sentinel on celo, zksync"
author: "TokenLogic and BGD Labs (@bgdlabs)"
discussions: TODO
---

## Simple Summary

Maintenance proposal to claim unclaimed StkAave rewards from the Ethereum V2 Incentives Controller and and activating Price Oracle Sentinel functionality on Aave V3 ZkSync and Celo instances.

## Motivation

During routine treasury analysis, TokenLogic identified approximately ~560 StkAave tokens (~$150,000 at current market prices) sitting unclaimed in the Ethereum V2 Incentives Controller contract. These dormant rewards represent treasury assets that should be actively managed rather than left idle, making it prudent for the DAO to claim and transfer them to the Aave Collector for proper treasury optimization.

Aave v3 has a mechanism called “Price Oracle Sentinel” by which if the network infrastructure is down (mainly the sequencer on rollups), new borrowings and liquidations are not processed, and a grace period is given to the user to refill their positions and avoid liquidation.
This mechanism is part of Aave v3, but its activation depends on having an underlying oracle providing the “health check” of the network infrastructure.
Aave uses the [L2 Sequencer Uptime Feeds](https://docs.chain.link/data-feeds/l2-sequencer-feeds) for various networks since day 0, but at that point, Celo, ZkSync was not available.
Following its introduction on Celo, ZkSync network, this proposal will activate its Price Oracle Sentinel on those networks.

## Specification

### StkAave Rewards Claiming

To claim the unclaimed StkAave reward, the payload:

- Set Claimer Authorization: Calls `setClaimer()` on the Ethereum V2 Incentives Controller to authorize the Aave Collector's executor address as the claimer.
- Execute Claim: Calls `claimRewardsOnBehalf()` to claim all pending StkAave rewards and transfer them directly to the Aave Collector.

Since the `EMISSIONS_ADMIN` role resides with the legacy Aave V2 Governance Short Executor, the implementation requires two additional payload contracts on Ethereum, to be called by the Governance V3 Lvl 1 Executor:

- [PART 1](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250928_Multi_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync/AaveV2Ethereum_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.sol#L42) Queue Payload: Contract calling `queueTransaction()` to queue the execution on Governance V2 Short Executor
- [PART 2](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250928_Multi_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync/AaveV2Ethereum_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.sol#L74) Execute Payload: Contract calling `executeTransaction()` to execute the queued transaction via Governance V2 Short Executor

### Price Oracle Sentinel Configuration

To configure the PriceOracleSentinel, `POOL_ADDRESSES_PROVIDER.setPriceOracleSentinel()` method will be called to set the price oracle sentinel on the pool addresses provider.

| Network | PriceOracleSentinel                                                                                                         |
| ------- | --------------------------------------------------------------------------------------------------------------------------- |
| Celo    | [0x06c5c197edfdf2ed0a3757880242b2264ef7c3c2](https://celoscan.io/address/0x06c5c197edfdf2ed0a3757880242b2264ef7c3c2)        |
| ZkSync  | [0xbb57eaaefe94fb6850941e360cf0939189f73ce5](https://era.zksync.network/address/0xbb57eaaefe94fb6850941e360cf0939189f73ce5) |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250928_Multi_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync/AaveV2Ethereum_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20250928_Multi_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync/AaveV3ZkSync_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.sol), [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250928_Multi_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync/AaveV3Celo_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250928_Multi_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync/AaveV2Ethereum_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.t.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20250928_Multi_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync/AaveV3ZkSync_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.t.sol), [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250928_Multi_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync/AaveV3Celo_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.t.sol)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
