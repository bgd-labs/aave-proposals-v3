---
title: "Safety Module Emission Update"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-safety-module-emission-update/22554"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x844e6490591165e166fe511c1c527798369a21394fd93812d299cc320ec91dd5"
---

## Simple Summary

This publication outlines the next incremental reduction in AAVE emissions being distributed to stkAAVE and stkABPT holders.

## Motivation

### stkAAVE

The current stkAAVE yield is 3.95% and represents 19.33% of Total AAVE supply with 22,675 unique users, up from 20,023 on the 5th June 2025. Since early April AAVE deposits in stkAAVE have been gradually increasing and only 3.82% of stkAAVE in cooldown, indicating stkAAVE has achieved an equilibrium with only minor flows in and out of the contract.

Over the last 30 days, an additional 43,664 AAVE has been deposited into stkAAVE, with 26,595 deposited on the 7th June, two days after the Umbrella upgrade went live.

Given the strong support for stkAAVE over the 30 day period since Umbrella went live, exceeding our expectations, this publication proposes the next reduction in Slashing Risk and AAVE emissions.

By reducing Slashing from 20% to 10%, the risk exposure is reduced by half. With an improving risk profile, the AAVE emissions are to be revised lower to 260 AAVE/day, or 3.25% at current deposit levels.

### stkABPT

Since the Umbrella upgrade went live on the 5th June 2025, when stkABPT emissions reduced from 240 AAVE/day to 216 AAVE/day, only 51,217 BPT tokens, or 8.21% of the liquidity has been withdrawn from the Balancer liquidity pool. The vast majority of the withdrawal volume was by a single user that withdrew 50k units on Jun-06-2025. Otherwise, the number of unique users remains unchanged with a net reduction of 2 users over the last 30 day period.

With only 1.25% of stkABPT in Cooldown, it indicates an equilibrium has been achieved, and we are now well placed to revise the AAVE emissions.
Reducing the Slashing exposure from 20% to 10%, improves the overall risk profile of holding stkABPT. A new guidance of 8% total yield for holding stkABPT is proposed comprised of 0.55% wstETH yield, 1.35% swap fee derived yield and 6.10% in AAVE emissions.

Whilst this represents as material change from ~12% to ~8% total yield, the liquidity pool contains generous levels of liquidity relative to swap volume passing through the pool. Utilisation of liquidity, Swap Volume / Pool TVL, remains mostly unchanged with 91.4% of swaps being $40k USD or smaller in size relative to a $211M TVL liquidity pool. A reduction in pool TVL is not likely to impede the pool's ability to attract swap volume.

## Specification

Reduce AAVE Emissions in the following manner:

| SM Category | Current              | Proposed                 |
| ----------- | -------------------- | ------------------------ |
| stkAAVE     | 315/day (3.94% APY)  | 260/day (Est. 3.25% APY) |
| stkABPT     | 216/day (10.09% APY) | 130/day (Est. 6.10% APY) |

Update maximum slashing percentage for both to 10%.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250721_AaveV3Ethereum_SafetyModuleEmissionUpdate/AaveV3Ethereum_SafetyModuleEmissionUpdate_20250721.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250721_AaveV3Ethereum_SafetyModuleEmissionUpdate/AaveV3Ethereum_SafetyModuleEmissionUpdate_20250721.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x844e6490591165e166fe511c1c527798369a21394fd93812d299cc320ec91dd5)
- [Discussion](https://governance.aave.com/t/arfc-safety-module-emission-update/22554)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
