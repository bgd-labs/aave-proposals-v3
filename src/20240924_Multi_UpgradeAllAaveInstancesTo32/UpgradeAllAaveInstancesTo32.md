---
title: "Upgrade all Aave instances to 3.2"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-aave-v3-2-liquid-emodes/19037/3"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x68ce69b5e71df1d77c2ad814a5d41162a40be54473576ff590d0b1bb5afde4a7"
---

## Simple Summary

Upgrades all active Aave instances to Aave 3.2 which debuts "Liquid eModes" and fully deprecated stable borrowing.

## Motivation

EModes have been a powerful feature since the inception of Aave v3.
Liquid eModes builds on this success by increase the flexibility in configuring eModes. With Liquid eModes it is now possible, to have a single asset be listed in multiple eModes.
At the same time, it's possible to granularly control which assets are collateral and borrowable inside an eMode.

Stable debt has been off-boarded from Aave v3 for quite some time. What was remaining on the protocol code were merely artifacts that increased gas consumption and code size.
Therefore the 3.2 release removes these artifacts in a backwards compatible way.

## Specification

Aave 3.2 focuses on two main areas of the aave protocol:

- The final deprecation of stable borrowing
- Improvements on the eModes, introducing "Liquid eModes"

_Please note: For existing users, the upgrade is 100% backwards compatible and no migration or similar is required. With introduction of liquid emode, entering and leaving an eMode still works via setUserEMode(categoryId) and getUserEMode(address user) like in previous versions of the protocol._

The proposal will execute to following operations on each active Aave v3 pool:

- Upgrade the Pool/L2Pool implementation to 3.2
- Upgrade the PoolConfigurator implementation to 3.2
- Deploy new ProtocolDataProvider compatible with v3.2, and set it on the addresses provider contract
- Migrate all assets currently in eMode to be both borrowable & collateral in eMode
- Migrate the InterestRateStrategy to a new version without stable rate calculations

## Security procedures

In addition to unit tests & integration test suites, the changes have been audited by 4 independent auditors:

- TODO
- TODO
- TODO
- TODO

## References

- [Payload Implementation](https://github.com/bgd-labs/protocol-v3.2-upgrade/blob/main/src/contracts/UpgradePayload.sol)
- [New initialization logic of Pool](https://github.com/bgd-labs/protocol-v3.2-upgrade/blob/main/src/contracts/CustomInitialize.sol)
- [New L1 pool implementation](https://github.com/bgd-labs/protocol-v3.2-upgrade/blob/main/src/contracts/PoolInstance.sol)
- [New L2 pool implementation](https://github.com/bgd-labs/protocol-v3.2-upgrade/blob/main/src/contracts/L2PoolInstance.sol)
- [Payload Tests](https://github.com/bgd-labs/protocol-v3.2-upgrade/tree/main/tests)
- [Code and post execution state diffs](https://github.com/bgd-labs/protocol-v3.2-upgrade/tree/main/diffs)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x68ce69b5e71df1d77c2ad814a5d41162a40be54473576ff590d0b1bb5afde4a7)
- [Discussion](https://governance.aave.com/t/bgd-aave-v3-2-liquid-emodes/19037/3)
- [Migration guide](https://github.com/aave-dao/aave-v3-origin/blob/main/changelog/3.2.md)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
