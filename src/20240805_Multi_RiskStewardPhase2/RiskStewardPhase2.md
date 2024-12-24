---
title: "Aave Generalized Risk Stewards (AGRS) activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-aave-generalized-risk-stewards-agrs-activation/19178"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x4809f179e517e5745ec13eba8f40d98dab73ca65f8a141bd2f18cc16dcd0cc16"
---

## Simple Summary

Expanding from the scope of [CapsPlusRiskSteward](https://governance.aave.com/t/bgd-risk-steward-phase-1-capsplusrisksteward/12602), we now introduce the new Aave Generalized Risk Stewards (AGRS), allowing hardly constrained risk parameter updates by risk service providers and reducing governance overhead.

Aave Generalized Risk Stewards (AGRS) include two instances: Manual AGRS and Automated AGRS. Manual AGRS is a continuation of the previous design, with the parameters recommendation risk provider, with constrained capacity to modify all types of risk parameters on Aave. Automated AGRS is a pilot version to automate interest rate updates of assets (starting with WETH on Aave v3 Lido Ethereum), based on the newly released risk infrastructure technology Edge, by Chaos Labs.

This AIP activates the Manual AGRS and the Automated AGRS will be activated at a later stage.

## Motivation

Aave's decentralized governance system, while robust, creates significant operational overhead and cost due to its comprehensive proposal process. This process includes pre-AIP procedures, payload creation, multiple reviews, voting, and on-chain verification.
While recent improvements have optimized some steps, further efficiency gains are possible, particularly in risk-related proposals.

The rationale for reducing risk-related proposals:

- Two experts, and independent risk teams (ChaosLabs, LlamaRisk) are engaged with the DAO.
- Historical voting unanimity on non-controversial, incremental risk proposals.
- Technical feasibility of constraining updates using Aave v3 roles and specific validations.

The success of the CapsPlusRiskStewards experiment demonstrates the viability of expanding this approach. As Aave expands to new networks, minimizing governance proposals becomes crucial to prevent voter fatigue.

## Specification

The new Manual AGRS we propose follows the same design as the CapsPlusRiskSteward, a smart contract to which the Aave Governance gives `RISK_ADMIN` role over all v3 instances, controlled by a 2-of-2 multisig, and heavily constrained on what can do and how by its own logic.

The 2-of-2 multisig controlling the Manual AGRS will have Chaos and BGD Labs as signers, temporarily including BGD Labs as a matter of extra security procedure.

`ACL_MANAGER.addRiskAdmin()` is called to add the new Manual AGRS.

Additionally, params for GHO on Arbitrum and Ethereum cannot be changed by this Manual AGRS, as the params will be updated by the GhoStewards instead, this is done by setting the GHO asset as restricted via the following method: `RISK_STEWARD.setAddressRestricted();`

To give some extra buffer and protection, we will remove the `RISK_ADMIN` role from the old `CapsPlusRiskSteward` once risk providers have adapted to use the new Risk Stewards.

Deployed AGRS Contracts:

| Network Instance | Manual AGRS Contract                                                                                                             |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Ethereum         | [0x7C7143f4bE189928A6a98D8686c5e84c893c59c7](https://etherscan.io/address/0x7C7143f4bE189928A6a98D8686c5e84c893c59c7)            |
| Ethereum Lido    | [0x30adC2f98ff78fDde12F191Acb82699f640694FB](https://etherscan.io/address/0x30adC2f98ff78fDde12F191Acb82699f640694FB)            |
| Ethereum EtherFi | [0xBF79d8339303148E345277a994Eb2cD5d82F0067](https://etherscan.io/address/0xBF79d8339303148E345277a994Eb2cD5d82F0067)            |
| Arbitrum         | [0x14568979093FFF97aeBD73F58051a4f0e297b1eB](https://arbiscan.io/address/0x14568979093FFF97aeBD73F58051a4f0e297b1eB)             |
| Optimism         | [0x928807b90a74210268b590d0159fcf1340ad76bd](https://optimistic.etherscan.io/address/0x928807b90a74210268b590d0159fcf1340ad76bd) |
| Polygon          | [0x88dECc4bf07f5219ea7D1E32fe3762DA28ff7609](https://polygonscan.com/address/0x88dECc4bf07f5219ea7D1E32fe3762DA28ff7609)         |
| Avalanche        | [0xbf03aB677DEdA36E19D294d1735b93Dd9d1E0c05](https://snowscan.xyz/address/0xbf03aB677DEdA36E19D294d1735b93Dd9d1E0c05)            |
| Scroll           | [0x64093fe5f8Cf62aFb4377cf7EF4373537fe9155B](https://scrollscan.com/address/0x64093fe5f8Cf62aFb4377cf7EF4373537fe9155B)          |
| Metis            | [0x58226D26658F19724cB881E9F747EeDC846BB1c9](https://explorer.metis.io/address/0x58226D26658F19724cB881E9F747EeDC846BB1c9)       |
| Base             | [0xD3DE4b3571744EB77946d65aBF01408902E92c4E](https://basescan.org/address/0xD3DE4b3571744EB77946d65aBF01408902E92c4E)            |
| BNB              | [0xbe7998712402b6a63975515a532ce503437998b7](https://bscscan.com/address/0xbe7998712402b6a63975515a532ce503437998b7)             |
| Gnosis           | [0x677c9f358dA5DC83aF6760a839E4448D72840d04](https://gnosisscan.io/address/0x677c9f358dA5DC83aF6760a839E4448D72840d04)           |
| ZkSync           | [0x05c77Cf62346329a157d7A6F874464D049CECb26](https://era.zksync.network/address/0x05c77Cf62346329a157d7A6F874464D049CECb26)      |

The new risk stewards have been configured with the following risk params on all Aave instances:

| Parameter                 | Percent change allowed  | minimumDelay |
| ------------------------- | ----------------------- | ------------ |
| Supply and Borrow Caps    | 100% (relative change)  | 3 days       |
| Debt Ceiling              | 20% (relative change)   | 3 days       |
| LST Cap adapter params    | 5% (relative change)    | 3 days       |
| Stable price cap          | 0.5% (relative change)  | 3 days       |
| Base Variable Borrow Rate | 0.5% (absolute change)  | 3 days       |
| Slope 1                   | 0.5% (absolute change)  | 3 days       |
| Slope 2                   | 5% (absolute change)    | 3 days       |
| Optimal Point (Kink)      | 3% (absolute change)    | 3 days       |
| Loan to Value (LTV)       | 0.25% (absolute change) | 3 days       |
| Liquidation Threshold     | 0.25% (absolute change) | 3 days       |
| Liquidation Bonus         | 0.5% (absolute change)  | 3 days       |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3Ethereum_RiskStewardPhase2_20240805.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3EthereumLido_RiskStewardPhase2_20240805.sol), [AaveV3EthereumEtherFi](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3EthereumEtherFi_RiskStewardPhase2_20240805.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3Polygon_RiskStewardPhase2_20240805.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3Avalanche_RiskStewardPhase2_20240805.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3Optimism_RiskStewardPhase2_20240805.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3Arbitrum_RiskStewardPhase2_20240805.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3Metis_RiskStewardPhase2_20240805.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3Base_RiskStewardPhase2_20240805.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3Gnosis_RiskStewardPhase2_20240805.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3Scroll_RiskStewardPhase2_20240805.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3BNB_RiskStewardPhase2_20240805.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/zksync/src/20240805_Multi_RiskStewardPhase2/AaveV3ZkSync_RiskStewardPhase2_20240805.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3Ethereum_RiskStewardPhase2_20240805.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3EthereumLido_RiskStewardPhase2_20240805.t.sol), [AaveV3EthereumEtherFi](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3EthereumEtherFi_RiskStewardPhase2_20240805.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3Polygon_RiskStewardPhase2_20240805.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3Avalanche_RiskStewardPhase2_20240805.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3Optimism_RiskStewardPhase2_20240805.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3Arbitrum_RiskStewardPhase2_20240805.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3Metis_RiskStewardPhase2_20240805.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3Base_RiskStewardPhase2_20240805.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3Gnosis_RiskStewardPhase2_20240805.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3Scroll_RiskStewardPhase2_20240805.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/src/20240805_Multi_RiskStewardPhase2/AaveV3BNB_RiskStewardPhase2_20240805.t.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/9c7233fde23e9061245c09b6cc58365a32a7b19b/zksync/src/20240805_Multi_RiskStewardPhase2/AaveV3ZkSync_RiskStewardPhase2_20240805.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-aave-generalized-risk-stewards-agrs-activation/19178)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x4809f179e517e5745ec13eba8f40d98dab73ca65f8a141bd2f18cc16dcd0cc16)
- Github Repo: [Aave V3 Risk Stewards](https://github.com/aave-dao/aave-v3-risk-stewards)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
