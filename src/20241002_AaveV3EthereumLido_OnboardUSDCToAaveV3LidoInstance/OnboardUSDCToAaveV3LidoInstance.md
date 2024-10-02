---
title: "Onboard USDC to Aave V3 Lido Instance"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-onboard-usdc-to-aave-v3-lido-instance/19201"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x6146daa40066e4000333f628f94263101ae03731ccd9a64303013a26172c9eef"
---

## Simple Summary

This proposal aims to onboard USDC to the Aave v3 Lido Instance.

## Motivation

The integration of USDC into the Aave v3 Lido Instance is driven by the following factors:

- Liquidity Enhancement: The inclusion of this widely-used stablecoin is expected to boost liquidity in the Lido Instance, potentially attracting more users and increasing overall platform activity.

- Strategic Alignment: This move aligns with Aave’s goal of offering a comprehensive suite of high-quality assets, keeping the protocol at the forefront of DeFi liquidity.

## Specification

The table below illustrates the configured risk parameters for **USDC**

| Parameter                 |                                                                                                                 Value |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------: |
| Isolation Mode            |                                                                                                                 false |
| Borrowable                |                                                                                                               ENABLED |
| Collateral Enabled        |                                                                                                                 false |
| Supply Cap (USDC)         |                                                                                                            30,000,000 |
| Borrow Cap (USDC)         |                                                                                                            27,600,000 |
| Debt Ceiling              |                                                                                                                 USD 0 |
| LTV                       |                                                                                                                   0 % |
| LT                        |                                                                                                                   0 % |
| Liquidation Bonus         |                                                                                                                   0 % |
| Liquidation Protocol Fee  |                                                                                                                  10 % |
| Reserve Factor            |                                                                                                                  10 % |
| Base Variable Borrow Rate |                                                                                                                   0 % |
| Variable Slope 1          |                                                                                                                 5.5 % |
| Variable Slope 2          |                                                                                                                  60 % |
| Uoptimal                  |                                                                                                                  92 % |
| Stable Borrowing          |                                                                                                              DISABLED |
| Flashloanable             |                                                                                                               ENABLED |
| Siloed Borrowing          |                                                                                                              DISABLED |
| Borrowable in Isolation   |                                                                                                               ENABLED |
| Oracle                    | [0x736bF902680e68989886e9807CD7Db4B3E015d3C](https://etherscan.io/address/0x736bF902680e68989886e9807CD7Db4B3E015d3C) |

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/5e1fb9724df8c6724f88c2fcecb59f1fc2f8b795/src/20241002_AaveV3EthereumLido_OnboardUSDCToAaveV3LidoInstance/AaveV3EthereumLido_OnboardUSDCToAaveV3LidoInstance_20241002.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/5e1fb9724df8c6724f88c2fcecb59f1fc2f8b795/src/20241002_AaveV3EthereumLido_OnboardUSDCToAaveV3LidoInstance/AaveV3EthereumLido_OnboardUSDCToAaveV3LidoInstance_20241002.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x6146daa40066e4000333f628f94263101ae03731ccd9a64303013a26172c9eef)
- [Discussion](https://governance.aave.com/t/arfc-onboard-usdc-to-aave-v3-lido-instance/19201)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
