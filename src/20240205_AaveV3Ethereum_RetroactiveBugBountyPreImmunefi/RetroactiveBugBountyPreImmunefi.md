---
title: "Retroactive Bug Bounty Pre-Immunefi"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-retroactive-bug-bounties-proposal-pre-immunefi/15989"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xb707cff629af03eeaa44bbbb7e38def2907a53791eb16d472dac1d45fb5ec26b"
---

## Simple Summary

Proposal to release a grand total of 86’500 USDC, for bounties pending from before the setup of the Aave <> Immunefi official bug bounty program.

## Motivation

Before the setup of the Aave <> Immunefi bug bounty program on [September 25th 2023](https://governance-v2.aave.com/governance/proposal/325/), security reports by white hats were evaluated in an ad-hoc basis.

Currently, every report is being processed via Immunefi and the rules of the Aave program, however, there were other reports submitted via other channel before that. As these reports should be evaluated at time of submission for fairness, and outside of the Immunefi scope defined afterwards, we think it is a good idea to reward them separately and retro-actively outside the program.

In one of the cases, we had recommended the white hat to submit the report via Immunefi, in order to have access to the mediation procedure of the platform. As this mediation process was finally requested by the white hat, Immunefi charges the corresponding fee of 10% of the amount.

## Specification

This proposal, will release the following funds to white-hat addresses and the Immunefi platform, from the Aave Ethereum Collector:

- $65’000 to `0xFa760444A229e78A50Ca9b3779f4ce4CcE10E170`.

- $15’000 to `0x7dF98A6e1895fd247aD4e75B8EDa59889fa7310b`.

- $6'500 to `0x2BC5fFc5De1a83a9e4cDDfA138bAEd516D70414b` (immunefi.eth). This is the fee corresponding to the 10% of the bounty being paid.

_Note: After checking with a financial contributor to the DAO (TokenLogic & Karpatkey), the asset used for the transfers is aUSDC v2 Ethereum_

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/acb952495e591972e26915668817a0cd0b3b7d05/src/20240205_AaveV3Ethereum_RetroactiveBugBountyPreImmunefi/AaveV3Ethereum_RetroactiveBugBountyPreImmunefi_20240205.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/acb952495e591972e26915668817a0cd0b3b7d05/src/20240205_AaveV3Ethereum_RetroactiveBugBountyPreImmunefi/AaveV3Ethereum_RetroactiveBugBountyPreImmunefi_20240205.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb707cff629af03eeaa44bbbb7e38def2907a53791eb16d472dac1d45fb5ec26b)
- [Discussion](https://governance.aave.com/t/bgd-retroactive-bug-bounties-proposal-pre-immunefi/15989)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
