---
title: "Aave v3 Gnosis Instance Updates Part 1"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/arfc-aave-v3-gnosis-instance-updates/20334"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0x2e93ddd01ba5ec415b0962907b7c65def947d1ed94f1e5b402c5578560b1dddb"
---

## Simple Summary

This AIP proposes several updates to the Aave v3 Gnosis instance to improve capital efficiency and add new use cases on the network. The key changes include removing GNO from isolation mode, adjusting the reserve factor for EURe, and creating a new relevant E-mode.

## Motivation

GNO has demonstrated strong stability and market presence on Gnosis Chain, making isolation mode unnecessarily restrictive and hindering network growth. Removing GNO from isolation mode will facilitate further expansion of the network.

The reduction in the EURe reserve factor aligns with the asset's performance and incentivizes increased lending activity.

introducing a new E-mode for sDAI & EURe will enhance capital efficiency and foster synergies between stable assets. The unique combination of EUR and USD borrowing opportunities is a distinct advantage for Gnosis Chain.

## Specification

### Rates and parameters updates

- Remove GNO from isolation mode
- change EURe Reserve Factor from 20% to 10%

### E-Modes

The followings E-mode will be created:

| **Parameter**         | **Value** | **Value** |
| --------------------- | --------- | --------- |
| Asset                 | sDAI      | EURe      |
| Collateral            | Yes       | No        |
| Borrowable            | No        | Yes       |
| Max LTV               | 85%       | 85%       |
| Liquidation Threshold | 87.5%     | 87.5%     |
| Liquidation Bonus     | 5%        | 5%        |

## References

- Implementation: [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241224_AaveV3Gnosis_AaveV3GnosisInstanceUpdates/AaveV3Gnosis_AaveV3GnosisInstanceUpdates_20241224.sol)
- Tests: [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241224_AaveV3Gnosis_AaveV3GnosisInstanceUpdates/AaveV3Gnosis_AaveV3GnosisInstanceUpdates_20241224.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x2e93ddd01ba5ec415b0962907b7c65def947d1ed94f1e5b402c5578560b1dddb)
- [Discussion](https://governance.aave.com/t/arfc-aave-v3-gnosis-instance-updates/20334)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
