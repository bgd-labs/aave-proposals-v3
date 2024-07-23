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

The Lido Alliance’s Aave v3 instance payload implements the following:

- Pre-execution:
  - Sets Ethereum V3 Incentives Controller to manage Ethereum Lido incentives.
  - Register Ethereum Lido instance in Ethereum V3 PoolAddressesProviderRegistry.
- Execution:

  - Add eMode category for ETH correlated assets:
    - LTV: 93.50%
    - LQT: 95.50%
    - LiqBonus: 1%
    - Oracle: Not set
    - Label : 'Eth correlated'
  - Listing of wstETH and WETH tokens.

    The table below illustrates the configured risk parameters for **wstETH** and **WETH** tokens.

| Parameter                          |                                     wstETH |                                       WETH |
| ---------------------------------- | -----------------------------------------: | -----------------------------------------: |
| Isolation Mode                     |                                      false |                                      false |
| Borrowable                         |                                    ENABLED |                                    ENABLED |
| Collateral Enabled                 |                                       true |                                       true |
| Supply Cap (wstETH)                |                                    650,000 |                                    900,000 |
| Borrow Cap (wstETH)                |                                     12,000 |                                    810,000 |
| Debt Ceiling                       |                                      USD 0 |                                      USD 0 |
| LTV                                |                                       80 % |                                       82 % |
| LT                                 |                                       81 % |                                       83 % |
| Liquidation Bonus                  |                                        6 % |                                        5 % |
| Liquidation Protocol Fee           |                                       10 % |                                       10 % |
| Reserve Factor                     |                                        5 % |                                       10 % |
| Base Variable Borrow Rate          |                                        0 % |                                        0 % |
| Variable Slope 1                   |                                      3.5 % |                                      2.5 % |
| Variable Slope 2                   |                                       85 % |                                       85 % |
| Uoptimal                           |                                       45 % |                                       90 % |
| Stable Borrowing                   |                                   DISABLED |                                   DISABLED |
| Stable Slope1                      |                                        0 % |                                        0 % |
| Stable Slope2                      |                                        0 % |                                        0 % |
| Base Stable Rate Offset            |                                        0 % |                                        0 % |
| Stable Rate Excess Offset          |                                        0 % |                                        0 % |
| Optimal Stable To Total Debt Ratio |                                        0 % |                                        0 % |
| Flashloanable                      |                                    ENABLED |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |                                   DISABLED |
| Oracle                             | 0xB4aB0c94159bc2d8C133946E7241368fc2F2a010 | 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419 |

- Post-execution:
  - Set Ethereum PROTOCOL_GUARDIAN as temporary Pool Admin of Ethereum Lido instance.
  - Set Risk Admin to CapsPlusRisk Steward contract, with **ACI** as admin of this steward that can bump caps with a delay of 2 days per cap update.
  - Set **ACI** as emission admin of WETH and aWETH rewards for LM program.
  - Seed initial wstETH and WETH token liquidity for security measures.
  - Send 15.000 GHO as service fee for Catapulta deployment service provider.

## References

- Implementation: [payload](https://github.com/bgd-labs/aave-proposals-v3/blob/cca3d21be3bea0c591ebab6bf48b61234c2fac88/src/20240720_AaveV3EthereumLido_LidoEthereumInstanceActivation/AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720.sol)
- Permissions: [Lido Instances Permissions Table](https://github.com/bgd-labs/aave-permissions-book/blob/23b6085a2c5b9342f0c72d205808e10655489c3c/out/MAINNET-LIDO.md)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/cca3d21be3bea0c591ebab6bf48b61234c2fac88/src/20240720_AaveV3EthereumLido_LidoEthereumInstanceActivation/AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x9403b7f704ade0d6510591e4846fd85c84b19d134c0814511af914751ecfad5d)
- [Discussion](https://governance.aave.com/t/arfc-deploy-a-lido-aave-v3-instance/18047)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
