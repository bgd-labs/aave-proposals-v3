---
title: "a.DI ZkSync path activation"
author: "BGD Labs @bgdlabs"
discussions: ""
---

## Simple Summary

This AIP activates the path Ethereum -> ZkSync on a.DI

## Motivation

By activating the path Ethereum -> ZkSync on a.DI, we are enabling Aave Governance to activate and control (in a future AIP) the new
Aave V3 market on ZkSync.

## Specification

The AIP adds the ZkSync adapter on Ethereum, and enables it for communication with ZkSync network with id 324, and pairs it with
the ZkSync adapter on ZkSync network so that messages are sent there.

| Network  | ZkSync Adapter |
| -------- | -------------- |
| Ethereum | []()           |
| ZkSync   | []()           |

The new a.DI deployments on ZkSync network are as follows:

| Contract             | Address |
| -------------------- | ------- |
| CrossChainController | []()    |
| Granular Guardian    | []()    |

The new Aave Governance deployments on ZkSync network are as follows:

| Contract            | Address |
| ------------------- | ------- |
| PayloadsController  | []()    |
| Executor Lvl 1      | []()    |
| Governance Guardian | []()    |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240726_AaveV3Ethereum_ADIZkSyncPathActivation/AaveV3Ethereum_ADIZkSyncPathActivation_20240726.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240726_AaveV3Ethereum_ADIZkSyncPathActivation/AaveV3Ethereum_ADIZkSyncPathActivation_20240726.t.sol)
- [Snapshot](TODO)
- [Discussion](TODO)
- [Tests](TODO)
- [Diffs](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
