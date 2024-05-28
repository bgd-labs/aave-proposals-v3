---
title: "aAMPL Second Distribution"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-aampl-second-distribution/17464"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x372ea60168390ca30be8890ae18ba3c1bb171428ad613a3c8c1a568721c1d65d"
---

## Simple Summary

A proposal for a follow-up distribution of 766'436 aUSDC (762'604 aUSDC + 3'832 aUSDC angle labs fee) from the Aave Collector to allow full withdrawals by aAMPL suppliers to Aave v2 Ethereum, consequence of the problem detected at the end of 2023.

## Motivation

In December 2023, a problem was detected on the AMPL custom reserve on Aave v2 Ethereum, causing an unexpected inflation of AMPL-related balances and supply, not following the intended design by the Ampleforth team.

After further analysis and remediation strategy, the Aave governance approved and executed a proposal on April 17th to provide approximately 300’000 USDC for aAMPL holders to claim. This was designed as an initial and interim distribution, with the sole objective of providing liquidity for users affected as soon as possible. Meanwhile, the service providers of the Aave DAO and the Ampleforth team completed further analysis for a final distribution proposal; this one.

## Specification

To fully understand the problem at hand and the rationale of this distribution, we recommend mandatorily reading its specification on the [forum](https://governance.aave.com/t/ampl-problem-on-aave-v2-ethereum/15886/155), to make an informed decision.

In summary, this proposal recommends making claimable 766'436 aUSDC (762'604 aUSDC + 3'832 aUSDC angle labs fee) from the Aave Ethereum Collector, in addition to the already distributed 300’000 USDC, making a total of approximately $1,066,436.

Some key points output of the analysis are:

- Decisions when doing the analysis have been made to favor aAMPL holders, whenever it was subjective generally, but always trying to maintain objectivity on the expected dynamics of AMPL on Aave.
- Real returns of supplied AMPL on Aave have been recalculated from the freezing period until the expected execution time of the proposal (beginning of May 2024). This approach, compared to calculating from market inception, preserves four times more AMPL for users, maximizing welfare for AMPL suppliers.
- The previous analysis resulted in identifying a claimable amount of 351,579 AMPL as of December 16th, 2023, after rectifying highly evident artificial inflation within the 764,303 aAMPL total supply. As a reference point, debt levels were observed to be at 42,847 AMPL during that period.
- As further compensation for the time passed since December during which funds were not withdrawable, the latest on-chain rate is applicable on the 351’579 AMPL: 256% compounding for more than 4 months, which results in a total of 882’869 AMPL, or $1,057,677.
  Uniform 100% utilization from 16th December 2023 to the beginning of May 2024 is considered, disregarding the underlying rebases of AMPL. This also tries to heavily increase the amount received by aAMPL holders, as once again, debt levels are currently just 72K vAMPL, compared to the much greater compensation amount.
- Pricing claims at $1.198 price per AMPL, despite the price falling below and negative rebases accruing on the aAMPL supply since.
  Any holding by the Aave Collector contract is not included in the compensation, to increase the amount received by other aAMPL holders.
- Interest generated from the 300’000 available on 17th April to withdraw is discounted, as those funds are fully claimable by users.
- The claim for the Mooniswap pool has been proxied with sub-claims for LPs on it.

The Ampleforth team agreed to compensate 40% of the total after proposal execution, as stated on https://governance.aave.com/t/ampl-problem-on-aave-v2-ethereum/15886/128, which will be done after Aave fully approves this distribution.

Regarding the technical details, the proposal will:

- Transfer v3 aUSDC from the collector (766.436k including a 0.5% fee for angle labs)
- Approve the full amount to [0x8BB4C975Ff3c250e0ceEA271728547f3802B36Fd](https://etherscan.io/address/0x8BB4C975Ff3c250e0ceEA271728547f3802B36Fd) which is the distribution creator by Angle Labs
- Create a campaign to distribute funds to the affected users

2 hours after proposal execution, users will be able to claim the aUSDC on https://app.merkl.xyz/

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f54bd5c228fc7789a4ea3f0c5ef77fe70f4be020/src/20240429_AaveV2Ethereum_AAMPLSecondDistribution/AaveV2Ethereum_AAMPLSecondDistribution_20240429.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f54bd5c228fc7789a4ea3f0c5ef77fe70f4be020/src/20240429_AaveV2Ethereum_AAMPLSecondDistribution/AaveV2Ethereum_AAMPLSecondDistribution_20240429.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x372ea60168390ca30be8890ae18ba3c1bb171428ad613a3c8c1a568721c1d65d)
- [Discussion](https://governance.aave.com/t/arfc-aampl-second-distribution/17464)
- [Distribution:IPFS](https://angle-blog.infura-ipfs.io/ipfs/QmTvv4u6MUb6cwThCi7tma1ZJ1XUe9mQmaGcHEmLZhazre)
- [Distribution:formatted](https://github.com/bgd-labs/aave-proposals-v3/blob/f54bd5c228fc7789a4ea3f0c5ef77fe70f4be020/src/20240429_AaveV2Ethereum_AAMPLSecondDistribution/distribution.pdf)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
