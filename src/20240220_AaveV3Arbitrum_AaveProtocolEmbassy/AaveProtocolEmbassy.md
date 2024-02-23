---
title: "Aave Protocol Embassy"
author: "karpatkey_TokenLogic_ACI"
discussions: "https://governance.aave.com/t/arfc-establishing-the-aave-protocol-embassy-ape/16445"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xe9da0e50526a98a55aae743f44afc21a86076a12184a6c6c9022aa63dcb0be73"
---

## Simple Summary

Transfer all available ARB on Aave V3 Arbitrum to the Aave Protocol Embassy multi-sig.

## Motivation

The Aave DAO possesses significant voting power in various governance tokens. However, the current structure of the collector contract hinders direct participation in other DAOs' governance. To effectively leverage this power and actively participate in pivotal governance decisions, such as LTIPs on Arbitrum, the creation of APE is essential.

This will allow the Aave DAO to have a meta-governance embassy represented by Aave DAO service providers and significant delegates.

## Specification

The multi-sig address was commented [here](https://governance.aave.com/t/arfc-establishing-the-aave-protocol-embassy-ape/16445/9).

- Transfer all available ARB on the Collector on Arbitrum to SAFE Multi-sig 0xa9e777D56C0Ad861f6a03967E080e767ad8D39b6

## References

- Implementation: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/1b85d9fb8fd2175b49da486fc6db3f8b752349cc/src/20240220_AaveV3Arbitrum_AaveProtocolEmbassy/AaveV3Arbitrum_AaveProtocolEmbassy_20240220.sol)
- Tests: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/1b85d9fb8fd2175b49da486fc6db3f8b752349cc/src/20240220_AaveV3Arbitrum_AaveProtocolEmbassy/AaveV3Arbitrum_AaveProtocolEmbassy_20240220.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xe9da0e50526a98a55aae743f44afc21a86076a12184a6c6c9022aa63dcb0be73)
- [Discussion](https://governance.aave.com/t/arfc-establishing-the-aave-protocol-embassy-ape/16445)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
