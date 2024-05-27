---
title: "Migrate Robots to Chainlink Automation v2"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/36"
---

## Simple Summary

Proposal to migrate existing Aave robots from chainlink automation `v1.2` to `v2.1`. For governance v3 robots on ethereum, we introduce gas-capped robots in order to limit execution based on network gas price. We also activate robots for refreshing liquidity mining rewards for static-a-tokens.

## Motivation

With the release of Chainlink automation `v2.1`, we think its a good idea to update the Aave Robot existing infrastructure to the latest `v2.1` version.
In addition, as an effort to reduce the cost spent in gas in times of high gas prices, we also introduce gas-capped robots on mainnet which will be activated via this proposal.

Currently when a liquidity mining reward is added after static-a-token creation, it needs to be registered manually on the token via the permissionless `refreshRewardTokens()` method. As this process is not currently automated users might be missing out on rewards until the method is called, so now we introduce the robot for static-a-token to automate this process.

## Specification

For the migration, the robots registered on the previous robot operator contract will be cancelled and new robots will be registered using an updated robot operator contract, compatible with the newer version of chainlink automation `v2.1`.

The robots will be cancelled by calling the `cancel()` method by the payload on the previous robot operator contract, and after the delay has passed anyone could call the permissionless method `withdrawLink()` on the robot operator contract to withdraw the unused funds on the previous robots to the collector.

On the newer robot operator, the payload will call the `register()` method to register the keepers with the newer chainlink automation registry supporting `v2.1`.

The proposal also refills the cross-chain-controller contract (part of aDI) on mainnet with 1 ethereum from the collector.

_Note: All aave governance v3 robots along with robots used for gsm swap freeze and Proof of Reserve will be migrated via this proposal and will use the same contract as before except the one's mentioned below_

|           | Deployed AaveCLRobotOperator                                                                                                     |
| --------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Mainnet   | [0x1cDF8879eC8bE012bA959EB515b11008E0cb6323](https://etherscan.io/address/0x1cDF8879eC8bE012bA959EB515b11008E0cb6323)            |
| Polygon   | [0xB4C212f5cD17E200019b07e6B1fDf124d35DBCf5](https://polygonscan.com/address/0xB4C212f5cD17E200019b07e6B1fDf124d35DBCf5)         |
| Avalanche | [0x06d958772304e7220fc3E463756CE01Ed0D24db2](https://snowscan.xyz/address/0x06d958772304e7220fc3E463756CE01Ed0D24db2)            |
| Optimism  | [0x55Cf9583D7D30DC4936bAee1f747591dBECe5df7](https://optimistic.etherscan.io/address/0x55Cf9583D7D30DC4936bAee1f747591dBECe5df7) |
| Arbitrum  | [0xaa944aD95e51CB83C1f35FAEEDfC7d2c31B0BB4d](https://arbiscan.io/address/0xaa944aD95e51CB83C1f35FAEEDfC7d2c31B0BB4d)             |
| Base      | [0x88db99eeBb390a2a4DcAC2E1DDb09c07E911C5C3](https://basescan.org/address/0x88db99eeBb390a2a4DcAC2E1DDb09c07E911C5C3)            |
| BNB       | [0x51Bd3d6011Dd0BD88Ee1bEA1a67be799A6A09D79](https://bscscan.com/address/0x51Bd3d6011Dd0BD88Ee1bEA1a67be799A6A09D79)             |

|                                               | Deployed Robots                                                                                                                  |
| --------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Mainnet Gas Capped Governance Robot           | [0x1996c281235D99bB3c6B8d2afbEb8ac6c7A39C11](https://etherscan.io/address/0x1996c281235D99bB3c6B8d2afbEb8ac6c7A39C11)            |
| Mainnet Gas Capped Voting Robot               | [0x7Ed0A6A294Cf085c90917c0ee1aa34e795932558](https://etherscan.io/address/0x7Ed0A6A294Cf085c90917c0ee1aa34e795932558)            |
| Mainnet Gas Capped Execution Robot            | [0xBa37F9eDC52f57caFA3a13ddfD655797Cc4FE257](https://etherscan.io/address/0xBa37F9eDC52f57caFA3a13ddfD655797Cc4FE257)            |
| Mainnet Gas Capped StaticAToken Rewards Robot | [0xda82148a3944BBe442116f41cDb329b0edF11d41](https://etherscan.io/address/0xda82148a3944BBe442116f41cDb329b0edF11d41)            |
| Polygon StaticAToken Rewards Robot            | [0x855FbD0D57fF5B1e8263e3cCDf3384545fbaF863](https://polygonscan.com/address/0x855FbD0D57fF5B1e8263e3cCDf3384545fbaF863)         |
| Avalanche StaticAToken Rewards Robot          | [0x8aD3f00e91F0a3Ad8b0dF897c19EC345EaB761c4](https://snowscan.xyz/address/0x8aD3f00e91F0a3Ad8b0dF897c19EC345EaB761c4)            |
| Optimism StaticAToken Rewards Robot           | [0x861Be72d464b6F1C99880B9bE476D40e8F9b5Bce](https://optimistic.etherscan.io/address/0x861Be72d464b6F1C99880B9bE476D40e8F9b5Bce) |
| Arbitrum StaticAToken Rewards Robot           | [0x0451f67bA61966C346daBAbB50a30Cc6A9A67C69](https://arbiscan.io/address/0x0451f67bA61966C346daBAbB50a30Cc6A9A67C69)             |
| Base StaticAToken Rewards Robot               | [0xad87684D27e6e58F055E6878A9F11F8c52A5b0F5](https://basescan.org/address/0xad87684D27e6e58F055E6878A9F11F8c52A5b0F5)            |
| BNB StaticAToken Rewards Robot                | [0x020E452b463568f55BAc6Dc5aFC8F0B62Ea5f0f3](https://bscscan.com/address/0x020E452b463568f55BAc6Dc5aFC8F0B62Ea5f0f3)             |

## References

- Implementation: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/cfa41b410141c5de76a184a4648bb4ce67fdd53c/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV2Polygon_MigrateRobotsToChainlinkAutomationV2_20240422.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/cfa41b410141c5de76a184a4648bb4ce67fdd53c/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV2Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/cfa41b410141c5de76a184a4648bb4ce67fdd53c/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV3Ethereum_MigrateRobotsToChainlinkAutomationV2_20240422.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/cfa41b410141c5de76a184a4648bb4ce67fdd53c/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV3Polygon_MigrateRobotsToChainlinkAutomationV2_20240422.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/cfa41b410141c5de76a184a4648bb4ce67fdd53c/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV3Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/cfa41b410141c5de76a184a4648bb4ce67fdd53c/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV3Optimism_MigrateRobotsToChainlinkAutomationV2_20240422.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/cfa41b410141c5de76a184a4648bb4ce67fdd53c/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV3Arbitrum_MigrateRobotsToChainlinkAutomationV2_20240422.sol)
- Tests: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/cfa41b410141c5de76a184a4648bb4ce67fdd53c/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV2Polygon_MigrateRobotsToChainlinkAutomationV2_20240422.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/cfa41b410141c5de76a184a4648bb4ce67fdd53c/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV2Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422.t.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/cfa41b410141c5de76a184a4648bb4ce67fdd53c/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV3Ethereum_MigrateRobotsToChainlinkAutomationV2_20240422.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/cfa41b410141c5de76a184a4648bb4ce67fdd53c/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV3Polygon_MigrateRobotsToChainlinkAutomationV2_20240422.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/cfa41b410141c5de76a184a4648bb4ce67fdd53c/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV3Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/cfa41b410141c5de76a184a4648bb4ce67fdd53c/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV3Optimism_MigrateRobotsToChainlinkAutomationV2_20240422.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/cfa41b410141c5de76a184a4648bb4ce67fdd53c/src/20240422_Multi_MigrateRobotsToChainlinkAutomationV2/AaveV3Arbitrum_MigrateRobotsToChainlinkAutomationV2_20240422.t.sol)
- [Discussion](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/36)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
