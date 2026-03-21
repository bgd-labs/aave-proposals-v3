---
title: "Reduce Safety Module Emissions"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-safety-module-reduce-emissions/24203"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xe76461b0936fc892904c1696066b9fa3688e1042078d9c9f06c1a937736a100e"
---

## Simple Summary

This proposal reduces Safety Module emissions and adjusts parameters for stkAAVE and stkAAVE/wstETH BPTv2, saving a combined 29,200 AAVE/year (~0.18% of total supply, ~$3.6M) while transitioning stkAAVE/wstETH BPTv2 toward sunset in favour of Protocol-Owned Liquidity.

## Motivation

The general theme over the last 6 months has been to reduce AAVE emissions by shifting towards direct AAVE/ETH provisioning and ensuring future emissions are more sustainably funded via the buyback program.

**stkAAVE**: The current 260 AAVE/day yields 3.69% for stkAAVE holders. The module continues to demonstrate healthy participation at 16.78% of AAVE supply staked, with strong net inflows (+98,600 in January 2026, +60,100 in February 2026). The previous reduction from 315 to 260 AAVE/day did not trigger an exodus. Reducing to 220 AAVE/day results in a 3.12% APR, continuing the proven downtrend (385 → 360 → 315 → 260 → 220). The cooldown reduction from 7 to 2 days makes stkAAVE more liquid and suitable for integrations such as CEX Earn programs and futures markets.

**stkAAVE/wstETH BPTv2**: With the Aave Finance Committee (AFC) receiving additional funding via [AIP 449](https://vote.onaave.com/proposal/?proposalId=449&ipfsHash=0xb0a156896cd0f4b24828145c34c36201d03241250aacc0c1c4e49174f427fff4), additional AAVE/wETH liquidity is to be deployed that allows stkAAVE/wstETH BPTv2 to be sunset, resulting in a cost savings of 14,600 AAVE/year. By replacing the inefficient full-range 80/20-weighted pool with concentrated liquidity, the Aave DAO can facilitate swaps more capital-efficiently. Umbrella rollout provides targeted, capital-efficient protocol protection, reducing the legacy need for stkAAVE/wstETH BPTv2 as a Safety Module mechanism.

## Specification

| Contract             | Parameter            | Current | Proposed |
| -------------------- | -------------------- | ------- | -------- |
| stkAAVE              | Emissions (AAVE/day) | 260     | 220      |
| stkAAVE              | Cooldown Period      | 7 Days  | 2 Days   |
| stkAAVE/wstETH BPTv2 | Emissions (AAVE/day) | 40      | 0        |
| stkAAVE/wstETH BPTv2 | Cooldown Period      | 20 Days | 0 Days   |
| stkAAVE/wstETH BPTv2 | Slashing             | 10%     | 0%       |

Combined annual emission savings: **~29,200 AAVE (~0.18% of total supply, ~$3.6M)**.

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/4ccf67880287701d393bb13015b73b1ad41db29c/src/20260224_AaveV3Ethereum_ReduceSafetyModuleEmissions/AaveV3Ethereum_ReduceSafetyModuleEmissions_20260224.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/4ccf67880287701d393bb13015b73b1ad41db29c/src/20260224_AaveV3Ethereum_ReduceSafetyModuleEmissions/AaveV3Ethereum_ReduceSafetyModuleEmissions_20260224.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xe76461b0936fc892904c1696066b9fa3688e1042078d9c9f06c1a937736a100e)
- [Discussion](https://governance.aave.com/t/arfc-safety-module-reduce-emissions/24203)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
