---
title: "Update legacy guardian"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/48"
---

## Simple Summary

Proposal to update emergency roles (protocol & governance) to the [new elected Aave Protocol & Emergency Guardians](https://governance.aave.com/t/arfc-renewal-of-aave-guardian-2024/17523).

## Motivation

This year, the community decided to renew the Aave Guardian and making it more granular with a Protocol Emergency Guardian and a Governance Emergency Guardian.
Even if new pieces of infrastructure (e.g. Lido/Etherfi/zkSync) pools have been configured with the new Guardians on activation stage, it is still necessary to update via governance proposal different on-chain roles, from old guardians to new ones.

## Specification

- Protocol Guardian
  - For Aave v2 pools POOL_ADDRESS_PROVIDER.setEmergencyAdmin() is called to replace the old Guardian with the new one.
  - For Aave v3 ACL_MANAGER.addEmergencyAdmin() is called to give the role to the new Guardian and ACL_MANAGER.removeEmergencyAdmin() to remove it from the old Guardian. This is not necessary for new pools where the new Guardian is already configured: zkSync, Lido, Etherfi.

The list of Protocol Guardian Safes is the following:

| Network   | Address                                                                                                                              |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| Ethereum  | [0x2CFe3ec4d5a6811f4B8067F0DE7e47DfA938Aa30](https://etherscan.io/address/0x2CFe3ec4d5a6811f4B8067F0DE7e47DfA938Aa30)                |
| Polygon   | [0xCb45E82419baeBCC9bA8b1e5c7858e48A3B26Ea6](https://polygonscan.com/address/0xCb45E82419baeBCC9bA8b1e5c7858e48A3B26Ea6)             |
| Avalanche | [0x56C1a4b54921DEA9A344967a8693C7E661D72968](https://snowtrace.io/address/0x56C1a4b54921DEA9A344967a8693C7E661D72968)                |
| Optimism  | [0x56C1a4b54921DEA9A344967a8693C7E661D72968](https://optimistic.etherscan.io/address/0x56C1a4b54921DEA9A344967a8693C7E661D72968)     |
| Arbitrum  | [0xCb45E82419baeBCC9bA8b1e5c7858e48A3B26Ea6](https://arbiscan.io/address/0xCb45E82419baeBCC9bA8b1e5c7858e48A3B26Ea6)                 |
| Base      | [0x56C1a4b54921DEA9A344967a8693C7E661D72968](https://basescan.org/address/0x56C1a4b54921DEA9A344967a8693C7E661D72968)                |
| Gnosis    | [0xCb45E82419baeBCC9bA8b1e5c7858e48A3B26Ea6](https://gnosisscan.io/address/0xCb45E82419baeBCC9bA8b1e5c7858e48A3B26Ea6)               |
| Scroll    | [0xCb45E82419baeBCC9bA8b1e5c7858e48A3B26Ea6](https://scrollscan.com/address/0xCb45E82419baeBCC9bA8b1e5c7858e48A3B26Ea6)              |
| Metis     | [0x56C1a4b54921DEA9A344967a8693C7E661D72968](https://andromeda-explorer.metis.io/address/0x56C1a4b54921DEA9A344967a8693C7E661D72968) |
| BNB       | [0xCb45E82419baeBCC9bA8b1e5c7858e48A3B26Ea6](https://bscscan.com/address/0xCb45E82419baeBCC9bA8b1e5c7858e48A3B26Ea6)                 |

The list of Governance Guardian Safes is the following:

| Network   | Address                                                                                                                              |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| Ethereum  | [0xCe52ab41C40575B072A18C9700091Ccbe4A06710](https://etherscan.io/address/0xCe52ab41C40575B072A18C9700091Ccbe4A06710)                |
| Polygon   | [0x1A0581dd5C7C3DA4Ba1CDa7e0BcA7286afc4973b](https://polygonscan.com/address/0x1A0581dd5C7C3DA4Ba1CDa7e0BcA7286afc4973b)             |
| Avalanche | [0x360c0a69Ed2912351227a0b745f890CB2eBDbcFe](https://snowtrace.io/address/0x360c0a69Ed2912351227a0b745f890CB2eBDbcFe)                |
| Optimism  | [0x360c0a69Ed2912351227a0b745f890CB2eBDbcFe](https://optimistic.etherscan.io/address/0x360c0a69Ed2912351227a0b745f890CB2eBDbcFe)     |
| Arbitrum  | [0x1A0581dd5C7C3DA4Ba1CDa7e0BcA7286afc4973b](https://arbiscan.io/address/0x1A0581dd5C7C3DA4Ba1CDa7e0BcA7286afc4973b)                 |
| Base      | [0x360c0a69Ed2912351227a0b745f890CB2eBDbcFe](https://basescan.org/address/0x360c0a69Ed2912351227a0b745f890CB2eBDbcFe)                |
| Gnosis    | [0x1A0581dd5C7C3DA4Ba1CDa7e0BcA7286afc4973b](https://gnosisscan.io/address/0x1A0581dd5C7C3DA4Ba1CDa7e0BcA7286afc4973b)               |
| Scroll    | [0x1A0581dd5C7C3DA4Ba1CDa7e0BcA7286afc4973b](https://scrollscan.com/address/0x1A0581dd5C7C3DA4Ba1CDa7e0BcA7286afc4973b)              |
| Metis     | [0x360c0a69Ed2912351227a0b745f890CB2eBDbcFe](https://andromeda-explorer.metis.io/address/0x360c0a69Ed2912351227a0b745f890CB2eBDbcFe) |
| BNB       | [0x1A0581dd5C7C3DA4Ba1CDa7e0BcA7286afc4973b](https://bscscan.com/address/0x1A0581dd5C7C3DA4Ba1CDa7e0BcA7286afc4973b)                 |

## References

- [Permissions diff](https://github.com/bgd-labs/aave-permissions-book/pull/80/files)
- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV2Ethereum_UpdateLegacyGuardian_20241016.sol), [AaveV2EthereumAMM](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV2EthereumAMM_UpdateLegacyGuardian_20241016.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV2Polygon_UpdateLegacyGuardian_20241016.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV2Avalanche_UpdateLegacyGuardian_20241016.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV3Ethereum_UpdateLegacyGuardian_20241016.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV3Polygon_UpdateLegacyGuardian_20241016.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV3Avalanche_UpdateLegacyGuardian_20241016.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV3Optimism_UpdateLegacyGuardian_20241016.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV3Arbitrum_UpdateLegacyGuardian_20241016.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV3Metis_UpdateLegacyGuardian_20241016.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV3Base_UpdateLegacyGuardian_20241016.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV3Gnosis_UpdateLegacyGuardian_20241016.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV3Scroll_UpdateLegacyGuardian_20241016.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV3BNB_UpdateLegacyGuardian_20241016.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV2Ethereum_UpdateLegacyGuardian_20241016.t.sol), [AaveV2EthereumAMM](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV2EthereumAMM_UpdateLegacyGuardian_20241016.t.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV2Polygon_UpdateLegacyGuardian_20241016.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV2Avalanche_UpdateLegacyGuardian_20241016.t.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV3Ethereum_UpdateLegacyGuardian_20241016.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV3Polygon_UpdateLegacyGuardian_20241016.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV3Avalanche_UpdateLegacyGuardian_20241016.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV3Optimism_UpdateLegacyGuardian_20241016.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV3Arbitrum_UpdateLegacyGuardian_20241016.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV3Metis_UpdateLegacyGuardian_20241016.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV3Base_UpdateLegacyGuardian_20241016.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV3Gnosis_UpdateLegacyGuardian_20241016.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV3Scroll_UpdateLegacyGuardian_20241016.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/f7f839239bf0eafe8e90e4f27cc2037c4b920d17/src/20241016_Multi_UpdateLegacyGuardian/AaveV3BNB_UpdateLegacyGuardian_20241016.t.sol)
- [Discussion](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/48)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
