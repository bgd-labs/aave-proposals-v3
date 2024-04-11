---
title: "Interim aAMPL distribution"
author: "BGD Labs"
discussions: "https://governance.aave.com/t/arfc-aampl-interim-distribution/17184"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xb7226dd6441b67225924082215f7a512bfd98252897ee43a879084e07ab53607"
---

## Simple Summary

Distribute 300.000 USDC to users affected by aAMPL problem.

## Motivation

On December 2023, a problem was detected on the AMPL custom reserve on Aave v2 Ethereum, causing an unexpected inflation of AMPL-related balances and supply, not following the intended design by the Ampleforth team.

While further analysis is performed for the most reasonable strategy on giving withdrawal liquidity for aAMPL supplies, an interim distribution of 300’000 USD value is proposed as lower threshold, to allow aAMPL suppliers to proceed partially with their withdrawals.

With [aip 72](https://vote.onaave.com/proposal/?proposalId=72&ipfsHash=0xaa46d2cf629d68cc84bcc83156b2fd8e54819c5e848c229c7e62d1f6212886cc) having passed the governance process, aAMPL transfers are no longer permitted, which allows to snapshot the current aAMPL balances to perform a fair distribution between affected users.

## Specification

The distribution will be done via the [Merkl](https://app.merkl.xyz/) platform by Angle Labs, specialised on these operations and used before in other Aave DAO proposals, like the Merit program.

Users with a balance below 30$ will be excluded from this initial distribution as the gas-cost for claiming would not offset set amount claimed.

Therefore the proposal will perform the following steps upon execution:

- withdraw USDC from the collector (298.5k including a 0.5% fee for angle labs)
- approve the full amount to [0x8BB4C975Ff3c250e0ceEA271728547f3802B36Fd](https://etherscan.io/address/0x8BB4C975Ff3c250e0ceEA271728547f3802B36Fd) which is the distribution creator by Angle Labs
- sign the tos of https://app.merkl.xyz/ via a onchain transaction
- create a campaign to distribute funds to the affected users

2 hours after proposal execution, users will be able to claim the USDC on https://app.merkl.xyz/

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240409_AaveV2Ethereum_InterimAAMPLDistribution/AaveV2Ethereum_InterimAAMPLDistribution_20240409.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240409_AaveV2Ethereum_InterimAAMPLDistribution/AaveV2Ethereum_InterimAAMPLDistribution_20240409.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb7226dd6441b67225924082215f7a512bfd98252897ee43a879084e07ab53607)
- [Discussion](https://governance.aave.com/t/arfc-aampl-interim-distribution/17184)
- [Distribution:IPFS](https://angle-blog.infura-ipfs.io/ipfs/Qmb9uJbEdppQsL8W4aVKxREoHo42iXtcp4CV1FLE5tY8Rt)
- [Distribution:formatted](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240409_AaveV2Ethereum_InterimAAMPLDistribution/distribution.pdf)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
