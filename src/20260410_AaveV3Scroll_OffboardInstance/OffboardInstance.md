---
title: "Offboard Aave V3 Scroll Instance"
author: "Aave Labs"
discussions: "todo"
snapshot: "direct-to-aip"
---

## Simple Summary

This proposal initiates the offboarding of the Aave V3 Scroll instance by freezing all reserves and increasing reserve factors to encourage position wind-down.

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

- Implementation: [AaveV3Scroll](https://github.com/aave-dao/aave-proposals-v3/blob/c20ccdd41d142635b07b4ec65efc15e0f3d9ec1c/src/20260410_AaveV3Scroll_OffboardInstance/AaveV3Scroll_OffboardInstance_20260410.sol)
- Tests: [AaveV3Scroll](https://github.com/aave-dao/aave-proposals-v3/blob/c20ccdd41d142635b07b4ec65efc15e0f3d9ec1c/src/20260410_AaveV3Scroll_OffboardInstance/AaveV3Scroll_OffboardInstance_20260410.t.sol)
- Snapshot: Direct-To-AIP
- Discussion: TODO

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
