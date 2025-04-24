---
title: "Lower stkABPT Emissions"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-stkabpt-emissions-update/21683"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x8dbeee9b489266cfefb8cb3c75fb0791d364975eed48cee951ff04fd17ee57c1"
---

## Simple Summary

This publication proposes reducing AAVE emissions to the stkABPT Safety Module category.

## Motivation

During 2025, AAVE liquidity is expected to transition away from stkABPT to a more diversified liquidity base.

The below outlines an overview of what to expect during 2025:

- Reduction stkABPT emissions, eventually to 0;
- Support AAVE liquidity across several networks;
- Improved liquidity distribution amongst LPs; and,
- Introduce Aave DAO liquidity provisions.

Thanks to a coordinated effort between Service Providers, AAVE token holders and Aerodrome, there is now AAVE liquidity on the Base network. The liquidity on Aerodrome was key to supporting the onboarding of AAVE to Aave Protocol on Base.

This publication focuses on implementing the first significant AAVE emission reduction to stkABPT holders.

![Screenshot 2025-04-03 at 21.55.51](https://hackmd.io/_uploads/SJ8k8uhaJg.png)
Source: https://aave.tokenlogic.xyz/stkbpt

### stkABPT Emissions

The Aave DAO currently emitting 360 AAVE per day to stkBPT holders. Assuming a spot price of $150/AAVE, this is equivalent to $19.71M a year.

The yield from holding stkABPT relative to the underlying, 18.21%, compares favorable to holding stkAAVE at 4.72%. Given the slashing risk is 30% for both stkAAVE and stkBPT, the delta of 13.49% represents compensation for the additional Balancer exposure.

This publication proposes reducing AAVE emissions by one-third, to 240 AAVE/day. The resulting AAVE yield on stkBPT is estimated to reduce by 4.67%, to 11.96% at current rates whilst still comparing favorably to stkAAVE at a time when swap fees and the Lido Index rate is below historical averages.

Based upon the swap size distribution routing through the pool, an overall reduction in TVL would not adversely affect users seeking to acquire AAVE. However, earning near 12% for providing liquidity in the current market is also an attractive investment option for LPs to consider.

## Specification

This AIP reduces the AAVE emission rate to the following:

| SM Category | Current | Proposed |
| :---------- | :-----: | :------: |
| stkABPT     | 360/day | 240/day  |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250423_AaveV3Ethereum_LowerStkABPTEmissions/AaveV3Ethereum_LowerStkABPTEmissions_20250423.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250423_AaveV3Ethereum_LowerStkABPTEmissions/AaveV3Ethereum_LowerStkABPTEmissions_20250423.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x8dbeee9b489266cfefb8cb3c75fb0791d364975eed48cee951ff04fd17ee57c1)
- [Discussion](https://governance.aave.com/t/arfc-stkabpt-emissions-update/21683)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
