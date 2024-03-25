---
title: "GHO Stewards + Borrow Rate Update"
author: "karpatkey_TokenLogic ACI ChaosLabs"
discussions: "https://governance.aave.com/t/arfc-gho-stewards-borrow-rate-update/16956"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xc26346b891974968c6fa1745b2cfa869d2d0e5875e9fc2bd661167ae19314c6b"
---

## Simple Summary

In response to recent market events, this publication proposes increasing the GHO Borrow Rate to better respond to varying market conditions.

## Motivation

In response to recent stable coin rates increasing and Maker DAO's recently proposed changes this publication seeks to amend the current GHO Interest Rate strategy and better equip the GHO Stewards to respond to evolving market conditions.

The Maker DAO proposal is expected to lead to higher borrowing rates. To enable GHO to continue growing with improved peg stability, this proposal acts to heavily reduce the Borrow Rate arbitrage opportunity created by incrementally increasing the GHO Borrow Rate within the current approved Direct-to-AIP process.

## Specification

| Description                | Current (%) | Proposed (%)       |
| -------------------------- | ----------- | ------------------ |
| Non Discounted Borrow Rate | 7.48%       | 13.00%             |
| stkAAVE Discount           | 30.00%      | 30.00% (no change) |
| Discounted Borrow Rate     | 5.24%       | 9.10%              |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_AaveV3Ethereum_GHOStewardsBorrowRateUpdate/AaveV3Ethereum_GHOStewardsBorrowRateUpdate_20240324.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_AaveV3Ethereum_GHOStewardsBorrowRateUpdate/AaveV3Ethereum_GHOStewardsBorrowRateUpdate_20240324.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xc26346b891974968c6fa1745b2cfa869d2d0e5875e9fc2bd661167ae19314c6b)
- [Discussion](https://governance.aave.com/t/arfc-gho-stewards-borrow-rate-update/16956)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
