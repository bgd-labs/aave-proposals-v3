---
title: "Update PoR Executor V3 Robot"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/42"
---

## Simple Summary

Proposal to re-enable Aave Proof of Reserve on Avalanche, after temporarily halting the system during the Aave v3.1 upgrade.

## Motivation

With the release of Aave V3.1, it is no longer necessary to set the asset’s LTV to zero before freezing during the execution of an emergency action on a Proof of Reserve alert, as the protocol does both actions in batch.

Moreover, setting LTV to zero that way would break the “rollback” mechanism (pendingLtv) of LTV back to normal value on unfreeze.

## Specification

The proposal is separated into two payloads because multiple blocks must pass between canceling the existing Aave Robot automation and withdrawing funds from it. The order of execution is guaranteed by the fact that it is impossible to withdraw funds before the robot is canceled.

The two payloads do the following:

1. Cancels the existing Aave Robot automation for PoR, by calling `cancel()` on the Aave Robot operator contract.
2. Activates the new PoR system by:

   2.1. Granting Aave v3 Avalanche RISK_ADMIN role to the new PoR executor contract, by calling `addRiskAdmin()` on the ACLManager contract.

   2.2. Withdrawing LINK funds from the existing Robot PoR by calling `withdrawLink()` on the Robot operator contract.

   2.3. Registering a new PoR Robot, by calling `register()` on the Robot operator contract.

   2.4. Refilling the new PoR Robot with 15 LINK from the Aave Collector.

The new contracts involved are the following:

|            Contract            |                                                        Address                                                        |
| :----------------------------: | :-------------------------------------------------------------------------------------------------------------------: |
| Proof Of Reserve Executor V3.1 | [0xB94e515615c244Ab25f7A6e592e3Cb7EE31E99F4](https://snowscan.xyz/address/0xb94e515615c244ab25f7a6e592e3cb7ee31e99f4) |
|     Proof Of Reserve Robot     | [0x7aE2930B50CFEbc99FE6DB16CE5B9C7D8d09332C](https://snowscan.xyz/address/0x7ae2930b50cfebc99fe6db16ce5b9c7d8d09332c) |

## References

- Implementation: [AaveV3Avalanche - Cancel existing robot](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240617_AaveV3Avalanche_UpdatePoRExecutorV3Robot/AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617.sol), [AaveV3Avalanche - Register new robot](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240617_AaveV3Avalanche_UpdatePoRExecutorV3Robot/AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617.sol)
- Tests: [AaveV3Avalanche - Cancel](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240617_AaveV3Avalanche_UpdatePoRExecutorV3Robot/AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617.t.sol), [AaveV3Avalanche - Register](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240617_AaveV3Avalanche_UpdatePoRExecutorV3Robot/AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617.t.sol)
- [New Proof of Reserve Executor](https://snowscan.xyz/address/0xb94e515615c244ab25f7a6e592e3cb7ee31e99f4)
- [Discussion](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/42)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
