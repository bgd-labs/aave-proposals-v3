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
3. List GHO as a borrowable asset on the Aave Pool, with the risk configuration specified in the ARFC. Then, initial liquidity will be provided to the pool as a security measure to mitigate potential vulnerabilities and facilitate a stable launch.
4. Set ACI multisig ([0xac140648435d03f784879cd789130F22Ef588Fcd](https://explorer.inkonchain.com/address/0xac140648435d03f784879cd789130F22Ef588Fcd)) as Emission Admin for GHO and aGHO rewards, as specified in the ARFC.

The table below lists the address of the new **Ink** deployments

| Contract         | Address                                                                                                                         |
| :--------------- | :------------------------------------------------------------------------------------------------------------------------------ |
| GhoToken         | [0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73](https://explorer.inkonchain.com/addres/0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73) |
| GhoTokenPool     | [0xDe6539018B095353A40753Dc54C91C68c9487D4E](https://explorer.inkonchain.com/addres/0xDe6539018B095353A40753Dc54C91C68c9487D4E) |
| GhoOracle        | [0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6](https://explorer.inkonchain.com/addres/0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6) |
| GhoBucketSteward | [0xA5Ba213867E175A182a5dd6A9193C6158738105A](https://explorer.inkonchain.com/addres/0xA5Ba213867E175A182a5dd6A9193C6158738105A) |
| GhoCcipSteward   | [0xca7c90A52B44E301AC01Cb5EB99b2fD99339433A](https://explorer.inkonchain.com/addres/0xca7c90A52B44E301AC01Cb5EB99b2fD99339433A) |

The table below illustrates the configured risk parameters for **GHO**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                      false |
| Supply Cap (BLT)          |                                  5,000,000 |
| Borrow Cap (BLT)          |                                  4,500,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                        0 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      5.5 % |
| Variable Slope 2          |                                       50 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6 |

# References

- Implementation: //TODO
- Tests: //TODO
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xf066b8a7b1c0f3d4edff72a047809e3e1f57578d2335fd769e23561a25efb795)
- [Discussion](https://governance.aave.com/t/arfc-launch-gho-on-ink-set-aci-as-emissions-manager-for-rewards/22664)

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
