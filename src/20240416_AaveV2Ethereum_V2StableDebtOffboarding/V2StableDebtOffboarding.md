---
title: "V2 Stable Debt Offboarding"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-full-deprecation-of-stable-rate/16473"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xb58ef33b4b7f4c35b7a6834b24f11b282d713b5e9f527f29d782aef04886c189"
---

## Simple Summary

Introduce a new method `swapToVariable(address asset, address user)` that allows permissionless swapping from stable to variable debt.

## Motivation

On the 4th of November 2023 10, a report was received via the Aave <> Immunefi bug bounty program about a critical bug related to the stable borrow rate.

Only certain assets were affected due to their configuration, but given the nature of the bug, together with the progressive deprecation of stable rate that started before (not enabled in Aave v3 Ethereum, the main instance of Aave at the moment, or any other afterwards), the fix involved a full deprecation of minting mechanisms of stable debt: halting new borrowings in that mode and also halting rebalancing and swapping from variable to stable.

Even if with the halting of minting of stable rate we are fully confident that there is no further vector, the current situation is extremely asymmetric, and creating really important technical overhead, for example when doing security evaluations/reviews of the protocol: there are user positions at stable, which factually have fixed rate until they decide to close it, without any kind of rebalancing applicable.

Therefore, after evaluating the scenario for some time, we think the better solution is to progress on the deprecation of stable rate, by migrating all user positions from stable to variable.

## Specification

On execution this proposal will call:

- `AaveV2Ethereum.POOL_ADDRESSES_PROVIDER.setLendingPoolImpl(LENDING_POOL_IMPL)` to update the pool implementation

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240416_AaveV2Ethereum_V2StableDebtOffboarding/AaveV2Ethereum_V2StableDebtOffboarding_20240416.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240416_AaveV2Ethereum_V2StableDebtOffboarding/AaveV2Ethereum_V2StableDebtOffboarding_20240416.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb58ef33b4b7f4c35b7a6834b24f11b282d713b5e9f527f29d782aef04886c189)
- [Discussion](https://governance.aave.com/t/bgd-full-deprecation-of-stable-rate/16473)
- [Diff](https://github.com/bgd-labs/v2-stable-debt-offboarding/blob/d9862450d82930a6c9c9fe67e84894c7c467514e/diffs/diff.md)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
