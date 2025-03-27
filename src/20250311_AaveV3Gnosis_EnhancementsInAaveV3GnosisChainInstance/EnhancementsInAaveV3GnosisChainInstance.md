---
title: "Enhancements in Aave v3 Gnosis Chain Instance"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-enhancements-in-aave-v3-gnosis-chain-instance/21214"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0x27b21aa2cd21d5e94eb9b9e0232fe875ad45719588ada4b059f67a8834d7408e"
---

## Simple Summary

This publication proposes changes in the Gnosis Chain instance to improve the capital efficiency of USDC.e and sDAI assets by promoting changes on its parametrisation.

## Motivation

The Gnosis Chain’s DeFi landscape has evolved considerably since these assets were first introduced. With a vibrant ecosystem now in place, it’s time to enhance capital efficiency, reduce capital fragmentation, and create useful debt vs no risk looping within the Aave GC instance to attract more capital and increase utilisation.

**USDC to USDC.e Transition:**

Gnosis Chain is committed to making USDC.e (the version that aligns with Circle’s standards) the defacto version of this stablecoin within its ecosystem, by accelerating the transition from USDC and making it the major market within Aave’s GC instance (replacing xDAI). To incentivise this migration and accommodate increased capital inflows, we propose the following adjustments for USDC.e:

- Supply and Borrowing Cap Increase: Enacted via the Risk Steward.
- Emode Creation: Establish an Emode pairing between USDC.e and sDAI, similar to the existing sDAI/EURe Emode.

Those changes will incentivise looping strategies with USDC.e similar to those with EURe/xDAI.

To further promote the transition to USDC.e, we propose reducing the LTV factor for USDC. This measure will prevent the initiation of new borrowings using USDC, thus encouraging users to adopt USDC.e.

**sDAI Borrowability**

This proposal also asks to make sDAI a borrowable asset. There is little justification for depositing xDAI into Aave on Gnosis, as sDAI offers the same risk profile. The optimal configuration, then, would be to phase out xDAI in favour of sDAI (this will be presented in a future proposal). sDAI becoming borrowable ensures a more efficient and market-driven borrowing system on the platform.

## Specification

The tables below show the current and proposed parameters for each asset. A subsequent AIP will be submitted to implement these changes upon implementing this proposal.

- USDC.e

| Parameters               | Current | Proposed |
| ------------------------ | ------- | -------- |
| Isolation Mode           | No      | -        |
| Borrowable in Isolation  | Yes     | -        |
| Enable Borrow            | Yes     | -        |
| Enable Collateral        | Yes     | -        |
| Loan To Value (LTV)      | 75%     | -        |
| Liquidation Threshold    | 78%     | -        |
| Liquidation Bonus        | 5%      | -        |
| Reserve Factor           | 10%     | -        |
| Liquidation Protocol Fee | 10%     | -        |
| Supply Cap               | 10M     | -        |
| Borrow Cap               | 9M      | -        |
| Debt Ceiling             | N/A     | -        |
| Optimal                  | 90%     | -        |
| Base                     | 0%      | -        |
| Slope1                   | 9.5%    | -        |
| Slope2                   | 40%     | -        |
| Emode                    | No      | Yes      |

- Create sDAI/USDC.e E-mode

| Parameters            | Value | Value  |
| --------------------- | ----- | ------ |
| Asset                 | sDAI  | USDC.e |
| Collateral            | Yes   | No     |
| Borrowable            | No    | Yes    |
| Max LTV               | 90%   | -      |
| Liquidation Threshold | 92%   | -      |
| Liquidation Bonus     | 4%    | -      |

- USDC

| Parameters     | Current | Proposed |
| -------------- | ------- | -------- |
| Supply Cap     | 11m     | 2.5m     |
| Borrow Cap     | 11m     | 2m       |
| Reserve Factor | 25%     | 40%      |
| LTV            | 75%     | 65%      |

- sDAI

| Parameters               | Current | Proposed |
| ------------------------ | ------- | -------- |
| Isolation Mode           | No      | -        |
| Borrowable in Isolation  | No      | -        |
| Enable Borrow            | No      | -        |
| Enable Collateral        | Yes     | -        |
| Loan To Value (LTV)      | 75%     | -        |
| Liquidation Threshold    | 78%     | -        |
| Liquidation Bonus        | 5%      | -        |
| Reserve Factor           | 10%     | -        |
| Liquidation Protocol Fee | 20%     | -        |
| Supply Cap               | 48M     | -        |
| Borrow Cap               | 0       | -        |
| Debt Ceiling             | N/A     | -        |
| Optimal                  | 90%     | -        |
| Base                     | 0%      | -        |
| Slope1                   | 4%      | -        |
| Slope2                   | 75%     | -        |
| Emode                    | No      | Yes      |

## References

- Implementation: [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/1df64075d9de756315cb85fc35b7b9f0d03c83ee/src/20250311_AaveV3Gnosis_EnhancementsInAaveV3GnosisChainInstance/AaveV3Gnosis_EnhancementsInAaveV3GnosisChainInstance_20250311.sol)
- Tests: [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/1df64075d9de756315cb85fc35b7b9f0d03c83ee/src/20250311_AaveV3Gnosis_EnhancementsInAaveV3GnosisChainInstance/AaveV3Gnosis_EnhancementsInAaveV3GnosisChainInstance_20250311.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x27b21aa2cd21d5e94eb9b9e0232fe875ad45719588ada4b059f67a8834d7408e)
- [Discussion](https://governance.aave.com/t/arfc-enhancements-in-aave-v3-gnosis-chain-instance/21214)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
