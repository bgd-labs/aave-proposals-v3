---
title: "GHO Borrow Rate Increase 2024-02-29"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-increase-gho-borrow-rate-29-02-2024/16787"
---

## Simple Summary

This ARFC proposes an increase in the GHO borrow rate from 6.22% APR to 7.22% APR to support the GHO peg restoration further, align borrowing costs with average market rates, and maintain its attractiveness as an option. The discounted rates remain unchanged at a 30% discount.

## Motivation

AIP-381 allows for 100 bps increases in the GHO borrow rate every 7 days while maintaining rates up to 9.5% APR if the monthly average price of GHO stays outside a 0,995<>1,005 price range.

While the peg has improved, it is still outside of the target range. This ARFC continues with the previous proposals for a further increase in the GHO borrow rate.

The GHO peg has shown more stability recently but is still slightly below the target. The average monthly borrow rate on Aave for DAI is 8.41%, LUSD is 7.34%, USDC is 9.01%, and USDT is 8.94%.

Increasing the non-discounted borrow rate of GHO from 6.22% to 7.22% will keep it an attractive option, increase protocol revenue, and is not expected to negatively affect the peg.

## Specification

- **Current Borrow Rate:** 6.22% APR - ~6.35% APY
- **Proposed Borrow Rate:** 7.22% - ~7.48% APY (non-discounted)
- **Discounted Rates:** 30% discount
- **New Discounted Borrow Rate:**
  - GHO: ~5.24% APY

If required, ACI will monitor the GHO peg and use authorized discretion for further rate adjustments in coordination with Aave finance SPs.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/23873467c60a1c79bf5ed9a73c60e05ceaea6171/src/20240229_AaveV3Ethereum_GHOBorrowRateIncrease20240229/AaveV3Ethereum_GHOBorrowRateIncrease20240229_20240229.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/23873467c60a1c79bf5ed9a73c60e05ceaea6171/src/20240229_AaveV3Ethereum_GHOBorrowRateIncrease20240229/AaveV3Ethereum_GHOBorrowRateIncrease20240229_20240229.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-increase-gho-borrow-rate-29-02-2024/16787)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
