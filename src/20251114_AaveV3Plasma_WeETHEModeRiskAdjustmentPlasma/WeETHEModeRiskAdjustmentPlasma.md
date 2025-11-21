---
title: "[Direct to AIP] weETH E-Mode Risk Parameter Adjustment on Aave V3 Plasma Instance"
author: "Chaos Labs (implemented by ACI via Skyward)"
discussions: "https://governance.aave.com/t/direct-to-aip-weeth-e-mode-risk-parameter-adjustment-on-aave-v3-plasma-instance/23381"
---

## Simple Summary

The proposal recommends increasing the LT and LTV of [Ether.fi](http://Ether.fi) restaked ETH in the weETH Stablecoin E-Mode on the Plasma instance in order to align the risk parameters of the asset in the E-Mode to the baseline configuration of weETH on the Ethereum Core instance.

## Motivation

When the Plasma instance was initially launched, we recommended introducing a Stablecoin E-Mode for weETH while restricting base risk parameters. This approach was designed to mitigate potential exposure to volatile debt-collateral positions and account for early uncertainty around market liquidity and stability. The initial E-Mode parameters for weETH on Plasma were set slightly below those on Ethereum Core to reflect uncertainty about the instance's market efficiency, as both LT and LTV were effectively discounted by 2% to reduce the amount of stablecoin debt each weETH token can accumulate. At the time of writing, both the asset and the instance have matured significantly, prompting a reassessment of the risk parameters.

## Market State

As market conditions have evolved, Plasma has improved in terms of liquidity depth, lending volumes, and overall efficiency. Specifically, the slippage on a 5,000 weETH sell order is limited to 3.5%. The aggregate supply of weETH on the instance currently exceeds $460 million (~100,000 tokens), surpassing WETH, which has a total supply of $160 million.

![image (7)|2000x1243](https://europe1.discourse-cdn.com/flex013/uploads/aave/original/2X/2/22be1659c9f33907262cf7bd0baa0b710693ded1.jpeg)

Furthermore, the market downturn on October 10th provided a measurable stress test of the system’s resilience, as weETH is primarily used to collateralize stablecoin borrow positions. Despite tightened liquidity conditions during the downturn, no bad debt was accrued, confirming that both risk controls and liquidation mechanisms functioned effectively. This outcome emphasizes the performance of the liquidation agreement facilitated by the Plasma team, which ensured orderly position unwinds.

![image (8)|2000x1241](https://europe1.discourse-cdn.com/flex013/uploads/aave/original/2X/4/42403c7b43cf6a418e7c1067863ae616148e5c5b.png)

Additionally, we observe that users who currently use weETH as collateral on the instance are primarily borrowing stablecoins within the dedicated weETH Stablecoin E-Mode. Therefore, the increase of the risk parameters of weETH would allow for additional stablecoin borrowing demand, boosting both protocol revenue and market efficiency.

## Recommendation

Given these developments, we propose increasing the E-Mode parameters by raising the LT to 80% and the LTV to 77.5%, thereby aligning the E-Mode with the weETH configuration on Ethereum Core. The adjustment is supported by the maturity of the instance, which has grown to over $4.5 billion, as well as the establishment of deep weETH liquidity pools paired with high market efficiency, and substantial demand to utilize the asset as collateral within the instance.

**weETH Stablecoin E-Mode**

| **Parameter**         | Current | Recommended |
| --------------------- | ------- | ----------- |
| Asset                 | weETH   | weETH       |
| Collateral            | Yes     | Yes         |
| Borrowable            | No      | No          |
| Max LTV               | 75%     | 77.5%       |
| Liquidation Threshold | 78%     | 80%         |
| Liquidation Bonus     | 7.50%   | 7.50%       |

## Disclosure

Chaos Labs has not been compensated by any third party for publishing this recommendation.

## References

- Implementation: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251114_AaveV3Plasma_WeETHEModeRiskAdjustmentPlasma/AaveV3Plasma_WeETHEModeRiskAdjustmentPlasma_20251114.sol)
- Tests: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251114_AaveV3Plasma_WeETHEModeRiskAdjustmentPlasma/AaveV3Plasma_WeETHEModeRiskAdjustmentPlasma_20251114.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-weeth-e-mode-risk-parameter-adjustment-on-aave-v3-plasma-instance/23381)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
