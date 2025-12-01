---
title: "Onboard syrupUSDT to Aave V3 Core Instance"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-syrupusdt-to-aave-v3-core-instance/23291"
---

## Simple Summary

This proposal seeks to onboard syrupUSDT to Aave V3 Core Instance.

## Motivation

With the recent approval of syrupUSDC on the Core Instance following BGD Labs’ updated [technical review](https://governance.aave.com/t/arfc-onboard-syrupusdc-to-aave-v3-core-instance/22456/10) and syrupUSDT on the Plasma Instance, we propose to expand this asset to other networks beginning with the Core Instance. We propose this under the Direct to AIP framework.

There is significant demand for syrupUSDT to be used in Aave, and with the Core Instance having the deepest stablecoin liquidity we believe this is the logical next instance on which to onboard syrupUSDT.

## Specification

The table below illustrates the configured risk parameters for **syrupUSDT**

| Parameter                 |      Value |
| ------------------------- | ---------: |
| Isolation Mode            |      false |
| Borrowable                |   DISABLED |
| Collateral Enabled        |       true |
| Supply Cap (syrupUSDT)    | 50,000,000 |
| Borrow Cap (syrupUSDT)    |          1 |
| Debt Ceiling              |      USD 0 |
| LTV                       |     0.05 % |
| LT                        |      0.1 % |
| Liquidation Bonus         |        6 % |
| Liquidation Protocol Fee  |       10 % |
| Reserve Factor            |       50 % |
| Base Variable Borrow Rate |        0 % |
| Variable Slope 1          |       10 % |
| Variable Slope 2          |      300 % |
| Uoptimal                  |       45 % |
| Flashloanable             |    ENABLED |
| Siloed Borrowing          |   DISABLED |
| Borrowable in Isolation   |   DISABLED |

**Oracle details**

| **Parameter**          | **Value**                                                                                                |
| ---------------------- | -------------------------------------------------------------------------------------------------------- |
| Oracle                 | [Capped SyrupUSDT / USDT / USD](https://etherscan.io/address/0x982ac260b5a4e5bcab6a437e79168390cfbde70d) |
| Ratio Provider         | [syrupUSDT](https://etherscan.io/address/0x356B8d89c1e1239Cbbb9dE4815c39A1474d5BA7D)                     |
| Underlying oracle      | [Capped USDT/USD](https://etherscan.io/address/0x260326c220E469358846b187eE53328303Efe19C)               |
| Minimum Snapshot delay | 7 days                                                                                                   |
| Max yearly growth      | 8.45%                                                                                                    |
| Last Answer            | (2025-11-26) USD 1.10433014                                                                              |

### E-mode

| **Parameter**         | **Value** | **Value** | **Value** |
| --------------------- | --------- | --------- | --------- |
| Asset                 | syrupUSDT | USDT      | GHO       |
| Collateral            | Yes       | No        | No        |
| Borrowable            | No        | Yes       | Yes       |
| Max LTV               | 90.00%    | -         | -         |
| Liquidation Threshold | 92.00%    | -         | -         |
| Liquidation Bonus     | 4.00%     | -         | -         |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for syrupUSDT and the corresponding aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/eae60bd78e895dee088fb1039dc87f103030b35c/src/20251126_AaveV3Ethereum_OnboardSyrupUSDTToAaveV3CoreInstance/AaveV3Ethereum_OnboardSyrupUSDTToAaveV3CoreInstance_20251126.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/eae60bd78e895dee088fb1039dc87f103030b35c/src/20251126_AaveV3Ethereum_OnboardSyrupUSDTToAaveV3CoreInstance/AaveV3Ethereum_OnboardSyrupUSDTToAaveV3CoreInstance_20251126.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-syrupusdt-to-aave-v3-core-instance/23291)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
