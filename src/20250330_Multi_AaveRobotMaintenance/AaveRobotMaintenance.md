---
title: "Robot Maintenance and remove old VotingPortals from Governance"
author: "BGD Labs (@bgdlabs)"
discussions: TODO
---

## Simple Summary

Maintenance proposal to remove old VotingPortals from the Aave Governance and update new governance robots and also update robots for refreshing liquidity mining rewards for stata-tokens.

## Motivation

With the voting machine / portal improvements [proposal](https://vote.onaave.com/proposal/?proposalId=273), as the voting machine addresses are updated it is required to update the voting chain robots which performs automation on the voting machine contracts and also registers storage roots for voting. Also as newer instances of stata-tokens have been deployed recently, it is also needed to register new robots for refreshing liquidity mining rewards and cancel the old ones which were previous activated via this [proposal](https://vote.onaave.com/proposal/?proposalId=109).

Also as the new VotingPortals have already been proved to be working by having been used for voting on at least 4 new proposals (279 - 282), it is time to remove the old ones, so that there is no confusion or possibility to use the old VotingPortals to vote on new proposals.

## Specification

The old stata-token refresh liquidity mining robots and the voting chain robots will be cancelled by calling the `cancel()` method on the robot operator contract, and after the delay has passed anyone could call the permissionless method `withdrawLink()` on the robot operator contract to withdraw the unused funds on the previous robots to the collector.

For the new stata-token and voting chain robots, the payload will call the `register()` method on the robot operator to register the new robots.

The RootsConsumer contracts which are triggered by voting chain robots to register storage roots for voting are also re-deployed and new instance are used on the new voting chain robots. The link balances from the old RootsConsumer are also migrated to the new RootsConsumer contract by calling the `emergencyTokenTransfer()` method.

_Please note: This proposal only updates robots on chainlink automation, robots using gelato automation on networks where chainlink automation is not available will be updated manually_

The payload calls `removeVotingPortals()` on the Aave Governance contract, with the list of old VotingPortals.

VotingPortals to remove:

| Network  | Path       | Address                                                                                                               |
| -------- | ---------- | --------------------------------------------------------------------------------------------------------------------- |
| Ethereum | Eth - Eth  | [0xf23f7De3AC42F22eBDA17e64DC4f51FB66b8E21f](https://etherscan.io/address/0xf23f7De3AC42F22eBDA17e64DC4f51FB66b8E21f) |
| Ethereum | Eth - Avax | [0x33aCEf7365809218485873B7d0d67FeE411B5D79](https://etherscan.io/address/0x33aCEf7365809218485873B7d0d67FeE411B5D79) |
| Ethereum | Eth - Pol  | [0x9b24C168d6A76b5459B1d47071a54962a4df36c3](https://etherscan.io/address/0x9b24C168d6A76b5459B1d47071a54962a4df36c3) |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Ethereum_AaveRobotMaintenance_20250330.sol), [AaveV3PolygonPart1](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Polygon_AaveRobotMaintenance_Part1_20250330.sol), [AaveV3PolygonPart2](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Polygon_AaveRobotMaintenance_Part2_20250330.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Avalanche_AaveRobotMaintenance_20250330.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Optimism_AaveRobotMaintenance_20250330.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Arbitrum_AaveRobotMaintenance_20250330.sol), [AaveV3BasePart1](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Base_AaveRobotMaintenance_Part1_20250330.sol), [AaveV3BasePart2](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Base_AaveRobotMaintenance_Part2_20250330.sol), [AaveV3BNBPart1](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3BNB_AaveRobotMaintenance_Part1_20250330.sol), [AaveV3BNBPart2](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3BNB_AaveRobotMaintenance_Part2_20250330.sol)

- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Ethereum_AaveRobotMaintenance_20250330.t.sol), [AaveV3PolygonPart1](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Polygon_AaveRobotMaintenance_Part1_20250330.t.sol), [AaveV3PolygonPart2](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Polygon_AaveRobotMaintenance_Part2_20250330.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Avalanche_AaveRobotMaintenance_20250330.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Optimism_AaveRobotMaintenance_20250330.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Arbitrum_AaveRobotMaintenance_20250330.t.sol), [AaveV3BasePart1](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Base_AaveRobotMaintenance_Part1_20250330.t.sol), [AaveV3BasePart2](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3Base_AaveRobotMaintenance_Part2_20250330.t.sol), [AaveV3BNBPart1](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3BNB_AaveRobotMaintenance_Part1_20250330.t.sol), [AaveV3BNBPart2](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250330_Multi_AaveRobotMaintenance/AaveV3BNB_AaveRobotMaintenance_Part2_20250330.t.sol)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
