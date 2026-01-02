---
title: "stkABPT Emission Update"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-safety-module-umbrella-emission-update/23103/9"
---

## Simple Summary

Reduce AAVE emissions for the legacy Safety Module **stkABPT** (stkAAVE/wstETH BPTv2) from **130 AAVE/day** to **40 AAVE/day**.

## Motivation

This change follows the proposal’s direction to **phase out stkABPT incentives** (as emissions will trend to **0**) by reducing incentives on the legacy Safety Module. Reducing stkABPT emissions lowers ongoing incentive spend while supporting the transition towards the Umbrella Safety Modules and improved capital efficiency.

**Note:** **stkAAVE is not being phased out**; it will be **repurposed** into a **no-risk staking (dividend yield) contract**.

## Specification

- **Target module:** Legacy Safety Module stake token **stkABPT** (`AaveSafetyModule.STK_AAVE_WSTETH_BPTV2`).
- **Change:** Update AAVE rewards emission rate from **130 AAVE/day → 40 AAVE/day** by setting:
  - `emissionPerSecond = 40 AAVE / day` (expressed as `uint128(40 ether) / 1 days`)
- **Distribution end:** extend rewards distribution by **90 days**: `newDistributionEnd = distributionEnd + 90 days`.
- **Allowance adjustment (funding):** Reset and set the AAVE allowance from the **Ecosystem Reserve** to the stake token to cover **already accrued** + **future emissions**:
  - `allowance = currentAllowance + emissionPerSecond * (newDistributionEnd - block.timestamp)`
- **No other changes:** This payload does **not** modify stkAAVE emissions, cooldown parameters, slashing parameters, or any Umbrella module emissions.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251219_AaveV3Ethereum_EmissionUpdate/AaveV3Ethereum_EmissionUpdate_20251219.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251219_AaveV3Ethereum_EmissionUpdate/AaveV3Ethereum_EmissionUpdate_20251219.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x6712b1677068d2d316af699757057a0c8c03e0ff0693c12aacc381d294c419a4)
- [Discussion](https://governance.aave.com/t/arfc-safety-module-umbrella-emission-update/23103/9)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
