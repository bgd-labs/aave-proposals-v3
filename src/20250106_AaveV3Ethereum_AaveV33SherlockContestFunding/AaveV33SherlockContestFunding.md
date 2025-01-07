---
title: "Aave v3.3 Sherlock contest funding"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-bgd-aave-v3-3-sherlock-contest/20498"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0x8c04404012d9b74c3e7cebff2ddff3c9d40a280b4cfa7c2fca42be2a59b005ee"
---

## Simple Summary

Proposal for the Aave DAO to host a Sherlock contest for the upcoming [Aave v3.3 upgrade](https://github.com/aave-dao/aave-v3-origin/pull/87), to complement the other security procedures already completed or in progress.

The total budget will be $230'000, with a $195'000 fixed prize pool and the rest ($35,000) allocated to the platform and judging fees.

## Motivation

In the middle of December 2024, we shared with the community a proposal for an Aave v3.3 upgrade, focused on adapting the protocol for the upcoming Umbrella system (a new iteration of the Aave Safety Module), together with doing different improvements mainly on the liquidation engine.

The reception by the community has been positive, and since then we have been doing internal reviews and different security procedures. In addition to those, and similar to how we proposed back in [Aave v3.1 with Cantina](https://governance.aave.com/t/arfc-bgd-aave-3-1-cantina-competition/17485), we think due to the nature of this upgrade it can be pretty positive to have an open security contest to maximize the numbers of experts looking for any type of problem in the codebase.

Even if the experience and [outcome](https://github.com/aave-dao/aave-v3-origin/blob/main/audits/02-06-2024-Cantina-contest-AaveV3.1.pdf) with Cantina was pretty positive, part of our security approach is to try different providers, whenever they look solid quality-wise, and/or introduce new mechanics, like in the case of Sherlock.

## Specification

The high-level structure of the contest can be found on the Aave governance forum [HERE](https://governance.aave.com/t/arfc-bgd-aave-v3-3-sherlock-contest/20498#p-51858-specification-3).

This proposal releases the budget required for the contest from the Aave Collector:

- 30'000 USDC to BGD Labs, to refund the part advanced to Sherlock post-ARFC (transaction [HERE](https://etherscan.io/tx/0x396995576313b6578dad47d0ef7ab454b9840c246262bb812a078a092158b058)).
- 200'000 USDC to Sherlock, to cover the rest of the contest budget.

| **Entity** | **Recipient Address**                      | **Value**    |
| ---------- | ------------------------------------------ | ------------ |
| BGD Labs   | 0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF | 30'000 USDC  |
| Sherlock   | 0x666B8EbFbF4D5f0CE56962a25635CfF563F13161 | 200'000 USDC |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250106_AaveV3Ethereum_AaveV33SherlockContestFunding/AaveV3Ethereum_AaveV33SherlockContestFunding_20250106.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250106_AaveV3Ethereum_AaveV33SherlockContestFunding/AaveV3Ethereum_AaveV33SherlockContestFunding_20250106.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x8c04404012d9b74c3e7cebff2ddff3c9d40a280b4cfa7c2fca42be2a59b005ee)
- [Discussion](https://governance.aave.com/t/arfc-bgd-aave-v3-3-sherlock-contest/20498)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
