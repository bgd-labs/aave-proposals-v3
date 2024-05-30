---
title: "Orbit Program Renewal"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-orbit-program-renewal-may-2024/17683"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x4a10e2a8ca95024d7cf0791aa82ed262c816ff0ee78bc2f3ab3487e70d731361"
---

## Simple Summary

Proposing the renewal of the Orbit program for recognized delegates, compensating them with GHO and ETH reimbursement of Gas costs associated with their governance activity.

## Motivation

Orbit recognizes the added value of the Delegates in the decentralization & diversity of the Aave DAO. This compensation allows them to focus on aave and keep their contribution efforts to our governance. The ACI proposes the extension of Orbit for a new quarter.

With the transition to Governance V3, a significant feature introduced is gasless voting via Gelato integration on the [DAO-run governance app](https://vote.onaave.com), making it easier for delegates to participate without the burden of gas costs. This innovation prompts the proposal to discontinue the general gas rebate program. However, recognizing the continued necessity for proposal creation and payload deployment activities, we propose maintaining targeted gas rebates for these specific actions.

## Specification

- **Period Coverage:** Blocks 19162697 (5th Feb 2024) to Block 19860031 (May 13th 2024)
- **Eligible Platforms:**
  - EzR3al
  - Stable Labs
  - Saucy Block
  - Areta
- **Gas Rebate:** Since this period is entirely covered by Governance V3, the Orbit program does not reimburse delegate vote gas as their vote is now subsidized by Gelato. We will continue to reimburse Service Providers for their Governance-related activity:
  - ACI : 2.74 ETH
  - TokenLogic : 0.641 ETH
- **Budget:** 60000 GHO and 3.381 ETH
- **Relevant Links:**

  - [Script output ](https://aavechan.notion.site/Gov-V3-May-2024-Script-Output-af8acc9d53874444b9a576e2329da28a)

- [ACI’s Orbit tracker ](https://apps.aavechan.com/orbit-tracker)

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240513_AaveV3Ethereum_OrbitProgramRenewal/AaveV3Ethereum_OrbitProgramRenewal_20240513.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240513_AaveV3Ethereum_OrbitProgramRenewal/AaveV3Ethereum_OrbitProgramRenewal_20240513.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x4a10e2a8ca95024d7cf0791aa82ed262c816ff0ee78bc2f3ab3487e70d731361)
- [Discussion](https://governance.aave.com/t/arfc-orbit-program-renewal-may-2024/17683)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
