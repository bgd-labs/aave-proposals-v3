---
title: "stkABPT - Emissions Update"
author: "TokenLogic"
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

### stkBPT Category Performance

#### Yield

The chart below shows the value of the Balancer Protocol Token (BPT) staked in the stkABPT category of the Safety Module (SM) and the historical yield received by Liquidity Providers (LP) over the last 30 days.

![Screenshot 2025-04-03 at 21.57.57](https://hackmd.io/_uploads/S1PwL_3pkx.png)
Source: https://aave.tokenlogic.xyz/stkbpt

The chart above shows the resulting yield from Swap Fees, wstETH and AAVE emissions. The high swap fee is due to this pooling being the primary source of DEX liquidity and the resulting arbitrage derived volumes.

### AAVE/wstETH Impermanent Loss

The image below compares the investment performance of depositing $100k into the AAVE/wstETH pool at launch on 2023/07/10 until 2025/04/02 versus passively holding each of the underlying assets.

![Screenshot 2025-04-03 at 21.59.35](https://hackmd.io/_uploads/H1xA8_2pJe.png)

Holding AAVE and wstETH outside of the liquidity pool generates a return of $147,355 versus $141,781 by holding the BPT. This means the impermanent loss incurred by LPs exceeds the yield from wstETH and swap fee volume by 5,574 USD.

#### AAVE Emissions

Since the pool was deployed, on average, stkABPT holders have received 12.24% in AAVE yield, 0.61% wstETH native yield and 2.74% swap fees for a Total yield of 15.51%.

![Screenshot 2025-04-03 at 22.01.26](https://hackmd.io/_uploads/HJK4vO2aJl.png)

Our [analysis](https://aave.tokenlogic.xyz/stkbpt) has shown depending on the compounding frequency of AAVE emission, the overall investment returns can vary widely. As a result, the affects of compounding has been omitted.

In return for holding stkABPT, users receive a premium relative to holding the underlying assets. The premium, 18.21% yield, compensates users for being exposed to the risk of impermanent loss, slashing and to Balancer v2. Do note this premium varies over time, it reduces when AAVE's price nominated in ETH increases and vice versa.

The below compares three different investment scenarios:

- Hold AAVE and wstETH, $147,355 (47.35%);
- Hold BPT with no AAVE Emissions, $141,781 (41.78%); and,
- Hold stkABPT and retain AAVE Emissions, $165,561 (65.56%).

![Screenshot 2025-04-03 at 22.04.13](https://hackmd.io/_uploads/Bkg9CvunaJl.png)

### Liquidity Distribution

Within the stkBPT SM category, 5 addresses are responsible for over 71.84% of the liquidity. Whilst these addresses are long term LPs, having a more diversified LP distribution reduces the reliance on select few addresses.

![Screenshot 2025-04-03 at 22.07.24](https://hackmd.io/_uploads/SJC5udnTJx.png)

By supporting DEX liquidity on Arbitrum, Base and Ethereum, we hope to reduce the concentration amongst LPs and support creating broader utility for the AAVE token beyond Ethereum. By providing direct liquidity provisions, the Aave DAO can provide a certain minimum amount of liquidity as a means of reducing overall liquidity derived expenses.

Several centralised exchanges are also in touch with tapping into "AAVE staking" yield that will be possible when the Umbrella and Aavenomic upgrades are live. This is expected to support greater adoption of AAVE across centralise exchanges.

In the near future, we are exploring deploying AAVE liquidity into a new Balancer v3 pool type well suited for volatile asset pairs. Pending having access to suitable data, this new pool could emerge as the preferred liquidity pool for AAVE liquidity on Balancer.

### Swap Distribution

An in depth analysis of the AAVE swap volume routing via the liquidity pool shows that 95.71% of all swaps are users acquiring 400 AAVE or less.

| ![Screenshot 2025-04-03 at 21.09.36](https://hackmd.io/_uploads/HyaWov36ke.png) | ![Screenshot 2025-04-03 at 21.14.09](https://hackmd.io/_uploads/Hkg7nDhTkg.png) |
| :-----------------------------------------------------------------------------: | :-----------------------------------------------------------------------------: |

The number of swaps per 10 AAVE bin size shows a distribution heavily skewed towards smaller swap sizes with key round numbers, 100, 200, 300 and 400 AAVE swap sizes featuring heavily amongst the data.

| ![Screenshot 2025-04-03 at 21.26.51](https://hackmd.io/_uploads/r17Vk_hT1l.png) | ![Screenshot 2025-04-03 at 21.26.13](https://hackmd.io/_uploads/HyUxy_hT1e.png) |
| :-----------------------------------------------------------------------------: | :-----------------------------------------------------------------------------: |

When comparing swap volume to the TVL in the pool, the largest daily swap volume as a % of the pool was 11.61% on the 20th Jan 2025 totalling $43.27M USD in value. The table below shows the largest swaps routed via the pool and indicates a very long tail up to 2.1M USD in swap size distribution.

![Screenshot 2025-04-03 at 21.46.37](https://hackmd.io/_uploads/S1Z67On6yl.png)

### stkABPT Emissions

The Aave DAO currently emitting 360 AAVE per day to stkBPT holders. Assuming a spot price of $150/AAVE, this is equivalent to $19.71M a year.

The yield from holding stkABPT relative to the underlying, 18.21%, compares favorable to holding stkAAVE at 4.72%. Given the slashing risk is 30% for both stkAAVE and stkBPT, the delta of 13.49% represents compensation for the additional Balancer exposure.

This publication proposes reducing AAVE emissions by one-third, to 240 AAVE/day. The resulting AAVE yield on stkBPT is estimated to reduce by 4.67%, to 11.96% at current rates whilst still comparing favorably to stkAAVE at a time when swap fees and the Lido Index rate is below historical averages.

Based upon the swap size distribution routing through the pool, an overall reduction in TVL would not adversely affect users seeking to acquire AAVE. However, earning near 12% for providing liquidity in the current market is also an attractive investment option for LPs to consider.

## Specification

This proposal when implemented via AIP will reduce the AAVE emission rate.

| SM Category | Current | Proposed |
| :---------- | :-----: | :------: |
| stkABPT     | 360/day | 240/day  |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250417_AaveV3Ethereum_StkABPTEmissionsUpdate/AaveV3Ethereum_StkABPTEmissionsUpdate_20250417.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250417_AaveV3Ethereum_StkABPTEmissionsUpdate/AaveV3Ethereum_StkABPTEmissionsUpdate_20250417.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x8dbeee9b489266cfefb8cb3c75fb0791d364975eed48cee951ff04fd17ee57c1)
- [Discussion](https://governance.aave.com/t/arfc-stkabpt-emissions-update/21683)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
