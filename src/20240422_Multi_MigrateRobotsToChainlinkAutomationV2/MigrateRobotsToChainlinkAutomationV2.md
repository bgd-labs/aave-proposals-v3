---
title: "Migrate Robots to Chainlink Automation v2"
author: "BGD Labs (@bgdlabs)"
discussions: ""
---

## Simple Summary

Proposal to migrate existing Aave robots from chainlink automation `v1.2` to `v2.1`. For governance v3 robots on ethereum, we also introduce gas-capped robots in order to limit execution based on network gas price.

## Motivation

With the release of Chainlink automation `v2.1`, we think its a good idea to update the Aave Robot existing infrastructure to the latest `v2.1` version.
In addition, as an effort to reduce the cost spent in gas in times of high gas prices, we also introduce gas-capped robots on mainnet which will be activated via this proposal.

## Specification

For the migration, the robots registered on the previous robot operator contract will be cancelled and new robots will be registered using an updated robot operator contract, compatible with the newer version of chainlink automation `v2.1`.

The robots will be cancelled by calling the `cancel()` method by the payload on the previous robot operator contract, and after the delay has passed anyone could call the permissionless method `withdrawLink()` on the robot operator contract to withdraw the unused funds on the previous robots to the collector.

On the newer robot operator, the payload will call the `register()` method to register the keepers with the newer chainlink automation registry supporting `v2.1`.

_Note: All aave governance v3 robots along with robots used for gsm swap freeze will be migrated via this proposal_

|           | Deployed AaveCLRobotOperator                                                                                                     |
| --------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Mainnet   | [0x737806fe47FDBDEcBcB82dF7b89AA3D74AdadF62](https://etherscan.io/address/0x737806fe47FDBDEcBcB82dF7b89AA3D74AdadF62)            |
| Polygon   | [0x4F341c371ab7E2F34A4d3EAd5b2C30F0A6BDC7d0](https://polygonscan.com/address/0x4F341c371ab7E2F34A4d3EAd5b2C30F0A6BDC7d0)         |
| Avalanche | [0x023640D7CDa2E2063546A45005393756B9b4ac9D](https://snowscan.xyz/address/0x023640D7CDa2E2063546A45005393756B9b4ac9D)            |
| Optimism  | [0x34F098B9B67B147d8a679476bc89982DdE525F8c](https://optimistic.etherscan.io/address/0x34F098B9B67B147d8a679476bc89982DdE525F8c) |
| Arbitrum  | [0xAa589e4c7539e8D7465c36578098499F0b2BBd12](https://arbiscan.io/address/0xAa589e4c7539e8D7465c36578098499F0b2BBd12)             |
| Base      | [0xBAC282927CE0cFD1698C5853dCED2eEf9F62a8bb](https://basescan.org/address/0xBAC282927CE0cFD1698C5853dCED2eEf9F62a8bb)            |
| BNB       | [0xf092900FC8D4962412eC784d7Fbc92a1F69c47bC](https://bscscan.com/address/0xf092900FC8D4962412eC784d7Fbc92a1F69c47bC)             |

|                             | Deployed Gas Capped Robots                                                                                            |
| --------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| Gas Capped Governance Robot | [0x1996c281235D99bB3c6B8d2afbEb8ac6c7A39C11](https://etherscan.io/address/0x1996c281235D99bB3c6B8d2afbEb8ac6c7A39C11) |
| Gas Capped Voting Robot     | [0x7Ed0A6A294Cf085c90917c0ee1aa34e795932558](https://etherscan.io/address/0x7Ed0A6A294Cf085c90917c0ee1aa34e795932558) |
| Gas Capped Execution Robot  | [0xBa37F9eDC52f57caFA3a13ddfD655797Cc4FE257](https://etherscan.io/address/0xBa37F9eDC52f57caFA3a13ddfD655797Cc4FE257) |

## References

- Implementation: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV2Polygon_MigrateRobotsToChainlinkAutomationV2_20240422.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV2Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV3Ethereum_MigrateRobotsToChainlinkAutomationV2_20240422.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV3Polygon_MigrateRobotsToChainlinkAutomationV2_20240422.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV3Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV3Optimism_MigrateRobotsToChainlinkAutomationV2_20240422.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV3Arbitrum_MigrateRobotsToChainlinkAutomationV2_20240422.sol)
- Tests: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV2Polygon_MigrateRobotsToChainlinkAutomationV2_20240422.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV2Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422.t.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV3Ethereum_MigrateRobotsToChainlinkAutomationV2_20240422.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV3Polygon_MigrateRobotsToChainlinkAutomationV2_20240422.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV3Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV3Optimism_MigrateRobotsToChainlinkAutomationV2_20240422.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV3Arbitrum_MigrateRobotsToChainlinkAutomationV2_20240422.t.sol)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
