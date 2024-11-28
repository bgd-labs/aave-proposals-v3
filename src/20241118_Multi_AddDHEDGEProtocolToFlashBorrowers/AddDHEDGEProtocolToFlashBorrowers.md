---
title: "Add dHEDGE Protocol to flashBorrowers"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-add-dhedge-protocol-to-flashborrowers/19547"
---

## Simple Summary

The following proposal plans to add dHEDGE Protocol as a whitelisted actor of the Flashborrowers of Aave V3 on Base, Polygon, Arbitrum, and Optimism liquidity pools.

## Motivation

If this proposal is implemented, all flashLoan fees for dHEGDE Protocol using Aave would be waived.

dHEDGE is a tokenized vault protocol that allows users to build, manage, and automate vault strategies. dHEDGE has many vaults that currently use AAVE V3, most notably Toros Finance Leverge tokens.

[dHEDGE Protocol](https://dhedge.org/)[Toros Finance](https://toros.finance/)

Given [[ARFC] Add Contango Protocol, CIAN Protocol and Index Coop to flashBorrowers on Aave v3](https://governance.aave.com/t/arfc-add-contango-protocol-cian-protocol-and-index-coop-to-flashborrowers-on-aave-v3/16478) passed [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x09bb9e7cffc974d330d82ce7a0b0502b573d6f3b4f839ea15d6629613901e96d) with 595k votes in favour, this proposal intends to utilize the Direct-to-AIP proposes to whitelisted permissions on dHEDGE Protocol.

## Specification

Whitelist dHEDGE Protocol as part of FlashBorrowers of Aave V3 on Base, Polygon, Arbitrum & Optimism liquidity pools.

This proposal aims to implement a single AIP, utilizing four similar payloads (one for each network), which will call addFlashBorrower() on the ACL_MANAGER contract for the followings addresses.

**Optimism**

- [0x83d1fa384ec44c2769a3562ede372484f26e141b](https://optimistic.etherscan.io/address/0x83d1fa384ec44c2769a3562ede372484f26e141b)
- [0x32ad28356ef70adc3ec051d8aacdeeaa10135296](https://optimistic.etherscan.io/address/0x32ad28356ef70adc3ec051d8aacdeeaa10135296)
- [0xb03818de4992388260b62259361778cf98485dfe](https://optimistic.etherscan.io/address/0xb03818de4992388260b62259361778cf98485dfe)
- [0x11b55966527ff030ca9c7b1c548b4be5e7eaee6d](https://optimistic.etherscan.io/address/0x11b55966527ff030ca9c7b1c548b4be5e7eaee6d)
- [0xcacb5a722a36cff6baeb359e21c098a4acbffdfa](https://optimistic.etherscan.io/address/0xcacb5a722a36cff6baeb359e21c098a4acbffdfa)
- [0x9573c7b691cdcebbfa9d655181f291799dfb7cf5](https://optimistic.etherscan.io/address/0x9573c7b691cdcebbfa9d655181f291799dfb7cf5)
- [0x32b1d1bfd4b3b0cb9ff2dcd9dac757aa64d4cb69](https://optimistic.etherscan.io/address/0x32b1d1bfd4b3b0cb9ff2dcd9dac757aa64d4cb69)
- [0x7d3c9c6566375d7ad6e89169ca5c01b5edc15364](https://optimistic.etherscan.io/address/0x7d3c9c6566375d7ad6e89169ca5c01b5edc15364)
- [0xcc7d6ed524760539311ed0cdb41d0852b4eb77eb](https://optimistic.etherscan.io/address/0xcc7d6ed524760539311ed0cdb41d0852b4eb77eb)
- [0xb9243c495117343981ec9f8aa2abffee54396fc0](https://optimistic.etherscan.io/address/0xb9243c495117343981ec9f8aa2abffee54396fc0)
- [0x1ec50880101022c11530a069690f5446d1464592](https://optimistic.etherscan.io/address/0x1ec50880101022c11530a069690f5446d1464592)
- [0x49bf093277bf4dde49c48c6aa55a3bda3eedef68](https://optimistic.etherscan.io/address/0x49bf093277bf4dde49c48c6aa55a3bda3eedef68)
- [0xb2cfb909e8657c0ec44d3dd898c1053b87804755](https://optimistic.etherscan.io/address/0xb2cfb909e8657c0ec44d3dd898c1053b87804755)
- [0x59babc14dd73761e38e5bda171b2298dc14da92d](https://optimistic.etherscan.io/address/0x59babc14dd73761e38e5bda171b2298dc14da92d)

**Arbitrum**

- [0x27d8fdb0251b48d8edd1ad7bedf553cf99abe7b0](https://arbiscan.io/address/0x27d8fdb0251b48d8edd1ad7bedf553cf99abe7b0)
- [0xe3254397f5d9c0b69917ebb49b49e103367b406f](https://arbiscan.io/address/0xe3254397f5d9c0b69917ebb49b49e103367b406f)
- [0xad38255febd566809ae387d5be66ecd287947cb9](https://arbiscan.io/address/0xad38255febd566809ae387d5be66ecd287947cb9)
- [0x40d30b13666c55b1f41ee11645b5ea3ea2ca31f8](https://arbiscan.io/address/0x40d30b13666c55b1f41ee11645b5ea3ea2ca31f8)
- [0x696f6d66c2da2aa4a400a4317eec8da88f7a378c](https://arbiscan.io/address/0x696f6d66c2da2aa4a400a4317eec8da88f7a378c)
- [0xf715724abba480d4d45f4cb52bef5ce5e3513ccc](https://arbiscan.io/address/0xf715724abba480d4d45f4cb52bef5ce5e3513ccc)
- [0xe9b5260d99d283ff887859c569baf8ad1bd12aac](https://arbiscan.io/address/0xe9b5260d99d283ff887859c569baf8ad1bd12aac)
- [0x43da9b0ab53242c55a9ff9c722ffc2a373d639c7](https://arbiscan.io/address/0x43da9b0ab53242c55a9ff9c722ffc2a373d639c7)
- [0x678569fc403ea2ba46b549a4d0e15e883d7cadf5](https://arbiscan.io/address/0x678569fc403ea2ba46b549a4d0e15e883d7cadf5)
- [0xc3198eb5102fb3335c0e911ef1da4bc07e403dd1](https://arbiscan.io/address/0xc3198eb5102fb3335c0e911ef1da4bc07e403dd1)
- [0xddd6b1f34e12c0230ab23cbd4514560b24438514](https://arbiscan.io/address/0xddd6b1f34e12c0230ab23cbd4514560b24438514)

**Base**

- [0xa672e882acbb96486393d43e0efdab5ebebddc1d](https://basescan.io/address/0xa672e882acbb96486393d43e0efdab5ebebddc1d)
- [0x15e2f06138aed58ca2a6afb5a1333bbc5f728f80](https://basescan.io/address/0x15e2f06138aed58ca2a6afb5a1333bbc5f728f80)
- [0xba5f6a0d2ac21a3fec7a6c40facd23407aa84663](https://basescan.io/address/0xba5f6a0d2ac21a3fec7a6c40facd23407aa84663)
- [0xc1e02884af4a283ca25ab63c45360d220d69da52](https://basescan.io/address/0xc1e02884af4a283ca25ab63c45360d220d69da52)
- [0x1c980456751ae40315ff73caac0843be643321be](https://basescan.io/address/0x1c980456751ae40315ff73caac0843be643321be)
- [0xede61eefa4850b459e3b09fe6d8d371480d6ff00](https://basescan.io/address/0xede61eefa4850b459e3b09fe6d8d371480d6ff00)
- [0x53a4716a8f7dbc9543ebf9cd711952033cc64d43](https://basescan.io/address/0x53a4716a8f7dbc9543ebf9cd711952033cc64d43)
- [0xd2f23773bf5e2d59f6bb925c2232f6e83f3f79e0](https://basescan.io/address/0xd2f23773bf5e2d59f6bb925c2232f6e83f3f79e0)
- [0x9e0501537723c71250307f5b1a8ee60e167d21c9](https://basescan.io/address/0x9e0501537723c71250307f5b1a8ee60e167d21c9)
- [0xcaf08bf08d0c87e2c74dd9ebec9c776037bd7e8e](https://basescan.io/address/0xcaf08bf08d0c87e2c74dd9ebec9c776037bd7e8e)

**Polygon**

- [0x86c3dd18baf4370495d9228b58fd959771285c55](https://polygonscan.io/address/0x86c3dd18baf4370495d9228b58fd959771285c55)
- [0xdb88ab5b485b38edbeef866314f9e49d095bce39](https://polygonscan.io/address/0xdb88ab5b485b38edbeef866314f9e49d095bce39)
- [0x79d2aefe6a21b26b024d9341a51f6b7897852499](https://polygonscan.io/address/0x79d2aefe6a21b26b024d9341a51f6b7897852499)
- [0x460b60565cb73845d56564384ab84bf84c13e47d](https://polygonscan.io/address/0x460b60565cb73845d56564384ab84bf84c13e47d)

This AIP grants permission to whitelist any dHEDGE Protocol contract for all use cases, such as leveraged positions, EMODE, debt and collateral swaps, with one exception: no smart-contract that migrates a position outside of the Aave ecosystem is eligible for whitelisting.

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/b537d861c6636003e985d83f1f622346ea62c1ac/src/20241118_Multi_AddDHEDGEProtocolToFlashBorrowers/AaveV3Polygon_AddDHEDGEProtocolToFlashBorrowers_20241118.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/b537d861c6636003e985d83f1f622346ea62c1ac/src/20241118_Multi_AddDHEDGEProtocolToFlashBorrowers/AaveV3Optimism_AddDHEDGEProtocolToFlashBorrowers_20241118.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/b537d861c6636003e985d83f1f622346ea62c1ac/src/20241118_Multi_AddDHEDGEProtocolToFlashBorrowers/AaveV3Arbitrum_AddDHEDGEProtocolToFlashBorrowers_20241118.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/b537d861c6636003e985d83f1f622346ea62c1ac/src/20241118_Multi_AddDHEDGEProtocolToFlashBorrowers/AaveV3Base_AddDHEDGEProtocolToFlashBorrowers_20241118.sol)
- Tests: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/b537d861c6636003e985d83f1f622346ea62c1ac/src/20241118_Multi_AddDHEDGEProtocolToFlashBorrowers/AaveV3Polygon_AddDHEDGEProtocolToFlashBorrowers_20241118.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/b537d861c6636003e985d83f1f622346ea62c1ac/src/20241118_Multi_AddDHEDGEProtocolToFlashBorrowers/AaveV3Optimism_AddDHEDGEProtocolToFlashBorrowers_20241118.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/b537d861c6636003e985d83f1f622346ea62c1ac/src/20241118_Multi_AddDHEDGEProtocolToFlashBorrowers/AaveV3Arbitrum_AddDHEDGEProtocolToFlashBorrowers_20241118.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/b537d861c6636003e985d83f1f622346ea62c1ac/src/20241118_Multi_AddDHEDGEProtocolToFlashBorrowers/AaveV3Base_AddDHEDGEProtocolToFlashBorrowers_20241118.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-add-dhedge-protocol-to-flashborrowers/19547)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
