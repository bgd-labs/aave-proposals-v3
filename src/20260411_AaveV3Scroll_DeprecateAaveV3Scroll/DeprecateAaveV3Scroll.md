---
title: "Deprecate Aave V3 Scroll Instance"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/direct-to-aip-aave-v3-scroll-instance-deprecation/24432"
---

## Simple Summary

Following the Risk Stewards cap reduction executed on April 10, 2026, this proposal completes the deprecation of Aave V3 on Scroll by freezing all assets and increasing the reserve factor on select assets.

## Motivation

As part of the ongoing assessment of Aave deployments across different chains, the Aave V3 Scroll instance has been identified for offboarding. This action freezes all reserves to prevent new supply and borrow positions, while increasing reserve factors to incentivize existing users to repay their positions and withdraw their funds.

## Specification

The proposal executes the following changes on the Aave V3 Scroll instance:

**Freeze all reserves:**

| Asset  | isFrozen (before) | isFrozen (after) |
| ------ | ----------------- | ---------------- |
| WETH   | false             | true             |
| USDC   | false             | true             |
| wstETH | false             | true             |
| weETH  | false             | true             |
| SCR    | false             | true             |

**Increase reserve factor to 85% (except WETH which remains at 50%):**

| Asset  | Reserve Factor (before) | Reserve Factor (after) |
| ------ | ----------------------- | ---------------------- |
| USDC   | 50%                     | 85%                    |
| wstETH | 50%                     | 85%                    |
| weETH  | 50%                     | 85%                    |
| SCR    | 50%                     | 85%                    |
| WETH   | 50%                     | 50% (unchanged)        |

## References

- Implementation: [AaveV3Scroll](https://github.com/aave-dao/aave-proposals-v3/blob/94d54123c14c41761e556e0106201f85a446b232/src/20260411_AaveV3Scroll_DeprecateAaveV3Scroll/AaveV3Scroll_DeprecateAaveV3Scroll_20260411.sol)
- Tests: [AaveV3Scroll](https://github.com/aave-dao/aave-proposals-v3/blob/94d54123c14c41761e556e0106201f85a446b232/src/20260411_AaveV3Scroll_DeprecateAaveV3Scroll/AaveV3Scroll_DeprecateAaveV3Scroll_20260411.t.sol)
- Snapshot: Direct-To-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-aave-v3-scroll-instance-deprecation/24432)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
