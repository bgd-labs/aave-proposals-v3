---
title: "stkGHO Incentives"
author: "karpatkey_TokenLogic_ACI"
discussions: "https://governance.aave.com/t/arfc-safety-module-stkgho-re-enable-rewards/19626"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x0f73500d0f65c72482d352080ea9aa0aa92264eb059b8f646cf6f0e86556bc3d"
---

## Simple Summary

Re-enable stkGHO incentives emissions for 180 days after previous period ended.
On the previous proposal to enable stkGHO emissions (Proposal 91 on the forum), an error in accounting made it so ~2,750 in emissions were not claimable during the last period. This current proposal includes that approval so that those emissions can be claimed, in addition to the 100 per day.
The previous proposal can be found [here](https://vote.onaave.com/proposal/?proposalId=91&ipfsHash=0x633733ef9b80afd497fd1a25d848fbe91ef694fab798dbbc27617ca07407454c).

## Motivation

To support the GHO peg and to pave the way for future GHO supply expansion, this publication proposes maintaining the daily AAVE emission going to stkGHO holders.

## Specification

For stkGHO:

- Set new allowance to 100 AAVE per day for 180 days
- Include prior ~2,750 AAVE in allowance
- Set distribution end for 180 days from Execution date

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/c4837d92cdc0cd819db9b6c2e43e8cda3dcc96e0/src/20241029_AaveV3Ethereum_StkGHOIncentivesQ4/AaveV3Ethereum_StkGHOIncentives_20240424.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/c4837d92cdc0cd819db9b6c2e43e8cda3dcc96e0/src/20241029_AaveV3Ethereum_StkGHOIncentivesQ4/AaveV3Ethereum_StkGHOIncentives_20240424.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x0f73500d0f65c72482d352080ea9aa0aa92264eb059b8f646cf6f0e86556bc3d)
- [Discussion](https://governance.aave.com/t/arfc-safety-module-stkgho-re-enable-rewards/19626)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
