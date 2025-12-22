---
title: "Ethena February E-Modes Adjustments"
author: "Chaos Labs (implemented by ACI via Skyward)"
discussions: "https://governance.aave.com/t/direct-to-aip-ethena-february-pts-caps-and-e-modes-adjustments/23501"
---

## Simple Summary

We recommend adding sUSDe as an eligible collateral asset in both the PTsUSDe5FEB/Stablecoins and PTsUSDe5FEB/USDe E-Modes and USDe as an eligible collateral asset in both the PTUSDe5FEB/Stablecoins and PTUSDe5FEB/USDe E-Modes.

## Motivation

### sUSDe

We recommend adding sUSDe as an eligible collateral asset in both the PTsUSDe5FEB/Stablecoins and PTsUSDe5FEB/USDe E-Modes to reduce potential friction for sUSDe-based principal token loopers when substituting collateral. As PT-sUSDe-5FEB2025 can only be redeemed for sUSDe, enabling sUSDe within these E-Modes will allow users to migrate collateral from the principal token to sUSDe while preserving E-Mode benefits, rather than fully unwinding their positions.

To date, this substitution path has seen limited use: in September, approximately 24.27 million sUSDe of collateral, out of more than 2 billion principal tokens with September maturity, was swapped via transactions that burned PT-sUSDe and minted aEthsUSDe. While not widely adopted historically, we view this as a useful tool for advanced position management and would recommend supporting it as the markets scale. This adjustment is therefore expected to increase the stickiness of PT-sUSDe-based demand for stablecoin borrowing, reduce unnecessary deleveraging and operational overhead around redemption events, and lower potential liquidity stress when positions are adjusted at substantial market sizes.

### USDe

The motivation behind the addition of sUSDe in the PT-sUSDe E-Modes strains from the fact that users would otherwise need to fully unwind highly leveraged positions in order to shift from the November sUSDe PTs to the February maturity tokens. Since Pendle allows one-to-one redemption of the PTs at maturity, users receive sUSDe without incurring in any swapping cost, which, while yield-bearing, can be utilized as collateral, and can act as a substitution for the PT-sUSDe when users are exiting the previous maturity PTs while awaiting the next maturity PTs (either to be listed or to have sufficient capacity). This way, the presence of sUSDe in the E-Modes serves a high-utility purpose for a subset of users.

The inclusion of USDe in the E-Modes does not provide such utility as it is not yield-bearing. Hence, if users redeem PT-USDe for USDe and then collateralize the debt with USDe, they would be taking a leveraged annualized loss equal to the borrowing costs of the notional debt. We’d also like to note that the utility of such collateral in the PT-related E-Modes does not depend on the type of PT (sUSDe or USDe), as no incremental utility is provided by USDe in either case. In case of unwinding staked USDe positions, the inclusion of USDe under the same parameters effectively presents the same utility. Nevertheless, the inclusion of USDe in the PT-USDe E-Mode can reduce the costs of transition in one specific edge case. Given that a user has a substantial leveraged position and is paying borrowing costs on the notional, if the next PT is expected to be listed within a reasonably short period of time, it might be beneficial to incur the funding costs of the net position instead of converting the USDe collateral to the debt assets.

While the inclusion of USDe in the proposed E-Modes presents limited utility, such an adjustment does not introduce additional risk; therefore, we support the proposed adjustment.

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

**PT-USDe Stablecoins E-mode**

| **Asset**         | **PT-USDe-5FEB2026**   | **PT-USDe-27NOV2025**  | **USDe**               | **USDC** | **USDT** | **USDtb** |
| ----------------- | ---------------------- | ---------------------- | ---------------------- | -------- | -------- | --------- |
| Collateral        | Yes                    | Yes                    | Yes                    | No       | No       | No        |
| Borrowable        | No                     | No                     | Yes                    | Yes      | Yes      | Yes       |
| LTV               | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -        | -        | -         |
| LT                | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -        | -        | -         |
| Liquidation Bonus | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -        | -        | -         |

**PT-USDe USDe E-mode**

| **Asset**         | **PT-USDe-5FEB2026**   | **PT-USDe-27NOV2025**  | **USDe**               |
| ----------------- | ---------------------- | ---------------------- | ---------------------- |
| Collateral        | Yes                    | Yes                    | Yes                    |
| Borrowable        | No                     | No                     | Yes                    |
| LTV               | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle |
| LT                | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle |
| Liquidation Bonus | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251205_AaveV3Ethereum_UpdateFEBSUSDePTEModes/AaveV3Ethereum_UpdateFEBSUSDePTEModes_20251205.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251205_AaveV3Ethereum_UpdateFEBSUSDePTEModes/AaveV3Ethereum_UpdateFEBSUSDePTEModes_20251205.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-ethena-february-pts-caps-and-e-modes-adjustments/23501)

## Disclosure

Chaos Labs has not been compensated by any third party for publishing this AGRS recommendation.

Caps updates mentioned on the forum discussion post have been implemented via risk steward so it will not be part of this AIP.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
