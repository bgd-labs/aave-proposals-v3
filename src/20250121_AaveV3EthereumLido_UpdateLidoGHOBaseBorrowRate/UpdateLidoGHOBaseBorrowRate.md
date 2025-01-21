---
title: "Update Lido GHO base borrow rate"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-risk-stewards-reduce-gho-borrow-rate-prime-instance/20501"
snapshot: Direct-to-AIP
---

## Simple Summary

This publication proposes reducing the base borrow rate Parameter for the GHO Reserve on Prime instance by 2.00%.

## Motivation

At launch, the GHO Borrow Rate was configured to suit the more buoyant market conditions of the time. Since then, market conditions have cooled and to date, the GHO reserve on Prime has experienced limited borrowing activity. Utilization is 2.30% with less than 120k GHO borrowed.

The Borrow Rate for USDS on Prime is trending slightly above 10% which is slightly lower than USDT on Core instance after recent deposits has reduced utilization.

Staked USDe is currently at capacity on Prime and is shown to be generating 12.50% on the Ethena dashboard. When the sUSDe supply cap is lifted, we expect demand for GHO debt to emerge, and if not initially, then when perpetual funding rates improve.

Additionally, the GHO Stewards lowered the Borrow Rate on the Core instance to 12.50% which is 1% less than the GHO Borrow Rate on Prime at the Uoptimal. Amending the GHO Borrow Rate at the Uoptimal on Prime to be less than the GHO Borrow Rate on Core encourages users to borrow GHO from Prime.

When demand for GHO on Prime emerges, providing the peg permits, the Borrow Cap shall be increased improving the overall efficiency of the GHO reserve, resulting in a higher deposit rate.

## Specification

The GHO base borrow rate Parameter on Prime instance of Aave v3 is to be revised as follows:

| Description | Current | Proposed | Change |
| ----------- | ------- | -------- | ------ |
| Borrow Rate | 10.50%  | 8.50%    | -2.00% |

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/051dd6743951609879d6358022e6521528046b7d/src/20250121_AaveV3EthereumLido_UpdateLidoGHOBaseBorrowRate/AaveV3EthereumLido_UpdateLidoGHOBaseBorrowRate_20250121.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/051dd6743951609879d6358022e6521528046b7d/src/20250121_AaveV3EthereumLido_UpdateLidoGHOBaseBorrowRate/AaveV3EthereumLido_UpdateLidoGHOBaseBorrowRate_20250121.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-risk-stewards-reduce-gho-borrow-rate-prime-instance/20501)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
