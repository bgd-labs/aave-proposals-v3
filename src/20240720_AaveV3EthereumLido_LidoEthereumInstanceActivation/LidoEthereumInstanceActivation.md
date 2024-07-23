---
title: "Lido Ethereum Instance Activation"
author: "Catapulta @catapulta_sh"
discussions: "https://governance.aave.com/t/arfc-deploy-a-lido-aave-v3-instance/18047"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x9403b7f704ade0d6510591e4846fd85c84b19d134c0814511af914751ecfad5d"
---

## Simple Summary

This AIP proposal activates the Ethereum Lido V3.1 instance, as discussed in [[ARFC] Deploy a Lido Aave v3 Instance](https://governance.aave.com/t/arfc-deploy-a-lido-aave-v3-instance/18047).

## Motivation

Aave and Lido have historically seen symbiotic growth, with stETH being one of the premier collaterals on Aave and leveraged staking being one of the most profitable use cases for both Aave DAO and Lido users.

Lido is in the process of launching the Lido Alliance, which will reward novel use cases of staked ETH and support further growth of the Lido ecosystem. This ARFC proposal suggests that Aave supports Lido Alliance efforts by deploying a new Aave V3 ETH market for Lido. This Aave v3 instance will be designed and tuned to support stETH leverage loopers. The deployment will only include wstETH and wETH assets with E-Mode enabled.

Lido has committed incentive programs and ecosystem support for this instance in order to bootstrap liquidity and promote additional programs within the Lido Alliance.

This instance will be bootstrapped with wETH from the Ahab program to attract wETH liquidity.

wETH suppliers will also be proposed to be eligible to a dedicated Merit Boost

## Specification

The Lido Alliance’s Aave v3 instance implements the following:

The borrow cap of wETH will be set to 90% of supplied wETH, with updates tightly controlled by the risk steward. This will ensure that stETH/wETH loops are consistently profitable and can’t go into negative territory.
E-Mode LTV & LT are set 50 bps above all other Aave implementations, making it the most efficient loop venue in the industry.
For the first 6 months of the Lido Alliance Aave v3, wETH slope1 will be set at 2.50%, ((currently 2.7% on mainnet and on L2s) and wETH RF set at 10% (currently 15% on all markets). This will make it the most profitable venue to loop stETH & wETH.
wstETH RF will be 5%.

The deployment of the Aave V3.1 Lido Ecosystem Aave have been done by Catapulta deployments provider on behalf of the Aave DAO.

The table below illustrates the configured risk parameters for **wstETH**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (wstETH)                |                                    650,000 |
| Borrow Cap (wstETH)                |                                     12,000 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                       80 % |
| LT                                 |                                       81 % |
| Liquidation Bonus                  |                                        6 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                        5 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                      3.5 % |
| Variable Slope 2                   |                                       85 % |
| Uoptimal                           |                                       45 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        0 % |
| Stable Slope2                      |                                        0 % |
| Base Stable Rate Offset            |                                        0 % |
| Stable Rate Excess Offset          |                                        0 % |
| Optimal Stable To Total Debt Ratio |                                        0 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0xB4aB0c94159bc2d8C133946E7241368fc2F2a010 |

,The table below illustrates the configured risk parameters for **WETH**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (WETH)                  |                                    900,000 |
| Borrow Cap (WETH)                  |                                    810,000 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                       82 % |
| LT                                 |                                       83 % |
| Liquidation Bonus                  |                                        5 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       10 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                      2.5 % |
| Variable Slope 2                   |                                       85 % |
| Uoptimal                           |                                       90 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        0 % |
| Stable Slope2                      |                                        0 % |
| Base Stable Rate Offset            |                                        0 % |
| Stable Rate Excess Offset          |                                        0 % |
| Optimal Stable To Total Debt Ratio |                                        0 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419 |

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240720_AaveV3EthereumLido_LidoEthereumInstanceActivation/AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240720_AaveV3EthereumLido_LidoEthereumInstanceActivation/AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x9403b7f704ade0d6510591e4846fd85c84b19d134c0814511af914751ecfad5d)
- [Discussion](https://governance.aave.com/t/arfc-deploy-a-lido-aave-v3-instance/18047)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
