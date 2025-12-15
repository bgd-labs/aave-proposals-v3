---
title: "Remove USDS as collateral and increase RF across all Aave Instances"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/arfc-remove-usds-as-collateral-and-increase-rf-across-all-aave-instances/23426"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0xeb05b887d9db47d2f4a42d4f4fcb7141080d091dc8c1b32e9a75597071f949ea"
---

## Simple Summary

This AIP proposes removing USDS as collateral and increasing RF across all Aave instances.

USDS generates negligible revenue while its issuance model introduces asymmetric risks that could impact Aave’s stability.

## Motivation

Motivation for these changes is driven by both reducing revenue from USDS borrows, and changing risk profile bringing into doubt the suitability of the asset as collateral.

### 1. Low Profitability

Data shows a decline in revenue each month, with \$543,528 since Q1 2025, and current annualised revenue of \$135,260 based on revenue since the beginning of Q4. With quarterly revenue data showing a sharp decline since the beginning of the year, we believe that current revenue is far below the scale required to justify current risk exposure.

| **Instance** | **Q1**       | **Q2**       | **Q3**       | **Q4**      |
| ------------ | ------------ | ------------ | ------------ | ----------- |
| Cove V3      | $87,948      | $127,768     | $96,556      | $17,417     |
| Prime V3     | $156,205     | $47,999      | $9,276       | $359        |
| **Total**    | **$244,153** | **$175,767** | **$105,832** | **$17,776** |

To combat this decline in revenue we propose raising RF to 25% which would increase Aave revenue by +150% on the same borrow volume.

### 2. Potential Risks from Issuance Model

With the new Stars being created within the Sky ecosystem, the risk profile of USDS is changing. Given these changes characterised by credit lines at low or zero cost, and the risk surface area presented by the yield strategies being utilised, we believe that the risk profile has increased to a degree which is outside of what is acceptable for Aave collateral.

Alongside the increase in RF we propose setting LTV to 0% in order to remove Aave’s exposure to USDS as collateral. Combined, we believe these measures bring the risk/reward of USDS back in line with other assets on Aave.

## Specification

| Instance      | Asset | Current Max LTV | Recommended Max LTV |
| ------------- | ----- | --------------- | ------------------- |
| Optimism      | DAI   | 63%             | 0%                  |
| Polygon       | DAI   | 63%             | 0%                  |
| Avalanche     | DAI.e | 63%             | 0%                  |
| Arbitrum      | DAI   | 63%             | 0%                  |
| Ethereum Core | DAI   | 63%             | 0%                  |
| Ethereum Core | USDS  | 75%             | 0%                  |
| Metis         | m.DAI | 63%             | 0%                  |

| Asset | Chain          | Current Supply Cap | Recommended Supply Cap | Current Borrow Cap | Recommended Borrow Cap | Current RF | **Recommended RF** |
| ----- | -------------- | ------------------ | ---------------------- | ------------------ | ---------------------- | ---------- | ------------------ |
| USDS  | Ethereum Core  | 800,000,000        | 160,000,000            | 360,000,000        | 144,000,000            | 10%        | 25%                |
| USDS  | Ethereum Prime | 200,000,000        | 40,000,000             | 180,000,000        | 36,000,000             | 10%        | 25%                |
| DAI   | Ethereum Core  | 338,000,000        | 200,000,000            | 271,000,000        | 180,000,000            | -          | -                  |
| DAI   | OP Mainnet     | 10,000,000         | 2,000,000              | 7,000,000          | 1,800,000              | -          | -                  |
| m.DAI | Metis          | 1,000,000          | 200,000                | 900,000            | 180,000                | -          | -                  |

Moreover USDS will be removed from the following emodes:

**Core**:

- USDe_sUSDe\_\_USDC_USDT_USDS
- sUSDe_PT_sUSDE_31JUL2025\_\_USDC_USDT_USDS
- PT_eUSDE_29MAY2025_eUSDe\_\_USDC_USDT_USDS
- USDe_PT_USDe_31JUL2025\_\_USDC_USDT_USDS
- USDe\_\_USDC_USDT_USDS
- PT_eUSDE_14AUG2025_eUSDe\_\_USDC_USDT_USDS
- eUSDe\_\_USDC_USDT_USDS
- sUSDe_PT_sUSDE_31JUL2025_PT_sUSDE_25SEP2025\_\_USDC_USDT_USDe_USDS_USDtb
- USDe_PT_USDe_31JUL2025_PT_eUSDE_14AUG2025_PT_USDe_25SEP2025\_\_USDC_USDT_USDe_USDS
- sUSDe_PT_sUSDE_25SEP2025_PT_sUSDE_27NOV2025\_\_USDC_USDT_USDe_USDS_USDtb
- PT_USDe_25SEP2025_PT_USDe_27NOV2025\_\_USDC_USDT_USDe_USDS_USDtb

**Prime**:

- ezETH\_\_USDS_USDC_GHO
- rsETH\_\_USDS_USDC_GHO

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251203_Multi_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances/AaveV3Ethereum_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251203_Multi_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances/AaveV3EthereumLido_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251203_Multi_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances/AaveV3Polygon_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251203_Multi_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances/AaveV3Avalanche_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251203_Multi_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances/AaveV3Optimism_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251203_Multi_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances/AaveV3Arbitrum_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251203_Multi_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances/AaveV3Metis_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251203_Multi_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances/AaveV3Ethereum_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251203_Multi_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances/AaveV3EthereumLido_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251203_Multi_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances/AaveV3Polygon_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251203_Multi_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances/AaveV3Avalanche_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251203_Multi_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances/AaveV3Optimism_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251203_Multi_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances/AaveV3Arbitrum_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251203_Multi_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances/AaveV3Metis_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0xeb05b887d9db47d2f4a42d4f4fcb7141080d091dc8c1b32e9a75597071f949ea)
- [Discussion](https://governance.aave.com/t/arfc-remove-usds-as-collateral-and-increase-rf-across-all-aave-instances/23426)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
