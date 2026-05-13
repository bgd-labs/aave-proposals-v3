---
title: "Renew LlamaRisk as Risk Service Provider - Epoch 4"
author: "LlamaRisk"
discussions: "https://governance.aave.com/t/arfc-renew-llamarisk-as-risk-service-provider-epoch-4/24446"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x139144f55e87579003f5f9ed53fc4b87bd0c7312fc9c356e5e4e164baa3f8077"
---

## Simple Summary

## Motivation

## Specification

The payload performs the following actions on Ethereum mainnet:

- Cancel the existing GHO stream (ID `100071`) on `AaveV3EthereumLido.COLLECTOR`.
- Transfer `1,500,000 aEthLidoGHO` from `AaveV3EthereumLido.COLLECTOR` to the LlamaRisk-controlled multisig at `0x9eE16dBDE572886342fc1e2Db8525DEFB007b27c`.
- Create a new `aEthLidoGHO` stream of `1,500,000` over `365 days` to the same recipient, via `CollectorUtils.stream()` on `AaveV3EthereumLido.COLLECTOR`.
- Create a new `AAVE` stream of `5,000` over `365 days` to the same recipient, via `AAVE_ECOSYSTEM_RESERVE_CONTROLLER.createStream()` on `MiscEthereum.ECOSYSTEM_RESERVE`. The stream amount is rounded down to the nearest multiple of the duration to avoid revert in the underlying controller.

## References

- Forum discussion: https://governance.aave.com/t/arfc-renew-llamarisk-as-risk-service-provider-epoch-4/24446
- Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x139144f55e87579003f5f9ed53fc4b87bd0c7312fc9c356e5e4e164baa3f8077

## Disclaimer

LlamaRisk receives compensation from the Aave DAO for serving as a Risk Service Provider, as specified in this proposal.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
