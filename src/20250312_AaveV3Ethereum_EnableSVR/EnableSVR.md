---
title: "Enable SVR V1 on Aave V3 Ethereum"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-aave-chainlink-svr-v1-phase-1-activation/21247"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0xe260268c607f20c85d1f93323f2f58b05f202916e0d3dbf55a8c335ed9be92da"
---

## Simple Summary

## Motivation

## Specification

- grant the "ASSET LISTING ADMIN" role to the `SVR_STEWARD`
- call the `SVR_STEWARD.enableSvrOracles`, replacing the oracle of
  - `LBTC`, `tBTC` and `cbBTC` with [0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A](https://etherscan.io/address/0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A)
  - `AAVE` with [0xF02C1e2A3B77c1cacC72f72B44f7d0a4c62e4a85](https://etherscan.io/address/0xF02C1e2A3B77c1cacC72f72B44f7d0a4c62e4a85)
  - `LINK` with [0xC7e9b623ed51F033b32AE7f1282b1AD62C28C183](https://etherscan.io/address/0xC7e9b623ed51F033b32AE7f1282b1AD62C28C183)

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_AaveV3Ethereum_EnableSVR/AaveV3Ethereum_EnableSVR_20250312.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_AaveV3Ethereum_EnableSVR/AaveV3Ethereum_EnableSVR_20250312.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0xe260268c607f20c85d1f93323f2f58b05f202916e0d3dbf55a8c335ed9be92da)
- [Discussion](https://governance.aave.com/t/arfc-aave-chainlink-svr-v1-phase-1-activation/21247)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
