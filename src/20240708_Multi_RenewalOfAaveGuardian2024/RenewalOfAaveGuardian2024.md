---
title: "Renewal of Aave Guardian 2024"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-renewal-of-aave-guardian-2024/17523"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x51cde0e183bd250839ef1fc4feb04a592263f848d44d1f67618504f98fa80865"
---

## Simple Summary

The Aave Guardians are a community-elected group with soft emergency protection permission on the Aave smart contracts. Periodically, the composition of this group undergoes renewals in which members may join, stay, or leave based on community votes. This process has occurred in the past, with the last renewal taking place in 2022. At present, it’s time for another round of renewals to ensure the Aave Guardians continue to embody the evolving interests and needs of the Aave community.

## Motivation

The Aave Guardians play a vital role in protecting the Aave Protocol.

This proposal aims to start a renewal of the aave guardian, allowing for the removal of members who wish to step down & the addition of new members more reflective of the Aave DAO’s current active contributors.

## Specification

This Guardian is the holder of EMERGENCY_ADMIN role in Aave v3, together with similar role in v2 and surrounding systems.
Given that speed is mandatory in an emergency situation, the members recommended are entities really active within the Aave DAO, for example service providers and delegates.

Its multi-sig configuration will be a 5-of-9.

Members (1 representative of each):

- Chaos Labs (risk service provider).
- Llamarisk (risk service provider).
- Karpatkey (finance service provider).
- Certora (security service provider).
- Tokenlogic (finance service provider).
- BGD Labs (development service provider).
- ACI (growth and business development service provider).
- Ezr3al (Aave DAO delegate).
- Stable Labs (Aave DAO delegate).

List of created multi-sigs:

| Network   | Address                                                                                |
| --------- | -------------------------------------------------------------------------------------- |
| Ethereum  | https://etherscan.io/address/0x2CFe3ec4d5a6811f4B8067F0DE7e47DfA938Aa30                |
| Polygon   | https://polygonscan.com/address/0xCb45E82419baeBCC9bA8b1e5c7858e48A3B26Ea6             |
| Avalanche | https://snowtrace.io/address/0x56C1a4b54921DEA9A344967a8693C7E661D72968                |
| Optimism  | https://optimistic.etherscan.io/address/0x56C1a4b54921DEA9A344967a8693C7E661D72968     |
| Arbitrum  | https://arbiscan.io/address/0xCb45E82419baeBCC9bA8b1e5c7858e48A3B26Ea6                 |
| Base      | https://basescan.org/address/0x56C1a4b54921DEA9A344967a8693C7E661D72968                |
| Gnosis    | https://gnosisscan.io/address/0xCb45E82419baeBCC9bA8b1e5c7858e48A3B26Ea6               |
| Scroll    | https://scrollscan.com/address/0xCb45E82419baeBCC9bA8b1e5c7858e48A3B26Ea6              |
| Metis     | https://andromeda-explorer.metis.io/address/0x56C1a4b54921DEA9A344967a8693C7E661D72968 |
| BNB       | https://bscscan.com/address/0xCb45E82419baeBCC9bA8b1e5c7858e48A3B26Ea6                 |

- for Aave v2 pools `POOL_ADDRESS_PROVIDER.setEmergencyAdmin()` is called.
- for Aave v3 `ACL_MANAGER.addEmergencyAdmin()` is called to add a new guardian and then `ACL_MANAGER.removeEmergencyAdmin()` to remove the existing one.

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV2Ethereum_RenewalOfAaveGuardian2024_20240708.sol), [AaveV2EthereumAMM](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV2EthereumAMM_RenewalOfAaveGuardian2024_20240708.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV2Polygon_RenewalOfAaveGuardian2024_20240708.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV2Avalanche_RenewalOfAaveGuardian2024_20240708.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Ethereum_RenewalOfAaveGuardian2024_20240708.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Polygon_RenewalOfAaveGuardian2024_20240708.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Avalanche_RenewalOfAaveGuardian2024_20240708.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Optimism_RenewalOfAaveGuardian2024_20240708.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Arbitrum_RenewalOfAaveGuardian2024_20240708.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Metis_RenewalOfAaveGuardian2024_20240708.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Base_RenewalOfAaveGuardian2024_20240708.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Gnosis_RenewalOfAaveGuardian2024_20240708.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Scroll_RenewalOfAaveGuardian2024_20240708.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3BNB_RenewalOfAaveGuardian2024_20240708.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV2Ethereum_RenewalOfAaveGuardian2024_20240708.t.sol), [AaveV2EthereumAMM](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV2EthereumAMM_RenewalOfAaveGuardian2024_20240708.t.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV2Polygon_RenewalOfAaveGuardian2024_20240708.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV2Avalanche_RenewalOfAaveGuardian2024_20240708.t.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Ethereum_RenewalOfAaveGuardian2024_20240708.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Polygon_RenewalOfAaveGuardian2024_20240708.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Avalanche_RenewalOfAaveGuardian2024_20240708.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Optimism_RenewalOfAaveGuardian2024_20240708.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Arbitrum_RenewalOfAaveGuardian2024_20240708.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Metis_RenewalOfAaveGuardian2024_20240708.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Base_RenewalOfAaveGuardian2024_20240708.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Gnosis_RenewalOfAaveGuardian2024_20240708.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Scroll_RenewalOfAaveGuardian2024_20240708.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3BNB_RenewalOfAaveGuardian2024_20240708.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x51cde0e183bd250839ef1fc4feb04a592263f848d44d1f67618504f98fa80865)
- [Discussion](https://governance.aave.com/t/arfc-renewal-of-aave-guardian-2024/17523)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
