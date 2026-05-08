---
title: "Winding Down the LEND Migration Contract"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/arfc-winding-down-lend-migration-contract/23126"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0x4d9eb143c46a637dbf98d63ad00a6e53739a9b6affc0eed7d3cd35680500afaa"
---

## Simple Summary

Terminate operations of the LEND → AAVE Migration Contract, reallocating all unspent budgets, assets, and remaining tokens or emissions into the Ecosystem Reserve, while minimizing disruption to users and integrations.

## Motivation

This proposal follows up on [Aavenomics Part 1](https://governance.aave.com/t/arfc-aavenomics-implementation-part-one/21248) by freeing approximately $100 million worth of AAVE for ecosystem growth and partnerships.

The LEND → AAVE Migration Contract has remained open for more than half a decade. This proposal closes the LEND chapter and redirects the approximately 302,000 AAVE remaining in the migration contract to the Ecosystem Reserve.

Moving these tokens back to the DAO treasury makes them available for future governance-directed use. A subsequent ARFC will propose distribution of the recovered AAVE for growth and ecosystem incentives.

## Specification

The execution of this proposal marks the deadline for LEND->AAVE migrations and redirects the remaining AAVE to the Aave DAO Ecosystem Reserve.

| Item                        | Action                                                                                                                      |
| --------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| Migration window expiration | Once this Proposal is executed                                                                                              |
| Contract shutdown           | Once this Proposal is executed                                                                                              |
| Asset redirection           | All remaining AAVE inside the migration contract redistributed back to the Aave DAO treasury, through the Ecosystem Reserve |
| Communication               | Service providers run a final communication campaign with the closing date                                                  |

## References

- [LEND to AAVE Migrator on Etherscan](https://etherscan.io/address/0x317625234562b1526ea2fac4030ea499c5291de4)
- [New LendToAaveMigrator Implementation](https://etherscan.io/address/0x2da544ae1ea4e19b680e7a39520c64e5d35c0345#code)
- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/39fc89b6d6d3d983d08ce60b95364db4354f526f/src/20260429_AaveV3Ethereum_LendMigrationShutdown/AaveV3Ethereum_LendMigrationShutdown_20260429.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/39fc89b6d6d3d983d08ce60b95364db4354f526f/src/20260429_AaveV3Ethereum_LendMigrationShutdown/AaveV3Ethereum_LendMigrationShutdown_20260429.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x4d9eb143c46a637dbf98d63ad00a6e53739a9b6affc0eed7d3cd35680500afaa)
- [Discussion](https://governance.aave.com/t/arfc-winding-down-lend-migration-contract/23126)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
