---
title: "ADI Shuffle Update"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-a-di-aave-delivery-infrastructure-v1-1/17838"
---

## Simple Summary

Proposal to update a.DI with the new Shuffle mechanism.

## Motivation

a.DI v1 has one constraint, that even if not major, limits the scalability of the system. Whenever a new underlying bridge
provider is added to the set of a communication path, each message on that path will be passed through all the bridges,
no matter if the consensus required on the recipient side is lower.
For example, currently all messages Ethereum → Polygon are sent via CCIP, LayerZero, Hyperlane, and the Polygon native bridge,
even if the consensus required on the Polygon side is 3-of-4. This means that even if consensus was reached already before
the slowest bridge delivers the message (Polygon native in this case), the cost incurred is of the whole set of 4 bridges, not only 3.
The main consequence of the previous is that adding new providers on existing paths was not really an option whenever others
have shown reliability, as each new provider would add extra cost for each message passed, even if the consensus requirements
would not change: the cost of 3-of-4 would be lower than 3-of-5 and so on.
This is problematic, because the core idea of a.DI is security by consensus, so if properly handled, the most diverse set of bridges,
the better. a.DI Shuffling introduces 2 new concepts in the forwarding side of a.DI:

- <b>Bandwidth</b>: The total number of underlying bridges whitelisted on a.DI for a specific communication path.
  For example, in a path with 4 whitelisted underlying bridges, 4 is its bandwidth.
- <b>Optimal bandwidth</b>: A parameter regulating how many underlying bridges will be used to send a message, always lower
  or equal than bandwidth, and loosely correlated with the threshold on the recipient side of a.DI.
  For example, in a path with 4 whitelisted underlying bridges, and a threshold on the recipient side of 3, the optimal bandwidth
  will be by general rule also 3.

<br></br>
With those concepts defined, the flow of a.DI with Shuffling is simple: whenever a message needs to be sent, the system chooses
pseudo-randomly a sub-set of all the available bridges for that specific path (e.g. Ethereum → Polygon) with optimal bandwidth size,
and only forwards the message via those bridges.

By doing this:

- Cost is reduced on all those configurations with optimal bandwidth < bandwidth.
- Any bottleneck to add new underlying bridge providers is removed, as increasing bandwidth doesn’t really have any effect
  on the optimal bandwidth of the path. Security-wise, the pseudo-random nature of the shuffling mechanism improves the system,
  in the line of other rotation-based systems like validators-selection in PoS blockchains.

## Specification

This proposal upgrades the a.DI on every supported network with the new implementation containing the Shuffle mechanism.

## References

- Implementation: [AaveV3Ethereum](), [AaveV3Polygon](), [AaveV3Avalanche](), [AaveV3Optimism](), [AaveV3Arbitrum](), [AaveV3Metis](), [AaveV3Base](), [AaveV3Gnosis](), [AaveV3Scroll](), [AaveV3BNB]()
- Tests: [AaveV3Ethereum](), [AaveV3Polygon](), [AaveV3Avalanche](), [AaveV3Optimism](), [AaveV3Arbitrum](), [AaveV3Metis](), [AaveV3Base](), [AaveV3Gnosis](), [AaveV3Scroll](), [AaveV3BNB]()
- [Snapshot](TODO)
- [Discussion](https://governance.aave.com/t/bgd-a-di-aave-delivery-infrastructure-v1-1/17838)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
