---
title: "Aave v3.1 Cantina competition"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-bgd-aave-3-1-cantina-competition/17485"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x79de5212e90a562918f72d47809bba5af1221cce4a8cd6dd38b89f38984e90ee"
---

## Simple Summary

Proposal for the Aave DAO to have a [Cantina security competition](https://cantina.xyz/competitions) for the upcoming Aave v3.1 upgrade, to complement the other security procedures already completed.
The budget will be a total of $195’000, with $150’000 prize pool and the rest ($45'000) allocated to platform and judging fees.

## Motivation

With the [Aave v3.1 upgrade](https://governance.aave.com/t/bgd-aave-v3-1-and-aave-origin/17305) well received by the community, and now entering into its final stages of pre-activation governance procedures, from the BGD side we have been thinking on how to add even more security assurances, in addition to what was already done and described [HERE](https://governance.aave.com/t/bgd-aave-v3-1-and-aave-origin/17305#security-16).

Open security competitions/contests are getting important adoption as a good pre-production mechanism: a scope is defined for some public code, and any security researcher can look into it for a limited period of time, in order to the prizes from a common prize pool. The more bugs found (and more unique, amongst other characteristics of the finding), the better the rewards.

We think that a competition can have extra security value for the improvements included into Aave v3.1, and after evaluating different solutions in the market, we have decided that doing an open Cantina competition fits into our requirements.

## Specification

After discussions with their team regarding options, we propose to create a [Cantina competition](<(https://cantina.xyz/competitions)>) with the following characteristics:

- $150’000 total prize pot, with the following limitations:

  - If there is any High (highest grade) finding, the whole $150’000 prize pot will be distributed.
  - If there is only Medium or lower grade findings, $50’000 prize pot will be distributed.
  - If there is only Lower/Informational, $20’000 prize pot will be distributed.

  The total of funds will be transferred initially to Cantina, and if applicable reimburse afterwards to the Aave DAO contracts.

- 20% fees over the total prize pot, amounting $30’000. Additional $15’000 for Cantina judging.

- The competition will last for 10 calendar days, starting on 10th May.

- Before the start, BGD Labs will collaborate with Cantina to have the best possible setup for researchers to tackle the competition, including but not limited to all required extra documentation. During the competition, we will also give all necessary support.

- The execution of the on-chain AIP proposal will act as a binding agreement between the Aave DAO and Cantina. The formal SoW (Scope-of-Work) between the Aave DAO and Cantina can be found [HERE](https://drive.google.com/file/d/1lGBLa9wqOC6Dvuv7jloqEoghNP-7wkb9/view).

- Only current or previous team members of BGD Labs and Certora, MixBytes (auditors of v3.1) during the last 6 months are non-eligible for any prizes in the competition, given the conflict of interest. Any other entity or individual is allowed to participate.

- On the technical aspects, the proposal payload will release 195'000 GHO to the wallet designed by Cantina `0x3Dcb7CFbB431A11CAbb6f7F2296E2354f488Efc2`.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240503_AaveV3Ethereum_AaveV31CantinaCompetition/AaveV3Ethereum_AaveV31CantinaCompetition_20240503.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240503_AaveV3Ethereum_AaveV31CantinaCompetition/AaveV3Ethereum_AaveV31CantinaCompetition_20240503.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x79de5212e90a562918f72d47809bba5af1221cce4a8cd6dd38b89f38984e90ee)
- [Discussion](https://governance.aave.com/t/arfc-bgd-aave-3-1-cantina-competition/17485)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
