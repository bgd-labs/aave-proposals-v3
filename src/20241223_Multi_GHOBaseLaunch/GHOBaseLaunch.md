---
title: "GHO Base Launch"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/arfc-launch-gho-on-base-set-aci-as-emissions-manager-for-rewards/19338"
---

## Simple Summary

This AIP proposes the expansion of GHO, the native asset of the Aave Protocol, to the Base network utilizing the Chainlink Cross-Chain Interoperability Protocol (CCIP) v1.5.1.

The smart contracts have been refined through multiple stages of design, development, testing, and implementation. Likewise, Certora, the DAO service provider, was engaged to conduct code reviews of the implementation.

## Motivation

Building on the successful expansion of GHO into Arbitrum, it is now time to expand GHO to other networks. The Base ecosystem will bring a new set of opportunities, allowing access to a wide array of integrations with other protocols and tools and ultimately enriching GHO's utility potential.

## Specification

This AIP includes a series of actions required to launch GHO on Base:

1. Configure new Chainlink CCIP lanes between Base and Ethereum/Arbitrum (while retaining existing ones) with a rate limit of 300,000 GHO capacity and 60 GHO per second rate.
2. Update the proxy admin of GHO token on Arbitrum to OpenZeppelin v5.1 Proxy Contract, enabling GHO on Arbitrum to be aligned with Base deployment.
3. Configure and activate GhoAaveSteward and GhoCcipSteward to control GHO listing and CCIP lane.
4. List GHO as a borrowable asset on the Aave Pool, with the risk configuration specified in the ARFC. Then, initial liquidity will be provided to the pool as a security measure to mitigate potential vulnerabilities and facilitate a stable launch.
5. Set ACI multisig ([0xac140648435d03f784879cd789130F22Ef588Fcd](https://basescan.org/address/0xac140648435d03f784879cd789130F22Ef588Fcd)) as Emission Admin for GHO and aGHO rewards, as specified in the ARFC.

The table below illustrates the configured risk parameters for **GHO**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                      false |
| Supply Cap (BLT)          |                                  2,500,000 |
| Borrow Cap (BLT)          |                                  2,250,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                        0 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      9.5 % |
| Variable Slope 2          |                                       50 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73 |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_GHOBaseLaunch/AaveV3Ethereum_GHOBaseLaunch_20241223.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_GHOBaseLaunch/AaveV3Arbitrum_GHOBaseLaunch_20241223.sol), [AaveV3BaseLaunch](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_GHOBaseLaunch/AaveV3Base_GHOBaseLaunch_20241223.sol), [AaveV3BaseListing](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_GHOBaseLaunch/AaveV3Base_GHOBaseListing_20241223.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_GHOBaseLaunch/AaveV3Ethereum_GHOBaseLaunch_20241223.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_GHOBaseLaunch/AaveV3Arbitrum_GHOBaseLaunch_20241223.t.sol), [AaveV3BaseLaunch](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_GHOBaseLaunch/AaveV3Base_GHOBaseLaunch_20241223.t.sol), [AaveV3BaseListing](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_GHOBaseLaunch/AaveV3Base_GHOBaseListing_20241223.t.sol), [E2EFlow](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_GHOBaseLaunch/AaveV3E2E_GHOBaseLaunch_20241223.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x03dc21e0423c60082dc23317af6ebaf997610cbc2cbb0f5a385653bd99a524fe)
- [Discussion](https://governance.aave.com/t/arfc-launch-gho-on-base-set-aci-as-emissions-manager-for-rewards/19338)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
