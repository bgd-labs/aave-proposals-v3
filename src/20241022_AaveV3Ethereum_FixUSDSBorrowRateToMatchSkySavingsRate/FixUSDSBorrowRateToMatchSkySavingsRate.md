---
title: "Fix USDS Borrow Rate to Match Sky Savings Rate"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-increase-usds-borrow-rate-to-match-sky-savings-rate/19494/2"
snapshot: "Direct-to-AIP"
---

## Simple Summary

Proposal to update the USDS Slope1 to .75%

## Motivation

While the latest AIP for USDS borrow rate has the intended effect of disincentivizing USDS borrows and looping on Main instance, the current slope1 is too aggressive compared to other stables. A new AIP to address the unnecessarily high borrow rate for USDS has been created with an updated slope1 at 0.75%.

## Specification

USDS Slope1 will be adjusted as follows

New Slope1 .75%
All other parameters remain unchanged.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/e63fc7d6052ae90eac55d373b52c1cf343acb9e9/src/20241022_AaveV3Ethereum_FixUSDSBorrowRateToMatchSkySavingsRate/AaveV3Ethereum_FixUSDSBorrowRateToMatchSkySavingsRate_20241022.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/e63fc7d6052ae90eac55d373b52c1cf343acb9e9/src/20241022_AaveV3Ethereum_FixUSDSBorrowRateToMatchSkySavingsRate/AaveV3Ethereum_FixUSDSBorrowRateToMatchSkySavingsRate_20241022.t.sol)
- [Snapshot](Direct-to-AIP)
- [Discussion](https://governance.aave.com/t/arfc-increase-usds-borrow-rate-to-match-sky-savings-rate/19494/2)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
