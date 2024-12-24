---
title: "Aave v3 Gnosis Instance Updates"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/arfc-aave-v3-gnosis-instance-updates/20334"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0x2e93ddd01ba5ec415b0962907b7c65def947d1ed94f1e5b402c5578560b1dddb"
---

## Simple Summary

## Motivation

## Specification

### Onbooarding

The table below illustrates the configured risk parameters for **osGNO**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (osGNO)        |                                      4,750 |
| Borrow Cap (osGNO)        |                                          1 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                     0.05 % |
| LT                        |                                      0.1 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        0 % |
| Variable Slope 2          |                                        0 % |
| Uoptimal                  |                                       50 % |
| Flashloanable             |                                   DISABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x22441d81416430A54336aB28765abd31a792Ad37 |

Additionaly [0xac140648435d03f784879cd789130F22Ef588Fcd](https://gnosisscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for osGNO and the corresponding aToken.

### Rates and parameters updates

- Remove GNO from isolation mode
- change EURe Reserve Factor from 20% to 10%

### E-Modes

The followings E-modes will be created:

| **Parameter**         | **Value** | **Value** |
| --------------------- | --------- | --------- |
| Asset                 | osGNO     | GNO       |
| Collateral            | Yes       | No        |
| Borrowable            | No        | Yes       |
| Max LTV               | 90%       | -         |
| Liquidation Threshold | 92.5%     | -         |
| Liquidation Bonus     | 2.50%     | -         |

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
