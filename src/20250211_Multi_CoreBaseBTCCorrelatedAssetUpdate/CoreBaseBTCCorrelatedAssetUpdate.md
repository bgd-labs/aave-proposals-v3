---
title: "Core & Base - BTC Correlated Asset Update"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-core-base-btc-correlated-asset-update/20940"
snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x9efbc881d7db09b549a4c342387c31149c066de4bc51b625e2213d43aee0e977
---

## Simple Summary

This proposal focuses curating LBTC for growth across Core and Base instances of Aave v3. Several initiatives are included:

- Onboard LBTC on Base;
- Create LBTC/cbBTC eMode on Core instance;
- Create LBTC/cbBTC eMode on Base instance; and;
- Amend cbBTC Borrow Rate.

## Motivation

Lombard has demonstrated consistent growth, surpassing $1.8B in TVL, and has established itself as the leading BTC LST in the market. Its initial onboarding, coupled with the first liquid eMode alongside WBTC, quickly reached supply caps, highlighting strong demand for leverage loops between LBTC and BTC wrappers.

On Aave’s Core instance, cbBTC is the second-largest BTC wrapper. While it experienced strong growth post-listing, the absence of borrowing opportunities has limited its potential. The onboarding of LBTC introduces a new growth avenue for both LBTC, cbBTC and fBTC. The new liquid eModes will allow users to loop LBTC exposure while offering attractive deposit rates for cbBTC and fBTC holders, incentivizing them to supply liquidity and fuelling this strategy.

Specifically to fBTC, a points program will be applied to users who deposit fBTC and also, to different users who borrow fBTC. Leveraging LBTC/fBTC is expected to stimulate demand for fBTC.

To support this growth strategy, the optimal utilization rate (Uoptimal) for cbBTC and fBTC should be increased from 45% to 80%, aligning them with wBTC. The initial Uoptimal was set when cbBTC had minimal borrowing demand, but the introduction of this liquid eMode is expected to significantly boost cbBTC borrowing activity, warranting this adjustment. For fBTC, not yet listed, the opportunity between Lombard and Ignition developed relatively recently.

Additionally, Base has emerged as the second-largest platform for cbBTC growth. Onboarding LBTC to Base will replicate this successful dynamic, with LBTC users leveraging existing cbBTC liquidity. For Lombard, Base is already the third-largest ecosystem (after Mainnet and Berachain), with over $117M in TVL, making it an ideal environment to extend this growth strategy.

## Specification

### Core Instance

#### Amend cbBTC Borrow rate Uoptimal

|     Description      | Current | Proposed | Change |
| :------------------: | :-----: | :------: | :----: |
| Borrow Rate Uoptimal |   45%   |   80%    |  +35%  |

#### Liquid E-modes

|      Parameters       | Value | Value | Value |
| :-------------------: | :---: | :---: | :---: |
|         Asset         | LBTC  | wBTC  | cbBTC |
|      Collateral       |  Yes  |  No   |  No   |
|      Borrowable       |  No   |  Yes  |  Yes  |
|        Max LTV        |  84%  |   -   |   -   |
| Liquidation Threshold |  86%  |   -   |   -   |
|   Liquidation Bonus   | 3.00% |   -   |   -   |

### Base Instance

#### Onboarding of LBTC

The table below illustrates the configured risk parameters for **LBTC**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (LBTC)         |                                        800 |
| Borrow Cap (LBTC)         |                                         80 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       70 % |
| LT                        |                                       75 % |
| Liquidation Bonus         |                                      8.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        4 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       80 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x1E6c22AAA11F507af12034A5Dc4126A6A25DC8d2 |

#### Liquid E-modes

|      Parameters       | Value | Value |
| :-------------------: | :---: | :---: |
|         Asset         | LBTC  | cbBTC |
|      Collateral       |  Yes  |  No   |
|      Borrowable       |  No   |  Yes  |
|        Max LTV        |  84%  |   -   |
| Liquidation Threshold |  86%  |   -   |
|   Liquidation Bonus   | 3.00% |   -   |

The above is to be reviewed with feedback from Risk Service Providers to be incorporated.

#### Amend cbBTC Borrow rate Uoptimal

|     Description      | Current | Proposed | Change |
| :------------------: | :-----: | :------: | :----: |
| Borrow Rate Uoptimal |   45%   |   80%    |  +35%  |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250211_Multi_CoreBaseBTCCorrelatedAssetUpdate/AaveV3Ethereum_CoreBaseBTCCorrelatedAssetUpdate_20250211.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250211_Multi_CoreBaseBTCCorrelatedAssetUpdate/AaveV3Base_CoreBaseBTCCorrelatedAssetUpdate_20250211.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250211_Multi_CoreBaseBTCCorrelatedAssetUpdate/AaveV3Ethereum_CoreBaseBTCCorrelatedAssetUpdate_20250211.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250211_Multi_CoreBaseBTCCorrelatedAssetUpdate/AaveV3Base_CoreBaseBTCCorrelatedAssetUpdate_20250211.t.sol)
  [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x9efbc881d7db09b549a4c342387c31149c066de4bc51b625e2213d43aee0e977)
- [Discussion](https://governance.aave.com/t/arfc-core-base-btc-correlated-asset-update/20940)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
