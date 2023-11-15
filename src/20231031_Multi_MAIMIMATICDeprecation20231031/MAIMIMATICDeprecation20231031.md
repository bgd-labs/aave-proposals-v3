---
title: "MAI/MIMATIC deprecation, 2023.10.31"
author: "Gauntlet"
discussions: "https://governance.aave.com/t/arfc-gauntlet-recommendation-for-mai-mimatic-deprecation/15119"
---

## Summary

Given MAI/MIMATIC price drop to ~$0.72 and its inability to regain peg for the past few months, Gauntlet recommends to begin deprecation of MAI/MIMATIC. We aim to do so by changing LT and increasing borrow rates to incentivize repayment. Additionally, Gauntlet recommends freezing MAI/MIMATIC and setting MAI/MIMATIC LTV -> 0 on Avalanche, which was not executed in [this previous AIP](https://app.aave.com/governance/proposal/318/).

## Specification

#### LT reductions

| Chain        | Asset       | Current LT | Recommended LT |
| ------------ | ----------- | ---------- | -------------- |
| avalanche v3 | MAI/MIMATIC | 0.8        | 0.01           |
| arbitrum v3  | MAI/MIMATIC | 0.8        | 0.01           |
| polygon v3   | MAI/MIMATIC | 0.8        | 0.01           |
| optimism v3  | MAI/MIMATIC | 0.8        | 0.65           |

#### IR recommendations

Adjust Uopt to 0.45, Slope 2 to 300%, RF to 95%

| Chain        | Asset   | Current Uopt | Current Slope2 | Current RF | Recommended Uopt | Recommended Slope2 | Recommended RF |
| ------------ | ------- | ------------ | -------------- | ---------- | ---------------- | ------------------ | -------------- |
| arbitrum v3  | MAI     | 0.8          | 0.75           | 0.2        | 0.45             | 3                  | 0.95           |
| avalanche v3 | MAI     | 0.8          | 0.75           | 0.2        | 0.45             | 3                  | 0.95           |
| optimism v3  | MAI     | 0.8          | 0.75           | 0.2        | 0.45             | 3                  | 0.95           |
| polygon v3   | miMATIC | 0.8          | 0.75           | 0.2        | 0.45             | 3                  | 0.95           |

#### Freeze MAI and set LTV -> 0 on Avalanche

| Chain        | Asset       | Action                       |
| ------------ | ----------- | ---------------------------- |
| avalanche v3 | MAI/MIMATIC | Freeze Reserve, set LTV -> 0 |

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/66b52de254b64062a4654440fae7d9a07b32f0e5/src/20231031_Multi_MAIMIMATICDeprecation20231031/AaveV3Polygon_MAIMIMATICDeprecation20231031_20231031.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/66b52de254b64062a4654440fae7d9a07b32f0e5/src/20231031_Multi_MAIMIMATICDeprecation20231031/AaveV3Avalanche_MAIMIMATICDeprecation20231031_20231031.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/66b52de254b64062a4654440fae7d9a07b32f0e5/src/20231031_Multi_MAIMIMATICDeprecation20231031/AaveV3Optimism_MAIMIMATICDeprecation20231031_20231031.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/66b52de254b64062a4654440fae7d9a07b32f0e5/src/20231031_Multi_MAIMIMATICDeprecation20231031/AaveV3Arbitrum_MAIMIMATICDeprecation20231031_20231031.sol)
- Tests: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/66b52de254b64062a4654440fae7d9a07b32f0e5/src/20231031_Multi_MAIMIMATICDeprecation20231031/AaveV3Polygon_MAIMIMATICDeprecation20231031_20231031.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/66b52de254b64062a4654440fae7d9a07b32f0e5/src/20231031_Multi_MAIMIMATICDeprecation20231031/AaveV3Avalanche_MAIMIMATICDeprecation20231031_20231031.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/66b52de254b64062a4654440fae7d9a07b32f0e5/src/20231031_Multi_MAIMIMATICDeprecation20231031/AaveV3Optimism_MAIMIMATICDeprecation20231031_20231031.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/66b52de254b64062a4654440fae7d9a07b32f0e5/src/20231031_Multi_MAIMIMATICDeprecation20231031/AaveV3Arbitrum_MAIMIMATICDeprecation20231031_20231031.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x9b7173e3f91ba3cab15dbe2d6d241de2e58b027612c690f00609d6e4fb422748)
- [Discussion](https://governance.aave.com/t/arfc-gauntlet-recommendation-for-mai-mimatic-deprecation/15119)

## Disclaimer

Gauntlet has not received any compensation from any third-party in exchange for recommending any of the actions contained in this proposal.

By approving this proposal, you agree that any services provided by Gauntlet shall be governed by the terms of service available at gauntlet.network/tos.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

_By approving this proposal, you agree that any services provided by Gauntlet shall be governed by the terms of service available at gauntlet.network/tos._
