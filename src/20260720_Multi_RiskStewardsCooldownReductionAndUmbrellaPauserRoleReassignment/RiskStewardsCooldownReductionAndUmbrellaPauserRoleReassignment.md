---
title: "Risk Stewards Cooldown Reduction & Umbrella Pauser Role Reassignment"
author: "Llama Risk (implemented by Aave Labs)"
discussions: "https://governance.aave.com/t/arfc-risk-stewards-cooldown-reduction-umbrella-pauser-role-reassignment/25068"
snapshot: "https://snapshot.org/#/aavedao.eth/proposal/0x7083921f2f549ffa2cdc294c8ff60fdc82af0becbb7b2f20f4f296c34694aaf2"
---

## Simple Summary

This proposal implements two operational changes identified during recent incident-response activity:

1. Reduce the Risk Steward `minDelay` from 72 hours to 36 hours for six supply-cap, borrow-cap, and interest-rate parameters across 19 current-layout Aave V3 deployments on 17 networks.
2. Grant the Aave Protocol Guardian the role required to pause and unpause every current and future stake token managed by the Ethereum Umbrella controller.

## Motivation

### Risk Steward Response Cadence

Over the preceding month, LlamaRisk adopted a more conservative supply-cap and borrow-cap posture, placing caps closer to actual utilisation to limit protocol exposure. While this posture is an important defensive tool, it can also make the existing 72-hour Risk Steward cooldown operationally restrictive. If legitimate demand increases shortly after a cap adjustment, the steward cannot make another update until the full cooldown has elapsed.

Reducing the cooldown to 36 hours for cap and interest-rate-model parameters improves the ability to respond to healthy demand without expanding the permitted size of any individual update. Every existing `maxPercentChange` restriction remains unchanged.

The higher-impact collateral, E-Mode, and price-cap parameters remain subject to their existing 72-hour delay. The Pendle discount-rate parameter remains at 48 hours. This preserves the more conservative cadence for changes that can have a direct downstream effect on existing positions.

The faster manual cadence complements defensive cap automation: automated mechanisms can reduce exposure quickly, while Risk Stewards retain a sufficiently responsive path for subsequent cap or rate increases when market conditions justify them.

### Umbrella Incident Response

During the rsETH incident response, pausing `stkwaWETH` required a complete governance proposal because the Umbrella pause authority was held by the Governance Executor rather than the standing Aave Protocol Guardian. This introduced an avoidable delay for an emergency action.

The original Umbrella activation framework assigned emergency stake-token pause and unpause authority to the Protocol Guardian. Granting the deployed Umbrella controller's `PAUSE_GUARDIAN_ROLE` to that multisig restores the intended emergency operating model and aligns Umbrella with the authority that already performs emergency actions elsewhere in Aave.

Umbrella uses one role for both `pauseStk` and `unpauseStk`; those permissions cannot be separated between different holders. The Protocol Guardian therefore receives both capabilities. Deliberate configuration authority—including stake-token creation, parameter changes, coverage configuration, and role administration—continues to reside with Aave Governance.

## Specification

### Risk Steward Configuration

The proposal changes only the following six `minDelay` values:

| Parameter                | Current `minDelay` | Current `maxPercentChange`    | New `minDelay` |
| ------------------------ | ------------------ | ----------------------------- | -------------- |
| `baseVariableBorrowRate` | 72 hours           | 100 bps (1.00% absolute)      | 36 hours       |
| `variableRateSlope1`     | 72 hours           | 100 bps (1.00% absolute)      | 36 hours       |
| `variableRateSlope2`     | 72 hours           | 2,000 bps (20.00% absolute)   | 36 hours       |
| `optimalUsageRatio`      | 72 hours           | 300 bps (3.00% absolute)      | 36 hours       |
| `supplyCap`              | 72 hours           | 10,000 bps (100.00% relative) | 36 hours       |
| `borrowCap`              | 72 hours           | 10,000 bps (100.00% relative) | 36 hours       |

The following parameters are intentionally unchanged:

| Parameter                     | Existing `minDelay` | Existing `maxPercentChange` |
| ----------------------------- | ------------------- | --------------------------- |
| `ltv`                         | 72 hours            | 50 bps (0.50% absolute)     |
| `liquidationThreshold`        | 72 hours            | 50 bps (0.50% absolute)     |
| `liquidationBonus`            | 72 hours            | 50 bps (0.50% absolute)     |
| E-Mode `ltv`                  | 72 hours            | 50 bps (0.50% absolute)     |
| E-Mode `liquidationThreshold` | 72 hours            | 10 bps (0.10% absolute)     |
| E-Mode `liquidationBonus`     | 72 hours            | 50 bps (0.50% absolute)     |
| `priceCapLst`                 | 72 hours            | 500 bps (5.00% relative)    |
| `priceCapStable`              | 72 hours            | 50 bps (0.50% relative)     |
| `discountRatePendle`          | 48 hours            | 2.50% absolute              |

No `maxPercentChange` value is modified.

The update applies to the following 19 Aave V3 deployments across 17 networks:

| Network   | Aave V3 deployment(s) |
| --------- | --------------------- |
| Ethereum  | Core, Lido, EtherFi   |
| Polygon   | Core                  |
| Avalanche | Core                  |
| Arbitrum  | Core                  |
| Optimism  | Core                  |
| Base      | Core                  |
| Gnosis    | Core                  |
| BNB Chain | Core                  |
| Scroll    | Core                  |
| Linea     | Core                  |
| Sonic     | Core                  |
| Celo      | Core                  |
| Mantle    | Core                  |
| Plasma    | Core                  |
| MegaETH   | Core                  |
| Monad     | Core                  |
| X Layer   | Core                  |

The following deployments are intentionally excluded:

| Network | Reason                                                                |
| ------- | --------------------------------------------------------------------- |
| Ink     | The corresponding delays are already 24 hours, below the proposed 36. |
| Metis   | Uses the legacy Risk Steward configuration layout.                    |
| Soneium | Uses the legacy Risk Steward configuration layout.                    |
| zkSync  | Uses the legacy Risk Steward configuration layout.                    |

### Umbrella Pause Guardian

The proposal grants `PAUSE_GUARDIAN_ROLE` on the Ethereum Umbrella controller (`0xD400fc38ED4732893174325693a63C30ee3881a8`) to the Aave Protocol Guardian (`0x2CFe3ec4d5a6811f4B8067F0DE7e47DfA938Aa30`). The role identifier is `keccak256("PAUSE_GUARDIAN_ROLE")`.

This controller-level grant authorises the Protocol Guardian to call `pauseStk(stkToken)` and `unpauseStk(stkToken)` for every stake token currently managed by the controller and every stake token added to it in the future.

The stake tokens currently managed by the controller are:

| Stake token | Address                                      |
| ----------- | -------------------------------------------- |
| stkwaUSDC   | `0x6bf183243FdD1e306ad2C4450BC7dcf6f0bf8Aa6` |
| stkwaUSDT   | `0xA484Ab92fe32B143AEE7019fC1502b1dAA522D31` |
| stkwaWETH   | `0xaAFD07D53A7365D3e9fb6F3a3B09EC19676B73Ce` |
| stkGHO      | `0x4f827A63755855cDf3e8f3bcD20265C833f15033` |

The proposal does not revoke the Governance Executor's existing pause role. The Governance Executor also retains `DEFAULT_ADMIN_ROLE` and the remaining configuration roles.

## References

- [Implementation and tests](https://github.com/aave-dao/aave-proposals-v3/tree/main/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment)
- [Snapshot](https://snapshot.org/#/aavedao.eth/proposal/0x7083921f2f549ffa2cdc294c8ff60fdc82af0becbb7b2f20f4f296c34694aaf2)
- [Discussion](https://governance.aave.com/t/arfc-risk-stewards-cooldown-reduction-umbrella-pauser-role-reassignment/25068)

## Disclaimer

This proposal was independently prepared by Llama Risk, a DeFi risk service provider funded in part by the Aave DAO, and implemented by Aave Labs. Llama Risk is not directly affiliated with the protocols assessed and received no separate compensation for this work.

Nothing in this proposal should be interpreted as legal, financial, tax, or other professional advice.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
