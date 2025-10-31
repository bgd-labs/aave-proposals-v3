---
title: "Safety Module Emissions Update"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/26"
---

## Simple Summary

Re-enable stkBPT incentives emissions for 90 days after previous period ended.

## Motivation

With the conclusion of the recent reward cycle, this proposal aims to renew $AAVE emissions for stkBPT holders. The stkBPT module has proven to be a crucial mechanism as an AAVE supply sink, currently holding a TVL of $1.6B. It is recommended to maintain these emissions in anticipation of upcoming Umbrella developments, with adjustments to be made following the outcomes of the Umbrella upgrade.

More information on stkBPT can be found in the following dashboard, [here](https://dune.com/xmc2/aave-safety-module).

Extend stkBPT V1 allowance so users can claim pending amounts (~875 AAVE).

## Specification

Set the following params for staked tokens:

| Token      | Emissions per day | Duration |
| ---------- | ----------------- | -------- |
| stkAAVE    | 260               | -        |
| stkABPT_V2 | 130               | 90 days  |
| stkABPT_V1 | 1,000 (total)     | -        |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251029_AaveV3Ethereum_SafetyModuleEmissionsUpdate/AaveV3Ethereum_SafetyModuleEmissionsUpdate_20251029.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251029_AaveV3Ethereum_SafetyModuleEmissionsUpdate/AaveV3Ethereum_SafetyModuleEmissionsUpdate_20251029.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/26)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
