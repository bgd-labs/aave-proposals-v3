---
title: "stkAAVE Emissions"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/26"
---

## Simple Summary

Re-enable stkAAVE incentives emissions for 90 days in anticipation of the launch of Umbrella.

## Motivation

With the recent reward cycle allowance coming to an end soon, this proposal aims to renew $AAVE emissions for stkAAVE holders. The stkAAVE module has proven to be a crucial mechanism as an AAVE supply sink, currently holding a TVL of $480M and accounting for 18.8% of the supply. It is recommended to maintain these emissions in anticipation of upcoming Umbrella developments, with adjustments to be made following the outcomes of the Umbrella upgrade.

More information on stkAAVE can be found in these dashboards, [here](https://dune.com/xmc2/aave-safety-module) and [here](https://dune.com/KARTOD/AAVE-Staking).

## Specification

- Set new allowance to 360 AAVE per day for 90 days
- Include prior remaining allowance

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250520_AaveV3Ethereum_StkAAVEEmissions/AaveV3Ethereum_StkAAVEEmissions_20250520.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250520_AaveV3Ethereum_StkAAVEEmissions/AaveV3Ethereum_StkAAVEEmissions_20250520.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/26)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
