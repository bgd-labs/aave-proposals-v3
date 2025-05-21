---
title: "GHO Avalanche Launch"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/arfc-launch-gho-on-avalanche-set-aci-as-emissions-manager-for-rewards/19339"
---

## Simple Summary

This AIP proposes the expansion of GHO, the native asset of the Aave Protocol, to the Avalanche network utilizing the Chainlink Cross-Chain Interoperability Protocol (CCIP).

The smart contracts have been refined through multiple stages of design, development, testing, and implementation. Likewise, Certora, the DAO service provider, was engaged to conduct code reviews of the implementation.

## Motivation

Building on the successful GHO's presence on other networks, it is now time to expand GHO to other networks. The Avalanche ecosystem will bring a new set of opportunities, allowing access to a wide array of integrations with other protocols and tools and ultimately enriching GHO's utility potential.

## Specification

This AIP includes a series of actions required to launch GHO on Avalanche:

1. Configure new Chainlink CCIP lanes between Avalanche and the chains where GHO is launched with a rate limit of ### GHO capacity and ### GHO per second rate. @todo update ### with ChaosLabs input
2. Configure and activate GhoAaveSteward and GhoCcipSteward to control GHO listing and CCIP lane.
3. List GHO as a borrowable asset on the Aave Pool, with the risk configuration specified in the ARFC. Then, initial liquidity will be provided to the pool as a security measure to mitigate potential vulnerabilities and facilitate a stable launch.
4. Set ACI multisig ([0xac140648435d03f784879cd789130F22Ef588Fcd](https://avascan.info/blockchain/all/address/0xac140648435d03f784879cd789130F22Ef588Fcd)) as Emission Admin for GHO and aGHO rewards, as specified in the ARFC.

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
| Variable Slope 1          |                                       12 % |
| Variable Slope 2          |                                       65 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x360d8aa8F6b09B7BC57aF34db2Eb84dD87bf4d12 |

## References

- Implementation: [AaveV3Ethereum](), [AaveV3Arbitrum](), [AaveV3Base](), [AaveV3AvalancheLaunch](), [AaveV3AvalancheListing]()
- Tests: [AaveV3Ethereum](), [AaveV3Arbitrum](), [AaveV3Base](), [AaveV3AvalancheLaunch](), [AaveV3AvalancheListing](), [E2EFlow]()
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x2aed7eb8b03cb3f961cbf790bf2e2e1e449f841a4ad8bdbcdd223bb6ac69e719)
- [Discussion](https://governance.aave.com/t/arfc-launch-gho-on-avalanche-set-aci-as-emissions-manager-for-rewards/19339)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
