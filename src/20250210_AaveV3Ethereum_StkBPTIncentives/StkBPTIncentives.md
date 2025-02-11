---
title: "stkBPT Incentives"
author: "@TokenLogic"
discussions: https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/13
---

## Simple Summary

Re-enable stkBPT incentives emissions for 180 days after previous period ended.

## Motivation

With the conclusion of the recent reward cycle, this proposal aims to renew $AAVE emissions for stkBPT holders. The stkBPT module has proven to be a crucial mechanism as an AAVE supply sink, currently holding a TVL of $1.6B. It is recommended to maintain these emissions in anticipation of upcoming Umbrella developments, with adjustments to be made following the outcomes of the Umbrella upgrade.

More information on stkBPT can be found in the following dashboard, [here](https://dune.com/xmc2/aave-safety-module).

## Specification

- Set new allowance to 360 AAVE per day for 180 days
- Include prior remaining allowance of ~21,000
- Include days between distribution end and execution date
- Set distribution end for 180 days from execution date

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/2099b900e5a755cd7f69eaf0a9e4d8f6711b33ab/src/20250210_AaveV3Ethereum_StkBPTIncentives/AaveV3Ethereum_StkBPTIncentives_20250210.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/2099b900e5a755cd7f69eaf0a9e4d8f6711b33ab/src/20250210_AaveV3Ethereum_StkBPTIncentives/AaveV3Ethereum_StkBPTIncentives_20250210.t.sol)
  [Snapshot](Direct-to-AIP)
- [Discussion](https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/13)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
