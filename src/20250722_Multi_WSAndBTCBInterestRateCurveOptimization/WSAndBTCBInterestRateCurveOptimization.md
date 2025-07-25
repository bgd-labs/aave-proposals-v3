---
title: "wS and BTC.b Interest Rate Curve Optimization"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-ws-and-btc-b-interest-rate-curve-optimization/21962"
---

## Simple Summary

Chaos Labs recommends adjusting wS’s IR curve on Aave V3 Sonic and BTC.b’s IR curve on Aave V3 Avalanche to better facilitate leveraged yield and directional trading strategies. This proposal will follow the Direct-to-AIP process.

## Motivation

### wS (Sonic)

To this point, wS has primarily been used as collateral to borrow USDC.e, and has been borrowed against USDC.e.

However, the recent listing of stS alongside the ensuing listing of wOS creates a new use case for wS as a debt asset. Namely, users may wish to borrow wS against such LSTs to enhance their yield.

One of the most important changes will be adjusting wS’s UOptimal upwards, allowing for a greater proportion of the wS supplied to be borrowed at a cheaper rate. However, this is only feasible if wS’s liquidity is strong enough to support its use as collateral; the primary risk of increasing UOptimal is creating a situation in which utilization reaches 100% during times of stress, coupled with significant wS collateral utilization, during which liquidations would not be able to be processed. wS’s liquidity has remained stable and relatively deep over the past month and a half.

As a result, in accordance with the underlying asset volatility, we recommend increasing the asset’s UOptimal to 80% from the current 45%. This change alone will open up roughly $30M of wS that can be borrowed before breaching the kink.

Additionally, we recommend adjusting Slope1 such that it is marginally lower than the stS staking yield to facilitate optimal revenue generation in accordance with prospective use cases.

With a median stS staking APY over the last 30 days of 4.56%, we thus recommend setting the Slope1 to 4.00%.

To ensure that there is not significant rate volatility just above UOptimal, we also recommend decreasing Slope2 from 300% to 80%, finding that 80% is still sufficient to encourage users to repay loans/suppliers to deposit when the asset is highly utilized.

Finally, anticipating that these changes will bring significant new borrowing activity, we recommend doubling the supply cap from 50M to 100M.

### BTC.b (Avalanche)

Over the past few months, BTC.b has experienced a notable increase in organic (non-recursive) borrowing demand, primarily driven by WAVAX-collateralized debt positions. This contrasts with earlier periods, where borrowing activity was largely fueled by recursive BTC.b collateral positions, incentivized through external rewards.

To further stimulate borrowing demand, we recommend implementing similar interest rate curve adjustments to those previously applied to BTC-denominated markets exhibiting strong borrowing activity. Specifically, we propose modifying the default tail asset configuration by increasing the Optimal Utilization Rate from 45% to 80%, reducing Slope1 to 4%, and raising the Reserve Factor to 50%. These changes align with the BTC-denominated strategy outlined in the [referenced ARFC](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-wbtc-reserve-factor-and-uoptimal-increase-10-25-24/19596) and are supported by the observed uptick in demand.

## Specification

### wS (Sonic)

| Parameter | Current | Recommended |
| --------- | ------- | ----------- |
| UOptimal  | 45%     | 80%         |
| Slope1    | 7.00%   | 4.00%       |
| Slope2    | 300.00% | 80.00%      |

### BTC.b (Avalanche)

| Parameter      | Current | Recommended |
| -------------- | ------- | ----------- |
| UOptimal       | 45%     | 80%         |
| Slope1         | 7.00%   | 4.00%       |
| Slope2         | 300.00% | 80.00%      |
| Reserve Factor | 20%     | 50%         |

## References

- Implementation: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250722_Multi_WSAndBTCBInterestRateCurveOptimization/AaveV3Avalanche_WSAndBTCBInterestRateCurveOptimization_20250722.sol), [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250722_Multi_WSAndBTCBInterestRateCurveOptimization/AaveV3Sonic_WSAndBTCBInterestRateCurveOptimization_20250722.sol)
- Tests: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250722_Multi_WSAndBTCBInterestRateCurveOptimization/AaveV3Avalanche_WSAndBTCBInterestRateCurveOptimization_20250722.t.sol), [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250722_Multi_WSAndBTCBInterestRateCurveOptimization/AaveV3Sonic_WSAndBTCBInterestRateCurveOptimization_20250722.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-ws-and-btc-b-interest-rate-curve-optimization/21962)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
