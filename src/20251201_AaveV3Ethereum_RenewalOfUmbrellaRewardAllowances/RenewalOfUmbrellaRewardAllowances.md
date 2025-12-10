---
title: "Renewal of Umbrella Reward Allowances"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-renewal-of-umbrella-reward-allowances/23474"
---

## Simple Summary

This proposal renews the Umbrella reward allowances to support continuing to distribute emissions at the current rate without any disruption to user positions.

## Motivation

Umbrella was activated on June 5th, 2025 and has been performing better than initially modelled. Deposits currently sit around ~$325M, exceeding the original target coverage of ~$261.8M, and providing stronger protection despite less favorable market conditions.

Umbrella rewards are funded through allowances from the Aave Ethereum Collector. The initial allowance configuration—designed to support roughly 6 months of emissions—is now approaching renewal. Based on the most recent 7-day emission rate and the remaining unassigned budget, GHO rewards will require renewing before December 22nd, with other assets requiring updates shortly afterward.

Renewing these allowances ensures that reward distribution continues uninterrupted and that stakers receive emissions at the current rate without disruption.

## Specification

Upon implementation, the AIP will **renew the reward allowances** by extending the four Umbrella StakeTokens on **Aave v3 Ethereum Core**.

No changes are proposed to:

- Emission rates
- Target Liquidity
- Cooldown parameters
- Deficit offsets
- Umbrella architecture

### New Allowances

Each new allowance equals:

| Asset           | Original Allowance | New Allowance         |
| --------------- | ------------------ | --------------------- |
| stkwaEthUSDC.v1 | 1,149,028          | remaining + 1,149,028 |
| stkwaEthUSDT.v1 | 1,809,848          | remaining + 1,809,848 |
| stkwaEthWETH.v1 | 271                | remaining + 271       |
| stkGHO.v1       | 591,781            | remaining + 591,781   |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/80995abb3e5d952ac2e28feb9b310c9b7b700934/src/20251201_AaveV3Ethereum_RenewalOfUmbrellaRewardAllowances/AaveV3Ethereum_RenewalOfUmbrellaRewardAllowances_20251201.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/80995abb3e5d952ac2e28feb9b310c9b7b700934/src/20251201_AaveV3Ethereum_RenewalOfUmbrellaRewardAllowances/AaveV3Ethereum_RenewalOfUmbrellaRewardAllowances_20251201.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-renewal-of-umbrella-reward-allowances/23474)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
