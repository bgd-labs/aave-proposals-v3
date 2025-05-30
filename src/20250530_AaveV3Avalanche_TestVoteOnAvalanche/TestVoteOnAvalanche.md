---
title: "Test vote on Avalanche"
author: "BGD Labs @bgdlabs"
discussions: TODO
---

## Simple Summary

Simple proposal to test the Aave Governance voting flow on Avalanche network.

## Motivation

As of now, Aave proposals have been only voted on Polygon network, but the Gov V3 system also allows voting on Ethereum and Avalanche networks. With this proposal we
create a simple payload so that the Avalanche voting flow can be tested, and in this way, unlock Avalanche network as a voting chain for the Aave governance.
Increasing in this manner, the Aave Governance voting system redundancy.

## Specification

The proposal will use the Eth -> Avax [Voting Portal](https://etherscan.io/address/0x9Ded9406f088C10621BE628EEFf40c1DF396c172) so that voting will happen on the Avalanche network.

On payload execution the message: `Payload executed correctly` will be emitted.

## References

- Implementation: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250530_AaveV3Avalanche_TestVoteOnAvalanche/AaveV3Avalanche_TestVoteOnAvalanche_20250530.sol)
- Tests: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250530_AaveV3Avalanche_TestVoteOnAvalanche/AaveV3Avalanche_TestVoteOnAvalanche_20250530.t.sol)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
