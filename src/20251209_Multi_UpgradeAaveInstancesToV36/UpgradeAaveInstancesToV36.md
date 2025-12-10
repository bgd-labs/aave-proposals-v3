---
title: "Upgrade Aave instances to v3.6"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-bgd-aave-v3-6/23172"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x83ab94cea13da68fc9685dc2fa8ad738107bdbebd01fdf04122131d5de1d7847"
---

## Simple Summary

Upgrade the Aave protocol instances from v3.5 to v3.6.

## Motivation

## Specification

The upgrade payload updates the implementations of the Pool, PoolConfigurator, AToken & VariableDebtToken on all networks.

On mainnet the payloads varies slightly to account for:

- aAave which has a different implementation due to the governance delegation integration
- vGHO which has a different implementation due to the deprecated discount mechanism on stkAAVE

An additional action is included on mainnet which transfers 113'752 $ as aUSDT to a BGD Labs address and 30'400 $ to a Certora address, to reimburse the cost of the audits.

## References

- Implementation: [AaveV3EthereumMainnetCore](https://github.com/bgd-labs/protocol-v3.6-upgrade/blob/main/src/UpgradePayloadMainnetCore.sol), [Other Networks](https://github.com/bgd-labs/protocol-v3.6-upgrade/blob/main/src/UpgradePayload.sol)
- [Tests](https://github.com/bgd-labs/protocol-v3.6-upgrade/tree/main/test)
- [Diffs](https://github.com/bgd-labs/protocol-v3.6-upgrade/tree/main/diffs/code)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x83ab94cea13da68fc9685dc2fa8ad738107bdbebd01fdf04122131d5de1d7847)
- [Discussion](https://governance.aave.com/t/arfc-bgd-aave-v3-6/23172)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
