---
title: "Increase GHO Borrow Rate"
author: "@Marczeller - Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-increase-gho-borrow-rate-to-5-22-on-aave-v3/15632"
---

## Simple Summary

This AIP proposes to increase the GHO borrow rate from 4.72% APR to 5.22% APR.
This aims to support the GHO peg and align borrowing costs closer to industry market rates.

## Motivation

Following [AIP-349](https://app.aave.com/governance/proposal/349/), which allowed for 50 bps increments in the GHO borrow rate, the peg remains off-target at ~0.965 avg price. This increase is part of the direct-to-AIP process to incentivize repayment and help restore the peg.

## Specification

- **Current Borrow Rate:** 4.72% APR - ~4.83% APY
- **Proposed Borrow Rate:** 5.22% - ~5.35% APY
- **New Discounted Borrow Rate:** ~3.7% - 3.75% APY

**The proposal also authorizes ACI to continue with up to 100 bps incremental increases every 7 days if required up to 9.5% APR if the monthly avg price of GHO stays outside a 0,995<>1,005 price range**.

Comparative analysis with other stablecoins on Aave V3 shows that GHO's current borrow rate is lower, which may contribute to its underpeg. The following table illustrates average borrow rates:

| Stablecoin | Average Borrow Rate |
| ---------- | ------------------- |
| USDC       | 6.39%               |
| USDT       | 7.29%               |
| DAI        | 6%                  |
| GHO        | 4.83% (APY)         |

Given this discrepancy, it is unlikely that the current rate is sufficient to restore GHO's peg.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/bbe74d703bf794fa98295322e626a0b2b9262c54/src/20231121_AaveV3Ethereum_IncreaseGHOBorrowRate/AaveV3Ethereum_IncreaseGHOBorrowRate_20231121.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/bbe74d703bf794fa98295322e626a0b2b9262c54/src/20231121_AaveV3Ethereum_IncreaseGHOBorrowRate/AaveV3Ethereum_IncreaseGHOBorrowRate_20231121.t.sol)
- [Snapshot](Direct-to-AIP)
- [Discussion](https://governance.aave.com/t/arfc-increase-gho-borrow-rate-to-5-22-on-aave-v3/15632)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
