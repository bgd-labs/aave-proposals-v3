---
title: "AMPL Interest Rate Updates on V2 Ethereum"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-ampl-interest-rate-updates-on-v2-ethereum/16189"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xc5373ecc51b9ce6a568f2bb99181cf34efb3f317a4bd340719bc10c864fd1332"
---

## Simple Summary

A proposal to reduce the interest rate curves for AMPL on Aave V2 Ethereum.

## Motivation

As per the initial forum post by BGD a few weeks ago 2, over the past few weeks, we have seen an abnormal exponential deviation within the AMPL market, particularly in the context of aAMPL/total supplied liquidity/vAMPL supply values. Although the exact cause of this shift is still under investigation, it appears linked to the unique aAMPL implementation. Specifically, the scaled total supply of the underlying AMPL in the market, and thus by proxy aAMPL supply, seems to rebase irrespective of the utilization rate, in addition to the high interest rates realized by the aAMPL. In the expected implementation however, suppliers and/or borrowers will proportionately receive daily AMPL rebases in accordance with the utilization of the underlying market (where utilization of 100% = zero to AMPL suppliers and 0% = only to AMPL suppliers).

With minimal withdrawals and 100% utilization rate over the last month and a half, it seems as though the correlation has only gotten stronger. Given the rampant growth in aAMPL supply whilst total supplied liquidity has stayed constant, & aAMPL withdrawals are naturally credited 1:1 with underlying AMPL, there is currently a predicament whereby current aAMPL holders cannot be paid out their effective claims on the market. The development of a fair method for distributing these claims, or any potential reimbursement strategy, will be formulated in the upcoming days and weeks, once we have a clearer understanding of the core issue. As such, given the AMPL market’s frozen status since Nov 27th, 2022, and the ongoing deprecation of the market (including setting the RF to 99% on Dec 17th, 2023), suggesting a decrease in slope2 from 300% to 0% could alleviate the interest rate’s impact on aAMPL supply growth, even if primarily realized by the Aave collector. This adjustment seeks to analyze the influence on the relative exponentiation within the current aAMPL supply, and would leave the 20% base rate intact.

## Specification

| Parameter      | Current | Recommended |
| -------------- | ------- | ----------- |
| Base           | 20%     | No Change   |
| Slope1         | 0%      | No Change   |
| Slope2         | 300%    | 0%          |
| Uoptimal       | 80%     | No Change   |
| Reserve Factor | 99.00%  | 99.90%      |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/02681712c414ab39bd3840337f1584ff7c4b603b/src/20240121_AaveV2Ethereum_AMPLInterestRateUpdatesOnV2Ethereum/AaveV2Ethereum_AMPLInterestRateUpdatesOnV2Ethereum_20240121.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/02681712c414ab39bd3840337f1584ff7c4b603b/src/20240121_AaveV2Ethereum_AMPLInterestRateUpdatesOnV2Ethereum/AaveV2Ethereum_AMPLInterestRateUpdatesOnV2Ethereum_20240121.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xc5373ecc51b9ce6a568f2bb99181cf34efb3f317a4bd340719bc10c864fd1332)
- [Discussion](https://governance.aave.com/t/arfc-ampl-interest-rate-updates-on-v2-ethereum/16189)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
