---
title: "Remove Frax from Isolation Mode on Aave v3 Mainnet"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-remove-frax-from-isolation-mode-on-aave-v3-mainnet/19337"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x9bc3f3d8e38d70f55887f2f2498e1b39f59467489158923488aceab73cd4f144"
---

## Simple Summary

This is an AIP to remove FRAX from isolation mode. This is a reboot with minor changes of a [previous ARFC](https://governance.aave.com/t/arfc-remove-frax-from-isolation-mode-and-onboard-sfrax-to-aave-v3-mainnet/18506) which passed Snapshot but has not yet been implemented.

## Motivation

FRAX and Aave DAO have found more synergies over the last months. The FRAX team has responded with major updates to security on sfrxETH in response to BGD Labs feedback. FRAX has also initated governance proposals to add GHO to Frax Lend. There are ongoing conversations to have a FRAX AMO included into Aave v3. sFRAX was [previously accepted](https://governance.aave.com/t/arfc-add-sfrax-on-ethereum-v3/16303) for onboarding in a previous [ARFC vote](https://snapshot.org/#/aave.eth/proposal/0xdba99e9c8da24424447d7c7b70eff93ad5b6055714b5f34cf9859c923fb3a38a) before the introduction of CAPO feeds.

This proposal suggests removing FRAX from isolation mode to facilitate further AMO deployments.

## Specification

- FRAX will be removed from Isolation Mode on Aave v3 instances.

| **Parameter**  | FRAX |
| -------------- | ---- |
| Isolation Mode | No   |
| Debt Ceiling   | 0    |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241105_AaveV3Ethereum_RemoveFraxFromIsolationModeOnAaveV3Mainnet/AaveV3Ethereum_RemoveFraxFromIsolationModeOnAaveV3Mainnet_20241105.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241105_AaveV3Ethereum_RemoveFraxFromIsolationModeOnAaveV3Mainnet/AaveV3Ethereum_RemoveFraxFromIsolationModeOnAaveV3Mainnet_20241105.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x9bc3f3d8e38d70f55887f2f2498e1b39f59467489158923488aceab73cd4f144)
- [Discussion](https://governance.aave.com/t/arfc-remove-frax-from-isolation-mode-on-aave-v3-mainnet/19337)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
