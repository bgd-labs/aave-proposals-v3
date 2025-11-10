---
title: "[Direct to AIP] weETH E-Mode Risk Parameter Adjustment on Aave V3 Plasma Instance"
author: "Chaos Labs (implemented by ACI by via Skyward)"
discussions: "https://governance.aave.com/t/direct-to-aip-weeth-e-mode-risk-parameter-adjustment-on-aave-v3-plasma-instance/23381"
snapshot: Direct to AIP
---

## Simple Summary

The proposal recommends increasing the LT and LTV of Ether.fi restaked ETH in the weETH Stablecoin E-Mode on the Plasma instance in order to align the risk parameters of the asset in the E-Mode to the baseline configuration of weETH on the Ethereum Core instance.

## Motivation

When the Plasma instance was initially launched, we recommended introducing a stablecoin E-Mode for weETH while restricting base risk parameters. This approach was designed to mitigate potential exposure to volatile debt-collateral positions and account for early uncertainty around market liquidity and stability. The initial E-Mode parameters for weETH on Plasma were set slightly below those on Ethereum Core to reflect uncertainty about the instance’s market efficiency, as both LT and LTV were effectively discounted by 2% to reduce the amount of stablecoin debt each weETH token can accumulate. At the time of writing, both the asset and the instance have matured significantly, prompting a reassessment of the risk parameters.

## Specification

As market conditions have evolved, Plasma has improved in terms of liquidity depth, lending volumes, and overall efficiency. Specifically, the slippage on a 5,000 weETH sell order is limited to 3.5%. The aggregate supply of weETH on the instance currently exceeds $460 million (~100,000 tokens), surpassing WETH, which has a total supply of $160 million.

Furthermore, the market downturn on October 10th provided a measurable stress test of the system’s resilience, as weETH is primarily used to collateralize stablecoin borrow positions. Despite tightened liquidity conditions during the downturn, no bad debt was accrued, confirming that both risk controls and liquidation mechanisms functioned effectively. This outcome emphasizes the performance of the liquidation agreement facilitated by the Plasma team, which ensured orderly position unwinds.

Additionally, we observe that users who currently use weETH as collateral on the instance are primarily borrowing stablecoins within the dedicated weETH Stablecoin E-Mode. Therefore, the increase of the risk parameters of weETH would allow for additional stablecoin borrowing demand, boosting both protocol revenue and market efficiency.

### Recommendation

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

## References

- Implementation: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251110_AaveV3Plasma_WeETHPlasmaEModeUpdate/AaveV3Plasma_WeETHPlasmaEModeUpdate_20251110.sol)
- Tests: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251110_AaveV3Plasma_WeETHPlasmaEModeUpdate/AaveV3Plasma_WeETHPlasmaEModeUpdate_20251110.t.sol)
  [Snapshot](TODO)
- [Discussion](https://governance.aave.com/t/direct-to-aip-weeth-e-mode-risk-parameter-adjustment-on-aave-v3-plasma-instance/23381)

## Disclosure

Chaos Labs has not been compensated by any third party for publishing this recommendation.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain)
