---
title: " Adjusting Interest Rate Curve for weETH on Arbitrum"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-adjusting-interest-rate-curve-for-weeth-on-arbitrum/17804"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xed2fd3dfee1f29f04b6cda4a5c4629fcca32a5c961b1b3e2a49ba6842367ce31"
---

## Simple Summary

The current proposal suggests adjusting the Interest Rate Curve for weETH on Arbitrum network to align with the mainnet, so Risk Parameters will be the same for weETH on Mainnet, Arbitrum, and Base networks.

The aim is to optimize the utilization rates and improve both lending and borrowing for users.

## Motivation

By adjusting the Interest Rate Curve, we aim to encourage more borrowing and lending activity, optimize the utilization rates, and enhance liquidity on Arbitrum and Base networks.

1. **Base Rate Increase:** Increasing the base rate provides a more attractive return for lenders, encouraging more weETH deposits.
2. **Slope 1 Adjustment:** Adjusting the Stable Rate Slope offers slightly higher interest for moderate utilization, making borrowing more attractive.
3. **Slope 2 Adjustment:** Reducing Stable Rate Slope 2 prevents excessively high borrowing costs at higher utilization rates, thus avoiding sharp declines in borrowing activities.
4. **Utilization Rate Optimal:** Raising the optimal utilization rate aims to better match the network's current usage patterns, ensuring a smoother transition between interest rate slopes and maintaining liquidity.
5. **Reserve Factor:** weETH borrowers and LP are less sensible to interest rates due to external incentives, to Optimize the DAO revenue the reserve factor is changed.

## Specification

Change Arbitrum Risk Parameters for weETH to align with Mainnet & Base.

**Proposed Changes:**

| Parameter                | Value          |
| ------------------------ | -------------- |
| Isolation Mode           | No             |
| Borrowable               | Yes            |
| Collateral Enabled       | Yes            |
| Supply Cap (weETH)       | no change      |
| Borrow Cap (weETH)       | no change      |
| Debt Ceiling             | -              |
| LTV                      | 72.50%         |
| LT                       | 75.00%         |
| Liquidation Bonus        | 7.50%          |
| Liquidation Protocol Fee | 10.00%         |
| Variable Base            | 0.0%           |
| Variable Slope1          | 7.00%          |
| Variable Slope2          | 300.00%        |
| Uoptimal                 | 35.00%         |
| Reserve Factor           | 45.00%         |
| Stable Borrowing         | Disabled       |
| Flashloanable            | Yes            |
| Siloed Borrowing         | No             |
| Borrowed in Isolation    | No             |
| E-Mode Category          | ETH-correlated |

## References

- Implementation: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240603_AaveV3Arbitrum_AdjustingInterestRateCurveForWeETHOnArbitrum/AaveV3Arbitrum_AdjustingInterestRateCurveForWeETHOnArbitrum_20240603.sol)
- Tests: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240603_AaveV3Arbitrum_AdjustingInterestRateCurveForWeETHOnArbitrum/AaveV3Arbitrum_AdjustingInterestRateCurveForWeETHOnArbitrum_20240603.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xed2fd3dfee1f29f04b6cda4a5c4629fcca32a5c961b1b3e2a49ba6842367ce31)
- [Discussion](https://governance.aave.com/t/arfc-adjusting-interest-rate-curve-for-weeth-on-arbitrum/17804)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
