---
title: "Increase GHO Borrow Rate 100 bps to ~6.41% on Aave V3"
author: "Alice Rozengarden (@Rozengarden - Aave-chan initiative)"
discussions: "https://governance.aave.com/t/arfc-increase-gho-borrow-rate-100-bps-to-6-35-on-aave-v3/15744"
---

## Simple Summary

This AIP proposes an increase in the GHO borrow rate from 5.22% APR to 6.22% APR to support the GHO peg restoration and align borrowing costs with market rates.

## Motivation

[AIP-381](https://app.aave.com/governance/proposal/381/) allows for 100 bps increases in the GHO borrow rate every 7 days while days up to 9.5% APR if the monthly average price of GHO stays outside a 0,995<>1,005 price range. While the peg has improved, it is still outside of the target range. This AIP continues with further increases of the GHO interest rate aligned with the previous proposal.

## Specification

- **Current Borrow Rate:** 5.22% APR - ~5.35% APY
- **Proposed Borrow Rate:** 6.22% APR - ~6.41% APY
- **New Discounted Borrow Rate:** ~4.35% APR - ~4.45% APY

ACI will continue with up to 100 bps incremental increases every 7 days if required up to 9.5% if the monthly average price of GHO stays outside a 0,995<>1,005 price range.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f6f4b43fec247208c71c1ece9611019ec1f7bdd8/src/20231205_AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3/AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3_20231205.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f6f4b43fec247208c71c1ece9611019ec1f7bdd8/src/20231205_AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3/AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3_20231205.t.sol)
- [Snapshot](No snapshot for direct to AIP)
- [Discussion](https://governance.aave.com/t/arfc-increase-gho-borrow-rate-100-bps-to-6-35-on-aave-v3/15744)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
