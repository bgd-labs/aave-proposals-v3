---
title: "Update a.DI implementation and CCIP adapters"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/21"
---

## Simple Summary

This proposal includes the update of the CrossChainController on all supported networks to Revision 2.
It also updates all the CCIP Bridge Adapters to version 1.2.0 on the supported networks.

## Motivation

The main motivation of this proposal is to bring the CCIP Bridge Adapters up to date with the latest bridge provider specifications,
and updating the logic to ease and standardize off chain tracking of a.DI contracts and events.

## Specification

- Update CCIP to v1.2.0
- Added Adapter Name to the contracts to make it easy to track off chain.

On the CrossChainController implementation we have updated the logic so that all bridged messages will be treated the same
even if required confirmation have already been reached. (Previously these messages where ignored)

Updates the implementation of CrossChainController on aDI on all supported networks:

| Network   | CrossChainController Impl                                                                                                            |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| Ethereum  | [0x28559c2F4B038b1E836fA419DCcDe7454d8Fe215](https://etherscan.io/address/0x28559c2F4B038b1E836fA419DCcDe7454d8Fe215)                |
| Polygon   | [0x87a95917DE670088d81B9a8B30E3B36704Ba3043](https://polygonscan.com/address/0x87a95917DE670088d81B9a8B30E3B36704Ba3043)             |
| Avalanche | [0x5Ef80c5eB6CF65Dab8cD1C0ee258a6D2bD38Bd22](https://snowscan.xyz/address/0x5Ef80c5eB6CF65Dab8cD1C0ee258a6D2bD38Bd22)                |
| Binance   | [0xf41193E25408F652AF878c47E4401A01B5E4B682](https://bscscan.com/address/0xf41193E25408F652AF878c47E4401A01B5E4B682)                 |
| Gnosis    | [0x5e06b10B3b9c3E1c0996D2544A35B9839Be02922](https://gnosisscan.io/address/0x5e06b10B3b9c3E1c0996D2544A35B9839Be02922)               |
| Arbitrum  | [0x6e633269af45F37c44659D98f382dd0DD524E5Df](https://arbiscan.io/address/0x6e633269af45F37c44659D98f382dd0DD524E5Df)                 |
| Optimism  | [0xa5cc218513305221201f196760E9e64e9D49d98A](https://optimistic.etherscan.io/address/0xa5cc218513305221201f196760E9e64e9D49d98A)     |
| Metis     | [0xa198Fac58E02A5C5F8F7e877895d50cFa9ad1E04](https://andromeda-explorer.metis.io/address/0xa198Fac58E02A5C5F8F7e877895d50cFa9ad1E04) |
| Base      | [0x9b6f5ef589A3DD08670Dd146C11C4Fb33E04494F](https://basescan.org/address/0x9b6f5ef589A3DD08670Dd146C11C4Fb33E04494F)                |
| Scroll    | [0x5e06b10B3b9c3E1c0996D2544A35B9839Be02922](https://scrollscan.com/address/0x5e06b10B3b9c3E1c0996D2544A35B9839Be02922)              |

Updates the bridge adapters used to connect between networks

| Network   | CCIP                                                                                                                     |
| --------- | ------------------------------------------------------------------------------------------------------------------------ |
| Ethereum  | [0xB7a6618df58626C3a122ABAFD6Ee63Af63f3Ef29](https://etherscan.io/address/0xB7a6618df58626C3a122ABAFD6Ee63Af63f3Ef29)    |
| Polygon   | [0xe79757D55a1600eF28D816a893E78E9FCDE2019E](https://polygonscan.com/address/0xe79757D55a1600eF28D816a893E78E9FCDE2019E) |
| Avalanche | [0x2b88C83727B0E290B76EB3F6133994fF81B7f355](https://snowscan.xyz/address/0x2b88C83727B0E290B76EB3F6133994fF81B7f355)    |
| Binance   | [0xAE93BEa44dcbE52B625169588574d31e36fb3A67](https://bscscan.com/address/0xAE93BEa44dcbE52B625169588574d31e36fb3A67)     |

Code diffs for the different networks can be checked on a.DI diff repository for [revision 2](https://github.com/bgd-labs/aDI-diffs/tree/main/diffs/rev2).
Adapter diffs: [CCIPAdapter](https://github.com/bgd-labs/aDI-diffs/tree/main/diffs/rev2/ccip), [BaseAdapter](https://github.com/bgd-labs/aDI-diffs/tree/main/diffs/rev2/base_adapter), [IBaseAdapter](https://github.com/bgd-labs/aDI-diffs/tree/main/diffs/rev2/i_base_adapter)
CCC Diffs: [Forwarder](https://github.com/bgd-labs/aDI-diffs/tree/main/diffs/rev2/ccc_impl), [Errors](https://github.com/bgd-labs/aDI-diffs/tree/main/diffs/rev2/errors)

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/5cd28b94b93f38301f02a1b7839eb493d5f71207/src/20240313_Multi_UpdateADIImplementationAndCCIPAdapters/AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/5cd28b94b93f38301f02a1b7839eb493d5f71207/src/20240313_Multi_UpdateADIImplementationAndCCIPAdapters/AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/5cd28b94b93f38301f02a1b7839eb493d5f71207/src/20240313_Multi_UpdateADIImplementationAndCCIPAdapters/AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/5cd28b94b93f38301f02a1b7839eb493d5f71207/src/20240313_Multi_UpdateADIImplementationAndCCIPAdapters/AaveV3Optimism_UpdateADIImplementationAndCCIPAdapters_20240313.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/5cd28b94b93f38301f02a1b7839eb493d5f71207/src/20240313_Multi_UpdateADIImplementationAndCCIPAdapters/AaveV3Arbitrum_UpdateADIImplementationAndCCIPAdapters_20240313.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/5cd28b94b93f38301f02a1b7839eb493d5f71207/src/20240313_Multi_UpdateADIImplementationAndCCIPAdapters/AaveV3Metis_UpdateADIImplementationAndCCIPAdapters_20240313.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/5cd28b94b93f38301f02a1b7839eb493d5f71207/src/20240313_Multi_UpdateADIImplementationAndCCIPAdapters/AaveV3Base_UpdateADIImplementationAndCCIPAdapters_20240313.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/5cd28b94b93f38301f02a1b7839eb493d5f71207/src/20240313_Multi_UpdateADIImplementationAndCCIPAdapters/AaveV3Gnosis_UpdateADIImplementationAndCCIPAdapters_20240313.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/5cd28b94b93f38301f02a1b7839eb493d5f71207/src/20240313_Multi_UpdateADIImplementationAndCCIPAdapters/AaveV3Scroll_UpdateADIImplementationAndCCIPAdapters_20240313.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/5cd28b94b93f38301f02a1b7839eb493d5f71207/src/20240313_Multi_UpdateADIImplementationAndCCIPAdapters/AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/5cd28b94b93f38301f02a1b7839eb493d5f71207/src/20240313_Multi_UpdateADIImplementationAndCCIPAdapters/AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/5cd28b94b93f38301f02a1b7839eb493d5f71207/src/20240313_Multi_UpdateADIImplementationAndCCIPAdapters/AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/5cd28b94b93f38301f02a1b7839eb493d5f71207/src/20240313_Multi_UpdateADIImplementationAndCCIPAdapters/AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/5cd28b94b93f38301f02a1b7839eb493d5f71207/src/20240313_Multi_UpdateADIImplementationAndCCIPAdapters/AaveV3Optimism_UpdateADIImplementationAndCCIPAdapters_20240313.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/5cd28b94b93f38301f02a1b7839eb493d5f71207/src/20240313_Multi_UpdateADIImplementationAndCCIPAdapters/AaveV3Arbitrum_UpdateADIImplementationAndCCIPAdapters_20240313.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/5cd28b94b93f38301f02a1b7839eb493d5f71207/src/20240313_Multi_UpdateADIImplementationAndCCIPAdapters/AaveV3Metis_UpdateADIImplementationAndCCIPAdapters_20240313.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/5cd28b94b93f38301f02a1b7839eb493d5f71207/src/20240313_Multi_UpdateADIImplementationAndCCIPAdapters/AaveV3Base_UpdateADIImplementationAndCCIPAdapters_20240313.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/5cd28b94b93f38301f02a1b7839eb493d5f71207/src/20240313_Multi_UpdateADIImplementationAndCCIPAdapters/AaveV3Gnosis_UpdateADIImplementationAndCCIPAdapters_20240313.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/5cd28b94b93f38301f02a1b7839eb493d5f71207/src/20240313_Multi_UpdateADIImplementationAndCCIPAdapters/AaveV3Scroll_UpdateADIImplementationAndCCIPAdapters_20240313.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/5cd28b94b93f38301f02a1b7839eb493d5f71207/src/20240313_Multi_UpdateADIImplementationAndCCIPAdapters/AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313.t.sol)
- [Discussion](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/21)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
