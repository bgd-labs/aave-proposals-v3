---
title: "[ARFC] Safety Module & Umbrella Emission Update"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-safety-module-umbrella-emission-update/23103/6"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x6712b1677068d2d316af699757057a0c8c03e0ff0693c12aacc381d294c419a4"
---

## Simple Summary

This proposal outlines the next incremental reduction in Safety Module emissions.

## Motivation

The proposed changes aim to improve the capital efficiency of the Aave Safety Module while ensuring a smooth transition away from legacy staking modules. By phasing out stkAAVE and stkABPT through the reduction of slashing to 0%.

## Specification

This proposal when implemented via AIP will:

| SM Category | Current | Proposed |
| ----------- | ------- | -------- |
| **stkAAVE** | 30%     | 0%       |
| **stkABPT** | 30%     | 0%       |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250918_AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate/AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250918_AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate/AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x6712b1677068d2d316af699757057a0c8c03e0ff0693c12aacc381d294c419a4)
- [Discussion](https://governance.aave.com/t/arfc-safety-module-umbrella-emission-update/23103/6)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
