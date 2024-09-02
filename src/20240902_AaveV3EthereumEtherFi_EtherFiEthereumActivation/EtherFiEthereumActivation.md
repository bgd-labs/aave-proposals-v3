---
title: "EtherFi Ethereum Activation"
author: "Catapulta"
discussions: "https://governance.aave.com/t/arfc-deploy-an-etherfi-stablecoin-aave-v3-instance/18440"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x4acd11c6100a6b85a553e21359f3720fa5cd4783a76c77857436ace134f88c05"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **weETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (weETH)        |                                     50,000 |
| Borrow Cap (weETH)        |                                          0 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       78 % |
| LT                        |                                       81 % |
| Liquidation Bonus         |                                        6 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                        0 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        0 % |
| Variable Slope 2          |                                        0 % |
| Uoptimal                  |                                        0 % |
| Stable Borrowing          |                                   DISABLED |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xf112aF6F0A332B815fbEf3Ff932c057E570b62d3 |

,The table below illustrates the configured risk parameters for **USDC**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (USDC)         |                                140,000,000 |
| Borrow Cap (USDC)         |                                135,000,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                        0 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      6.5 % |
| Variable Slope 2          |                                       60 % |
| Uoptimal                  |                                       90 % |
| Stable Borrowing          |                                   DISABLED |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x736bF902680e68989886e9807CD7Db4B3E015d3C |

,The table below illustrates the configured risk parameters for **PYUSD**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (PYUSD)        |                                 60,000,000 |
| Borrow Cap (PYUSD)        |                                 15,000,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      5.5 % |
| Variable Slope 2          |                                       80 % |
| Uoptimal                  |                                       90 % |
| Stable Borrowing          |                                   DISABLED |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x150bAe7Ce224555D39AfdBc6Cb4B8204E594E022 |

,The table below illustrates the configured risk parameters for **FRAX**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (FRAX)         |                                 54,000,000 |
| Borrow Cap (FRAX)         |                                 12,000,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      5.5 % |
| Variable Slope 2          |                                       80 % |
| Uoptimal                  |                                       90 % |
| Stable Borrowing          |                                   DISABLED |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x45D270263BBee500CF8adcf2AbC0aC227097b036 |

## References

- Implementation: [AaveV3EthereumEtherFi](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240902_AaveV3EthereumEtherFi_EtherFiEthereumActivation/AaveV3EthereumEtherFi_EtherFiEthereumActivation_20240902.sol)
- Tests: [AaveV3EthereumEtherFi](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240902_AaveV3EthereumEtherFi_EtherFiEthereumActivation/AaveV3EthereumEtherFi_EtherFiEthereumActivation_20240902.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x4acd11c6100a6b85a553e21359f3720fa5cd4783a76c77857436ace134f88c05)
- [Discussion](https://governance.aave.com/t/arfc-deploy-an-etherfi-stablecoin-aave-v3-instance/18440)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
