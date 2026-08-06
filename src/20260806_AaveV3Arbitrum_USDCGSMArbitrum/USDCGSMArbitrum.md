---
title: "USDC GSM Arbitrum"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-launch-remotegsm-on-arbitrum/24986"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0xf24321514fb593af9e5082d26a1358819ec0f648db8fdb5c2b083f53ef785793"
---

## Simple Summary

Replace existing GSM with underlying USDC.e with new GSM with underlying USDCn on Arbitrum.

## Motivation

With USDC.e related assets soon to be deprecated as can be seen on this forum [post](https://governance.aave.com/t/arfc-low-adoption-asset-deprecation-on-aave-v3/25401), replace USDC.e GSM with USDCn GSM on Arbitrum.

## Specification

### Wire up Arbitrum GSM (stataUSDCn)

- Point it at the `GhoReserve`, enroll it as an entity with a 25M GHO reserve limit.
- Grant `SWAP_FREEZER_ROLE` to the asset's `OracleSwapFreezer` and to the Arbitrum executor.
- Register it in the `GsmRegistry` and grant `CONFIGURATOR_ROLE` to the `GhoGsmSteward`.
- Set the initial exposure cap to 20M of the underlying (6 decimals) and attach the 0% mint / 0.10% burn fee strategy.

## References

- Implementation: [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260806_AaveV3Arbitrum_USDCGSMArbitrum/AaveV3Arbitrum_USDCGSMArbitrum_20260806.sol)
- Tests: [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260806_AaveV3Arbitrum_USDCGSMArbitrum/AaveV3Arbitrum_USDCGSMArbitrum_20260806.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0xf24321514fb593af9e5082d26a1358819ec0f648db8fdb5c2b083f53ef785793)
- [Discussion](https://governance.aave.com/t/arfc-launch-remotegsm-on-arbitrum/24986)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
