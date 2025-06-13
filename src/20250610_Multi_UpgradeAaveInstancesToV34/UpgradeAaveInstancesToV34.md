---
title: "Upgrade Aave instances to v3.4"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-bgd-aave-v3-4/21572/20"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xbbdd44ff07184dc17b9215414f5bb747a48c19e699c7505df35a7e1ca54e9da6"
---

## Simple Summary

## Motivation

## Specification

## Security procedures

- The upgrade was extensively unit tested and fuzzed.
- Certora adapted its formal properties to ensure the upgrade's correctness.

In addition 4 audits by Independent Auditors were conducted.

- Auditors: [Stermi](https://auditor1.com), [Certora](https://auditor2.com), [Enigma](https://auditor3.com), [Blackthorn](https://auditor4.com)

## References

- Implementation: [AaveV3EthereumCore](https://github.com/bgd-labs/protocol-v3.4-upgrade/blob/main/src/UpgradePayloadMainnet.sol), [AllOtherInstances](https://github.com/bgd-labs/protocol-v3.4-upgrade/blob/main/src/UpgradePayload.sol)
- Tests: [AaveV3EthereumCore](https://github.com/bgd-labs/protocol-v3.4-upgrade/blob/main/test/MainnetCore.t.sol), [AllOtherInstances](https://github.com/bgd-labs/protocol-v3.4-upgrade/blob/main/test/UpgradeTest.t.sol)
- Upgrade diff: [v3.3 - v3.4](https://github.com/aave-dao/aave-v3-origin/pull/129)
- Onchain Diffs: [TODO](link to diffs)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xbbdd44ff07184dc17b9215414f5bb747a48c19e699c7505df35a7e1ca54e9da6)
- [Discussion](https://governance.aave.com/t/arfc-bgd-aave-v3-4/21572/20)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
