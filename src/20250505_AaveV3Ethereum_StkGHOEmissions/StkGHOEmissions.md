---
title: "stkGHO Emissions"
author: "@TokenLogic"
discussions: https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/18
snapshot: Direct-to-AIP
---

## Simple Summary

Re-enable stkGHO incentives emissions for 180 days after previous period ended.

## Motivation

To support the GHO peg and to pave the way for future GHO supply expansion, this publication proposes maintaining the daily AAVE emission going to stkGHO holders.

## Specification

- Set new allowance to 100 AAVE per day for 180 days
- Include prior remaining allowance
- Set distribution end for 180 days from execution date

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/c8180be42db546bc6b11dfddd6fa48f649c6a3df/src/20250505_AaveV3Ethereum_StkGHOEmissions/AaveV3Ethereum_StkGHOEmissions_20250505.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/c8180be42db546bc6b11dfddd6fa48f649c6a3df/src/20250505_AaveV3Ethereum_StkGHOEmissions/AaveV3Ethereum_StkGHOEmissions_20250505.t.sol)
  [Snapshot](Direct-to-AIP)
- [Discussion](https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/18)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
