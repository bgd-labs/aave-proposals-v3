---
title: "Update flashBorrowers"
author: "Karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-add-cian-protocol-to-flashborrowers/18731"
snapshot: "Direct-to-AIP"
---

## Simple Summary

This AIP updates whitelisted flashBorrowers addresses across various instances of Aave v3.

## Motivation

Upon execution, this AIP will implement will waiver flash loan fees for the following:

- A new address associated with CIAN Protocol across all instances of Aave v3 on Ethereum, Optimism and Arbitrum; and,
- Existing addresses associated with Index Coop and Contango on the Lido and EtherFi instances only.

Each of the mentioned team has expressed interest in integrating with these new instances of Aave v3.

## Specification

This AIP, will call addFlashBorrower() on the ACL_MANAGER contract to whitelist the addresses as outlined below:

| Network  | Instance                   | Protocol      | Address                                                                                                                            | Contract Name           |
| -------- | -------------------------- | ------------- | ---------------------------------------------------------------------------------------------------------------------------------- | ----------------------- |
| Ethereum | Main Market, Lido, EtherFi | CIAN Protocol | [`0x49d9409111a6363d82c4371ffa43faea660c917b`](https://etherscan.io/address/0x49d9409111a6363d82c4371ffa43faea660c917b)            | FlashloanHelper         |
| Arbitrum | Main Market                | CIAN Protocol | [`0x49d9409111a6363d82c4371ffa43faea660c917b`](https://arbiscan.io/address/0x49d9409111a6363d82c4371ffa43faea660c917b)             | FlashloanHelper         |
| Optimism | Main Market                | CIAN Protocol | [`0x49d9409111a6363d82c4371ffa43faea660c917b`](https://optimistic.etherscan.io/address/0x49d9409111a6363d82c4371ffa43faea660c917b) | FlashloanHelper         |
| Ethereum | Lido, EtherFi              | Index Coop    | [`0x45c00508C14601fd1C1e296eB3C0e3eEEdCa45D0`](https://etherscan.io/address/0x45c00508C14601fd1C1e296eB3C0e3eEEdCa45D0)            | FlashMintLeveraged      |
| Ethereum | Lido, EtherFi              | Contango      | [`0xab515542d621574f9b5212d50593cD0C07e641bD`](https://etherscan.io/address/0xab515542d621574f9b5212d50593cD0C07e641bD)            | PermissionedAaveWrapper |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/b966b2e0da664a57b16c38609b980ac4f9478fa0/src/20240906_Multi_AddFlashBorrowers/AaveV3Ethereum_AddFlashBorrowers_20240906.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/b966b2e0da664a57b16c38609b980ac4f9478fa0/src/20240906_Multi_AddFlashBorrowers/AaveV3EthereumLido_AddFlashBorrowers_20240906.sol), [AaveV3EthereumEtherFi](https://github.com/bgd-labs/aave-proposals-v3/blob/b966b2e0da664a57b16c38609b980ac4f9478fa0/src/20240906_Multi_AddFlashBorrowers/AaveV3EthereumEtherFi_AddFlashBorrowers_20240906.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/b966b2e0da664a57b16c38609b980ac4f9478fa0/src/20240906_Multi_AddFlashBorrowers/AaveV3Optimism_AddFlashBorrowers_20240906.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/b966b2e0da664a57b16c38609b980ac4f9478fa0/src/20240906_Multi_AddFlashBorrowers/AaveV3Arbitrum_AddFlashBorrowers_20240906.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/b966b2e0da664a57b16c38609b980ac4f9478fa0/src/20240906_Multi_AddFlashBorrowers/AaveV3Ethereum_AddFlashBorrowers_20240906.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/b966b2e0da664a57b16c38609b980ac4f9478fa0/src/20240906_Multi_AddFlashBorrowers/AaveV3EthereumLido_AddFlashBorrowers_20240906.t.sol), [AaveV3EthereumEtherFi](https://github.com/bgd-labs/aave-proposals-v3/blob/b966b2e0da664a57b16c38609b980ac4f9478fa0/src/20240906_Multi_AddFlashBorrowers/AaveV3EthereumEtherFi_AddFlashBorrowers_20240906.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/b966b2e0da664a57b16c38609b980ac4f9478fa0/src/20240906_Multi_AddFlashBorrowers/AaveV3Optimism_AddFlashBorrowers_20240906.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/b966b2e0da664a57b16c38609b980ac4f9478fa0/src/20240906_Multi_AddFlashBorrowers/AaveV3Arbitrum_AddFlashBorrowers_20240906.t.sol)
- [Snapshot](Direct-to-AIP)
- [Discussion](https://governance.aave.com/t/arfc-add-cian-protocol-to-flashborrowers/18731)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
