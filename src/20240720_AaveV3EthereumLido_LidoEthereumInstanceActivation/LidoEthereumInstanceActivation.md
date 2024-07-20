---
title: "Lido Ethereum Instance Activation"
author: "Catapulta @catapulta_sh"
discussions: "https://governance.aave.com/t/arfc-deploy-a-lido-aave-v3-instance/18047"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x9403b7f704ade0d6510591e4846fd85c84b19d134c0814511af914751ecfad5d"
---

## Simple Summary

## Motivation

## Specification

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
