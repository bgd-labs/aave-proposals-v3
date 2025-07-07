---
title: "Robot Maintenance"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/96"
---

## Simple Summary

Maintenance proposal to update the Aave Robot automations related with governance voting machines and Stata Tokens rewards accounting.

## Motivation

Due to the update of the VotingMachine addresses on the voting machine/portal improvements [proposal](https://vote.onaave.com/proposal/?proposalId=273), it is required to update the voting chain Aave Robot performing automations on the voting machine contracts, and also registering storage roots for voting.
Additionally, with newer instances of Stata Tokens (used on Umbrella) having been deployed recently, it is also needed to register new robots for refreshing liquidity mining rewards and cancel the old ones that were previously activated via this [proposal](https://vote.onaave.com/proposal/?proposalId=109).

## Specification

The old Stata Token refresh liquidity mining robots and the voting chain robots will be cancelled by calling the `cancel()` method on the Aave Robot operator contract, and after the delay has passed anyone could call the permissionless method `withdrawLink()` to withdraw the unused funds on the previous robots to the Collector.

For the new Stata Token and voting chain Robots, the payload will call the `register()` method on the robot operator to register them.

The RootsConsumer contracts, which are triggered by voting chain robots to register storage roots for voting, are also redeployed, and new instances are used on the new voting chain robots. The LINK balances from the old RootsConsumer are also migrated to the new RootsConsumer contract by calling the `emergencyTokenTransfer()` method.

_Note: This proposal only updates Robots on Chainlink automation. Robots using Gelato automation on networks where Chainlink automation is not available will be updated manually_

Below you can find the changelog of deployed contracts for each instance:

### StataRefreshRewardRobot:

|           | Old Contract                               | New Contract                               |
| --------- | ------------------------------------------ | ------------------------------------------ |
| Core      | 0xda82148a3944BBe442116f41cDb329b0edF11d41 | 0x892B74CD3703B427CD90e7f140F358A1DE1EA703 |
| Prime     | -                                          | 0x858f50cB70e6476d37543275aF4c738Ae8a27893 |
| Arbitrum  | 0x0451f67bA61966C346daBAbB50a30Cc6A9A67C69 | 0xF01281a6DfDe5506C5049c9BBf8C7E087b9bD4bF |
| Avalanche | 0x8aD3f00e91F0a3Ad8b0dF897c19EC345EaB761c4 | 0x43C6b39669355AF93DdEdc70e8eB44c226f09BFB |
| Polygon   | 0x855FbD0D57fF5B1e8263e3cCDf3384545fbaF863 | 0x1d8347B427964fad8a742e7f9442a4E89346400a |
| Base      | 0xad87684D27e6e58F055E6878A9F11F8c52A5b0F5 | 0x97CB9e81d480A2AB03299760654C1DDC0C16bE07 |
| BNB       | 0x020E452b463568f55BAc6Dc5aFC8F0B62Ea5f0f3 | 0x9062F78b631f33D24Ed058cBc116A653452ea82A |
| Optimism  | 0x861Be72d464b6F1C99880B9bE476D40e8F9b5Bce | 0x365d47ceD3D7Eb6a9bdB3814aA23cc06B2D33Ef8 |

### VotingChainRobot:

|           | Old Contract                               | New Contract                               |
| --------- | ------------------------------------------ | ------------------------------------------ |
| Mainnet   | 0x7Ed0A6A294Cf085c90917c0ee1aa34e795932558 | 0xbC3210bfff692a5bbDBB068D42Ab4eAF28b01Ee0 |
| Avalanche | 0x10E49034306EaA663646773C04b7B67E81eD0D52 | 0x2cf0fA5b36F0f89a5EA18F835d1375974a7720B8 |
| Polygon   | 0xbe7998712402B6A63975515A532Ce503437998b7 | 0x1180eE41eC15Dd0accC13a1e646B3152bECFf8F6 |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Ethereum_AaveRobotMaintenance_20250330.sol), [AaveV3PolygonPart1](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Polygon_AaveRobotMaintenance_Part1_20250330.sol), [AaveV3PolygonPart2](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Polygon_AaveRobotMaintenance_Part2_20250330.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Avalanche_AaveRobotMaintenance_20250330.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Optimism_AaveRobotMaintenance_20250330.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Arbitrum_AaveRobotMaintenance_20250330.sol), [AaveV3BasePart1](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Base_AaveRobotMaintenance_Part1_20250330.sol), [AaveV3BasePart2](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Base_AaveRobotMaintenance_Part2_20250330.sol), [AaveV3BNBPart1](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3BNB_AaveRobotMaintenance_Part1_20250330.sol), [AaveV3BNBPart2](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3BNB_AaveRobotMaintenance_Part2_20250330.sol)

- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Ethereum_AaveRobotMaintenance_20250330.t.sol), [AaveV3PolygonPart1](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Polygon_AaveRobotMaintenance_Part1_20250330.t.sol), [AaveV3PolygonPart2](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Polygon_AaveRobotMaintenance_Part2_20250330.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Avalanche_AaveRobotMaintenance_20250330.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Optimism_AaveRobotMaintenance_20250330.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Arbitrum_AaveRobotMaintenance_20250330.t.sol), [AaveV3BasePart1](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Base_AaveRobotMaintenance_Part1_20250330.t.sol), [AaveV3BasePart2](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Base_AaveRobotMaintenance_Part2_20250330.t.sol), [AaveV3BNBPart1](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3BNB_AaveRobotMaintenance_Part1_20250330.t.sol), [AaveV3BNBPart2](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3BNB_AaveRobotMaintenance_Part2_20250330.t.sol)
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/96)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
