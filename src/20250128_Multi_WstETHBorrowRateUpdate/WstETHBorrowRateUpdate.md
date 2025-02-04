---
title: "wstETH Borrow Rate Update"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-wsteth-borrow-rate-update/20762"
snapshot: "https://snapshot.org/#/s:aave.eth/proposal/0xcb271a2308f78eeab5cbf5576938b61e7437c99781320c1340c885a656c9dbdc"
---

## Simple Summary

This publication proposes updating the wstETH Borrow Rate to support the adoption of LRTs across several instances of Aave v3.

## Motivation

To support the listing of ezETH and rsETH across multiple Aave v3 instances, this proposal recommends lowering the wstETH Borrow Rate to promote adoption of the LRT/LST yield strategy. The adjustment will harmonize the wstETH Borrow Rate across all Aave v3 instances that support LRT collateral, except for the Core instance.

Several teams plan to introduce rewards to bootstrap growth across various Aave instances. While these incentives are necessary to meet users’ return expectations, they are not yet sustainable. Reducing the wstETH Borrow Rate allows teams to allocate their incentive budgets more effectively, supporting a larger AUM base and extending the duration of reward campaigns.

Increased utilization of the wstETH reserve is expected to enhance revenue generation for the Aave DAO while delivering higher returns for users participating in the wstETH/ETH yield strategy.

The proposed wstETH Borrow Rate parameters for Aave v3 instances (excluding the Core instance) are as follows:

| Parameter | Value |
| :-------- | :---: |
| Base      | 0.00% |
| Slope1    | 0.75% |
| Slope2    | 85.0% |
| Uoptimal  | 90.0% |

Due to the size of the wstETH reserve on the Core instance of Aave v3 on Ethereum, this instance is excluded from this proposal.

With LRTs already listed on Arbitrum, Base, Scroll, and zkSync, the proposed changes will be implemented on these networks first.

Future proposals that onboard LRTs to instances of Aave v3 that do not yet include LRTs, shall also include the the wstETH Borrow Rate update.

## Specification

Update AaveV3Arbitrum, AaveV3Base, AaveV3Scroll and AaveV3ZKSync wstETH Borrow Rate:

| Parameter | Value |
| :-------- | :---: |
| Base      | 0.00% |
| Slope1    | 0.75% |
| Slope2    | 85.0% |
| Uoptimal  | 90.0% |

When implemented this proposal will harmonise the wstETH Borrow Rate with Prime instance of Aave v3 on Ethereum.

## References

- Implementation: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250128_Multi_WstETHBorrowRateUpdate/AaveV3Arbitrum_WstETHBorrowRateUpdate_20250128.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250128_Multi_WstETHBorrowRateUpdate/AaveV3Base_WstETHBorrowRateUpdate_20250128.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250128_Multi_WstETHBorrowRateUpdate/AaveV3Scroll_WstETHBorrowRateUpdate_20250128.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20250128_Multi_WstETHBorrowRateUpdate/AaveV3ZkSync_WstETHBorrowRateUpdate_20250128.sol)
- Tests: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250128_Multi_WstETHBorrowRateUpdate/AaveV3Arbitrum_WstETHBorrowRateUpdate_20250128.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250128_Multi_WstETHBorrowRateUpdate/AaveV3Base_WstETHBorrowRateUpdate_20250128.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250128_Multi_WstETHBorrowRateUpdate/AaveV3Scroll_WstETHBorrowRateUpdate_20250128.t.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20250128_Multi_WstETHBorrowRateUpdate/AaveV3ZkSync_WstETHBorrowRateUpdate_20250128.t.sol)
- [Snapshot](https://snapshot.org/#/s:aave.eth/proposal/0xcb271a2308f78eeab5cbf5576938b61e7437c99781320c1340c885a656c9dbdc)
- [Discussion](https://governance.aave.com/t/arfc-wsteth-borrow-rate-update/20762)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
