---
title: "Aave v2 Deprecation - Update"
author: "@TokenLogic & BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-aave-v2-deprecation-update/23008/2"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x0c5427caf17d21b321a3b62362d085e580446b136b0eccf7f4dc377856025486"
---

## Simple Summary

This proposal presents the next round of parameter updates to be implemented as we work towards deprecating v2 instances of Aave Protocol across Polygon, Ethereum and Avalanche.

## Motivation

This proposal builds on previous efforts that froze both Polygon v2 and Avalanche v2, supporting the deprecation of Aave v2 and ensuring a smooth, controlled, and secure transition to Aave v3.

The proposed changes are designed to increase borrowing costs through adjustments to the interest rate curve parameters, creating stronger incentives for users to migrate to Aave v3. Where practical, a standardized approach of reducing the Uoptimal parameter has been applied, alongside adjustments to the Base and Slope1 parameters to raise borrow rates. At the same time, the Slope2 parameter has been reduced to avoid excessive borrowing costs at near-full utilization. Overall, these changes raise borrow rates without exposing users to extreme costs.

The updated Uoptimal parameter now exceeds current reserve utilization levels and is expected to be progressively lowered toward a 25% target.

For commonly borrowed assets, the Base parameter is increased to 5%, with further increases planned as reserve liquidity decreases. This gradual adjustment ensures a minimum borrow rate is always maintained.

Additionally, the Reserve Factor is increased to 85%, resulting in lower deposit rates that discourage idle capital remaining in v2.

These changes represent a coordinated effort among several service providers to align incentives and ensure the long-term health of the Aave ecosystem.

---

In [proposal 378](https://vote.onaave.com/proposal/?proposalId=378&ipfsHash=0x81a22e1d8c05b3061c45954cc83c807553fed9fae55cb6e074edf8f8557f5f8b), the metadata(symbol & name) was incorrectly configured on the aWBTC implementation due to minor technical differences between the v2 versions. Therefore, this proposal will update the aWBTC implementation on mainnet core, with a code-wise identical but correctly initialized version.

## Specification

### Ethereum v2

RF / Base / Uoptimal

| Asset | RF Current | RF Proposed | Base Current | Base Proposed | Uoptimal Current | Uoptimal Proposed |
| ----- | ---------- | ----------- | ------------ | ------------- | ---------------- | ----------------- |
| wETH  | 85.00%     | 85.00%      | 0.00%        | 5.00%         | 80.00%           | 25.00%            |
| wBTC  | 90.00%     | 90.00%      | 0.00%        | 20.00%        | 65.00%           | 25.00%            |
| USDC  | 70.00%     | 85.00%      | 0.00%        | 5.00%         | 90.00%           | 60.00%            |
| USDT  | 70.00%     | 85.00%      | 0.00%        | 5.00%         | 80.00%           | 40.00%            |
| DAI   | 70.00%     | 85.00%      | 0.00%        | 5.00%         | 80.00%           | 50.00%            |

Slopes

| Asset | Slope1 Current | Slope1 Proposed | Slope2 Current | Slope2 Proposed |
| ----- | -------------- | --------------- | -------------- | --------------- |
| wETH  | 3.80%          | 5.00%           | 80.00%         | 40.00%          |
| wBTC  | 0.00%          | 0.00%           | 300.00%        | 40.00%          |
| USDC  | 12.50%         | 12.50%          | 60.00%         | 40.00%          |
| USDT  | 12.50%         | 12.50%          | 60.00%         | 40.00%          |
| DAI   | 12.50%         | 12.50%          | 60.00%         | 40.00%          |

### Polygon v2

RF / Base / Uoptimal

| Asset  | RF Current | RF Proposed | Base Current | Base Proposed | Uoptimal Current | Uoptimal Proposed |
| ------ | ---------- | ----------- | ------------ | ------------- | ---------------- | ----------------- |
| wETH   | 99.99%     | 99.99%      | 0.00%        | 5.00%         | 40.00%           | 25.00%            |
| wBTC   | 99.99%     | 99.99%      | 0.00%        | 20.00%        | 37.00%           | 25.00%            |
| USDC.e | 99.99%     | 99.99%      | 0.00%        | 5.00%         | 77.00%           | 65.00%            |
| DAI    | 99.99%     | 99.99%      | 0.00%        | 5.00%         | 71.00%           | 45.00%            |
| USDT   | 99.99%     | 99.99%      | 0.00%        | 5.00%         | 52.00%           | 35.00%            |
| POL    | 99.99%     | 99.99%      | 0.00%        | 5.00%         | 48.00%           | 25.00%            |

Slopes

| Asset  | Slope1 Current | Slope1 Proposed | Slope2 Current | Slope2 Proposed |
| ------ | -------------- | --------------- | -------------- | --------------- |
| wETH   | 10.00%         | 15.00%          | 134.00%        | 40.00%          |
| wBTC   | 0.00%          | 0.00%           | 134.00%        | 40.00%          |
| USDC.e | 15.00%         | 15.00%          | 134.00%        | 40.00%          |
| DAI    | 15.00%         | 15.00%          | 134.00%        | 40.00%          |
| USDT   | 15.00%         | 15.00%          | 134.00%        | 40.00%          |
| POL    | 12.00%         | 15.00%          | 134.00%        | 40.00%          |

### Avalanche v2

RF / Base / Uoptimal

| Asset  | RF Current | RF Proposed | Base Current | Base Proposed | Uoptimal Current | Uoptimal Proposed |
| ------ | ---------- | ----------- | ------------ | ------------- | ---------------- | ----------------- |
| wBTC.e | 99.99%     | 99.99%      | 20.00%       | 20.00%        | 45.00%           | 25.00%            |
| wETH   | 80.00%     | 85.00%      | 0.00%        | 5.00%         | 45.00%           | 25.00%            |
| USDC.e | 80.00%     | 85.00%      | 0.00%        | 5.00%         | 80.00%           | 25.00%            |
| AVAX   | 80.00%     | 85.00%      | 0.00%        | 5.00%         | 45.00%           | 25.00%            |
| USDT.e | 80.00%     | 85.00%      | 0.00%        | 5.00%         | 80.00%           | 45.00%            |
| DAI    | 80.00%     | 85.00%      | 0.00%        | 5.00%         | 80.00%           | 80.00%            |

Slopes

| Asset  | Slope1 Current | Slope1 Proposed | Slope2 Current | Slope2 Proposed |
| ------ | -------------- | --------------- | -------------- | --------------- |
| wBTC.e | 0.00%          | 0.00%           | 300.00%        | 40.00%          |
| wETH   | 10.00%         | 15.00%          | 300.00%        | 40.00%          |
| USDC.e | 0.00%          | 0.00%           | 75.00%         | 40.00%          |
| AVAX   | 5.00%          | 15.00%          | 300.00%        | 40.00%          |
| USDT.e | 9.00%          | 15.00%          | 75.00%         | 40.00%          |
| DAI    | 9.00%          | 15.00%          | 75.00%         | 40.00%          |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250925_Multi_AaveV2DeprecationUpdate/AaveV2Ethereum_AaveV2DeprecationUpdate_20250925.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250925_Multi_AaveV2DeprecationUpdate/AaveV2Polygon_AaveV2DeprecationUpdate_20250925.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250925_Multi_AaveV2DeprecationUpdate/AaveV2Avalanche_AaveV2DeprecationUpdate_20250925.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250925_Multi_AaveV2DeprecationUpdate/AaveV2Ethereum_AaveV2DeprecationUpdate_20250925.t.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250925_Multi_AaveV2DeprecationUpdate/AaveV2Polygon_AaveV2DeprecationUpdate_20250925.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250925_Multi_AaveV2DeprecationUpdate/AaveV2Avalanche_AaveV2DeprecationUpdate_20250925.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x0c5427caf17d21b321a3b62362d085e580446b136b0eccf7f4dc377856025486)
- [Discussion](https://governance.aave.com/t/arfc-aave-v2-deprecation-update/23008/2)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
