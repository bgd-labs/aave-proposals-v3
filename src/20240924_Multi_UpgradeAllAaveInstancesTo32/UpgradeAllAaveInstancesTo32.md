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

_In addition to the upgrade itself, the proposal payload includes reimbursement of $76’000 denominated in GHO, to cover the cost of extra external security procedures incurred._

## Specification

Aave 3.2 focuses on two main areas of the aave protocol:

- The final deprecation of stable borrowing
- Improvements on the eModes, introducing "Liquid eModes"

The proposal will execute to following operations on each active Aave v3 pool:

- Upgrade the Pool/L2Pool implementation to 3.2, which will internally set the stableDebtToken address to `address(0)` on all assets
- Upgrade the PoolConfigurator implementation to 3.2
- Deploy new ProtocolDataProvider compatible with v3.2, and set it on the addresses provider contract
- Migrate all assets currently in eMode to be both borrowable & collateral in eMode
- Migrate the InterestRateStrategy to a new version without stable rate calculations

An additional payload will transfer `76,000.00` GHO to the BGD-controlled address `0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF`.

## Security procedures

In addition to unit tests & integration test suites, the changes have been audited in 5 audits by 4 independent auditors:

### Stable Rate and Liquid eModes

- [Certora](https://github.com/aave-dao/aave-v3-origin/blob/v3.2.0/audits/2024-09-10_Certora_Aave-v3.2_Stable_Rate_Removal.pdf)
- [Enigma Dark](https://github.com/aave-dao/aave-v3-origin/blob/v3.2.0/audits/2024-09-30_Enigma_Aave-v3.2.pdf)

### Liquid eModes

- [Certora](https://github.com/aave-dao/aave-v3-origin/blob/v3.2.0/audits/2024-09-19_Certora_Aave-v3.2_Liquid_eModes.pdf)
- [Oxorio](https://github.com/aave-dao/aave-v3-origin/blob/v3.2.0/audits/2024-09-12_Oxorio_Aav3-v3.2.pdf)
- [Pashov](https://github.com/aave-dao/aave-v3-origin/blob/v3.2.0/audits/2024-09-15_Pashov_Aave-v3.2.pdf)

## References

- [Payload Implementation](https://github.com/bgd-labs/protocol-v3.2-upgrade/blob/main/src/contracts/UpgradePayload.sol)
- [New initialization logic of Pool](https://github.com/bgd-labs/protocol-v3.2-upgrade/blob/main/src/contracts/CustomInitialize.sol)
- [New L1 pool implementation](https://github.com/bgd-labs/protocol-v3.2-upgrade/blob/main/src/contracts/PoolInstance.sol)
- [New L2 pool implementation](https://github.com/bgd-labs/protocol-v3.2-upgrade/blob/main/src/contracts/L2PoolInstance.sol)
- [Payload Tests](https://github.com/bgd-labs/protocol-v3.2-upgrade/tree/main/tests)
- [Live-code and post execution state diffs](https://github.com/bgd-labs/protocol-v3.2-upgrade/tree/main/diffs)
- [PoolDiff](https://github.com/aave-dao/aave-v3-origin/blob/v3.2.0/docs/3.2/3.1_3.2_L2PoolDiff.md), [PoolConfiguratorDiff](https://github.com/aave-dao/aave-v3-origin/blob/v3.2.0/docs/3.2/3.1-3.2_PoolConfiguratorDiff.md)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x68ce69b5e71df1d77c2ad814a5d41162a40be54473576ff590d0b1bb5afde4a7)
- [Discussion](https://governance.aave.com/t/bgd-aave-v3-2-liquid-emodes/19037/3)
- [Migration guide](https://github.com/aave-dao/aave-v3-origin/blob/v3.2.0/docs/3.2/Aave-3.2-features.md)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
