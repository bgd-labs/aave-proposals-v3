---
title: "Upgrade Aave instances to v3.5"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/direct-to-aip-bgd-aave-v3-5-v3-4-part-2/22639/1"
---

## Simple Summary

Upgrade the Aave protocol instances from v3.4 to v3.5.

## Motivation

Due to aspects like using rebasing tokens (a/v Tokens) on the accounting layer, Aave v3 has had well-known inherent mathematical imprecision on the lowest order of magnitudes. But even if this imprecision is highly frequently unavoidable, in the case of Aave v3, it has a kind of “chaotic” direction. This is different from standards like 4626, where the rounding is directionally explicit, consequently simpler to understand and reason about.

Even though this has not created major problems historically, we believe it is essential to enhance these mathematical mechanisms in a protocol as significant and widely adopted as Aave v3.

While originally these changes were part of the Aave v3.4 upgrade, they have been isolated in a v3.5 upgrade to have a reduced scope on 3.4 while having additional audits for v3.5.

## Specification

The upgrade payload updates the implementations of the Pool, AToken & VariableDebtToken on all networks.

On mainnet the payloads varies slightly to account for:

- aAave which has a different implementation due to the governance delegation integration
- vGHO which has a different implementation due to the deprecated discount mechanism on stkAAVE

An additional action is included on mainnet which transfers `96,050 $` as aUSDT to a BGD Labs address, to reimburse the cost of the audits.

## Security procedures

- The upgrade was extensively unit tested and fuzzed.
- Certora adapted its formal properties to ensure the upgrade's correctness.

In addition 4 audits by Independent Auditors were conducted.

- [Stermi](https://github.com/aave-dao/aave-v3-origin/blob/v3.5.0/audits/2025-07-17_StErMi_Aave-v3.5.md)
- [Certora](https://github.com/aave-dao/aave-v3-origin/blob/v3.5.0/audits/2025-07-14_Certora_AaveV3.5.pdf)
- [MixBytes](https://github.com/aave-dao/aave-v3-origin/blob/v3.5.0/audits/2025-07-18_MixBytes_AaveV3.5.pdf)
- [ABDK](https://github.com/aave-dao/aave-v3-origin/blob/v3.5.0/audits/2025-07-17_ABDK_Aave-v3.5.pdf)

## References

- Implementation: [AaveV3EthereumCore](https://github.com/bgd-labs/protocol-v3.5-upgrade/blob/main/src/UpgradePayloadMainnetCore.sol), [AllOtherInstances](https://github.com/bgd-labs/protocol-v3.5-upgrade/blob/main/src/UpgradePayload.sol)
- Tests: [AaveV3EthereumCore](https://github.com/bgd-labs/protocol-v3.5-upgrade/blob/main/test/MainnetCore.t.sol), [AllOtherInstances](https://github.com/bgd-labs/protocol-v3.5-upgrade/blob/main/test/UpgradeTest.t.sol)
- Upgrade diff: [v3.4 - v3.5](https://github.com/aave-dao/aave-v3-origin/pull/133)
- Onchain Diffs: [Per network diffs](https://github.com/bgd-labs/protocol-v3.5-upgrade/tree/main/diffs/code)
- [Discussion](https://governance.aave.com/t/direct-to-aip-bgd-aave-v3-5-v3-4-part-2/22639/1)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
