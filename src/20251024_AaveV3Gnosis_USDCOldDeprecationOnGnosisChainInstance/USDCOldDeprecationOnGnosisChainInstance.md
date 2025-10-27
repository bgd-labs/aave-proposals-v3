---
title: "USDC (old) deprecation on Gnosis Chain Instance"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/arfc-usdc-old-deprecation-on-gnosis-chain-instance/23189"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x438b460559aa8c3a039f28212362af9a0e3b94a88e4a2b8230fe2c5e8f4d43da"
---

## Simple Summary

This publication proposes the **deprecation of the legacy USDC market** on the Aave Gnosis Chain deployment.
The deprecation will be executed by **freezing the reserve** (preventing new deposits, borrows, or collateral usage) and **immediately increasing the Reserve Factor (RF) to 80%**.

This aligns with the broader ecosystem effort to establish **USDC.e (Circle-supported)** as the canonical USDC representation on Gnosis Chain, consolidating liquidity and improving capital efficiency across Aave markets.

## Motivation

The Gnosis Chain ecosystem has grown significantly since the initial deployment of assets on the Aave GC instance. With Circle-supported USDC.e now established as the canonical USDC representation, it is important to accelerate the transition away from legacy USDC to prevent liquidity fragmentation and enhance capital efficiency.

To promote the migration from USDC to USDC.e and concentrate liquidity in a single canonical market, this proposal introduces a progressive parameter adjustment schedule:

1. **Freeze the market** — Preventing new positions from being created and new deposits.
2. **Reserve Factor Increase** — USDC’s (old) RF will be increased to 80%, incentivising lenders to migrate to USDC.e.

## Specification

The following table shows the current parameters and proposed adjustments for USDC (old) in the first AIP (updated upon receiving feedback from both @LlamaRisk and @ChaosLabs):

| Parameter | Current | Proposed |
| --------- | ------- | -------- |
| RF        | 40%     | 80%      |

- The **USDC (old)** reserve will be **frozen** — preventing new deposits, borrows, or collateral enablement.
- The **Reserve Factor** will be immediately increased to **80%**, redirecting most of the yield to the protocol and incentivising migration to **USDC.e**.
- **Existing positions remain unaffected**, but users are encouraged to unwind and migrate voluntarily to **USDC.e**.

## References

- Implementation: [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/2eebace0ecd8f4851a5d97796aa1dbf3ced8683e/src/20251024_AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance/AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance_20251024.sol)
- Tests: [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/2eebace0ecd8f4851a5d97796aa1dbf3ced8683e/src/20251024_AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance/AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance_20251024.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x438b460559aa8c3a039f28212362af9a0e3b94a88e4a2b8230fe2c5e8f4d43da)
- [Discussion](https://governance.aave.com/t/arfc-usdc-old-deprecation-on-gnosis-chain-instance/23189)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
