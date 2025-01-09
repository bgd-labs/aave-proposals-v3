---
title: "GHO CCIP 1.5.1 Upgrade"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/59"
---

## Simple Summary

Proposal to update the GHO CCIP Token Pools to integrate them with CCIP (Chainlink Cross-Chain Interoperability Protocol) version 1.5.1. While the existing deployments on Arbitrum and Ethereum are compatible with 1.5.1, adopting the latest version is preferable in order to leverage the full functionality of CCIP and prepare for future expansions to other chains.

## Motivation

The CCIP was upgraded to version 1.5.1 at the beginning of December, 2024, introducing a number of enhancements for cross-chain pool management. Currently, GHO CCIP Token Pools are based on version 1.4, though still compatible with 1.5.1.

Aave Labs will provide technical support to maintain the GHO CCIP Token Pools functional, secure, and aligned with the latest updates, enabling GHO expansion to other networks when needed.

## Specification

This proposal aims to upgrade the existing CCIP Token Pools for GHO on Ethereum and Arbitrum to CCIP version 1.5.1, by establishing a new lane between these two chains and deprecating the old one.

The proposal includes the following actions:

1. Ownership maintenance of contracts:

   1. Accept ownership of new token pool contracts for GHO on each network.
   2. Assume Admin role for the GHO token in the CCIP TokenAdminRegistry contract on each network.
   3. Take ownership of the existing proxy pools (even though they’ll be deprecated).

2. Migrate Liquidity Between Old and New Token Pools:

   1. On Ethereum: Transfer locked GHO liquidity from the old LockReleaseTokenPool contract to the new one, and properly initialize the new contract to reflect the correct amount of bridged liquidity.
   2. On Arbitrum: Mint tokens on the new BurnMintTokenPool contract and burn tokens from the old pool using the newly introduced `directMint` and `directBurn` methods. This is necessary to offboard the old pool as a facilitator and enable the new pool to handle bridge transactions.

3. Setup a token rate limit of 300,000 GHO capacity and 60 GHO per second refill rate (216,000 GHO per hour), as recommended by the Risk Provider [`@ChaosLabs`](https://governance.aave.com/u/chaoslabs) in the previous maintenance upgrade to v1.5, see [here](https://governance.aave.com/t/technical-maintenance-proposals/15274/54).
   Keep GhoStewards functional by validating they can execute actions over the new CCIP lane and remain fully operational.

## Security

The new CCIP version 1.5.1 has undergone Chainlink’s standard security process.
Certora has completed a review of the new version of the CCIP GHO Token Pool contracts (see [here](https://github.com/aave/ccip/blob/d5c6cedde6fbca9890a92a55f2db80e94793d0ec/contracts/src/v0.8/ccip/pools/GHO/audits/2024-12-24_GHO-CCIP-TokenPools_Certora.pdf)).

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241209_Multi_GHOCCIP151Upgrade/AaveV3Ethereum_GHOCCIP151Upgrade_20241209.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241209_Multi_GHOCCIP151Upgrade/AaveV3Arbitrum_GHOCCIP151Upgrade_20241209.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241209_Multi_GHOCCIP151Upgrade/AaveV3Ethereum_GHOCCIP151Upgrade_20241209.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241209_Multi_GHOCCIP151Upgrade/AaveV3Arbitrum_GHOCCIP151Upgrade_20241209.t.sol), [AaveV3E2E](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241209_Multi_GHOCCIP151Upgrade/AaveV3E2E_GHOCCIP151Upgrade_20241209.t.sol)
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/59)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
