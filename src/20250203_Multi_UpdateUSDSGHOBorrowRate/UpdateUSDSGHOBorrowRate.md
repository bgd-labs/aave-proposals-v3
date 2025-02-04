---
title: "Update USDS & GHO Borrow Rate"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/arfc-update-usds-gho-borrow-rate/20892"
---

## Simple Summary

The Sky Savings Rate (SSR) is expected to be lowered from 12.50% to 9.50% on February 10th. This publication proposes updating the USDS Borrow Rate and also, reducing the GHO Borrow Rate on the Prime instance.
This update will be conducted via a Direct-to-AIP process.

## Motivation

In response to the latest proposal to reduce the SSR to [9.50%](https://forum.sky.money/t/feb-6-2025-stability-scope-parameter-changes-21/25906), this publication proposes reducing the Base on Core and Slope1 on Prime by 3.00% respectively.

The chart below shows the USDC and USDT deposit rates on Aave relative to the SSR over the last 90 days. More recently, the SSR has materially outperformed USDC and USDT deposit yield on Aave due to the borrow rate for USDC and USDT continually declining since mid-december.

The GHO Borrow Rate on Core is currently configured at 9.00%, representing a cost of capital of 9.42% for non stkAAVE holders. 9.42% compares favourably to the SUSDS Deposit Yield (Native + Incentives) of 13.42% + SPK airdrop rewards.

When the SSR is reduced to 9.50%, the USDS collateral and GHO debt free carry trade remains profitable with compressed margins until such time as the GHO Borrow Rate is lowered. Notably, over the last 30 days, wallets holding USDS deposits on Core have borrowed +1,108,212 units of GHO representing a small portion of newly borrowed GHO.

With the GHO Steward role in place on Core, the GHO Borrow Rate can be reduced with short notice and therefore, this publication focuses on adjusting the Prime instance of Aave where the GHO Steward role is not yet extended.

With the USDS Borrow Rate, Slope1 parameter, being reduced by 3.00% this publication proposes reducing the GHO Borrow Rate, Base parameter by 1.50%. Upon implementing both Borrow Rate updates, the GHO Borrow Rate at the Uoptimal will be 0.50% less than USDS. A slightly lower GHO Borrow Rate provides an economic incentive to hold GHO debt relative to USDS.

## Specification

**Prime Instance**

USDS

| Detail | Current | Proposed | Change |
| ------ | ------- | -------- | ------ |
| Base   | 0.75%   | 0.75%    | 0.00%  |
| Slope1 | 10.75%  | 8.75%    | -2.00% |
| Slope2 | 35.00%  | 35.00%   | 0.00%  |

Borrow Rate at Uoptimal 9.50% matching the proposed SSR.

GHO

| Detail | Current | Proposed | Change |
| ------ | ------- | -------- | ------ |
| Base   | 8.00%   | 6.50%    | -1.50% |
| Slope1 | 2.50%   | 2.50%    | 0.00%  |
| Slope2 | 50.00%  | 50.00%   | 0.00%  |

Borrow Rate at Uoptimal 9.00% matching.

**Core Instance**

USDS

| Detail | Current | Proposed | Change |
| ------ | ------- | -------- | ------ |
| Base   | 11.75%  | 8.75%    | -3.00% |
| Slope1 | 0.75%   | 0.75%    | 0.00%  |
| Slope2 | 35.00%  | 35.00%   | 0.00%  |

Borrow Rate at Uoptimal 9.50% matching the proposed SSR.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250203_Multi_UpdateUSDSGHOBorrowRate/AaveV3Ethereum_UpdateUSDSGHOBorrowRate_20250203.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250203_Multi_UpdateUSDSGHOBorrowRate/AaveV3EthereumLido_UpdateUSDSGHOBorrowRate_20250203.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250203_Multi_UpdateUSDSGHOBorrowRate/AaveV3Ethereum_UpdateUSDSGHOBorrowRate_20250203.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250203_Multi_UpdateUSDSGHOBorrowRate/AaveV3EthereumLido_UpdateUSDSGHOBorrowRate_20250203.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-update-usds-gho-borrow-rate/20892)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
