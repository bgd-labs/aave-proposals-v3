---
title: "Chaos Labs RF and IR Updates - Aave V2 Ethereum"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-rf-and-ir-updates-aave-v2-ethereum-2023-11-24/15661"
---

## Simple Summary

A proposal to update Reserve Factors and IR curves for frozen assets on V2 Ethereum as part of the ongoing deprecation plan.

## Motivation

In the past several months, the community is in the process of gradually winding down the V2 markets via a series of LT reductions and incremental increases in RFs. These efforts have been ongoing with the following proposals already implemented:

- [[ARFC] Chaos Labs - Incremental Reserve Factor Updates - Aave V2 Ethereum](https://governance.aave.com/t/arfc-chaos-labs-incremental-reserve-factor-updates-aave-v2-ethereum/13766)
- [[ARFC] Freeze CRV on V2](https://governance.aave.com/t/arfc-gauntlet-recommendation-on-freezing-crv-for-aave-v2-ethereum/14428)
- [[ARFC] Chaos Labs Risk Parameter Updates - Aave V2 Ethereum - 2023.6.23](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v2-ethereum-2023-6-23/13789)
- [[ARFC] TUSD Offboarding Plan](https://governance.aave.com/t/arfc-tusd-offboarding-plan/14008)
- [[ARFC] Set CRV LTV to Zero on V2](https://governance.aave.com/t/post-vyper-exploit-crv-market-update-and-recommendations/14214/4)
- [[ARFC] Chaos Labs Risk Parameter Updates - Aave V2 Ethereum - 2023.08.09](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v2-ethereum-2023-08-09/14404)
- [[ARFC] CRV Aave V2 Ethereum - LT Reduction - 08.21.2023](https://governance.aave.com/t/arfc-crv-aave-v2-ethereum-lt-reduction-08-21-2023/14589/7)
- [[ARFC] TUSD Offboarding Plan Part II](https://governance.aave.com/t/arfc-tusd-offboarding-plan-part-ii/14863)
- [[ARFC] CRV Aave V2 Ethereum - LT Reduction - 09.19.2023](https://governance.aave.com/t/arfc-crv-aave-v2-ethereum-lt-reduction-09-19-2023/14890/4)
- [[ARFC] V2 Ethereum Deprecation 10.03.2023](https://governance.aave.com/t/arfc-v2-ethereum-deprecation-10-03-2023/15040/7)
- [[ARFC] V2 Ethereum LT Reductions - 10.27.2023](https://governance.aave.com/t/arfc-v2-ethereum-lt-reductions-10-27-2023/15249/6)
- [[ARFC] V2 Ethereum Deprecation 11.20.2023](https://governance.aave.com/t/arfc-v2-ethereum-deprecation-11-20-2023/15628/3)

Below are the current supply and borrow amounts and utilization for V2 Ethereum frozen assets, excluding assets that have already had IR curves amended in previous proposals and LINK, which will be accommodated separately:

| Asset  | Total Supply ($) | Total Borrows ($) | Utilization Rate | Borrow APY | Base | Uoptimal | Slope1 | Slope2 |
| ------ | ---------------- | ----------------- | ---------------- | ---------- | ---- | -------- | ------ | ------ |
| CRV    | $10,580,000      | $2,310,000        | 21.83%           | 10.44%     | 3%   | 45%      | 17%    | 300%   |
| SNX    | $3,570,000       | $2,080,000        | 58.26%           | 12.44%     | 3%   | 80%      | 15%    | 100%   |
| MKR    | $4,830,000       | $341,800          | 7.08%            | 1.11%      | 0%   | 45%      | 7%     | 300%   |
| DPI    | $322,890         | $264,000          | 81.76%           | 586%       | 0%   | 50%      | 7%     | 300%   |
| ZRX    | $1,840,000       | $210,290          | 11.43%           | 0.18%      | 0%   | 45%      | 7%     | 300%   |
| CVX    | $510,630         | $199,390          | 39.05%           | 6.24%      | 0%   | 45%      | 7%     | 300%   |
| 1INCH  | $107,930         | $107,930          | 100.00%          | 2054%      | 0%   | 45%      | 7%     | 300%   |
| MANA   | $860,890         | $68,980           | 8.01%            | 1.25%      | 0%   | 45%      | 7%     | 300%   |
| ENJ    | $421,880         | $53,730           | 12.74%           | 2%         | 0%   | 45%      | 7%     | 300%   |
| RAI    | $257,980         | $49,400           | 19.15%           | 0.96%      | 0%   | 80%      | 4%     | 75%    |
| UNI    | $5,650,000       | $47,010           | 0.83%            | 0.13%      | 0%   | 45%      | 7%     | 300%   |
| AMPL   | $40,750          | $39,800           | 97.67%           | 186.21K%   | 1%   | 80%      | 3%     | 750%   |
| BAT    | $168,860         | $36,360           | 21.53%           | 3.41%      | 0%   | 45%      | 7%     | 300%   |
| BAL    | $465,520         | $35,720           | 7.67%            | 7.37%      | 5%   | 80%      | 27%    | 150%   |
| YFI    | $1,160,000       | $27,900           | 2.41%            | 0.37%      | 0%   | 45%      | 7%     | 300%   |
| KNCL   | $32,320          | $20,330           | 62.90%           | 8.03%      | 0%   | 65%      | 8%     | 300%   |
| ENS    | $9,200,000       | $18,200           | 0.20%            | 0.03%      | 0%   | 45%      | 7%     | 300%   |
| UST    | $85,430          | $10,150           | 11.88%           | 0.60%      | 0%   | 45%      | 7%     | 300%   |
| REN    | $174,060         | $6,900            | 3.96%            | 0.62%      | 0%   | 45%      | 7%     | 300%   |
| xSUSHI | $888,870         | $727              | 0.08%            | 0.01%      | 0%   | 45%      | 7%     | 300%   |

As part of our ongoing deprecation process, we propose the following measures designed to motivate the repayment of borrowed assets and the redemption of supplied assets:

### Increase Reserve Factors:

In order to further disincentivize the supply of the assets being deprecated, this proposal recommends setting the RFs of all frozen assets on V2 Ethereum to near 100%. This change will effectively remove any yield for depositors of these assets, thereby discouraging their supply.

### Increase Borrow Rates:

To encourage the repayment of borrowed assets, we propose raising the borrow rates across V2 frozen assets. This will be achieved by creating a constant borrow rate up to the currently set UOptomal configuration, with the moderate option as voted by the community on Snapshot:

_Moderate (Chaos Recommendation):_

1. Set Base Rate at 20%
2. Set Slope1 at 0%
3. Set Slope2 at 300%

After these changes are put into effect, we'll evaluate their influence on loan repayments and, if necessary, offer additional recommendations. Future updates could involve further hikes in borrow rates and adjustments to the UOptimal points.

## Specification

| Asset  | Current RF | Rec RF | Current Base | Recommended Base | Current Slope1 | Recommended Slope1 | Current Slope2 | Recommended Slope2 |
| ------ | ---------- | ------ | ------------ | ---------------- | -------------- | ------------------ | -------------- | ------------------ |
| 1INCH  | 30%        | 99.90% | 0%           | 20%              | 7%             | 0%                 | 300%           | 300%               |
| BAL    | 35%        | 99.90% | 5%           | 20%              | 22%            | 0%                 | 150%           | 300%               |
| BAT    | 35%        | 99.90% | 0%           | 20%              | 7%             | 0%                 | 300%           | 300%               |
| CRV    | 30%        | 99.90% | 3%           | 20%              | 14%            | 0%                 | 300%           | 300%               |
| CVX    | 35%        | 99.90% | 0%           | 20%              | 7%             | 0%                 | 300%           | 300%               |
| DPI    | 35%        | 99.90% | 0%           | 20%              | 7%             | 0%                 | 300%           | 300%               |
| ENJ    | 35%        | 99.90% | 0%           | 20%              | 7%             | 0%                 | 300%           | 300%               |
| ENS    | 30%        | 99.90% | 0%           | 20%              | 7%             | 0%                 | 300%           | 300%               |
| MANA   | 50%        | 99.90% | 0%           | 20%              | 7%             | 0%                 | 300%           | 300%               |
| MKR    | 30%        | 99.90% | 0%           | 20%              | 7%             | 0%                 | 300%           | 300%               |
| REN    | 35%        | 99.90% | 0%           | 20%              | 7%             | 0%                 | 300%           | 300%               |
| SNX    | 45%        | 99.90% | 3%           | 20%              | 12%            | 0%                 | 100%           | 300%               |
| UNI    | 30%        | 99.90% | 0%           | 20%              | 7%             | 0%                 | 300%           | 300%               |
| xSUSHI | 50%        | 99.90% | 0%           | 20%              | 7%             | 0%                 | 300%           | 300%               |
| YFI    | 35%        | 99.90% | 0%           | 20%              | 7%             | 0%                 | 300%           | 300%               |
| ZRX    | 35%        | 99.90% | 0%           | 20%              | 7%             | 0%                 | 300%           | 300%               |
| KNCL   | 30%        | 99.90% | 0%           | 20%              | 8%             | 0%                 | 300%           | 300%               |
| UST    | 20%        | 99.90% | 0%           | 20%              | 4%             | 0%                 | 300%           | 300%               |
| AMPL   | 10%        | 99.90% | 1%           | 20%              | 2%             | 0%                 | 750%           | 300%               |
| RAI    | 20%        | 99.90% | 0%           | 20%              | 4%             | 0%                 | 75%            | 300%               |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231203_AaveV2Ethereum_ChaosLabsRFAndIRUpdatesAaveV2Ethereum/AaveV2Ethereum_ChaosLabsRFAndIRUpdatesAaveV2Ethereum_20231203.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231203_AaveV2Ethereum_ChaosLabsRFAndIRUpdatesAaveV2Ethereum/AaveV2Ethereum_ChaosLabsRFAndIRUpdatesAaveV2Ethereum_20231203.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xbdd7c43d6e435c6c1ed08183f9e2e78f66a24436f45d48f04b85487a2f96e387)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-rf-and-ir-updates-aave-v2-ethereum-2023-11-24/15661)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
