---
title: "Remove old VotingPortals from Aave Governance"
author: "BGD Labs @bgdlabs"
discussions: TODO
---

## Simple Summary

Proposal to remove old VotingPortals from the Aave Governance.

## Motivation

As the new VotingPortals have already been proved to be working by having been used for voting on at least 5 new proposals, it is time to remove the old ones, so that there is no confusion or possibility to use the old VotingPortals to vote on new proposals.

## Specification

The payload calls `removeVotingPortals()` on the Aave Governance contract, with the list of old VotingPortals.

VotingPortals to remove:

| Network  | Path       | Address                                                                                                               |
| -------- | ---------- | --------------------------------------------------------------------------------------------------------------------- |
| Ethereum | Eth - Eth  | [0xf23f7De3AC42F22eBDA17e64DC4f51FB66b8E21f](https://etherscan.io/address/0xf23f7De3AC42F22eBDA17e64DC4f51FB66b8E21f) |
| Ethereum | Eth - Avax | [0x33aCEf7365809218485873B7d0d67FeE411B5D79](https://etherscan.io/address/0x33aCEf7365809218485873B7d0d67FeE411B5D79) |
| Ethereum | Eth - Pol  | [0x9b24C168d6A76b5459B1d47071a54962a4df36c3](https://etherscan.io/address/0x9b24C168d6A76b5459B1d47071a54962a4df36c3) |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250405_AaveV3Ethereum_RemoveOldVotingPortalsFromAaveGovernance/AaveV3Ethereum_RemoveOldVotingPortalsFromAaveGovernance_20250405.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250405_AaveV3Ethereum_RemoveOldVotingPortalsFromAaveGovernance/AaveV3Ethereum_RemoveOldVotingPortalsFromAaveGovernance_20250405.t.sol)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
