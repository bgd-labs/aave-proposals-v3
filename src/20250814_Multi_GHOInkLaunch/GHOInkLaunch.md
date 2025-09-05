---
title: "GHO Ink Launch"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/arfc-launch-gho-on-ink-set-aci-as-emissions-manager-for-rewards/22664"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xf066b8a7b1c0f3d4edff72a047809e3e1f57578d2335fd769e23561a25efb795"
---

# Simple Summary

This AIP proposes the expansion of GHO, the native asset of the Aave Protocol, to the Ink network utilizing the Chainlink Cross-Chain Interoperability Protocol (CCIP).

The smart contracts have been refined through multiple stages of design, development, testing, and implementation. Likewise, Certora, the DAO service provider, was engaged to conduct code reviews of the implementation.

# Motivation

Building on the successful GHO's presence on other networks, it is now time to expand GHO to other networks. The Ink ecosystem will bring a new set of opportunities, allowing access to a wide array of integrations with other protocols and tools and ultimately enriching GHO's utility potential.

# Specification

This AIP includes a series of actions required to launch GHO on Ink:

1. Configure new Chainlink CCIP lanes between Ink and the chains where GHO is launched with a rate limit of 1.5M GHO capacity and 300 GHO per second rate.
2. Configure GhoCcipSteward.

The table below lists the address of the new **Ink** deployments

| Contract         | Address                                                                                                                         |
| :--------------- | :------------------------------------------------------------------------------------------------------------------------------ |
| GhoToken         | [0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73](https://explorer.inkonchain.com/addres/0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73) |
| GhoTokenPool     | [0xDe6539018B095353A40753Dc54C91C68c9487D4E](https://explorer.inkonchain.com/addres/0xDe6539018B095353A40753Dc54C91C68c9487D4E) |
| GhoOracle        | [0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6](https://explorer.inkonchain.com/addres/0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6) |
| GhoBucketSteward | [0xA5Ba213867E175A182a5dd6A9193C6158738105A](https://explorer.inkonchain.com/addres/0xA5Ba213867E175A182a5dd6A9193C6158738105A) |
| GhoCcipSteward   | [0x2Ce400703dAcc37b7edFA99D228b8E70a4d3831B](https://explorer.inkonchain.com/addres/0x2Ce400703dAcc37b7edFA99D228b8E70a4d3831B) |

# References

- Implementation: //TODO
- Tests: //TODO
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xf066b8a7b1c0f3d4edff72a047809e3e1f57578d2335fd769e23561a25efb795)
- [Discussion](https://governance.aave.com/t/arfc-launch-gho-on-ink-set-aci-as-emissions-manager-for-rewards/22664)

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
