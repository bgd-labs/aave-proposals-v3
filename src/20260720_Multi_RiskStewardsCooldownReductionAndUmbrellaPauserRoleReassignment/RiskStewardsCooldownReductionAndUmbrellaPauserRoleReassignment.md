---
title: "Risk Stewards Cooldown Reduction & Umbrella Pauser Role Reassignment"
author: "Llama Risk (implemented by Aave Labs)"
discussions: "https://governance.aave.com/t/arfc-risk-stewards-cooldown-reduction-umbrella-pauser-role-reassignment/25068"
snapshot: "https://snapshot.org/#/aavedao.eth/proposal/0x7083921f2f549ffa2cdc294c8ff60fdc82af0becbb7b2f20f4f296c34694aaf2"
---

## Simple Summary

This proposal reduces the minimum delay between Risk Steward updates for six cap and interest-rate parameters from 72 hours to 36 hours across 19 current-layout Aave V3 deployments. It also grants the Aave Protocol Guardian permission to pause and unpause all current and future Ethereum Umbrella stake tokens.

## Motivation

Supply and borrow caps set close to current utilisation can make the existing 72-hour Risk Steward cooldown a constraint on responding to healthy demand. A 36-hour cooldown for cap and interest-rate model updates improves responsiveness while retaining every existing maximum-change bound. Higher-impact collateral, E-Mode, price-cap, and Pendle discount-rate delays remain unchanged.

Umbrella stake-token pauses and unpauses are controlled by a single controller-wide role. Granting this emergency role to the Aave Protocol Guardian aligns Umbrella with the protocol's standing emergency authority and avoids requiring a full governance cycle during incident response. Governance retains its existing role and all configuration authority.

## Specification

Upon execution, the proposal:

- Updates the Risk Steward configuration for 19 Aave V3 deployments across 17 networks: Ethereum Core, Lido, and EtherFi; Polygon; Avalanche; Arbitrum; Optimism; Base; Gnosis; BNB Chain; Scroll; Linea; Sonic; Celo; Mantle; Plasma; MegaETH; Monad; and X Layer.
- On each Risk Steward, changes only the `minDelay` of `baseVariableBorrowRate`, `variableRateSlope1`, `variableRateSlope2`, `optimalUsageRatio`, `supplyCap`, and `borrowCap` to 36 hours. All `maxPercentChange` values and every other delay are preserved.
- Grants `PAUSE_GUARDIAN_ROLE` on the Ethereum Umbrella controller to the Aave Protocol Guardian (`0x2CFe3ec4d5a6811f4B8067F0DE7e47DfA938Aa30`). This role authorises both `pauseStk(stkToken)` and `unpauseStk(stkToken)` for every current and future Umbrella stake token managed by the controller.

Ink is not modified because its corresponding delays are already 24 hours, below the proposed 36-hour value. Metis, Soneium, and zkSync are not modified because they use the legacy Risk Steward configuration layout.

## References

- [Implementation and tests](https://github.com/aave-dao/aave-proposals-v3/tree/main/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment)
- [Snapshot](https://snapshot.org/#/aavedao.eth/proposal/0x7083921f2f549ffa2cdc294c8ff60fdc82af0becbb7b2f20f4f296c34694aaf2)
- [Discussion](https://governance.aave.com/t/arfc-risk-stewards-cooldown-reduction-umbrella-pauser-role-reassignment/25068)

## Disclaimer

This proposal was authored by Llama Risk and implemented by Aave Labs.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
