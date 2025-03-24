---
title: "Enable SVR V1 on Aave V3 Ethereum"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-aave-chainlink-svr-v1-phase-1-activation/21247"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0xe260268c607f20c85d1f93323f2f58b05f202916e0d3dbf55a8c335ed9be92da"
---

## Simple Summary

Activates SVR oracles on the `AaveV3Ethereum` instance for the assets `LBTC`, `tBTC`, `LINK` and `AAVE`.

## Motivation

As described in the on the original [governance post](https://snapshot.box/#/s:aave.eth/proposal/0x29721c3f2d61a793b310720ffd671fe349b4f9603f066e0f5644a40e59549b96), this proposal seeks the community’s approval to integrate Chainlink’s SVR v1 system.
Extensive details about its rationale and specifications can be found on the [governance forum](https://governance.aave.com/t/temp-check-aave-chainlink-svr-v1-integration/20378).

## Specification

Given the new introduction of SVR feeds, this proposal will perform the activation through an `SVR_STEWARD` steward.
The `SVR_STEWARD`, ensures there is minimal derivation between the `current` price feed and the `svr` price feed at activation.
Also the `SVR_STEWARD` allows for the `Protocol guardian` to revert to the previous oracle in case any unforeseen issue arises.

- grant the "ASSET LISTING ADMIN" role to the [SVR_STEWARD](https://etherscan.io/address/0x8b493f416F5F7933cC146b1899c069F2361cad60)
- call the `SVR_STEWARD.enableSvrOracles`, replacing the oracle of
  - `LBTC` and `tBTC` with [0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A](https://etherscan.io/address/0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A)
  - `AAVE` with [0xF02C1e2A3B77c1cacC72f72B44f7d0a4c62e4a85](https://etherscan.io/address/0xF02C1e2A3B77c1cacC72f72B44f7d0a4c62e4a85)
  - `LINK` with [0xC7e9b623ed51F033b32AE7f1282b1AD62C28C183](https://etherscan.io/address/0xC7e9b623ed51F033b32AE7f1282b1AD62C28C183)

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/d0f08ff2386af26975ce5bd4e050da8bae6079e5/src/20250312_AaveV3Ethereum_EnableSVR/AaveV3Ethereum_EnableSVR_20250312.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/d0f08ff2386af26975ce5bd4e050da8bae6079e5/src/20250312_AaveV3Ethereum_EnableSVR/AaveV3Ethereum_EnableSVR_20250312.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0xe260268c607f20c85d1f93323f2f58b05f202916e0d3dbf55a8c335ed9be92da)
- [Discussion](https://governance.aave.com/t/arfc-aave-chainlink-svr-v1-phase-1-activation/21247)
- [SvrOracleSteward](https://github.com/bgd-labs/aave-stewards/blob/main/src/risk/SvrOracleSteward.sol)
- [SvrOracleSteward security assessment](https://github.com/bgd-labs/aave-stewards/blob/main/audits/2025_03_10_SvrOracleSteward_Certora.pdf)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
