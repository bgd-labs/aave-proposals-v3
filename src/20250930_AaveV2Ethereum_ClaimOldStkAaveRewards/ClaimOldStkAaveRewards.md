---
title: "Claim Aave v2 stkAAVE rewards"
author: "BGD Labs (@bgdlabs) and TokenLogic (@Token_Logic)"
discussions: https://governance.aave.com/t/technical-maintenance-proposals/15274/115
---

## Simple Summary

Maintenance proposal to claim unclaimed StkAave rewards from the Ethereum V2 Incentives Controller.

## Motivation

During routine treasury analysis, TokenLogic identified approximately ~560 StkAave tokens (~$150,000 at current market prices) sitting unclaimed in the Ethereum V2 Incentives Controller contract. These dormant rewards represent treasury assets that should be actively managed rather than left idle, making it prudent for the DAO to claim and transfer them to the Aave Collector for proper treasury optimization.

## Specification

To claim the unclaimed StkAave reward, the payload:

- Sets Claimer Authorization: Calls `setClaimer()` on the Ethereum V2 Incentives Controller to authorize the executor address as the claimer.
- Executes Claim: Calls `claimRewardsOnBehalf()` to claim all pending StkAave rewards and transfer them directly to the Aave Collector.

Since the `EMISSIONS_ADMIN` role resides with the legacy Aave V2 Governance Short Executor, the implementation requires two additional payload contracts on Ethereum, to be called by the Governance V3 Lvl 1 Executor:

- [PART 1](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250930_AaveV2Ethereum_ClaimOldStkAaveRewards/AaveV2Ethereum_ClaimOldStkAaveRewards_20250930.sol#L42) Queue Payload: Contract calling `queueTransaction()` to queue the execution on Governance V2 Short Executor
- [PART 2](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250930_AaveV2Ethereum_ClaimOldStkAaveRewards/AaveV2Ethereum_ClaimOldStkAaveRewards_20250930.sol#L74) Execute Payload: Contract calling `executeTransaction()` to execute the queued transaction via Governance V2 Short Executor

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250930_AaveV2Ethereum_ClaimOldStkAaveRewards/AaveV2Ethereum_ClaimOldStkAaveRewards_20250930.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250930_AaveV2Ethereum_ClaimOldStkAaveRewards/AaveV2Ethereum_ClaimOldStkAaveRewards_20250930.t.sol)
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/115)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
