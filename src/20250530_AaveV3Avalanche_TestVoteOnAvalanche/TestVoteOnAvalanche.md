---
title: "Fire drill proposal Avalanche VotingMachine"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/92"
---

## Simple Summary

Do a fire drill voting flow with a mock governance proposal using Avalanche as the voting network instead of Polygon as usual, to test that all peripheral systems are properly functioning.

## Motivation

Following the same rationale as [the previous proposed fire drill using Ethereum as voting network](https://governance.aave.com/t/technical-maintenance-proposals/15274/91), we think it is beneficial to do the same with Avalanche, the other available network in production, but that has never been used, given that Polygon has worked properly.

## Specification

The governance proposal will be created using the [Ethereum → Avalanche Voting Portal](https://etherscan.io/address/0x9Ded9406f088C10621BE628EEFf40c1DF396c172) so that voting will happen on the Avalanche network.

The payload executed will just contain an empty `execute()` function, as the purpose of this fire drill is testing the full flow, and not any execution content.

## References

- Implementation: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250530_AaveV3Avalanche_TestVoteOnAvalanche/AaveV3Avalanche_TestVoteOnAvalanche_20250530.sol)
- Tests: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250530_AaveV3Avalanche_TestVoteOnAvalanche/AaveV3Avalanche_TestVoteOnAvalanche_20250530.t.sol)
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/92)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
