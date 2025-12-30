---
title: "Onboard syrupUSDC to Aave V3 Base Instance"
author: "Maple (implemented and written by ACI via Skyward)"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-syrupusdc-to-aave-v3-base-instance/23234"
---

## Simple Summary

This AIP proposes to onboard syrupUSDC to Aave V3 Base Instance.

## Motivation

With the recent approval of syrupUSDC on the Core Instance following BGD Labs’ updated [technical review](https://governance.aave.com/t/arfc-onboard-syrupusdc-to-aave-v3-core-instance/22456/10) we now propose to onboard syrupUSDC to the Base Instance. We propose this under the Direct to AIP framework.

We believe that the Base instance has strong growth prospects and with an increase in high demand collateral assets we will see rate of growth pick up. syrupUSDC is a good candidate for onboarding to Base for these reasons.

We recommend an eMode be created with USDC and GHO as borrow assets.

## Specification

The table below illustrates the configured risk parameters for **syrupUSDC**

| Parameter                 |      Value |
| ------------------------- | ---------: |
| Isolation Mode            |      false |
| Borrowable                |   DISABLED |
| Collateral Enabled        |       true |
| Supply Cap (syrupUSDC)    | 50,000,000 |
| Borrow Cap (syrupUSDC)    |          1 |
| Debt Ceiling              |      USD 0 |
| LTV                       |     0.05 % |
| LT                        |      0.1 % |
| Liquidation Bonus         |        4 % |
| Liquidation Protocol Fee  |       10 % |
| Reserve Factor            |       50 % |
| Base Variable Borrow Rate |        0 % |
| Variable Slope 1          |       10 % |
| Variable Slope 2          |      300 % |
| Uoptimal                  |       45 % |
| Flashloanable             |    ENABLED |
| Siloed Borrowing          |   DISABLED |
| Borrowable in Isolation   |   DISABLED |

### Oracle details

| **Parameter**          | **Value**                                                                                                |
| ---------------------- | -------------------------------------------------------------------------------------------------------- |
| Oracle                 | [Capped SyrupUSDC / USDC / USD](https://basescan.org/address/0xa61f10Bb2f05A94728734A8a95673ADbCA9B8397) |
| Ratio Provider         | [syrupUSDC-USDC Exchange Rate](https://basescan.org/address0x311D3A3faA1d5939c681E33C2CDAc041FF388EB2/)  |
| Underlying oracle      | [Capped USDC/USD](https://basescan.org/address/0xfcF82bFa2485253263969167583Ea4de09e9993b)               |
| Minimum Snapshot delay | 7 days                                                                                                   |
| Max yearly growth      | 8.04%                                                                                                    |
| Last Answer            | (2025-12-23) USD 1.14277342                                                                              |

### Emodes

**syrupUSDC/stablecoin**

| **Parameter**         | **Value** | **Value** | **Value** |
| --------------------- | --------- | --------- | --------- |
| Asset                 | syrupUSDC | USDC      | GHO       |
| Collateral            | Yes       | No        | No        |
| Borrowable            | No        | Yes       | Yes       |
| Max LTV               | 90.00%    | -         | -         |
| Liquidation Threshold | 92.00%    | -         | -         |
| Liquidation Bonus     | 4.00%     | -         | -         |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://basescan.org/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for syrupUSDC and the corresponding aToken.

## References

- Implementation: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251223_AaveV3Base_OnboardSyrupUSDCToAaveV3BaseInstance/AaveV3Base_OnboardSyrupUSDCToAaveV3BaseInstance_20251223.sol)
- Tests: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251223_AaveV3Base_OnboardSyrupUSDCToAaveV3BaseInstance/AaveV3Base_OnboardSyrupUSDCToAaveV3BaseInstance_20251223.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-syrupusdc-to-aave-v3-base-instance/23234)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
