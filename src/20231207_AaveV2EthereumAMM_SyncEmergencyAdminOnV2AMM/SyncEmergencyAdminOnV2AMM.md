---
title: "Sync emergency admin on v2 AMM"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/10"
---

## Simple Summary

This proposal aligns the emergency admin address on the deprecated Aave v2 AMM pool with the one of Aave v2 and v3 Ethereum.

## Motivation

During an internal security review procedure of Aave, we detected that the emergency admin on Aave v2 AMM is a legacy address, not aligned with the Aave Guardian.

Even if the v2 AMM pool is deprecated (frozen) and almost off-boarded, for hygiene we think it is appropriate to have consistency on all Aave instances in the same network, and simpler for operations.

## Specification

Upon execution, the proposal will call setEmergencyAdmin(0xCA76Ebd8617a03126B6FB84F9b1c1A0fB71C2633) on the addresses provider contract of v2 AMM, passing the address of the Aave Ethereum Guardian.

## References

- Implementation: [AaveV2EthereumAMM](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231207_AaveV2EthereumAMM_SyncEmergencyAdminOnV2AMM/AaveV2EthereumAMM_SyncEmergencyAdminOnV2AMM_20231207.sol)
- Tests: [AaveV2EthereumAMM](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231207_AaveV2EthereumAMM_SyncEmergencyAdminOnV2AMM/AaveV2EthereumAMM_SyncEmergencyAdminOnV2AMM_20231207.t.sol)
- [Snapshot](TODO)
- [Discussion](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/10)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
