---
title: "Fire drill proposal Ethereum VotingMachine"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/91"
---

## Simple Summary

Do a fire drill voting flow with a mock governance proposal using Ethereum as the voting network instead of Polygon as usual, to test that all peripheral systems are properly functioning.

## Motivation

One of the design principles of the currently running Aave Governance v3 system is to inherit Ethereum’s security at its core, delegating the voting stage to more cost-efficient networks (currently Polygon PoS and Avalanche C-Chain), while avoiding full dependency on them.

Partially, this is achieved by replicating the same voting infrastructure on Ethereum itself: if, for any reason, all the more optimal voting networks would not be operative, a governance proposal can still be created and voted on (even if more expensive) directly on Ethereum itself.

Given that this flow is only to be used in some very edge emergency scenario, we think it is healthy to make a fire drill: creating a proposal executing a payload without any meaningful content, but using the Ethereum voting infrastructure.

## Specification

The governance proposal will be created using the [Ethereum → Ethereum Voting Portal](https://etherscan.io/address/0x6ACe1Bf22D57a33863161bFDC851316Fb0442690) so that voting will happen on the Ethereum network.

The payload executed will just contain an empty execute() function, as the purpose of this fire drill is testing the full flow, and not any execution content.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/12b567e8939bbd8297d73225fae9b5a6a4e0d5ec/src/20250530_AaveV3Ethereum_TestVoteOnEthereum/AaveV3Ethereum_TestVoteOnEthereum_20250530.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/12b567e8939bbd8297d73225fae9b5a6a4e0d5ec/src/20250530_AaveV3Ethereum_TestVoteOnEthereum/AaveV3Ethereum_TestVoteOnEthereum_20250530.t.sol)
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/91)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
