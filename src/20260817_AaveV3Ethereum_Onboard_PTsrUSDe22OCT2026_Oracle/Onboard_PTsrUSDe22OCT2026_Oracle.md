---
title: "Onboard PT-srUSDe-22OCT2026 to the LlamaRisk PT Risk Oracle"
author: "LlamaRisk"
discussions: "https://gov.discussion.placeholder"
---

## Simple Summary

Deploys and registers two risk agents on the Aave-owned AgentHub so that discount rate and eMode risk parameters for PT-srUSDe-22OCT2026 on Aave V3 Ethereum Core can be maintained automatically from the LlamaRisk PT Risk Oracle, within bounds this proposal sets.

## Motivation

PT-srUSDe-22OCT2026 is a Pendle principal token listed on Ethereum Core as reserve 66 and collateral in eMode categories 47 and 48. Its fair value depends on an implied discount rate that decays to zero at maturity, so a static discount rate is wrong almost everywhere: too high early, and increasingly too low as maturity approaches. The same drift affects the liquidation threshold and bonus that should apply to it.

LlamaRisk operates an offchain pipeline on Chainlink CRE that tracks the Pendle market, maintains an EMA of the implied rate, and derives both the discount rate and the eMode parameters from it. This proposal is the last link in that chain: it grants the two agent contracts permission to apply those values, and bounds how far each application may move a parameter.

The pipeline publishes to a RiskOracle that only LlamaRisk's router can write to, and the router only accepts reports from the Chainlink CRE forwarder for a workflow owned by the Aave CRE organisation multisig. Governance retains the ability to disable either agent at any time.

## Specification

The payload performs three groups of actions.

**1. Deploy and register the discount rate agent.** The payload deploys `AaveDiscountRateAgent` from `aave-dao/aave-risk-agents`, then calls `registerAgent` on `MiscEthereum.AGENT_HUB`, consuming `PendleDiscountRateUpdate` records from the LlamaRisk RiskOracle, allowed to act only on PT-srUSDe-22OCT2026. Minimum delay 2 days, expiration period 2 days.

**2. Deploy and register the eMode agent.** `AaveEModeAgent` from the same repository, registered for the same oracle, consuming `EModeCategoryUpdate`, allowed to act only on eMode categories 47 and 48. Minimum delay 3 days, expiration period 3 days. Its agent context encodes `AaveV3Ethereum.CONFIG_ENGINE`, which it delegatecalls to apply category updates.

Both are registered with `admin` set to `GovernanceV3Ethereum.EXECUTOR_LVL_1`, which already owns the AgentHub, and with `isAgentPermissioned` and `isMarketsFromAgentEnabled` at their defaults.

Both agents are constructed by `execute` rather than deployed ahead of the vote. Every address they are bound to is immutable and comes from the address book, so deploying them inside the payload means the code that governance reviews is the code that ends up registered, with no separate address to check and no window in which a registered agent could point at something the proposal did not build. Neither agent is registered with a suffixed update type: the LlamaRisk RiskOracle serves this stack alone, so the base types are unambiguous.

**3. Grant `RISK_ADMIN` and bound the ranges.** `addRiskAdmin` on `AaveV3Ethereum.ACL_MANAGER` for both freshly deployed agents, then `setDefaultRangeConfig` on `MiscEthereum.RANGE_VALIDATION_MODULE` for each parameter each agent can move.

The role is required because of how the agents write. The discount rate agent resolves the PT price source through the Aave oracle and calls `setDiscountRatePerYear` on the `PendlePriceCapAdapter`, which gates that call on `isRiskAdmin || isPoolAdmin`. The eMode agent delegatecalls the config engine, and because delegatecall preserves the caller, the PoolConfigurator sees the agent rather than the engine, so the role has to sit on the agent there as well.

### Bounds

Every bound is absolute rather than relative. A relative cap is measured against the last value the agent injected, which does not exist on a freshly assigned agent id, so a relative configuration would leave the first injection unbounded.

| Agent         | Parameter                   | Maximum move per injection |
| ------------- | --------------------------- | -------------------------- |
| Discount rate | `PendleDiscountRateUpdate`  | 100 bps (`1e16`)           |
| eMode         | `EModeLTV`                  | 50 bps                     |
| eMode         | `EModeLiquidationThreshold` | 50 bps                     |
| eMode         | `EModeLiquidationBonus`     | 50 bps                     |

These configurations are not optional. A fresh agent id inherits no default range config, and the module reads a missing config as a zero bound, which rejects every injection. Omitting them would produce a registered but permanently inert agent.

Two further limits apply outside this payload. The minimum delays above are enforced by the hub per agent and market. And the LlamaRisk router applies its own 48 hour minimum delay and 100 bps step cap to the discount rate route, so that value is bounded twice, independently.

### Affected eMode categories

| Id  | Label                 |
| --- | --------------------- |
| 47  | PT-srUSDe Stablecoins |
| 48  | PT-srUSDe USDe        |

No reserve configuration is changed by this payload. The snapshot diff is empty by design.

## Deployed Contracts

- `LLAMARISK_RISK_ORACLE`: [0x8346170dcE5455A1205f55A0b5448E67e42CD270](https://etherscan.io/address/0x8346170dcE5455A1205f55A0b5448E67e42CD270)
- `LLAMAGUARD_ROUTER`: [0xE2c9B46353D1ED959caA91369b853D84b616A0Fd](https://etherscan.io/address/0xE2c9B46353D1ED959caA91369b853D84b616A0Fd)
- `CHAINLINK_CRE_FORWARDER`: [0x0b93082D9b3C7C97fAcd250082899BAcf3af3885](https://etherscan.io/address/0x0b93082D9b3C7C97fAcd250082899BAcf3af3885)

The payload only references the RiskOracle directly. The Router and CRE Forwarder are included above to make the complete write path easier to review.

Both agents are deployed by `execute`, so they have no address until the payload runs. After execution they are readable from the hub as `getAgentAddress(agentId)` for the two ids the payload consumed.

Existing Aave contracts referenced, all from the address book:

- AgentHub: `MiscEthereum.AGENT_HUB`
- RangeValidationModule: `MiscEthereum.RANGE_VALIDATION_MODULE`
- ACL manager: `AaveV3Ethereum.ACL_MANAGER`
- Config engine: `AaveV3Ethereum.CONFIG_ENGINE`
- Agent admin: `GovernanceV3Ethereum.EXECUTOR_LVL_1`

### Agent source

Both agents are the stock BGD implementations from [aave-dao/aave-risk-agents](https://github.com/aave-dao/aave-risk-agents), added to this repository as a submodule and compiled into the payload. Nothing is forked or modified.

The submodule is pinned to the merged [aave-risk-agents#6](https://github.com/aave-dao/aave-risk-agents/pull/6) commit on `main`. That change restores the `isolated` field that `AaveEModeAgent` must pass to the current config engine and uses `EngineFlags.KEEP_CURRENT` to preserve the governance-configured isolation setting. Without it, the agent builds a five-field `EModeCategoryUpdate` that no longer matches any function on the deployed engine, and every eMode injection reverts.

## References

- Implementation: [AaveV3Ethereum_Onboard_PTsrUSDe22OCT2026_Oracle_20260817.sol](./AaveV3Ethereum_Onboard_PTsrUSDe22OCT2026_Oracle_20260817.sol)
- Agent implementations: [aave-dao/aave-risk-agents](https://github.com/aave-dao/aave-risk-agents)
- Tests: [AaveV3Ethereum_Onboard_PTsrUSDe22OCT2026_Oracle_20260817.t.sol](./AaveV3Ethereum_Onboard_PTsrUSDe22OCT2026_Oracle_20260817.t.sol)
- [Discussion](https://gov.discussion.placeholder)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
