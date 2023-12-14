---
title: "Request for Bounty Payout - December 2023"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-request-for-bounty-payout-december-2023/15826"
---

## Simple Summary

Proposal to release a grand total of 23’600 DAI, for periodic Aave <> Immunefi bounty payouts and Immunefi fee.

## Motivation

As disclosed in [this post](https://governance.aave.com/t/bgd-aave-immunefi-request-for-bounty-payouts/15751), we think it is appropriate to split bug bounty payouts from disclosure and fix stages, for Low, Medium and High reports.
The objectives are not creating unnecessary interdependencies, and keep a healthy and frequent payment schedule for white-hats participating securing Aave.

## Specification

This proposal, will release the following funds to white-hat addresses and the Immunefi platform, from the Aave Ethereum Collector:

- $1’000 to `0x2af2144429a7eAe5fB3999B2059f246ffab6c90A`

- $10’000 to `0xEb8b275F05423566C95AbCCdD92d860B758cF08a`

- $10’000 to `0x6248E2481c3d80C05F49a185D9BAEE515f0E7F2C`

- $2’600 to `0x2BC5fFc5De1a83a9e4cDDfA138bAEd516D70414b` (immunefi.eth). This amount is slightly above the expected $2’100 (10% of bounties), because an extra pending bounty of $5’000 will be paid in January, while the Immunefi component should be included now.

After checking with a financial contributor to the DAO (TokenLogic & Karpatkey), _the asset used for the transfers is aDAI v3 Ethereum_.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231213_AaveV3Ethereum_RequestForBountyPayoutDecember2023/AaveV3Ethereum_RequestForBountyPayoutDecember2023_20231213.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231213_AaveV3Ethereum_RequestForBountyPayoutDecember2023/AaveV3Ethereum_RequestForBountyPayoutDecember2023_20231213.t.sol)
- Snapshot: N/A
- [Discussion](https://governance.aave.com/t/bgd-request-for-bounty-payout-december-2023/15826)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
