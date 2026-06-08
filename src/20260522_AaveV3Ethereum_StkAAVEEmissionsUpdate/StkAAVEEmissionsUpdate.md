---
title: "stkAAVE Emissions Update"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-stkaave-emissions-update/24945"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0xd416e6cb09416cc4effdd2ad869373db2ac005ea63e7d7baeec0db4934281352"
---

## Simple Summary

Reduce stkAAVE emissions from `220 AAVE/day` to `150 AAVE/day`, targeting a staking APR of `~2.75%` (down from `~3.30%`).

## Motivation

Following significant stkAAVE withdrawals in Q2 2026 (`~32,593` AAVE across four large holders, with an additional `35,000+` AAVE in cooldown), the stkAAVE APR is trending upward toward `~3.93%` absent corrective action. Lowering emissions by `70 AAVE/day` brings yield back in line with the target rate and reduces annualized emissions from `80,300 AAVE` to `54,750 AAVE` (`~$2.3M/year` at `$90/AAVE`).

The adjustment is consistent with guidance from the "Aave DAO Funding Insights" publication and the DAO's recent decisions to pause buyback programs and redirect capital toward strengthening the balance sheet following the rsETH incident donation.

## Specification

Call `configureAssets` on the stkAAVE Safety Module (`0x4da27a545c0c5B758a6BA100e3a049001de870f5`) to set `emissionPerSecond` for stkAAVE to `150 ether / 1 days` (1,736,111,111,111,111 wei/s). No other Safety Module parameters are modified.

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260522_AaveV3Ethereum_StkAAVEEmissionsUpdate/AaveV3Ethereum_StkAAVEEmissionsUpdate_20260522.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260522_AaveV3Ethereum_StkAAVEEmissionsUpdate/AaveV3Ethereum_StkAAVEEmissionsUpdate_20260522.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0xd416e6cb09416cc4effdd2ad869373db2ac005ea63e7d7baeec0db4934281352)
- [Discussion](https://governance.aave.com/t/arfc-stkaave-emissions-update/24945)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
