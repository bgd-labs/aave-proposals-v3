---
title: "GHO Avalanche Launch"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/arfc-launch-gho-on-avalanche-set-aci-as-emissions-manager-for-rewards/19339"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x2aed7eb8b03cb3f961cbf790bf2e2e1e449f841a4ad8bdbcdd223bb6ac69e719"
---

# Simple Summary

This AIP proposes the expansion of GHO, the native asset of the Aave Protocol, to the Avalanche network utilizing the Chainlink Cross-Chain Interoperability Protocol (CCIP).

The smart contracts have been refined through multiple stages of design, development, testing, and implementation. Likewise, Certora, the DAO service provider, was engaged to conduct code reviews of the implementation.

# Motivation

Building on the successful GHO's presence on other networks, it is now time to expand GHO to other networks. The Avalanche ecosystem will bring a new set of opportunities, allowing access to a wide array of integrations with other protocols and tools and ultimately enriching GHO's utility potential.

# Specification

This AIP includes a series of actions required to launch GHO on Avalanche:

1. Configure new Chainlink CCIP lanes between Avalanche and the chains where GHO is launched with a rate limit of 1.5M GHO capacity and 300 GHO per second rate.
2. Configure and activate GhoAaveSteward and GhoCcipSteward to control GHO listing and CCIP lane.
3. List GHO as a borrowable asset on the Aave Pool, with the risk configuration specified in the ARFC. Then, initial liquidity will be provided to the pool as a security measure to mitigate potential vulnerabilities and facilitate a stable launch.
4. Set ACI multisig ([0xac140648435d03f784879cd789130F22Ef588Fcd](https://avascan.info/blockchain/all/address/0xac140648435d03f784879cd789130F22Ef588Fcd)) as Emission Admin for GHO and aGHO rewards, as specified in the ARFC.

The table below lists the address of the new **Avalanche** deployments

| Contract         | Address                                                                                                                              |
| :--------------- | :----------------------------------------------------------------------------------------------------------------------------------- |
| GhoToken         | [0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73](https://avascan.info/blockchain/all/address/0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73) |
| GhoTokenPool     | [0xDe6539018B095353A40753Dc54C91C68c9487D4E](https://avascan.info/blockchain/all/address/0xDe6539018B095353A40753Dc54C91C68c9487D4E) |
| GhoOracle        | [0x360d8aa8F6b09B7BC57aF34db2Eb84dD87bf4d12](https://avascan.info/blockchain/all/address/0x360d8aa8F6b09B7BC57aF34db2Eb84dD87bf4d12) |
| GhoAaveSteward   | [0xA5Ba213867E175A182a5dd6A9193C6158738105A](https://avascan.info/blockchain/all/address/0xA5Ba213867E175A182a5dd6A9193C6158738105A) |
| GhoBucketSteward | [0x2Ce400703dAcc37b7edFA99D228b8E70a4d3831B](https://avascan.info/blockchain/all/address/0x2Ce400703dAcc37b7edFA99D228b8E70a4d3831B) |
| GhoCcipSteward   | [0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6](https://avascan.info/blockchain/all/address/0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6) |

The table below illustrates the configured risk parameters for **GHO**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                      false |
| Supply Cap (BLT)          |                                 10,000,000 |
| Borrow Cap (BLT)          |                                  9,000,000 |
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
| Oracle                    | 0x360d8aa8F6b09B7BC57aF34db2Eb84dD87bf4d12 |

# References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/7c57d7f5843f1d07af9f463a4e12768a00c112fa/src/20250519_Multi_GHOAvalancheLaunch/AaveV3Ethereum_GHOAvalancheLaunch_20250519.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/7c57d7f5843f1d07af9f463a4e12768a00c112fa/src/20250519_Multi_GHOAvalancheLaunch/AaveV3Arbitrum_GHOAvalancheLaunch_20250519.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/7c57d7f5843f1d07af9f463a4e12768a00c112fa/src/20250519_Multi_GHOAvalancheLaunch/AaveV3Base_GHOAvalancheLaunch_20250519.sol), [AaveV3AvalancheLaunch](https://github.com/bgd-labs/aave-proposals-v3/blob/7c57d7f5843f1d07af9f463a4e12768a00c112fa/src/20250519_Multi_GHOAvalancheLaunch/AaveV3Avalanche_GHOAvalancheLaunch_20250519.sol), [AaveV3AvalancheListing](https://github.com/bgd-labs/aave-proposals-v3/blob/7c57d7f5843f1d07af9f463a4e12768a00c112fa/src/20250519_Multi_GHOAvalancheLaunch/AaveV3Avalanche_GHOAvalancheListing_20250519.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/7c57d7f5843f1d07af9f463a4e12768a00c112fa/src/20250519_Multi_GHOAvalancheLaunch/AaveV3Ethereum_GHOAvalancheLaunch_20250519.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/7c57d7f5843f1d07af9f463a4e12768a00c112fa/src/20250519_Multi_GHOAvalancheLaunch/AaveV3Arbitrum_GHOAvalancheLaunch_20250519.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/7c57d7f5843f1d07af9f463a4e12768a00c112fa/src/20250519_Multi_GHOAvalancheLaunch/AaveV3Base_GHOAvalancheLaunch_20250519.t.sol), [AaveV3AvalancheLaunch](https://github.com/bgd-labs/aave-proposals-v3/blob/7c57d7f5843f1d07af9f463a4e12768a00c112fa/src/20250519_Multi_GHOAvalancheLaunch/AaveV3Avalanche_GHOAvalancheLaunch_20250519.t.sol), [AaveV3AvalancheListing](https://github.com/bgd-labs/aave-proposals-v3/blob/7c57d7f5843f1d07af9f463a4e12768a00c112fa/src/20250519_Multi_GHOAvalancheLaunch/AaveV3Avalanche_GHOAvalancheListing_20250519.t.sol), [E2EFlow](https://github.com/bgd-labs/aave-proposals-v3/blob/7c57d7f5843f1d07af9f463a4e12768a00c112fa/src/20250519_Multi_GHOAvalancheLaunch/AaveV3E2E_GHOAvalancheLaunch_20250519.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x2aed7eb8b03cb3f961cbf790bf2e2e1e449f841a4ad8bdbcdd223bb6ac69e719)
- [Discussion](https://governance.aave.com/t/arfc-launch-gho-on-avalanche-set-aci-as-emissions-manager-for-rewards/19339)

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
