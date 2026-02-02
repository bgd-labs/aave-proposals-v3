---
title: "Extend stkAAVE Emissions"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/49"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x0f73500d0f65c72482d352080ea9aa0aa92264eb059b8f646cf6f0e86556bc3d"
---

## Simple Summary

Top-up the AAVE allowance for the Safety Module **stkAAVE** to extend rewards distribution by **90 days** while keeping the current emission rate unchanged.

## Motivation

The current stkAAVE allowance from the Ecosystem Reserve is approaching depletion. This proposal renews the allowance to ensure uninterrupted reward distribution for stakers.

**Note:** **stkAAVE is not being phased out**; it will be **repurposed** into a **no-risk staking (dividend yield) contract**.

## Specification

- **Target module:** Safety Module stake token **stkAAVE** (`AaveSafetyModule.STK_AAVE`).
- **Emission rate:** Unchanged; the payload reads the current `emissionPerSecond` on-chain.
- **Allowance adjustment (funding):** Reset and set the AAVE allowance from the **Ecosystem Reserve** to cover **remaining allowance** + **90 days** of future emissions:
  - `allowance = currentAllowance + (emissionPerSecond * 90 days)`
- **No other changes:** This payload does **not** modify stkAAVE emission rates, cooldown parameters, slashing parameters, or any other Safety Module settings.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/70387ba097a5472490c6d0848cbed263fa6b9d5f/src/20260121_AaveV3Ethereum_ExtendStkAAVEEmissions/AaveV3Ethereum_ExtendStkAAVEEmissions_20260121.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/70387ba097a5472490c6d0848cbed263fa6b9d5f/src/20260121_AaveV3Ethereum_ExtendStkAAVEEmissions/AaveV3Ethereum_ExtendStkAAVEEmissions_20260121.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x0f73500d0f65c72482d352080ea9aa0aa92264eb059b8f646cf6f0e86556bc3d)
- [Discussion](https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/49)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
