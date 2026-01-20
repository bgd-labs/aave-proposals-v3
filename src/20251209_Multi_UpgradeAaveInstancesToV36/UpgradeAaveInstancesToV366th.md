---
title: "Upgrade Aave instances to v3.6 Part 3"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-bgd-aave-v3-6/23172/8"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x83ab94cea13da68fc9685dc2fa8ad738107bdbebd01fdf04122131d5de1d7847"
---

## Simple Summary

Resubmission: Upgrade of the Aave protocol instances from v3.5 to v3.6 **Part 3**.
Due to a expiry protection, the payloads on the following networks were not executed on part 2: **Plasma, Base, Arbitrum, Avalanche, Linea, BNB Chain, Polygon**.

## Motivation

Aave v3.6 enhances isolation, via more fine-grained configurations and the decoupling of eMode and eMode0 settings. For a comprehensive overview of the changes, please refer to the [documentation](https://github.com/bgd-labs/aave-v3-origin/blob/b3ce63440cacd4054c62d55c6282afd248215b28/docs/3.6/Aave-v3.6-features.md).

## Specification

The upgrade payload updates the implementations of the Pool, PoolConfigurator, AToken & VariableDebtToken on the second set of pools, namely **Plasma, Base, Arbitrum, Avalanche, Linea, BNB Chain, Polygon**.

## Security procedures

The upgrade was extensively unit tested and fuzzed.
Certora adapted its formal properties to ensure the upgrade's correctness.
In addition 5 audits by Independent Auditors were conducted.

- [Blackthorn](https://github.com/bgd-labs/aave-v3-origin/blob/b3ce63440cacd4054c62d55c6282afd248215b28/audits/2025-11-16_Blackthorn_Aave-v3.6.pdf)
- [Certora](https://github.com/bgd-labs/aave-v3-origin/blob/b3ce63440cacd4054c62d55c6282afd248215b28/audits/2025-11-18_Certora_Aave-v3.6.pdf)
- [MixBytes](https://github.com/bgd-labs/aave-v3-origin/blob/b3ce63440cacd4054c62d55c6282afd248215b28/audits/2025-11-18_MixBytes_Aave-v3.6.pdf)
- [Savant](https://github.com/bgd-labs/aave-v3-origin/blob/b3ce63440cacd4054c62d55c6282afd248215b28/audits/2025-11-18_Savant_Aave-v3.6.pdf)
- [Pashov](https://github.com/bgd-labs/aave-v3-origin/blob/b3ce63440cacd4054c62d55c6282afd248215b28/audits/2025-11-29_Pashov_Aave-v3.6.pdf)

## References

- [Implementation](https://github.com/bgd-labs/protocol-v3.6-upgrade/blob/main/src/UpgradePayload.sol)
- [Tests](https://github.com/bgd-labs/protocol-v3.6-upgrade/tree/main/test)
- [Diffs](https://github.com/bgd-labs/protocol-v3.6-upgrade/tree/main/diffs/code)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x83ab94cea13da68fc9685dc2fa8ad738107bdbebd01fdf04122131d5de1d7847)
- [Discussion](https://governance.aave.com/t/arfc-bgd-aave-v3-6/23172/8)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
