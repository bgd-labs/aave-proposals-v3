---
title: "Onboard syrupUSDT to Aave V3 Plasma Instance"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-syrupusdt-to-aave-v3-plasma-instance/23204"
---

## Simple Summary

This AIP proposes to onboard syrupUSDT to Aave V3 Plasma Instance.

## Motivation

With the recent approval of syrupUSDC on the Core Instance following BGD Labs’ updated [technical review](https://governance.aave.com/t/arfc-onboard-syrupusdc-to-aave-v3-core-instance/22456/10) we now propose to onboard syrupUSDT to the Plasma Instance. We propose this under the Direct to AIP framework.

Plasma is a **Tether-aligned chain**, making USDT-based assets a natural fit for its ecosystem. syrupUSDT combines USDT’s ubiquity with Maple’s institutional yield strategies, providing a compelling addition to Aave’s supported assets.

Key reasons for onboarding:

- **Chain alignment.** Plasma revolves around USDT, so syrupUSDT is more relevant than USDC-based alternatives.
- **Strong demand.** There is **~$2 billion in pent-up demand for SYRUPUSDT deployment** that cannot be accomodated anywhere else. syrupUSDT would capture and expand this demand and increase the utilization of USDT0 on Plasma.
- **Non-cyclical yield product.** Unlike most yield-bearing opportunities on Aave, **syrupUSDT** incorporates a non-cyclical component to its returns. This comes from the shorter-term fixed loans it offers, which are structurally designed to provide higher yields than Aave’s variable borrowing rates. This will also help the borrow rates on Aave to stay competitive and consistant, as syrupUSDT will provide continuous demand.
- **Network competitiveness.** Expanding supported assets on Plasma improves its attractiveness compared to other scaling networks.
- **Institutional inflows.** Maple’s counterparties are prepared to allocate into syrupUSDT, particularly if it is accepted as collateral on a USDT-centric chain like Plasma.

## Specification

The table below illustrates the configured risk parameters for **syrupUSDT**

| Parameter                 |       Value |
| ------------------------- | ----------: |
| Isolation Mode            |       false |
| Borrowable                |    DISABLED |
| Collateral Enabled        |        true |
| Supply Cap (syrupUSDT)    | 250,000,000 |
| Borrow Cap (syrupUSDT)    |           1 |
| Debt Ceiling              |       USD 0 |
| LTV                       |      0.05 % |
| LT                        |       0.1 % |
| Liquidation Bonus         |         6 % |
| Liquidation Protocol Fee  |        10 % |
| Reserve Factor            |        45 % |
| Base Variable Borrow Rate |         0 % |
| Variable Slope 1          |        10 % |
| Variable Slope 2          |       300 % |
| Uoptimal                  |        45 % |
| Flashloanable             |     ENABLED |
| Siloed Borrowing          |    DISABLED |
| Borrowable in Isolation   |    DISABLED |

### Oracle

| Parameter            |                                                                                                 syrupUSDT |
| -------------------- | --------------------------------------------------------------------------------------------------------: |
| Oracle               | [Capped syrupUSDT / USDT / USD](https://plasmascan.to/address/0x0A3F8218a98337Ef37dCAE4F8a8cfaB0711C64cF) |
| BASE/USD Oracle      |               [Capped USDT/USD](https://plasmascan.to/address/0xdBbB0b5DD13E7AC9C56624834ef193df87b022c3) |
| BASE/USD Oracle      |             [ChainlinkUSDT/USD](https://plasmascan.to/address/0xdBbB0b5DD13E7AC9C56624834ef193df87b022c3) |
| Ratio Provider       |  [SYRUPUSDT-USDT Exchange Rate](https://plasmascan.to/address/0x89a0e204591Fce2611e89CA7634c12B400d347fe) |
| Oracle Latest Answer |                                                                               (2025-10-16) USD 1.09822744 |
| min snapshot         |                                                                                                    7 days |
| max yearly growth    |                                                                                                     8.45% |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://plasmascan.to/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for syrupUSDT and the corresponding aToken.

### **E-Mode**

| **Parameter**         | **Value** | **Value** |
| --------------------- | --------- | --------- |
| Asset                 | syrupUSDT | USDT0     |
| Collateral            | Yes       | No        |
| Borrowable            | No        | Yes       |
| Max LTV               | 90.00%    | -         |
| Liquidation Threshold | 92.00%    | -         |
| Liquidation Bonus     | 4.00%     | -         |

## References

- Implementation: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251016_AaveV3Plasma_OnboardSyrupUSDTToAaveV3PlasmaInstance/AaveV3Plasma_OnboardSyrupUSDTToAaveV3PlasmaInstance_20251016.sol)
- Tests: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251016_AaveV3Plasma_OnboardSyrupUSDTToAaveV3PlasmaInstance/AaveV3Plasma_OnboardSyrupUSDTToAaveV3PlasmaInstance_20251016.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-syrupusdt-to-aave-v3-plasma-instance/23204)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
