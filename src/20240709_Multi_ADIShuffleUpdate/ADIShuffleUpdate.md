---
title: "ADI Shuffle Update"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-a-di-aave-delivery-infrastructure-v1-1/17838"
---

## Simple Summary

Proposal to update a.DI with the new Shuffle mechanism, included into the v1.1 release presented [HERE](https://governance.aave.com/t/bgd-a-di-aave-delivery-infrastructure-v1-1/17838).

## Motivation

a.DI v1 has one constraint, that even if not major, limits the scalability of the system: whenever a new underlying bridge provider is added to the set of a communication path, each message on that path will be passed through all the bridges, no matter if the consensus required on the recipient side is lower.
For example, currently all messages Ethereum → Polygon are sent via CCIP, LayerZero, Hyperlane, and the Polygon native bridge, even if the consensus required on the Polygon side is 3-of-4. This means that even if consensus was reached already before the slowest bridge delivers the message (Polygon native in this case), the cost incurred is of the whole set of 4 bridges, not only 3.

a.DI v1.1 (and more specifically its Shuffling feature) introduces a mechanism for, whenever a message needs to be sent, the system choosing pseudo-randomly a sub-set of all the available bridges for that specific path (e.g. Ethereum → Polygon) with optimal bandwidth size,
and only forwards the message via those bridges.

By doing this:

- Cost is reduced on all those configurations with optimal bandwidth < bandwidth.
- Any bottleneck to add new underlying bridge providers is removed, as increasing bandwidth doesn’t really have any effect on the optimal bandwidth of the path.
- Security-wise, the pseudo-random nature of the shuffling mechanism improves the system, in the line of other rotation-based systems like validators-selection in PoS blockchains.

## Specification

This proposal upgrades a.DI on every supported network with the new implementation containing the Shuffle mechanism; afterwards, it configures the new parameters required.

The upgrade adds a new `_optimalBandwidthByChain` mapping on CrossChainForwarder that will store the optimal bandwidth for every supported chain. This will be used to determine how many adapters will be used to pass a message to a destination network

The OptimalBandwidth used to update a.DI will be:

| Origin Network | Ethereum | Polygon | Avalanche | Arbitrum | Optimism | Base | Gnosis | Metis | Binance | Scroll |
| -------------- | -------- | ------- | --------- | -------- | -------- | ---- | ------ | ----- | ------- | ------ |
| Ethereum       | -        | 4       | 2         | 1        | 1        | 1    | 2      | 1     | 2       | 1      |
| Polygon        | 3        | -       | -         | -        | -        | -    | -      | -     | -       | -      |
| Avalanche      | 2        | -       | -         | -        | -        | -    | -      | -     | -       | -      |
| Arbitrum       | -        | -       | -         | -        | -        | -    | -      | -     | -       | -      |
| Optimism       | -        | -       | -         | -        | -        | -    | -      | -     | -       | -      |
| Base           | -        | -       | -         | -        | -        | -    | -      | -     | -       | -      |
| Gnosis         | -        | -       | -         | -        | -        | -    | -      | -     | -       | -      |
| Metis          | -        | -       | -         | -        | -        | -    | -      | -     | -       | -      |
| Binance        | -        | -       | -         | -        | -        | -    | -      | -     | -       | -      |
| Scroll         | -        | -       | -         | -        | -        | -    | -      | -     | -       | -      |

The method used to initialize a.DI with the new bandwidth configurations is:

```solidity
function initializeRevision(
  OptimalBandwidthByChain[] memory optimalBandwidthByChain
) external reinitializer(3) {
  _updateOptimalBandwidthByChain(optimalBandwidthByChain);
}
```

The new CrossChainController implementations for every supported network are the following:

| Network   | New CCC implementation with Shuffle support                                                                                      |
| --------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Ethereum  | [0x92f4736b72d131d836b3e4d4c3c23fe53150ce4d](https://etherscan.io/address/0x92f4736b72d131d836b3e4d4c3c23fe53150ce4d)            |
| Polygon   | [0x191f2bd27f1ce4318f9a0c6b82688c66cd7ad3ba](https://polygonscan.com/address/0x191f2bd27f1ce4318f9a0c6b82688c66cd7ad3ba)         |
| Avalanche | [0x23f5150ace7382c7160a2192c3f9f77444f420d9](https://snowscan.xyz/address/0x23f5150ace7382c7160a2192c3f9f77444f420d9)            |
| Arbitrum  | [0x92f4736b72d131d836b3e4d4c3c23fe53150ce4d](https://arbiscan.io/address/0x92f4736b72d131d836b3e4d4c3c23fe53150ce4d)             |
| Optimism  | [0x92f4736b72d131d836b3e4d4c3c23fe53150ce4d](https://optimistic.etherscan.io/address/0x92f4736b72d131d836b3e4d4c3c23fe53150ce4d) |
| Base      | [0x92f4736b72d131d836b3e4d4c3c23fe53150ce4d](https://basescan.org/address/0x92f4736b72d131d836b3e4d4c3c23fe53150ce4d)            |
| Gnosis    | [0x88e9f8e208ba5ae72b56861d63cbf70fd2320f5c](https://gnosisscan.io/address/0x88e9f8e208ba5ae72b56861d63cbf70fd2320f5c)           |
| Metis     | [0x92f4736b72d131d836b3e4d4c3c23fe53150ce4d](https://explorer.metis.io/address/0x92f4736b72d131d836b3e4d4c3c23fe53150ce4d)       |
| Binance   | [0xda81fb369942e43d4797e79f2c4cbef9fe58b90a](https://bscscan.com/address/0xda81fb369942e43d4797e79f2c4cbef9fe58b90a)             |
| Scroll    | [0x92f4736b72d131d836b3e4d4c3c23fe53150ce4d](https://scrollscan.com/address/0x92f4736b72d131d836b3e4d4c3c23fe53150ce4d)          |

## Security

Certora audit report on the Shuffle update can be found [here](https://github.com/bgd-labs/aave-delivery-infrastructure/blob/3c842f4d0a484ea8f574ab31c4a50026e16691ec/security/certora/reports/aDI-Shuffle.pdf)

## References

- Implementation: CrossChainController Shuffle update payloads [implementation](https://github.com/bgd-labs/adi-deploy/blob/e33318258fedc3317949bb9f8c7c57966a3e3197/src/ccc_payloads/shuffle/ShuffleCCCUpdatePayload.sol)
- Tests: CrossChainController Shuffle update [tests](https://github.com/bgd-labs/adi-deploy/blob/e33318258fedc3317949bb9f8c7c57966a3e3197/tests/ccc/shuffle/ShufflePayloadTests.t.sol)
- Diffs: CrossChainController implementation address change [diffs](https://github.com/bgd-labs/adi-deploy/blob/e33318258fedc3317949bb9f8c7c57966a3e3197/diffs)
- [Discussion](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/39)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
