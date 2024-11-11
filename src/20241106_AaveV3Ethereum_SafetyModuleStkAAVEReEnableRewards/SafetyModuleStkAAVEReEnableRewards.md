---
title: "Safety Module stkAAVE - Re-enable Rewards"
author: "@karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/13"
snapshot: "Direct-to-AIP"
---

## Simple Summary

This publication proposes renewing the AAVE emissions to stkAAVE holders for the following 180 days.

## Motivation

With the conclusion of the recent reward cycle, this proposal aims to renew $AAVE emissions for stkAAVE holders. The stkAAVE module has proven to be a crucial mechanism as an AAVE supply sink, currently holding a TVL of $480M and accounting for 18.8% of the supply. It is recommended to maintain these emissions in anticipation of upcoming Umbrella developments, with adjustments to be made following the outcomes of the Umbrella upgrade.

More information on stkAAVE can be found in these dashboards, [here](https://dune.com/xmc2/aave-safety-module) and [here](https://dune.com/KARTOD/AAVE-Staking).

## Specification

This proposal will implement the following changes to the AAVE emissions across the three SM categories:

| Asset   | Current AAVE/Day | Proposed AAVE/Day |
| ------- | ---------------- | ----------------- |
| stkAAVE | 360              | 360               |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241106_AaveV3Ethereum_SafetyModuleStkAAVEReEnableRewards/AaveV3Ethereum_SafetyModuleStkAAVEReEnableRewards_20241106.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241106_AaveV3Ethereum_SafetyModuleStkAAVEReEnableRewards/AaveV3Ethereum_SafetyModuleStkAAVEReEnableRewards_20241106.t.sol)
- [Snapshot]: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/13)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
