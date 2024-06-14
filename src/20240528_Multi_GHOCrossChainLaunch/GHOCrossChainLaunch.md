---
title: "GHO Cross-Chain"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/arfc-gho-cross-chain-launch/17616"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x2a6ffbcff41a5ef98b7542f99b207af9c1e79e61f859d0a62f3bf52d3280877a"
---

## Simple Summary

This AIP proposes the cross-chain implementation for the GHO stablecoin, the native asset of the Aave Protocol, beginning with the initial expansion to the Arbitrum network utilizing the Chainlink Cross-Chain Interoperability Protocol (CCIP).

The smart contracts have been refined through multiple stages of design, development, testing, and implementation. For security validations, collaborations with DAO service providers Certora and BGD Labs were established to conduct code reviews.

Following extensive community discussion, this AIP proposes the deployment of cross-chain GHO, adopting risk parameters formulated by Chaos Labs.

## Motivation

Transitioning to a cross-chain model beyond Ethereum Mainnet enhances GHO's accessibility and the overall user experience with faster transactions and reduced costs. This shift also presents new opportunities within the ecosystem of each network, allowing access to a wide array of integrations with other protocols and tools, enriching GHO's utility potential.

## Specification

This AIP addresses the implementation of the GHO cross-chain strategy. The following smart contracts have been developed:

- Upgradable GHO Token: This contract version allows the DAO to adjust the logic of the token.
- Modified CCIP Contracts: Tailored versions of the Chainlink Cross-Chain Interoperability Protocol (CCIP) contracts, designed to support the GHO cross-chain implementation.

All smart contracts, including the code for this AIP, have been reviewed by BGD Labs for alignment with the Aave Protocol and by Certora for security aspects, including both manual and formal verification.

Proposed implementation actions are the following:

Ethereum:

- Deployment of CCIP LockReleaseTokenPool Contract: GHO reserve contract backs up liquidity across different chains. A "bridge limit" control enables the DAO to regulate the outflow of GHO liquidity to other networks. The limit is set at the minimum bucket capacity of the bridges across networks to ensure proper validation of GHO transfers on the source chain to facilitate transfers between chains.
- Transfer of ownership of the CCIP LockReleaseTokenPool contract to the DAO: The DAO controls and owns the contract logic and configuration parameters, including the outbound/inbound rate limit and the bridge limit.
- Configuration of CCIP LockReleaseTokenPool contract: token pool rate limit will be disabled.

Arbitrum:

- Deployment of UpgradeableGHO: The contract is configured to be deployed by the DAO upon passing of this AIP.
- Deployment of CCIP BurnMintTokenPool contract: The contract handles the minting and burning processes, based on the liquidity backed from Ethereum.
- Transfer of ownership of the CCIP BurnMintTokenPool contract to the DAO: The DAO will take control of the contract logic and configuration of outbound/inbound rate limit.
- Configuration of CCIP BurnMintTokenPool contract: token pool rate limit will be disabled.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/7725647f98f1ae815c207bf7f3d26f933f538baa/src/20240528_Multi_GHOCrossChainLaunch/AaveV3Ethereum_GHOCrossChainLaunch_20240528.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/7725647f98f1ae815c207bf7f3d26f933f538baa/src/20240528_Multi_GHOCrossChainLaunch/AaveV3Arbitrum_GHOCrossChainLaunch_20240528.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/7725647f98f1ae815c207bf7f3d26f933f538baa/src/20240528_Multi_GHOCrossChainLaunch/AaveV3Ethereum_GHOCrossChainLaunch_20240528.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/7725647f98f1ae815c207bf7f3d26f933f538baa/src/20240528_Multi_GHOCrossChainLaunch/AaveV3Arbitrum_GHOCrossChainLaunch_20240528.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x2a6ffbcff41a5ef98b7542f99b207af9c1e79e61f859d0a62f3bf52d3280877a)
- [Discussion](https://governance.aave.com/t/arfc-gho-cross-chain-launch/17616)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
