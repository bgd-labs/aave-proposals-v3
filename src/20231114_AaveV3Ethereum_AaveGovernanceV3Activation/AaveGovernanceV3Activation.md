---
title: "Aave Governance V3 Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/bgd-aave-governance-v3-activation-plan/14993/13"
---

## Simple Summary

Proposal for the migration of the Aave Governance v2.5 to v3, transferring all permissions from the v2 system to v3, executing all required smart contracts upgrades and different miscellaneous preparations.

Additionally, Aave Robot systems is activated, being requirement for the optimal functioning of Governance v3.

## Motivation

v3 is a the next iteration for the Aave governance smart contracts systems, controlling in a fully decentralized manner the whole Aave ecosystem.

Being a replacement on the currently running v2.5, a set of two proposals on v2.5 need to be passed to migrate one system to another: once both are passed and executed on the current governance smart contracts, these will stop working, and the new v3 ones will start operating.

## Specification

A full specification can be found [HERE](https://governance.aave.com/t/bgd-aave-governance-v3-activation-plan/14993/13), but as summary:

- 2 governance proposals need to be created: one running on the Level 1 Executor (Short Executor) and another on the Level 2 Executor (Long Executor).
- As both proposals need to be atomically executed, a `Mediator` contract will temporary receive certain permissions, in order to sync both Level 1 and Level 2.
- High-level, the proposals do the following:

  - Migrate the ownership of the v2 Executors to the v3 Executors, in order to avoid any possible permissions lock.
  - Upgrade the implementations of the Governance v3 voting assets (AAVE, stkAAVE and aAAVE), to make them compatible with the new system.
  - Fund Aave Robot.
  - Transfer permissions for ARC and for swap adapters on Base.

- Implementation: [V2Ethereum](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/src/contracts/governance3/EthShortV2Payload.sol), [V3Ethereum](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/src/contracts/governance3/EthShortV3Payload.sol), [V3EthereumLong](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/src/contracts/governance3/EthLongV3Payload.sol), [Avalanche](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/src/contracts/governance3/AvalancheFundRobotPayload.sol), [Polygon](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/src/contracts/governance3/PolygonFundRobotPayload.sol), [Base](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/src/contracts/governance3/BaseSwapsPayload.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/tests/governance3/EthShortPayloadTest.t.sol), [EthereumLong](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/tests/governance3/EthLongV3PayloadTest.t.sol), [Avalanche](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/tests/governance3/AvalancheFundRobotPayload.t.sol), [Polygon](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/tests/governance3/PolygonFundRobotPayload.t.sol), [Base](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/tests/governance3/BaseSwapsPayloadTest.t.sol)

- [Pre-approval Snapshot](https://snapshot.org/#/aave.eth/proposal/0x7e61744629fce7787281905b4d5984b39f9cbe83fbe2dd05d8b77697205ce0ce)

- [Governance forum Discussion](https://governance.aave.com/t/bgd-aave-governance-v3-activation-plan/14993/13)

- [Aave Governance V3 smart contracts](https://github.com/bgd-labs/aave-governance-v3)

- [Aave Governance V3 interface](https://github.com/bgd-labs/aave-governance-v3-interface)

- [Aave Robot v3](https://github.com/bgd-labs/aave-governance-v3-robot)

- [AAVE token v3](https://github.com/bgd-labs/aave-token-v3)

- [aAAVE governance v3 compatible](https://github.com/bgd-labs/aave-a-token-with-delegation)

- [stkAAVE governance v3 compatible](https://github.com/bgd-labs/aave-stk-gov-v3)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
