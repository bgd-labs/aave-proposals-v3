---
title: "Risk Stewards Cooldown Reduction & Umbrella Pauser Role Reassignment"
author: "Llama Risk (implemented by Aave Labs)"
discussions: "https://governance.aave.com/t/arfc-risk-stewards-cooldown-reduction-umbrella-pauser-role-reassignment/25068"
snapshot: "https://snapshot.org/#/aavedao.eth/proposal/0x7083921f2f549ffa2cdc294c8ff60fdc82af0becbb7b2f20f4f296c34694aaf2"
---

## Simple Summary

This ARFC operationalises two changes surfaced after the active incident response management over the past months. First, the Risk Steward `minDelay` is reduced from 72 hours to 36 hours on six cap and IRM parameters where the conservative cap posture meaningfully constrains response speed. Second, the pause role on Aave Umbrella stkTokens is reassigned to the Aave Protocol Guardian, the standing Aave-wide emergency multisig that already holds pause and freeze authority across Aave deployments, with all other Umbrella governance action permissions remaining with the Aave Governance Executor.

The cooldown change addresses a friction surfaced over the past month as LlamaRisk has tightened supply and borrow caps on listed assets closer to their current utilisation. This conservative cap posture is the principal lever Aave has used to bound exposure. It has, however, a structural side effect: when caps sit close to organic demand, the 72-hour Risk Steward cooldown becomes a binding constraint on the next cap raise after the demand suddenly increases, turning the defensive posture into a blocker on healthy growth. Reducing `minDelay` to 36 hours on the six cap and IRM parameters relieves this constraint without weakening any `maxPercentChange` bound.

In parallel, Umbrella pause reassignment addresses the operational friction observed when stkwaWETH had to be paused during the rsETH incident response. The `PAUSE_GUARDIAN_ROLE` on Umbrella (which governs both pause and unpause) currently sits behind the Aave Governance Executor rather than behind Aave's standing emergency body, which meant the action had to be routed through a full AIP cycle. Reassigning `PAUSE_GUARDIAN_ROLE` to the Aave Protocol Guardian, the multisig that already holds emergency pause authority across the rest of the protocol, restores the role assignment originally specified at Umbrella's activation and ensures that future stkToken pauses can be executed at incident response speed. Configuration authority on Umbrella (token creation, parameter changes, role management under `DEFAULT_ADMIN_ROLE`) remains solely with the Aave Governance Executor.

## Motivation

On the Risk Stewards, the more conservative cap posture taken over the past month limits the operational levers available to balance the protocol's needs and safety. When caps are sized closer to current utilisation, legitimate organic growth on a healthy asset more frequently bumps into the 72-hour Risk Steward cooldown. The defensive posture, intended to keep collateral exposure under control, turns into a cap on legitimate organic flow.

On Umbrella, the [\[Direct-to-AIP\] Pause stkwaWETH Umbrella Staked Token on Ethereum V3](https://governance.aave.com/t/direct-to-aip-pause-stkwaweth-umbrella-staked-token-on-ethereum-v3/24595) had to be proposed through a full governance vote because pause authority on Umbrella currently sits behind the Aave Governance Executor, rather than Aave's standing emergency pause body. This is a direct departure from the role assignment specified in the [\[ARFC\] Aave Umbrella - activation](https://governance.aave.com/t/arfc-aave-umbrella-activation/21521) proposal, which explicitly stated that emergency pause and unpause authority would belong to the Aave Protocol Guardian.

### Part 1: Risk Stewards Cooldown Reduction

#### Background

The current Risk Steward [`RiskConfig`](https://etherscan.io/address/0x13a9CC64344b02bACC5AD9Cf38B5711F1B9ec3d4) enforces per-parameter constraints, where:

- `minDelay` is the minimum time between consecutive changes to the same parameter on the same reserve.
- `maxPercentChange` is the largest single-step change accepted, with semantics that vary by parameter: collateral and rate parameters use absolute difference bounds, cap parameters use relative difference of the current cap.

The proposed change reduces `minDelay` from 72 hours to 36 hours on the six cap and IRM parameters where the defensive cap posture meaningfully constrains response speed. The higher-impact collateral and E-Mode parameters (base LTV, LT, LB and their E-Mode equivalents, both price caps) stay at the 72-hour minimum because changes there have a larger downstream effect on existing positions. The Pendle discount rate stays at its existing 48-hour minimum, already tighter than the cap and IRM cadence proposed here. `maxPercentChange` bounds are unchanged across every parameter under this proposal.

The intent is symmetric with the previewed Cap Oracle defensive automation: a faster downward path on caps through the oracle automatization, and a faster upward path on caps and rates through tighter manual cadence, so that the defensive cap posture does not turn into a soft cap on legitimate organic growth.

#### Proposed Configuration Change

| Parameter                    | Current `minDelay` | Current `maxPercentChange` | Proposed `minDelay` |
| :--------------------------- | :----------------- | :------------------------- | :------------------ |
| `ltv`                        | 72h                | 50 bps (0.50% absolute)    | -                   |
| `liquidationThreshold`       | 72h                | 50 bps (0.50% absolute)    | -                   |
| `liquidationBonus`           | 72h                | 50 bps (0.50% absolute)    | -                   |
| `eMode ltv`                  | 72h                | 50 bps (0.50% absolute)    | -                   |
| `eMode liquidationThreshold` | 72h                | 10 bps (0.10% absolute)    | -                   |
| `eMode liquidationBonus`     | 72h                | 50 bps (0.50% absolute)    | -                   |
| `baseVariableBorrowRate`     | 72h                | 100 bps (1.00% absolute)   | 36h                 |
| `variableRateSlope1`         | 72h                | 100 bps (1.00% absolute)   | 36h                 |
| `variableRateSlope2`         | 72h                | 2000 bps (20.00% absolute) | 36h                 |
| `optimalUsageRatio`          | 72h                | 300 bps (3.00% absolute)   | 36h                 |
| `supplyCap`                  | 72h                | 10000 bps (100% relative)  | 36h                 |
| `borrowCap`                  | 72h                | 10000 bps (100% relative)  | 36h                 |
| `priceCapLst`                | 72h                | 500 bps (5.00% relative)   | -                   |
| `priceCapStable`             | 72h                | 50 bps (0.50% relative)    | -                   |
| `discountRatePendle`         | 48h                | 2.50% absolute             | -                   |

### Part 2: Umbrella Pause Guardian Reassignment

#### Background

Umbrella was deployed with pause and configuration changes routed through the `UmbrellaEthereum PERMISSIONED_PAYLOADS_CONTROLLER` (`0xF86F77F7531B3374274E3f725E0A81D60bC4bB67`) and its executor (`0x2759de67aD133C747C9f41d56F1b8A343cE679a1`). In practice this means any pause action on an Umbrella stkToken requires a full AIP cycle, which is what happened during the rsETH response when stkwaWETH had to be paused.

The original role specification in the [\[ARFC\] Aave Umbrella - activation](https://governance.aave.com/t/arfc-aave-umbrella-activation/21521) proposal assigned StakeToken pause to the Aave Protocol Guardian, listing under "Permissioned actions & roles" the explicit line "Emergency pause and unpause: Aave Protocol Guardian." The current Umbrella deployment does not reflect that assignment.

The Aave Protocol Guardian on Ethereum Core is Aave's standing emergency multisig. It is a [community-elected 4-of-7 multisig](https://governance.aave.com/t/aave-emergency-guardian-protocol-signer-rotation/24944), and it already holds emergency authority on Aave's other safety surfaces, including market pause and reserve freeze across Aave deployments and emergency-mode actions on cross-chain messaging. Reassigning Umbrella pause to this multisig consolidates Aave's emergency authority under the body that exists for exactly this purpose, restores the role assignment originally specified at Umbrella's activation, and removes the AIP-cycle bottleneck observed during the rsETH response.

#### Proposed Reassignment

The role separation in this proposal runs along the emergency vs. configuration axis rather than along pause vs. unpause. The Umbrella contract uses OpenZeppelin AccessControl, and `pauseStk` and `unpauseStk` on `UmbrellaStkManager` are both protected by a single `PAUSE_GUARDIAN_ROLE` that cannot be split between two holders. Pause and unpause therefore move together, and the question is which body should hold that combined emergency role.

`PAUSE_GUARDIAN_ROLE` is assigned to the Aave Protocol Guardian, the standing 4-of-7 Aave-wide emergency multisig described above. This adheres the assignment specified in the activation ARFC, removes the AIP-cycle bottleneck on pause action, and aligns Umbrella with the body that already holds emergency authority on Aave's other safety surfaces. Because pause and unpause are bound to the same role, the Protocol Guardian also holds unpause: reversing an precautious pause does not require a governance vote, which is consistent with how emergency pause and unpause work on other Aave surfaces today.

`DEFAULT_ADMIN_ROLE` and the remaining configuration roles on Umbrella stay with the Aave Governance Executor. This covers token creation, parameter changes, asset onboarding to Umbrella, modification of coverage scope, role grants and revocations, and any other deliberate configuration action. These remain on the AIP cadence, where they belong.

#### Stake Tokens in Scope

`PAUSE_GUARDIAN_ROLE` is held on the Umbrella controller and is used to pause and unpause individual stkTokens via the `pauseStk(address)` and `unpauseStk(address)` entry points. Granting the role at the controller is sufficient to cover all current and future stkTokens managed by the controller. The currently deployed Ethereum stkTokens are:

| Stake token | Address                                      |
| :---------- | :------------------------------------------- |
| stkwaUSDC   | `0x6bf183243FdD1e306ad2C4450BC7dcf6f0bf8Aa6` |
| stkwaUSDT   | `0xA484Ab92fe32B143AEE7019fC1502b1dAA522D31` |
| stkwaWETH   | `0xaAFD07D53A7365D3e9fb6F3a3B09EC19676B73Ce` |
| stkGHO      | `0x4f827A63755855cDf3e8f3bcD20265C833f15033` |

## Specification

- Grant `PAUSE_GUARDIAN_ROLE` on the Umbrella controller (`0xD400fc38ED4732893174325693a63C30ee3881a8`) to the Aave Protocol Guardian (`0x2CFe3ec4d5a6811f4B8067F0DE7e47DfA938Aa30`) on Ethereum Mainnet. This authorises the Protocol Guardian to call `pauseStk(stkToken)` and `unpauseStk(stkToken)` on every stkToken currently managed by the controller and any future stkToken added under it.
- On the Risk Steward [`RiskConfig`](https://etherscan.io/address/0x13a9CC64344b02bACC5AD9Cf38B5711F1B9ec3d4), set `minDelay` to 36 hours on `baseVariableBorrowRate`, `variableRateSlope1`, `variableRateSlope2`, `optimalUsageRatio`, `supplyCap`, and `borrowCap` (reduced from 72 hours).

### Amendment

For the purpose of clarity at the AIP implementation phase, the following list of market deployments are to be affected by this change:

- Ethereum (Core, Lido, and EtherFi deployments)
- Polygon
- Avalanche
- Arbitrum
- Optimism
- Base
- Gnosis
- BNB Chain
- Scroll
- Linea
- Sonic
- Celo
- Mantle
- Plasma
- MegaETH
- Monad
- X Layer

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Ethereum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol), [AaveV3EthereumLido](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3EthereumLido_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol), [AaveV3EthereumEtherFi](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3EthereumEtherFi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol), [AaveV3Polygon](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Polygon_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol), [AaveV3Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Avalanche_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol), [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Arbitrum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol), [AaveV3Optimism](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Optimism_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Base_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol), [AaveV3Gnosis](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Gnosis_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol), [AaveV3BNB](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3BNB_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol), [AaveV3Scroll](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Scroll_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol), [AaveV3Linea](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Linea_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol), [AaveV3Sonic](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Sonic_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol), [AaveV3Celo](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Celo_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol), [AaveV3Mantle](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Mantle_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Plasma_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol), [AaveV3MegaEth](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3MegaEth_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol), [AaveV3Monad](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Monad_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol), [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3XLayer_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Ethereum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol), [AaveV3EthereumLido](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3EthereumLido_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol), [AaveV3EthereumEtherFi](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3EthereumEtherFi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol), [AaveV3Polygon](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Polygon_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol), [AaveV3Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Avalanche_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol), [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Arbitrum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol), [AaveV3Optimism](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Optimism_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Base_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol), [AaveV3Gnosis](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Gnosis_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol), [AaveV3BNB](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3BNB_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol), [AaveV3Scroll](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Scroll_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol), [AaveV3Linea](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Linea_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol), [AaveV3Sonic](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Sonic_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol), [AaveV3Celo](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Celo_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol), [AaveV3Mantle](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Mantle_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Plasma_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol), [AaveV3MegaEth](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3MegaEth_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol), [AaveV3Monad](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Monad_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol), [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/81474886a4e3db16ae09b51bd231ab6a9b2fb07d/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3XLayer_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol)
- [Snapshot](https://snapshot.org/#/aavedao.eth/proposal/0x7083921f2f549ffa2cdc294c8ff60fdc82af0becbb7b2f20f4f296c34694aaf2)
- [Discussion](https://governance.aave.com/t/arfc-risk-stewards-cooldown-reduction-umbrella-pauser-role-reassignment/25068)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
