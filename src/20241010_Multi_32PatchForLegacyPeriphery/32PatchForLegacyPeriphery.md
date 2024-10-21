---
title: "3.2 patch for legacy periphery"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/45"
---

## Simple Summary

Upgrade the Pool contract across all networks, to add an extra fallback on the getReserveData() view function, allowing for integrators unable to update peripheral contracts (Aave Pool Data Provider) to still be compatible with v3.2.

## Motivation

Aave v3.2 included the removal of all the logic of stable rate borrow mode, and the release of a new ProtocolDataProvider maintaining retro-compatibility.

However, post-release we have been contacted by integrators with totally immutable infrastructure depending on so-called “hardcoding” of legacy peripheral contracts, in this case, an old version of the ProtocolDataProvider, designed to be replaced on the core contract of Aave (PoolAddressesProvider) whenever an upgrade happens.

Even if non-critical, this has created issues for those integrators, and from the Aave side, it is possible to increase even more the retro-compatibility by doing a simple upgrade on the Pool smart contract.

## Specification

The governance proposal will configure a MOCK_STABLE_DEBT variable on the PoolAddressesProvider, together with upgrading the Aave Pool contract across all networks.

On this pool upgrade, the only modification would be to now return the previously configured MOCK_STABLE_DEBT address for stableDebtTokenAddress on Pool.getReserveData(), this way removing any type of unexpected behavior from integrators using legacy ProtocolDataProvider peripheral contracts, consuming getReserveData().

## Security considerations

The proposal was tested via unit tests and Certora [checked the upgrade and proposal](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/46).

## References

- [Proposal Implementation](https://github.com/bgd-labs/protocol-v3.2-pdp-patch/blob/main/src/contracts/UpgradePayload.sol)
- [Protocol Upgrade Implementation](https://github.com/aave-dao/aave-v3-origin/pull/64)
- [Pool implementation diff](https://github.com/bgd-labs/protocol-v3.2-pdp-patch/blob/main/diffs/1_poolImpl_0x1f64488c2C4686771dafA75915274d27878B667a_0xeF434E4573b90b6ECd4a00f4888381e4D0CC5Ccd.diff)
- [Tests](https://github.com/bgd-labs/protocol-v3.2-pdp-patch/tree/main/tests)
- [Discussion](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/45)
- [Upgrade repository](https://github.com/bgd-labs/protocol-v3.2-pdp-patch)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
