---
title: "GHO Borrow Rate Increase"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-increase-gho-borrow-rate-08-03-2024/16885"
---

## Simple Summary

This AIP will increase GHO borrow rate by 0.7% APR.

## Motivation

With the evolving market dynamics and the increasing popularity of GHO as a stablecoin option, it is necessary to maintain competitiveness by aligning borrowing costs with average market rates. The current GHO borrow rate of 7.22% APR (~7.48% APY) no longer meets this requirement.

AIP-381 allows for 100 bps increases in the GHO borrow rate every 7 days while maintaining rates up to 9.5% APR if the monthly average price of GHO stays outside a 0,995<>1,005 price range. The peg has shown improvement but remains below the target.

| Monthly Average Borrow Cost (APR) | Stablecoin |
| --------------------------------- | ---------- |
| 10.45%                            | DAI        |
| 10.89%                            | LUSD       |
| 10.91%                            | USDC       |
| 11.87%                            | USDT       |

Source: [TokenLogic | GHO Analytics](https://aave.tokenlogic.com.au/stablecoin-rates)

Increasing the non-discounted borrow rate of GHO from 7.22% to 7.92% is proposed to remain competitive, increase protocol revenue, and not negatively affect the peg.

## Specification

- **Current Borrow Rate:** 7.22% APR - ~7.48% APY (non-discounted)
- **Proposed Borrow Rate:** 7.92% - ~8% APY (non-discounted)
- **Discounted Rates:** 30% discount
- **New Discounted Borrow Rate:**
  - GHO: ~5.6% APY

If required, ACI will monitor the GHO peg and use authorized discretion for further rate adjustments in coordination with @karpatkey_TokenLogic Aave finance SPs.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240308_AaveV3Ethereum_GHOBorrowRateIncrease/AaveV3Ethereum_GHOBorrowRateIncrease_20240308.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240308_AaveV3Ethereum_GHOBorrowRateIncrease/AaveV3Ethereum_GHOBorrowRateIncrease_20240308.t.sol)
- Snapshot: No snapshot for Direct-to-AIP)
- [Discussion](https://governance.aave.com/t/arfc-increase-gho-borrow-rate-08-03-2024/16885)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
