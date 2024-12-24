---
title: "GHO CCIP Integration Maintenance (CCIP v1.5 upgrade)"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/51"
---

## Simple Summary

Proposal to update GHO CCIP Token Pools to ensure GHO’s CCIP integration remains functional during and after the upcoming migration to CCIP version 1.5.

## Motivation

The Chainlink Cross-Chain Interoperability Protocol (CCIP) is upgrading to version 1.5 in Q4 2024, introducing several new features and enhancements. We are expecting that a detailed description of this new version will be announced by Chainlink soon.
Currently, GHO CCIP Token Pools are based on version 1.4, and they are not compatible in their current form with CCIP 1.5. The Chainlink CCIP team cannot migrate the GHO CCIP Token Pools as part of the system-wide upgrade, as these are fully controlled by the Aave DAO.
Aave Labs will provide technical support to ensure that GHO CCIP Token Pools remain functional, secure, and aligned with the latest updates, enabling GHO to expand to other networks if needed.

## Specification

Below actions are taken in order to make GHO token pools work with the new CCIP 1.5 protocol by allowing the "Intermediary Contract" (proxyPool) to translate the interface between 1.4 & 1.5 OnRamps and OffRamps:

- Configure an Intermediary Contract: This contract translates execution calls between the new OnRamp and the existing GHO Token Pools. It was developed and deployed by the Chainlink CCIP team on behalf of the Aave DAO.
- Upgrade the Existing GHO Token Pools: The existing Token Pools are adjusted to allow calls from both the old and new versions of the OnRamp and OffRamp, through the intermediary contract.
- Setup a Token Rate Limit: A token rate limit of 300,000 GHO as limit capacity and 60 GHO per second as refill rate is set for both directions of Ethereum <> Arbitrum lane. This is a temporary security measure that can be lifted later via AIP or by GHO Stewards.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/c016f11d2d921748459bb0aaca37f462b2639e1a/src/20241021_Multi_GHOCCIP150Upgrade/AaveV3Ethereum_GHOCCIP150Upgrade_20241021.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/c016f11d2d921748459bb0aaca37f462b2639e1a/src/20241021_Multi_GHOCCIP150Upgrade/AaveV3Arbitrum_GHOCCIP150Upgrade_20241021.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/c016f11d2d921748459bb0aaca37f462b2639e1a/src/20241021_Multi_GHOCCIP150Upgrade/AaveV3Ethereum_GHOCCIP150Upgrade_20241021.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/c016f11d2d921748459bb0aaca37f462b2639e1a/src/20241021_Multi_GHOCCIP150Upgrade/AaveV3Arbitrum_GHOCCIP150Upgrade_20241021.t.sol)
- Snapshot - Direct-to-AIP
- [Discussion](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/51)
- Token Pool Contracts - [UpgradeableLockReleaseTokenPool](https://github.com/aave/ccip/blob/bc0561e6a9615f410086d4766839eaf3ca9b9f49/contracts/src/v0.8/ccip/pools/GHO/UpgradeableLockReleaseTokenPool.sol), [UpgradeableBurnMintTokenPool](https://github.com/aave/ccip/blob/bc0561e6a9615f410086d4766839eaf3ca9b9f49/contracts/src/v0.8/ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
