---
title: "[ARFC] Deprecate Aave V2 AMM Market - Step 2"
author: "Gauntlet"
discussions: "https://governance.aave.com/t/arfc-deprecate-aave-v2-amm-market-step-2/16408/1"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x0ade316f52d5f763160ea15538a71a4682ae1b708864e8d33497d8de40ad9973"
---

## Simple Summary

A proposal for further deprecation recommendations on Aave AMM v2. For more details, see the full forum post [here](https://governance.aave.com/t/arfc-deprecate-aave-v2-amm-market-step-2/16408/2).

## Motivation

Gauntlet aims to reduce the remaining $94k borrow position and migrate users off the AMM market. Further analysis and information can be found in our forum [post](https://governance.aave.com/t/arfc-deprecate-aave-v2-amm-market-step-2/16408).

## Specification

Gauntlet recommends to increase reserve factor to 99% for the following assets:

| Asset | Current RF | Recommended RF |
| ----- | ---------- | -------------- |
| WETH  | 0.1        | 0.99           |
| DAI   | 0.1        | 0.99           |
| USDC  | 0.1        | 0.99           |
| WBTC  | 0.2        | 0.99           |
| USDT  | 0.1        | 0.99           |

Gauntlet recommends to adjust the IR params for the following assets:
| Asset | Current Variable Base | Recommended Variable Base | Current Variable Slope1 | Recommended Variable Slope1 |
| ----- | --------------------- | ------------------------- | ----------------------- | --------------------------- |
| WETH | 0 | 0.06 | 0.08 | No Change |
| DAI | 0 | 0.04 | 0.04 | 0.1 |
| USDC | 0 | 0.04 | 0.04 | 0.1 |
| WBTC | 0 | 0.05 | 0.08 | No Change |
| USDT | 0 | 0.06 | 0.04 | 0.1 |

## References

- Implementation: [AaveV2EthereumAMM](https://github.com/bgd-labs/aave-proposals-v3/blob/39189d59297210e893235715f70923ede3acfa07/src/20240205_AaveV2EthereumAMM_ARFCDeprecateAaveV2AMMMarketStep2/AaveV2EthereumAMM_ARFCDeprecateAaveV2AMMMarketStep2_20240205.sol)
- Tests: [AaveV2EthereumAMM](https://github.com/bgd-labs/aave-proposals-v3/blob/39189d59297210e893235715f70923ede3acfa07/src/20240205_AaveV2EthereumAMM_ARFCDeprecateAaveV2AMMMarketStep2/AaveV2EthereumAMM_ARFCDeprecateAaveV2AMMMarketStep2_20240205.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x0ade316f52d5f763160ea15538a71a4682ae1b708864e8d33497d8de40ad9973)
- [Discussion](https://governance.aave.com/t/arfc-deprecate-aave-v2-amm-market-step-2/16408/1)

## Disclaimer

Gauntlet has not been compensated by any third party for publishing this ARFC.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

_By approving this proposal, you agree that any services provided by Gauntlet shall be governed by the terms of service available at gauntlet.network/tos._
