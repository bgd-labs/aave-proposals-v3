---
title: "Update PoR Executor V3 Robot"
author: "BGD Labs (@bgdlabs)"
discussions: ""
---

## Simple Summary

Proposal to re-enable Aave Proof of Reserve on Avalanche, after temporarily halting the system during the Aave v3.1 upgrade.

## Motivation

With the release of Aave V3.1, it is no longer necessary to set the asset's LTV to zero before freezing during the execution of an emergency action on a Proof of Reserve alert, as the protocol does it both actions in batch. Moreover setting LTV to zero that way would break the "rollback" mechanism (pendingLtv) of LTV back to normal value on unfreeze.

## Specification

|            Contract            |                                                        Address                                                        |
| :----------------------------: | :-------------------------------------------------------------------------------------------------------------------: |
| Proof Of Reserve Executor V3.1 | [0xB94e515615c244Ab25f7A6e592e3Cb7EE31E99F4](https://snowscan.xyz/address/0xb94e515615c244ab25f7a6e592e3cb7ee31e99f4) |
|     Proof Of Reserve Robot     | [0x7aE2930B50CFEbc99FE6DB16CE5B9C7D8d09332C](https://snowscan.xyz/address/0x7ae2930b50cfebc99fe6db16ce5b9c7d8d09332c) |

This proposal consists of two payloads:

- To cancel the existing robot.
- To grant risk admin permission to the new executor, withdraw funds from the existing robot, and register the new one.

The proposal is separated into two payloads because several blocks must pass between canceling the existing robot and withdrawing the funds. The order of execution is guaranteed by the fact that it is impossible to withdraw funds before the robot is canceled.

The new version of the Proof of Reserve Executor is granted the risk admin role by calling the ACL Manager's `addRiskAdmin()` method.

The current robot will be canceled by calling the `cancel()` method by the first payload on the robot operator contract. After the delay, the second payload will be executed to `withdrawLink()` on the robot operator contract to withdraw the unused funds on the previous robot to the collector and then call the `register()` method to register the new keeper.

The new robot would be fulfilled with 15 LINK.

## References

- Implementation: [AaveV3Avalanche - Cancel existing robot](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240617_AaveV3Avalanche_UpdatePoRExecutorV3Robot/AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617.sol), [AaveV3Avalanche - Register new robot](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240617_AaveV3Avalanche_UpdatePoRExecutorV3Robot/AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617.sol)
- Tests: [AaveV3Avalanche - Cancel](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240617_AaveV3Avalanche_UpdatePoRExecutorV3Robot/AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617.t.sol), [AaveV3Avalanche - Register](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240617_AaveV3Avalanche_UpdatePoRExecutorV3Robot/AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617.t.sol)
- [New Proof of Reserve Executor](https://snowscan.xyz/address/0xb94e515615c244ab25f7a6e592e3cb7ee31e99f4)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
