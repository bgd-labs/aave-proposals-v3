---
title: "[ARFC] Safety Module & Umbrella Emission Update"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-safety-module-umbrella-emission-update/23103/8"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x6712b1677068d2d316af699757057a0c8c03e0ff0693c12aacc381d294c419a4"
---

## Simple Summary

This proposal outlines the next incremental reduction in Safety Module emissions.

## Motivation

The proposed changes aim to improve the capital efficiency of the Aave Safety Module while ensuring a smooth transition away from legacy staking modules. By phasing out stkAAVE and stkABPT through the reduction of slashing to 0%.

## Specification

If approved and executed, this proposal will implement the following updates:

### 1. Reduce Slashing Risk

| SM Category | Current | Proposed |
| ----------- | ------- | -------- |
| **stkAAVE** | 10%     | 0%       |
| **stkABPT** | 10%     | 0%       |

### 2. Reduce Cooldown Period

| SM Category | Current | Proposed |
| ----------- | ------- | -------- |
| **stkAAVE** | 20 days | 7 days   |
| **stkABPT** | 20 days | 20 days  |

### 3. AAVE/wETH Liquidity Funding

Create allowances to a new **Aave Liquidity SAFE** for the equivalent of **$5M AAVE** and **$5M aEthWETH**, sourced from the Aave Ecosystem Reserve and the Aave Collector on Ethereum.

- **Asset:** AAVE – `0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9`  
  **Amount:** $5M USD equivalent
- **Asset:** aEthWETH – `0x4d5F47FA6A74757f35C14fD3a6Ef8E3C9BC514E8`  
  **Amount:** $5M USD equivalent
- **Spender:** Aave Liquidity SAFE – `0xAAA973Fe8A6202947e21D0a3a43d8E83ABE35C23`
- **Method:** `approve()` on the Ecosystem Reserve (AAVE) and Collector (aEthWETH) to the Liquidity SAFE

The Liquidity SAFE signers follow the same configuration as other Asset SAFEs, requiring **3 of 4** approvals.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250918_AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate/AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250918_AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate/AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x6712b1677068d2d316af699757057a0c8c03e0ff0693c12aacc381d294c419a4)
- [Discussion](https://governance.aave.com/t/arfc-safety-module-umbrella-emission-update/23103/8)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
