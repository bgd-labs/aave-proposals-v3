---
title: "addFlashborrowers"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-add-contango-protocol-cian-protocol-and-index-coop-to-flashborrowers-on-aave-v3/16478"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x09bb9e7cffc974d330d82ce7a0b0502b573d6f3b4f839ea15d6629613901e96d"
---

## Simple Summary

The following proposal plans to add Contango Protocol, Cian Protocol and Index Coop as whitelisted actors of the Flashborrowers of Aave V3 on Ethereum, Arbitrum, and Optimism liquidity pools.

## Motivation

[Contango Protocol ](https://app.contango.xyz/) is a Dapp that builds perps by automating looping strategies, through Flash Loans. When a trader opens a position, the protocol borrows on the money market, swaps on the spot market, then lends back on the money market, allowing users to actively manage and take leveraged positions on Aave and other protocols.

[Cian Protocol ](https://cian.app/) is a decentralized automation platform that helps users onboard complex crypto delta-neutral yield strategies in one simple transaction.

[Index Coop](https://indexcoop.com/) is an EVM based protocol that enables easy access to complex DeFi strategies by translating them into ERC20 tokens

Another Aave-Aligned protocol has been added to this proposal in the context of upcoming synergies and partnerships.

If this proposal is implemented, all flashLoan fees for Contango Protocol, Cian Protocol and Index Coop users using Aave would be waived.

The Aave-Chan initiative believes that any incurred lost potential revenue will be compensated by the increased competitiveness of the Aave Protocol and the increased borrow volume.

Currently, every flashloan has a 9 bps fee that rewards liquidity providers in Aave. While flashloans were created by Aave, the ecosystem as a whole has replicated this feature, and most protocols do not implement any fees.

The ACI does not support waiving the fees for flashloans in general, as we firmly believe that users’ funds used, even in the context of a single transaction, should be rewarded.

However, some strategic use cases of V3, such as emode, are very fee-sensitive as they mobilize high leverage. Waiving the Contango Protocol, Cian Protocol and Index Coop flashloan fees is expected to make these strategies more convenient and profitable, leading to increased borrow volume and thus increased Aave DAO revenue.

## Specification

Whitelist Contango Protocol, Cian Protocol and Index Coop as part of FlashBorrowers of Aave V3 on Ethereum, Arbitrum & Optimism liquidity pools.

This proposal aims to implement a single AIP, utilizing three similar payloads (one for each network), which will call addFlashBorrower() on the ACL_MANAGER contract.

This AIP grants permission to whitelist any Contango Protocol, Cian Protocol and Index Coop contract for all use cases, such as leveraged positions, EMODE, debt and collateral swaps, with one exception: no smart-contract that migrates a position outside of the Aave ecosystem is eligible for whitelisting.

This AIP will whitelist the following contracts:

| Network  | Protocol   | Address                                                                                                                          | Contract Name                    |
| -------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------- | -------------------------------- |
| Ethereum | Index Coop | [0x45c00508C14601fd1C1e296eB3C0e3eEEdCa45D0](https://etherscan.io/address/0x45c00508C14601fd1C1e296eB3C0e3eEEdCa45D0)            | FlashMintLeveraged               |
| Ethereum | Index Coop | [0x6e8ac99B2ec2e08600c7d0Aab970f31e9b11957a](https://etherscan.io/address/0x6e8ac99B2ec2e08600c7d0Aab970f31e9b11957a)            | ETH2x-FLI AaveMigrationExtension |
| Ethereum | Index Coop | [0x3a657Ec8a755d2E43DDbfDeaDc15899EDaf8dcf8](https://etherscan.io/address/0x3a657Ec8a755d2E43DDbfDeaDc15899EDaf8dcf8)            | BTC2x-FLI AaveMigrationExtension |
| Ethereum | CIAN       | [0x85105b7E11c442Ca6fF6b4d90d7a439f68376Ac4](https://etherscan.io/address/0x85105b7e11c442ca6ff6b4d90d7a439f68376ac4)            | FlashloanHelper                  |
| Ethereum | Contango   | [0xab515542d621574f9b5212d50593cD0C07e641bD](https://etherscan.io/address/0xab515542d621574f9b5212d50593cD0C07e641bD)            | PermissionedAaveWrapper          |
| Arbitrum | Contango   | [0x5e2aDC1F256f990D73a69875E06AF8A8404e3a03](https://arbiscan.io/address/0x5e2aDC1F256f990D73a69875E06AF8A8404e3a03)             | PermissionedAaveWrapper          |
| Optimism | Contango   | [0xab515542d621574f9b5212d50593cD0C07e641bD](https://optimistic.etherscan.io/address/0xab515542d621574f9b5212d50593cd0c07e641bd) | PermissionedAaveWrapper          |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/7fd20f9b5876309cec8fafdf78080e258ce938c4/src/20240306_Multi_AddFlashborrowers/AaveV3Ethereum_AddFlashborrowers_20240306.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/7fd20f9b5876309cec8fafdf78080e258ce938c4/src/20240306_Multi_AddFlashborrowers/AaveV3Optimism_AddFlashborrowers_20240306.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/7fd20f9b5876309cec8fafdf78080e258ce938c4/src/20240306_Multi_AddFlashborrowers/AaveV3Arbitrum_AddFlashborrowers_20240306.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/7fd20f9b5876309cec8fafdf78080e258ce938c4/src/20240306_Multi_AddFlashborrowers/AaveV3Ethereum_AddFlashborrowers_20240306.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/7fd20f9b5876309cec8fafdf78080e258ce938c4/src/20240306_Multi_AddFlashborrowers/AaveV3Optimism_AddFlashborrowers_20240306.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/7fd20f9b5876309cec8fafdf78080e258ce938c4/src/20240306_Multi_AddFlashborrowers/AaveV3Arbitrum_AddFlashborrowers_20240306.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x09bb9e7cffc974d330d82ce7a0b0502b573d6f3b4f839ea15d6629613901e96d)
- [Discussion](https://governance.aave.com/t/arfc-add-contango-protocol-cian-protocol-and-index-coop-to-flashborrowers-on-aave-v3/16478)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
