---
title: "Risk Steward Phase 2"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-bgd-risk-steward-phase-2-risksteward/16204"
---

## Simple Summary

Expanding from the scope of [CapsPlusRiskSteward](https://governance.aave.com/t/bgd-risk-steward-phase-1-capsplusrisksteward/12602), we now introduce the new generalized RiskSteward, allowing hardly constrained risk parameter updates by risk service providers and reducing governance overhead.

## Motivation

Aave's decentralized governance system, while robust, creates significant operational overhead and cost due to its comprehensive proposal process. This process includes pre-AIP procedures, payload creation, multiple reviews, voting, and on-chain verification.
While recent improvements have optimized some steps, further efficiency gains are possible, particularly in risk-related proposals.

Rationale for reducing risk-related proposals:

- Two expert, independent risk teams (ChaosLabs, LlamaRisk) are engaged with the DAO.
- Historical voting unanimity on non-controversial, incremental risk proposals.
- Technical feasibility of constraining updates using Aave v3 roles and specific validations.

The success of the CapsPlusRiskStewards experiment demonstrates the viability of expanding this approach. As Aave expands to new networks, minimizing governance proposals becomes crucial to prevent voter fatigue.

## Specification

The new RiskSteward we propose follows the same design as the CapsPlusRiskSteward, an smart contract to which the Aave Governance gives `RISK_ADMIN` role over all v3 instances, controlled by a 2-of-2 multisig of the risk providers, and heavily constrained on what can do and how by its own logic.

`ACL_MANAGER.addRiskAdmin()` is called to add a the new risk steward.

To give some extra buffer and protection, we would remove the `RISK_ADMIN` role from the old `CapsPlusRiskSteward` once risk providers have adapted to use the new Risk Stewards.

The new risk stewards have been configured with the following risk params on all Aave instances:

| Parameter                 | Percent change allowed | minimumDelay |
| ------------------------- | ---------------------- | ------------ |
| Supply and Borrow Caps    | 100% (relative change) | 3 days       |
| Debt Ceiling              | 100% (relative change) | 3 days       |
| LST Cap adapter params    | 15% (relative change)  | 3 days       |
| Stable price cap          | 2% (relative change)   | 3 days       |
| Base Variable Borrow Rate | 2% (absolute change)   | 3 days       |
| Slope 1                   | 2% (absolute change)   | 3 days       |
| Slope 2                   | 20% (absolute change)  | 3 days       |
| Optimal Point (Kink)      | 10% (absolute change)  | 3 days       |
| Loan to Value (LTV)       | 3% (absolute change)   | 3 days       |
| Liquidation Threshold     | 3% (absolute change)   | 3 days       |
| Liquidation Bonus         | 2% (absolute change)   | 3 days       |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3Ethereum_RiskStewardPhase2_20240805.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3EthereumLido_RiskStewardPhase2_20240805.sol), [AaveV3EthereumEtherFi](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3EthereumEtherFi_RiskStewardPhase2_20240805.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3Polygon_RiskStewardPhase2_20240805.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3Avalanche_RiskStewardPhase2_20240805.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3Optimism_RiskStewardPhase2_20240805.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3Arbitrum_RiskStewardPhase2_20240805.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3Metis_RiskStewardPhase2_20240805.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3Base_RiskStewardPhase2_20240805.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3Gnosis_RiskStewardPhase2_20240805.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3Scroll_RiskStewardPhase2_20240805.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3BNB_RiskStewardPhase2_20240805.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3Ethereum_RiskStewardPhase2_20240805.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3EthereumLido_RiskStewardPhase2_20240805.t.sol), [AaveV3EthereumEtherFi](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3EthereumEtherFi_RiskStewardPhase2_20240805.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3Polygon_RiskStewardPhase2_20240805.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3Avalanche_RiskStewardPhase2_20240805.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3Optimism_RiskStewardPhase2_20240805.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3Arbitrum_RiskStewardPhase2_20240805.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3Metis_RiskStewardPhase2_20240805.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3Base_RiskStewardPhase2_20240805.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3Gnosis_RiskStewardPhase2_20240805.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3Scroll_RiskStewardPhase2_20240805.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240805_Multi_RiskStewardPhase2/AaveV3BNB_RiskStewardPhase2_20240805.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-bgd-risk-steward-phase-2-risksteward/16204)
- Snapshot: Direct To AIP
- Github Repo: [Aave V3 Risk Stewards](https://github.com/aave-dao/aave-v3-risk-stewards)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
