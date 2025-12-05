---
title: "Ethena February E-Modes Adjustments"
author: "Chaos Labs (implemented by ACI via Skyward)"
discussions: "https://governance.aave.com/t/direct-to-aip-ethena-february-pts-caps-and-e-modes-adjustments/23501"
---

## Simple Summary

We recommend adding sUSDe as an eligible collateral asset in both the PTsUSDe5FEB/Stablecoins and PTsUSDe5FEB/USDe E-Modes

## Motivation

We recommend adding sUSDe as an eligible collateral asset in both the PTsUSDe5FEB/Stablecoins and PTsUSDe5FEB/USDe E-Modes to reduce potential friction for sUSDe-based principal token loopers when substituting collateral. As PT-sUSDe-5FEB2025 can only be redeemed for sUSDe, enabling sUSDe within these E-Modes will allow users to migrate collateral from the principal token to sUSDe while preserving E-Mode benefits, rather than fully unwinding their positions.

To date, this substitution path has seen limited use: in September, approximately 24.27 million sUSDe of collateral, out of more than 2 billion principal tokens with September maturity, was swapped via transactions that burned PT-sUSDe and minted aEthsUSDe. While not widely adopted historically, we view this as a useful tool for advanced position management and would recommend supporting it as the markets scale. This adjustment is therefore expected to increase the stickiness of PT-sUSDe-based demand for stablecoin borrowing, reduce unnecessary deleveraging and operational overhead around redemption events, and lower potential liquidity stress when positions are adjusted at substantial market sizes.

## Specification

**PT-sUSDe Stablecoins E-mode**

| **Asset**         | **PT-sUSDe-5FEB2026**  | **PT-sUSDe-27NOV2025** | **sUSDe**              | **USDC** | **USDT** | **USDe** | **USDtb** |
| ----------------- | ---------------------- | ---------------------- | ---------------------- | -------- | -------- | -------- | --------- |
| Collateral        | Yes                    | Yes                    | Yes                    | No       | No       | No       | No        |
| Borrowable        | No                     | No                     | No                     | Yes      | Yes      | Yes      | Yes       |
| LTV               | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -        | -        | -        | -         |
| LT                | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -        | -        | -        | -         |
| Liquidation Bonus | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -        | -        | -        | -         |

**PT-sUSDe USDe E-mode**

| **Asset**         | **PT-sUSDe-5FEB2026**  | **PT-sUSDe-27NOV2025** | **sUSDe**              | **USDe** |
| ----------------- | ---------------------- | ---------------------- | ---------------------- | -------- |
| Collateral        | Yes                    | Yes                    | Yes                    | No       |
| Borrowable        | No                     | No                     | No                     | Yes      |
| LTV               | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -        |
| LT                | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -        |
| Liquidation Bonus | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -        |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251205_AaveV3Ethereum_UpdateFEBSUSDePTEModes/AaveV3Ethereum_UpdateFEBSUSDePTEModes_20251205.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251205_AaveV3Ethereum_UpdateFEBSUSDePTEModes/AaveV3Ethereum_UpdateFEBSUSDePTEModes_20251205.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-ethena-february-pts-caps-and-e-modes-adjustments/23501)

## Disclosure

Chaos Labs has not been compensated by any third party for publishing this AGRS recommendation.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
