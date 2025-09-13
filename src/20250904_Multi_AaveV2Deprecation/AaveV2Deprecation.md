---
title: "Aave V2 deprecation"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-aave-v2-deprecation-tech-next-phase/23022"
snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xbece41f2549d7b908a07ef1e5032e500e9c887b8252915d3782b74df35659d22
---

## Simple Summary

Propose to the community further non-invasive deprecation steps on the technical side, by setting the CF (Close Factor) to 100% allowing smoother liquidations, cleaning bad debt via a new ClinicSteward adapted for v2, and minor code adjustments.

## Motivation

After years of v2 being in a deprecated stage, with the majority (or all) of the assets on Ethereum/Polygon/Avalanche being frozen or disabled for borrowing, we believe it is necessary to continue with progressive deprecation steps for the system.

Given that the pools are still relatively big (especially v2 Ethereum with approximately $300m in size), this phase is still not invasive to users, mainly focused on making smoother liquidations, for the DAO to be able to clean up all historic bad debt without systemically leaving dust.

This proposal is, even if independent, complementary to [this other](https://governance.aave.com/t/arfc-aave-v2-deprecation-update/23008) by `@TokenLogic` and the risk providers.

## Specification

The proposal will execute the following two steps on each network:

1. Replace the `LendingPoolCollateralManager` with a version implementing 100% CF (Close Factor). For clarity, this means that whenever a position is eligible for liquidation (when reaching 1 HF), the liquidator will be able to close 100% of the position, instead of 50% if over the Close Factor threshold.
2. Grant `FUNDS_MANAGER` role from the `Collector` to a `ClinicStewardV2` smart contract, an adapted version of the one done [HERE](https://governance.aave.com/t/arfc-bgd-aave-clinicsteward/21209) for Aave v3, for the DAO to clean up historic v2 bad debt with Collector’s funds.
   Additional details on its configuration:

   - The final budgets per pool are as follows:
     - 1M $ on Ethereum core
     - 1k $ on Ethereum AMM
     - 2.5k $ on Avalanche
     - 5k $ on Polygon
   - The roles configuration of the steward [will be the same as on v3’s](https://governance.aave.com/t/arfc-bgd-aave-clinicsteward/21209#p-53721-specification-3) for the superadmin (to not be really used). And a Dolce Vita EOA for the cleanup role, totally constrained by pre-defined budgets and on-chain logic.

3. Do very minor changes to the precision of the system to have more compatibility with v3.

On the security side, the different components have been reviewed by Certora.

## References

### Aave V2 deprecation payloads

- Implementation: [UpgradePayloadMainnet](https://github.com/bgd-labs/v2-deprecation/blob/main/src/payloads/UpgradePayloadMainnet.sol), [UpgradePayloadAMM](https://github.com/bgd-labs/v2-deprecation/blob/main/src/payloads/UpgradePayloadAMM.sol), [UpgradePayloadPolygon](https://github.com/bgd-labs/v2-deprecation/blob/main/src/payloads/UpgradePayloadPolygon.sol), [UpgradePayloadAvalanche](https://github.com/bgd-labs/v2-deprecation/blob/main/src/payloads/UpgradePayloadAvalanche.sol)
- Tests: [UpgradePayloadMainnet](https://github.com/bgd-labs/v2-deprecation/blob/main/tests/MainnetCore.t.sol), [UpgradePayloadAMM](https://github.com/bgd-labs/v2-deprecation/blob/main/tests/MainnetAmm.t.sol), [UpgradePayloadPolygon](https://github.com/bgd-labs/v2-deprecation/blob/main/tests/Polygon.t.sol), [UpgradePayloadAvalanche](https://github.com/bgd-labs/v2-deprecation/blob/main/tests/Avalanche.t.sol)

### Clinic Steward V2 activation payloads

- Implementation: [ClinicStewardV2Activation](./ClinicStewardV2Activation_20250904.sol)
- Tests: [ClinicStewardV2Activation](./ClinicStewardV2Activation_20250904.t.sol)

### Other

- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xbece41f2549d7b908a07ef1e5032e500e9c887b8252915d3782b74df35659d22)
- [Discussion](https://governance.aave.com/t/arfc-aave-v2-deprecation-tech-next-phase/23022)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
