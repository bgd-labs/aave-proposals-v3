---
title: "Removal of legacy VotingPortals from Governance v3"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/77"
---

## Simple Summary

Proposal to remove the deprecated `VotingPortals` from the Aave Governance.

## Motivation

[Proposal 273](https://vote.onaave.com/proposal/?proposalId=273) enabled new VotingPortal contracts on the Aave Governance, but without removing the previous ones to be sure no issues during the transition would happen.

As the new `VotingPortals` have already been proven to be working by using them for voting on at least 4 new proposals (279 - 282), it is time to remove the old ones, so that there is no confusion or possibility of using the old `VotingPortals` on new proposals.

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
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/77)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
