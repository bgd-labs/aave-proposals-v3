---
title: "Deprecation of Long-tail Assets"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-deprecation-of-long-tail-assets/22592"
---

## Simple Summary

A proposal to adjust parameters to begin/continue the deprecation process for EURS on Polygon, SNX on Core, and LUSD on Arbitrum and OP due to a lack of liquidity and changing risk profiles.

## Motivation

### EURS (Polygon)

EURS has maintained downwards-trending supply and borrow cap utilization over much of the past year.

Additionally, there are virtually no assets borrowed against EURS, while borrows of EURS are largely collateralized by WBTC.

#### Liquidity

EURS’ on-chain market cap has remained low, not demonstrating significant growth since a large reduction in supply in November 2024. This indicates that, despite the market being offered on Aave, there is not substantial demand for the asset.

Additionally, 2.54M EURS are supplied on Aave V3 Polygon, relative to an on-chain supply of just 1.54M.

Further reflecting this downtrend, EURS’ on-chain liquidity against WBTC has deteriorated since last year, swaps of just 100K EURS now incur nearly 10% price slippage, necessitating an update in its risk parameters to align with its current profile.

#### Recommendation

To begin the deprecation of this market, we propose the following actions:

- Reduce the supply and borrow caps to 1, preventing new entries in the market while not negatively affecting current users
- Set LTV to 0% to prevent further collateralization of EURS
- Reduce the asset’s Debt Ceiling to $0 from $675K
- Increase the Base Rate from 0% to 2% to increase borrowing costs and encourage EURS borrowers to repay their debt
- Increase the Reserve Factor to 50% to offset increased supply APY from the Base Rate increase and to encourage suppliers to exit the market

### SNX (Ethereum Core)

In May, Chaos Labs [published](https://governance.aave.com/t/chaos-labs-risk-stewards-adjustment-of-supply-caps-borrow-caps-and-debt-ceiling-on-aave-v3-05-19-25/22114) a recommendation to begin the deprecation process for SNX, in part due to continued sUSD depegs and a planned Synthetix acquisition of Derive; this proposed acquisition was later [withdrawn](https://blog.synthetix.io/the-withdrawal-of-the-derive-acquisition-proposal/) because of community feedback. However, sUSD has been depegged since March, despite a [post](https://blog.synthetix.io/the-repeggening/) laying out plans to re-peg the asset on May 30, indicating increased risk associated with the protocol.

While previous actions have been successful in preventing further SNX exposure on Aave, the amount supplied and borrowed has been relatively resilient.

As a result, and in line with a broader community strategy to deprecate long-tailed assets that do not provide sufficient reward relative to their risk, we recommend continuing the deprecation of SNX with additional steps.

#### Recommendation

To continue the deprecation of this market, we propose the following actions:

- Set LTV to 0% to prevent further collateralization of SNX
- Reduce the asset’s Debt Ceiling to $0 from $4M
- Increase the Base Rate from 3% to 6% to increase borrowing costs and encourage SNX borrowers to repay their debt
- Increase the Reserve Factor to 95% to offset increased supply APY from the Base Rate increase and to encourage suppliers to exit the market

### LUSD (Arbitrum and OP)

LUSD supply on Arbitrum and Optimism has consistently contracted on both Arbitrum and Optimism over the past year, falling to 500K on Optimism and 170K on Arbitrum.

Additionally, the asset’s DEX liquidity has contracted on both Arbitrum and Optimism, displayed below against the top collateral asset for each market, described in more detail at the end of this section.

As a result of this contraction, it is prudent to begin deprecating these markets on Aave, which have also shown consistent outflows over the last year.

These assets cannot be used as collateral, making their depreciation process somewhat simpler than the previously discussed markets. However, in the event of liquidations, it would be necessary for a liquidator to purchase LUSD to repay the debt.

Taking into account the asset’s low liquidity against its top collateral asset on each respective chain, it is important to deprecate the market in such a way that limits potential liquidations while expediting users exiting the markets.

#### Recommendation

To begin the deprecation of these markets we propose the following actions:

- Reduce the supply and borrow caps to 1, preventing new entries in the market while not negatively affecting current users
- Increase the Base Rate to 2% to increase borrowing costs and encourage LUSD borrowers to repay their debt
- Increase the Reserve Factor to 50% to offset increased supply APY from the Base Rate increase and to encourage suppliers to exit the market

## Specification

The following changes will be applied:

### EURS (Polygon)

| Parameter      | Current | Recommended |
| -------------- | ------- | ----------- |
| LTV            | 65%     | 0%          |
| Debt Ceiling   | $675K   | $0          |
| Base Rate      | 0.00%   | 2.00%       |
| Reserve Factor | 20%     | 50%         |

### SNX (Ethereum Core)

| Parameter      | Current    | Recommended |
| -------------- | ---------- | ----------- |
| LTV            | 49%        | 0%          |
| Debt Ceiling   | $4,000,000 | $0          |
| Base Rate      | 3.00%      | 6.00%       |
| Reserve Factor | 35%        | 95%         |

### LUSD (Arbitrum)

| Parameter      | Current | Recommended |
| -------------- | ------- | ----------- |
| Base Rate      | 0.00%   | 2.00%       |
| Reserve Factor | 20%     | 50%         |

### LUSD (OP)

| Parameter      | Current | Recommended |
| -------------- | ------- | ----------- |
| Base Rate      | 0.00%   | 2.00%       |
| Reserve Factor | 20%     | 50%         |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250715_Multi_DeprecationOfLongTailAssets/AaveV3Ethereum_DeprecationOfLongTailAssets_20250715.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250715_Multi_DeprecationOfLongTailAssets/AaveV3Polygon_DeprecationOfLongTailAssets_20250715.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250715_Multi_DeprecationOfLongTailAssets/AaveV3Optimism_DeprecationOfLongTailAssets_20250715.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250715_Multi_DeprecationOfLongTailAssets/AaveV3Arbitrum_DeprecationOfLongTailAssets_20250715.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250715_Multi_DeprecationOfLongTailAssets/AaveV3Ethereum_DeprecationOfLongTailAssets_20250715.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250715_Multi_DeprecationOfLongTailAssets/AaveV3Polygon_DeprecationOfLongTailAssets_20250715.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250715_Multi_DeprecationOfLongTailAssets/AaveV3Optimism_DeprecationOfLongTailAssets_20250715.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250715_Multi_DeprecationOfLongTailAssets/AaveV3Arbitrum_DeprecationOfLongTailAssets_20250715.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-deprecation-of-long-tail-assets/22592)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
