---
title: "Upgrade all Aave instances to 3.2"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-aave-v3-2-liquid-emodes/19037/3"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x68ce69b5e71df1d77c2ad814a5d41162a40be54473576ff590d0b1bb5afde4a7"
---

## Simple Summary

Upgrades all active Aave instances to Aave 3.2 which debuts "Liquid eModes" and fully deprecated stable borrowing.

## Motivation

eModes have been a powerful feature since the inception of aave v3.
Liquid eModes builds on this success by increase the flexibility in configuring eModes. With Liquid eModes it is now possible, to have a single asset be listed in multiple eModes.
At the same time it's possible to granuarily control which assets are collateral and borrowable inside an eMode.

Stable debt has been offboarded from aave v3 for quite some time. What was remaining on the protocol code were merley artifacts which increase gas consumption and codesize.
Therefore the 3.2 release removes these artifacts in a backwards compatible way.

## Specification

The proposal will execute to following operations on each active aave v3 pool:

- upgrade the Pool/L2Pool implementation to 3.2
- upgrade the PoolConfigurator implementation to 3.2
- upgrade the ProtocolDataProvider to 3.2
- migrate all assets currently in eMode to be both borrowable & collateral in eMode
- migrate the InterestRateStrategy to a new version without stable rate calculations

## References

- [Implementation](https://github.com/bgd-labs/protocol-v3.2-upgrade/tree/main/src/contracts)
- [Tests](https://github.com/bgd-labs/protocol-v3.2-upgrade/tree/main/tests)]
- [Code and post execution state diffs](https://github.com/bgd-labs/protocol-v3.2-upgrade/tree/main/diffs)]
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x68ce69b5e71df1d77c2ad814a5d41162a40be54473576ff590d0b1bb5afde4a7)
- [Discussion](https://governance.aave.com/t/bgd-aave-v3-2-liquid-emodes/19037/3)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
