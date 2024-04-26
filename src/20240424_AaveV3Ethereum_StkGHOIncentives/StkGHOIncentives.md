---
title: "stkGHO Incentives"
author: "karpatkey_TokenLogic_ACI"
discussions: "https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x0f73500d0f65c72482d352080ea9aa0aa92264eb059b8f646cf6f0e86556bc3d"
---

## Simple Summary

Re-enable stkGHO incentives emissions for 180 days after previous period ended.

## Motivation

To support the GHO peg and to pave the way for future GHO supply expansion, this publication proposes maintaining the daily AAVE emission going to stkGHO holders.

## Specification

For stkGHO:

- Set new allowance to 100 AAVE per day for 180 days
- Set distribution end for 180 days from Execution date

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/8fe09bb7196ce1f7043b85660c6aed5f0457be3f/src/20240424_AaveV3Ethereum_StkGHOIncentives/AaveV3Ethereum_StkGHOIncentives_20240424.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/8fe09bb7196ce1f7043b85660c6aed5f0457be3f/src/20240424_AaveV3Ethereum_StkGHOIncentives/AaveV3Ethereum_StkGHOIncentives_20240424.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x0f73500d0f65c72482d352080ea9aa0aa92264eb059b8f646cf6f0e86556bc3d)
- [Discussion](https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
