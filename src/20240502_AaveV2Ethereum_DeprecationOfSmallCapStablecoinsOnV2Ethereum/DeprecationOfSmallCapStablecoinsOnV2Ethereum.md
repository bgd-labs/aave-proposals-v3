---
title: "Deprecation of Small-cap Stablecoins on V2 Ethereum"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-deprecation-of-small-cap-stablecoins-on-v2-ethereum/17484/1"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xf6aaa50a6a76f44df9cfbbb760ca80878854dd16d88b16a3fc0f5fa6920741f0"
---

## Simple Summary

A proposal to deprecate USDP, GUSD, LUSD, FRAX, and sUSD on Aave V2

## Motivation

Following our ongoing efforts to deprecate the V2 markets and following the recent USDP volatility and subsequent freeze, we propose deprecating smaller market cap stablecoins on V2.

#### Deprecation Phase I

Recent events have highlighted the need for Aave to reduce its V2 exposure to lesser-used stablecoins, many of which have limited liquidity, thus allowing for price manipulation and other potentially harmful events. Previously, the community followed a two-phase process to deprecate stablecoins, with BUSD and TUSD as examples. Given the success of these, we propose a similar path forward. Notably, none of the below stablecoins are collateral assets, reducing the complication of the process.

For USDP, GUSD, LUSD, FRAX, and sUSD we propose the following parameters:

| Parameter         | Proposed Value |
| ----------------- | -------------- |
| Reserve Factor    | 95%            |
| Borrowing Enabled | No             |
| Base Rate         | 3%             |
| Slope1            | +3%            |
| Slope2            | 200%           |
| UOptimal          | 20%            |

The goal of Phase I is to increase borrower APR to encourage borrowers to repay their loans; this is achieved through higher Base Rate, Slope1, Slope2, and lower UOptimal. Additionally, we recommend leaving them frozen to prevent new supplies and borrowings. Finally, we increase the reserve factor to reduce supply APY, reducing the attractiveness of supply as borrowers pay increased rates.

Following observations from Phase I, we may move to further decrease UOptimal, increase Reserve Factor, and increase Slope2.

## Specification

USDP
| Parameter | Current Value | Proposed Value |
|-------------------|---------------|----------------|
| Reserve Factor | 45% | 95% |
| Borrowing Enabled | Yes | No |
| Base Rate | 0% | 3% |
| Slope1 | 12% | 15% |
| Slope2 | 75% | 200% |
| UOptimal | 80% | 20% |

GUSD
| Parameter | Current Value | Proposed Value |
|-------------------|---------------|----------------|
| Reserve Factor | 45% | 95% |
| Borrowing Enabled | Yes | No |
| Base Rate | 0% | 3% |
| Slope1 | 12% | 15% |
| Slope2 | 150% | 200% |
| UOptimal | 70% | 20% |

LUSD
| Parameter | Current Value | Proposed Value |
|-------------------|---------------|----------------|
| Reserve Factor | 50% | 95% |
| Borrowing Enabled | Yes | No |
| Base Rate | 0% | 3% |
| Slope1 | 12% | 15% |
| Slope2 | 75% | 200% |
| UOptimal | 80% | 20% |

FRAX
| Parameter | Current Value | Proposed Value |
|-------------------|---------------|----------------|
| Reserve Factor | 55% | 95% |
| Borrowing Enabled | Yes | No |
| Base Rate | 0% | 3% |
| Slope1 | 12% | 15% |
| Slope2 | 100% | 200% |
| UOptimal | 80% | 20% |

sUSD
| Parameter | Current Value | Proposed Value |
|-------------------|---------------|----------------|
| Reserve Factor | 55% | 95% |
| Borrowing Enabled | Yes | No |
| Base Rate | 0% | 3% |
| Slope1 | 12% | 15% |
| Slope2 | 100% | 200% |
| UOptimal | 80% | 20% |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240502_AaveV2Ethereum_DeprecationOfSmallCapStablecoinsOnV2Ethereum/AaveV2Ethereum_DeprecationOfSmallCapStablecoinsOnV2Ethereum_20240502.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240502_AaveV2Ethereum_DeprecationOfSmallCapStablecoinsOnV2Ethereum/AaveV2Ethereum_DeprecationOfSmallCapStablecoinsOnV2Ethereum_20240502.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xf6aaa50a6a76f44df9cfbbb760ca80878854dd16d88b16a3fc0f5fa6920741f0)
- [Discussion](https://governance.aave.com/t/arfc-deprecation-of-small-cap-stablecoins-on-v2-ethereum/17484/1)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
