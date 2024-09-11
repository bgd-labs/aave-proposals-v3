---
title: "add flash borrowers"
author: "Karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-add-cian-protocol-to-flashborrowers/18731"
snapshot: "Direct-to-AIP"
---

## Simple Summary

This AIP updated and extends existing whitelisted flashBorrowers addresses to recently deployed instances of Aave v3 on Ethereum.

## Motivation

This AIP will waive the flash loan fee for one new CIAN Protocol address and extend the waiver to cover recently deployed instances of Aave v3 for existing beneficiaries who have expressed interest integrating the new instances of Aave v3.

## Specification

This AIP, will call addFlashBorrower() on the ACL_MANAGER contract to whitelist the following contract address on all instances of Aave v3 on the mentioned network:

| Network  | Protocol      | Address                                                                                                                            | Contract Name           |
| -------- | ------------- | ---------------------------------------------------------------------------------------------------------------------------------- | ----------------------- |
| Ethereum | CIAN Protocol | [`0x49d9409111a6363d82c4371ffa43faea660c917b`](https://etherscan.io/address/0x49d9409111a6363d82c4371ffa43faea660c917b)            | FlashloanHelper         |
| Arbitrum | CIAN Protocol | [`0x49d9409111a6363d82c4371ffa43faea660c917b`](https://arbiscan.io/address/0x49d9409111a6363d82c4371ffa43faea660c917b)             | FlashloanHelper         |
| Optimism | CIAN Protocol | [`0x49d9409111a6363d82c4371ffa43faea660c917b`](https://optimistic.etherscan.io/address/0x49d9409111a6363d82c4371ffa43faea660c917b) | FlashloanHelper         |
| Ethereum | Index Coop    | [`0x45c00508C14601fd1C1e296eB3C0e3eEEdCa45D0`](https://etherscan.io/address/0x45c00508C14601fd1C1e296eB3C0e3eEEdCa45D0)            | FlashMintLeveraged      |
| Ethereum | Contango      | [`0xab515542d621574f9b5212d50593cD0C07e641bD`](https://etherscan.io/address/0xab515542d621574f9b5212d50593cD0C07e641bD)            | PermissionedAaveWrapper |
| Ethereum | Seven Seas    | [`0xf0bb20865277aBd641a307eCe5Ee04E79073416C`](https://etherscan.io/address/0xf0bb20865277aBd641a307eCe5Ee04E79073416C)            | Ether.Fi Liquid ETH     |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240906_Multi_AddFlashBorrowers/AaveV3Ethereum_AddFlashBorrowers_20240906.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240906_Multi_AddFlashBorrowers/AaveV3EthereumLido_AddFlashBorrowers_20240906.sol), [AaveV3EthereumEtherFi](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240906_Multi_AddFlashBorrowers/AaveV3EthereumEtherFi_AddFlashBorrowers_20240906.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240906_Multi_AddFlashBorrowers/AaveV3Optimism_AddFlashBorrowers_20240906.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240906_Multi_AddFlashBorrowers/AaveV3Arbitrum_AddFlashBorrowers_20240906.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240906_Multi_AddFlashBorrowers/AaveV3Ethereum_AddFlashBorrowers_20240906.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240906_Multi_AddFlashBorrowers/AaveV3EthereumLido_AddFlashBorrowers_20240906.t.sol), [AaveV3EthereumEtherFi](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240906_Multi_AddFlashBorrowers/AaveV3EthereumEtherFi_AddFlashBorrowers_20240906.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240906_Multi_AddFlashBorrowers/AaveV3Optimism_AddFlashBorrowers_20240906.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240906_Multi_AddFlashBorrowers/AaveV3Arbitrum_AddFlashBorrowers_20240906.t.sol)
- [Snapshot](Direct-to-AIP)
- [Discussion](https://governance.aave.com/t/arfc-add-cian-protocol-to-flashborrowers/18731)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
