---
title: "CAPO SnapshotRatio Update Across Aave V3"
author: "Llama Risk (implemented by Aave Labs)"
discussions: "https://governance.aave.com/t/direct-to-aip-capo-snapshotratio-update-across-aave-v3/24854"
---

## Simple Summary

LlamaRisk proposes updating the snapshotRatio to address stale snapshots and the growing drift between the CAPO upper bound and the current ratio across Aave V3. This update addresses the risk stemming from the widening spread, where, in the event of an inflation attack, collateral could become materially overpriced, potentially resulting in undercollateralized positions and bad debt for the protocol.

## Motivation

The spread between the CAPO upper bound and the current exchange rate for yield-bearing assets on Aave has widened due to a combination of high maxYearlyRatioGrowthPercent values and outdated snapshots. In the event of an inflation attack, where an adversary artificially pushes the underlying exchange-rate source upward, the collateral may become overpriced. The amount of borrows that can be accumulated against this overpriced collateral is directly driven by the magnitude of the spread between the current exchange rate and the CAPO upper bound. If the spread becomes sufficiently large, the position may become undercollateralized once the exchange rate normalizes, potentially resulting in bad debt for the protocol.

## Specification

The proposal refreshes the snapshotRatio and snapshotTimestamp for the reserves listed above, anchoring the cap to recent on-chain readings rather than year-old reference points. The new snapshot for each adapter is selected from the historical getRatio() series (verifiable on-chain) such that all four validation predicates of \_setCapParameters are respected: the new timestamp is strictly greater than the stored one, is at least MINIMUM_SNAPSHOT_DELAY seconds in the past, is no more than MAXIMUM_SNAPSHOT_TERM (180 days) in the past, the new ratio is non-zero, and snapshotRatio <= currentRatio.

In addition to the snapshot refresh, we recommend an additional change to the sUSDe CAPO on Ethereum (affects both Core and Lido markets). The adapter is currently configured with a maxYearlyRatioGrowthPercent of 50%, far above realized APY as shown below. Accounting for future growth scenario we recommend lowering maxYearlyRatioGrowthPercent from 50% to 11.17%.

| Instance       | Asset  | Current SnapshotRatio | New SnapshotRatio   | Current SnapshotTimestamp | New SnapshotTimestamp   |
| -------------- | ------ | --------------------- | ------------------- | ------------------------- | ----------------------- |
| Ethereum Prime | sUSDe  | 1150485992969698694   | 1227131992751411096 | 1737789743 (2025-01-25)   | 1776098039 (2026-04-13) |
| Ethereum Core  | sUSDe  | 1150485992969698694   | 1227131992751411096 | 1737789743 (2025-01-25)   | 1776098039 (2026-04-13) |
| Ethereum Core  | rETH   | 1098284517740008249   | 1161297025018026367 | 1708004591 (2024-02-15)   | 1776100271 (2026-04-13) |
| Polygon        | MaticX | 1098625039344900513   | 1184553336304744130 | 1707352792 (2024-02-08)   | 1776095251 (2026-04-13) |
| Ethereum Core  | weETH  | 1034656878645040505   | 1092511275951548029 | 1711416299 (2024-03-26)   | 1776098051 (2026-04-13) |
| Ethereum Core  | ETHx   | 1029650229444067238   | 1086803171399918543 | 1715877911 (2024-05-16)   | 1776097967 (2026-04-13) |
| Ethereum Core  | osETH  | 1014445878439441413   | 1069243791626177773 | 1713934379 (2024-04-24)   | 1776100271 (2026-04-13) |
| Polygon        | wstETH | 1157105995453941980   | 1231787423404290591 | 1707948441 (2024-02-14)   | 1776095275 (2026-04-13) |
| Gnosis         | wstETH | 1157105995453941980   | 1231706743820320505 | 1707988835 (2024-02-15)   | 1776087290 (2026-04-13) |
| Ethereum Core  | ezETH  | 1019883708003361006   | 1076159265830748846 | 1727172839 (2024-09-24)   | 1776100259 (2026-04-13) |
| Ethereum Prime | ezETH  | 1019883708003361006   | 1076159265830748846 | 1727172839 (2024-09-24)   | 1776100259 (2026-04-13) |
| Ethereum Core  | cbETH  | 1063814269953974334   | 1127672723490107311 | 1708004591 (2024-02-15)   | 1776097967 (2026-04-13) |
| Avalanche      | sAVAX  | 1130535654847205789   | 1258004893989529449 | 1707346799 (2024-02-07)   | 1776080367 (2026-04-13) |
| Linea          | wstETH | 1190272828525538502   | 1231706743820320505 | 1736592058 (2025-01-11)   | 1776040336 (2026-04-13) |
| Linea          | ezETH  | 1029140608890425422   | 1076090972297786741 | 1733109809 (2024-12-02)   | 1776040248 (2026-04-13) |
| Plasma         | sUSDe  | 1193972665854975048   | 1227017473582880624 | 1756871339 (2025-09-03)   | 1776095930 (2026-04-13) |
| Linea          | weETH  | 1054169605180649721   | 1092447295285287694 | 1733109809 (2024-12-02)   | 1776040278 (2026-04-13) |
| Avalanche      | sUSDe  | 1193972665854975048   | 1227006247957361173 | 1756871339 (2025-09-03)   | 1776080378 (2026-04-13) |
| Plasma         | weETH  | 1075964667602784803   | 1092447295285287694 | 1756871339 (2025-09-03)   | 1776095953 (2026-04-13) |
| Mantle         | sUSDe  | 1213777113888938853   | 1227013966208500235 | 1767152639 (2025-12-31)   | 1776095860 (2026-04-13) |
| Gnosis         | sDAI   | 1175603447581596870   | 1234933736953001411 | 1746358275 (2025-05-04)   | 1776087275 (2026-04-13) |

Both Ethereum Core and Lido markets utilize the same CAPO for sUSDe.

| Instance | Asset | Current maxYearlyRatioGrowthPercent | Recommended maxYearlyRatioGrowthPercent |
| -------- | ----- | ----------------------------------- | --------------------------------------- |
| Ethereum | sUSDe | 50%                                 | 11.17%                                  |

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3Ethereum_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol), [AaveV3Polygon](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3Polygon_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol), [AaveV3Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3Avalanche_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol), [AaveV3Gnosis](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3Gnosis_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol), [AaveV3Linea](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3Linea_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3Plasma_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol), [AaveV3Mantle](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3Mantle_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3Ethereum_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.t.sol), [AaveV3EthereumLido](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3EthereumLido_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.t.sol), [AaveV3Polygon](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3Polygon_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.t.sol), [AaveV3Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3Avalanche_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.t.sol), [AaveV3Gnosis](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3Gnosis_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.t.sol), [AaveV3Linea](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3Linea_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.t.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3Plasma_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.t.sol), [AaveV3Mantle](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3Mantle_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-capo-snapshotratio-update-across-aave-v3/24854)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
