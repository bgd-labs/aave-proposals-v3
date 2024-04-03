---
title: "TUSD and BUSD Aave V2 Rate Amendments"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-tusd-and-busd-aave-v2-rate-amendments/16887"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xcff2253ff9d74193354370fe95ebe0fe2f0b6f34873281d1b9b55b9f51dea011"
---

## Simple Summary

Amend Interest Rate parameters for TUSD and BUSD Aave V2 deprecated markets.

## Motivation

Currently, the highly aggressive interest rate strategy implemented for TUSD and BUSD markets, with the primary objective of deprecating, poses a challenge due to the distribution of bad debt within these markets.

Due to a significant amount of bad debt in these markets, the anticipated outcome of incentivizing debt repayments may not be realized to the same extent, alternatively resulting in effective virtual debt growth. Although the elevated reserve factor allows the collector to cover a substantial portion of the remaining aToken underlying claims of the respective market as other positions are repaid (provided the collector does not withdraw), this debt growth must be addressed. Otherwise, it could potentially escalate to an arbitrarily high market size, given the magnitude of the current interest rate.

## Specification

| Asset | Parameter | Current | Recommendations |
| ----- | --------- | ------- | --------------- |
| BUSD  | Base Rate | 100%    | 10%             |
| BUSD  | Slope 1   | 70%     | 0%              |
| BUSD  | Slope 2   | 300%    | 0%              |
| BUSD  | Uoptimal  | 1%      | No Change       |

| Asset | Parameter | Current | Recommendations |
| ----- | --------- | ------- | --------------- |
| TUSD  | Base Rate | 100%    | 10%             |
| TUSD  | Slope 1   | 70%     | 0%              |
| TUSD  | Slope 2   | 300%    | 0%              |
| TUSD  | Uoptimal  | 1%      | No Change       |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/64d84923830233364030bbf87f555208e05c78bd/src/20240324_AaveV2Ethereum_TUSDAndBUSDAaveV2RateAmendments/AaveV2Ethereum_TUSDAndBUSDAaveV2RateAmendments_20240324.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/64d84923830233364030bbf87f555208e05c78bd/src/20240324_AaveV2Ethereum_TUSDAndBUSDAaveV2RateAmendments/AaveV2Ethereum_TUSDAndBUSDAaveV2RateAmendments_20240324.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xcff2253ff9d74193354370fe95ebe0fe2f0b6f34873281d1b9b55b9f51dea011)
- [Discussion](https://governance.aave.com/t/arfc-tusd-and-busd-aave-v2-rate-amendments/16887)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
