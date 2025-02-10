---
title: "stkBPT Incentives"
author: "@TokenLogic"
discussions: https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/13
---

## Simple Summary

Re-enable stkBPT incentives emissions for 180 days after previous period ended.

## Motivation

## Specification

- Set new allowance to 360 AAVE per day for 180 days
- Include prior remaining allowance of ~21,000
- Include days between distribution end and execution date
- Set distribution end for 180 days from execution date

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250210_AaveV3Ethereum_StkBPTIncentives/AaveV3Ethereum_StkBPTIncentives_20250210.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250210_AaveV3Ethereum_StkBPTIncentives/AaveV3Ethereum_StkBPTIncentives_20250210.t.sol)
  [Snapshot](Direct-to-AIP)
- [Discussion](https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/13)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
