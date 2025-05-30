---
title: "GHO Gnosis Launch"
author: "kpk"
discussions: "https://governance.aave.com/t/arfc-launch-gho-on-gnosis-chain/21379"
---

## Simple Summary

This AIP proposes the expansion of GHO, the native asset of the Aave Protocol, to the Gnosis Chain network utilizing the Chainlink Cross-Chain Interoperability Protocol (CCIP). This follows the consensus reached in the ARFC phase initiated by kpk.

The necessary smart contracts and configurations have been developed and reviewed to ensure a secure deployment on Gnosis Chain.

## Motivation

Building on GHO's presence on other networks, expanding to Gnosis Chain offers significant advantages. Gnosis is known for its low transaction fees, an engaged community, and a rapidly growing suite of DeFi applications, particularly focused on Real World Assets (RWAs) and innovative payment solutions like Gnosis Pay. This expansion aims to increase GHO's utility, provide the foundation for sGHO deployment on Gnosis, and ultimately enhance Aave's Total Value Locked (TVL) and revenue on this chain.

## Specification

This AIP includes a series of actions required to launch GHO on Gnosis Chain:

1.  Configure new Chainlink CCIP lanes between the chains GHO is listed with a rate limit capacity of \*1,500,000 GHO** and **300 GHO per second\*\* refill rate. An Ethereum-based GHO Facilitator with a specified mint cap of 20M GHO will support this bridge.
2.  Configure and activate GhoAaveSteward and GhoCcipSteward on Gnosis Chain to control GHO listing parameters and the CCIP lane configuration.
3.  List GHO as a borrowable asset on the Aave V3 Gnosis Chain pool, with the risk configuration specified below (derived from the ARFC). Initial liquidity may be provided to the pool as a security measure to facilitate a stable launch.
4.  Set ACI multisig (**`0xac140648435d03f784879cd789130F22Ef588Fcd`**) as Emission Admin for GHO and aGHO rewards on Gnosis Chain, as specified and approved in the ARFC.

The table below illustrates the configured risk parameters for **GHO on Gnosis Chain**:

| Parameter                 | Value                                      |
| :------------------------ | :----------------------------------------- |
| Isolation Mode            | false                                      |
| Borrowable                | ENABLED                                    |
| Collateral Enabled        | false                                      |
| Supply Cap                | 2,500,000                                  |
| Borrow Cap                | 2,250,000                                  |
| Debt Ceiling              | USD 0                                      |
| LTV                       | 0 %                                        |
| LT                        | 0 %                                        |
| Liquidation Bonus         | 0 %                                        |
| Liquidation Protocol Fee  | 0 %                                        |
| Reserve Factor            | 10 %                                       |
| Base Variable Borrow Rate | 0 %                                        |
| Variable Slope 1          | 6.5%                                       |
| Variable Slope 2          | 50 %                                       |
| Uoptimal                  | 90 %                                       |
| Flashloanable             | ENABLED                                    |
| Siloed Borrowing          | DISABLED                                   |
| Borrowable in Isolation   | DISABLED                                   |
| Oracle                    | 0x360d8aa8F6b09B7BC57aF34db2Eb84dD87bf4d12 |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250421_Multi_GHOGnosisLaunch/AaveV3Ethereum_GHOGnosisLaunch_20250421.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250421_Multi_GHOGnosisLaunch/AaveV3Arbitrum_GHOGnosisLaunch_20250421.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250421_Multi_GHOGnosisLaunch/AaveV3Base_GHOGnosisLaunch_20250421.sol), [AaveV3GnosisLaunch](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250421_Multi_GHOGnosisLaunch/AaveV3Gnosis_GHOGnosisLaunch_20250421.sol), [AaveV3GnosisListing](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250421_Multi_GHOGnosisLaunch/AaveV3Gnosis_GHOGnosisListing_20250421.sol)
- Tests:
  [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250421_Multi_GHOGnosisLaunch/AaveV3Ethereum_GHOGnosisLaunch_20250421.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250421_Multi_GHOGnosisLaunch/AaveV3Arbitrum_GHOGnosisLaunch_20250421.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250421_Multi_GHOGnosisLaunch/AaveV3Base_GHOGnosisLaunch_20250421.t.sol), [AaveV3GnosisLaunch](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250421_Multi_GHOGnosisLaunch/AaveV3Gnosis_GHOGnosisLaunch_20250421.t.sol), [AaveV3GnosisListing](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250421_Multi_GHOGnosisLaunch/AaveV3Gnosis_GHOGnosisListing_20250421.t.sol), [E2EFlow](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250421_Multi_GHOGnosisLaunch/AaveV3E2E_GHOGnosisLaunch_20250421.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x62996204d8466d603fe8c953176599db02a23f440a682ff15ba2d0ca63dda386)
- [Discussion](https://governance.aave.com/t/arfc-launch-gho-on-gnosis-chain/21379)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
