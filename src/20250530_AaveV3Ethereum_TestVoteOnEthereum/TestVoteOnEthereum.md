---
title: "Test vote on Ethereum"
author: "BGD Labs @bgdlabs"
discussions: TODO
---

## Simple Summary

Simple proposal to test the Aave Governance voting flow on Ethereum network.

## Motivation

As of now, Aave proposals have been only voted on Polygon network, but the Gov V3 system also allows voting on Ethereum and Avalanche networks. With this proposal we
create a simple payload so that the Ethereum voting flow can be tested, and in this way, unlock Ethereum network as a voting chain for the Aave governance.
Increasing in this manner, the Aave Governance voting system redundancy.

## Specification

The proposal will use the Eth -> Eth [Voting Portal](https://etherscan.io/address/0x6ACe1Bf22D57a33863161bFDC851316Fb0442690) so that voting will happen on the Ethereum network.

On payload execution the message: `Payload executed correctly` will be emitted.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250530_AaveV3Ethereum_TestVoteOnEthereum/AaveV3Ethereum_TestVoteOnEthereum_20250530.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250530_AaveV3Ethereum_TestVoteOnEthereum/AaveV3Ethereum_TestVoteOnEthereum_20250530.t.sol)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
