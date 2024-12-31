---
title: "GHO Base Launch"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/arfc-launch-gho-on-base-set-aci-as-emissions-manager-for-rewards/19338"
---

## Simple Summary

## Motivation

## Specification

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
| Variable Slope 1          |                                       12 % |
| Variable Slope 2          |                                       65 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73 |

Additionaly [0xac140648435d03f784879cd789130F22Ef588Fcd](https://basescan.org/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for GHO and the corresponding aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_GHOBaseLaunch/AaveV3Ethereum_GHOBaseLaunch_20241223.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_GHOBaseLaunch/AaveV3Arbitrum_GHOBaseLaunch_20241223.sol), [AaveV3BaseLaunch](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_GHOBaseLaunch/AaveV3Base_GHOBaseLaunch_20241223.sol), [AaveV3BaseListing](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_GHOBaseLaunch/AaveV3Base_GHOBaseListing_20241223.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_GHOBaseLaunch/AaveV3Ethereum_GHOBaseLaunch_20241223.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_GHOBaseLaunch/AaveV3Arbitrum_GHOBaseLaunch_20241223.t.sol), [AaveV3BaseLaunch](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_GHOBaseLaunch/AaveV3Base_GHOBaseLaunch_20241223.t.sol), [AaveV3BaseListing](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_GHOBaseLaunch/AaveV3Base_GHOBaseListing_20241223.t.sol), [E2EFlow](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_GHOBaseLaunch/AaveV3E2E_GHOBaseLaunch_20241223.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x03dc21e0423c60082dc23317af6ebaf997610cbc2cbb0f5a385653bd99a524fe)
- [Discussion](https://governance.aave.com/t/arfc-launch-gho-on-base-set-aci-as-emissions-manager-for-rewards/19338)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
