---
title: "Aave V3.3 Soneium Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-deploy-aave-on-soneium/21204/9"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xb996bda7e60f85de7f6f2d9f7f6c15ddddfbd871465d8f00b846f8ab014a5953"
---

## Simple Summary

This proposal allows the Aave governance to activate the Aave V3 Soneium pool (3.3) by completing all the initial setup and listing USDC, USDT, WETH as suggested by the risk service providers engaged with the DAO on the governance forum.

All the Aave Soneium V3 addresses can be found in the [aave-address-book](https://github.com/bgd-labs/aave-address-book/blob/18ac617a151d271c9c41d3565c8e4422d1fc6e18/src/AaveV3Soneium.sol).

## Motivation

All the governance procedures for the expansion of Aave v3 to Soneium have been finished, said:

- Positive signaling and approval regarding the expansion on the [governance forum](https://governance.aave.com/t/arfc-deploy-aave-on-soneium/21204), and [snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xb996bda7e60f85de7f6f2d9f7f6c15ddddfbd871465d8f00b846f8ab014a5953).
- Positive technical evaluation done by BGD Labs of the Soneium network, as described in the [forum](https://governance.aave.com/t/bgd-aave-soneium-infrastructure-technical-evaluation/21968) in detail.
- Positive risk analysis and assets/parameters recommendation by the risk service providers.

## Specification

The proposal will do the following:

- List the following assets on Aave V3 Soneium: USDC, USDT, WETH.
- Set the risk steward as the risk admin by executing `ACL_MANAGER.addRiskAdmin()`.
- Set the guardian address as the pool admin by executing `ACL_MANAGER.addPoolAdmin()`. This is following the standard procedure of keeping pool admin on the Aave Guardian during the bootstrap period, for security.
- Set ACI [multi-sig](https://soneium.blockscout.com/address/0xac140648435d03f784879cd789130F22Ef588Fcd) as liquidity mining admin for all aTokens and underlying tokens by calling `EMISSION_MANAGER.setEmissionAdmin()` method.

The table below illustrates the configured risk parameters for the assets to be listed:

The table below illustrates the configured risk parameters for **USDCe**

| Parameter                        |                                    [USDC](https://soneium.blockscout.com/address/0xbA9986D2381edf1DA03B0B9c1f8b00dc4AacC369) |               [USDT](https://soneium.blockscout.com/address/0x3A337a6adA9d885b6Ad95ec48F9b75f197b5AE35) |              [WETH](https://soneium.blockscout.com/address/0x4200000000000000000000000000000000000006) |
| -------------------------------- | ---------------------------------------------------------------------------------------------------------------------------: | ------------------------------------------------------------------------------------------------------: | -----------------------------------------------------------------------------------------------------: |
| Isolation Mode                   |                                                                                                                        false |                                                                                                   false |                                                                                                  false |
| Borrowable                       |                                                                                                                      ENABLED |                                                                                                 ENABLED |                                                                                                ENABLED |
| Collateral Enabled               |                                                                                                                         true |                                                                                                    true |                                                                                                   true |
| Supply Cap                       |                                                                                                                    8,000,000 |                                                                                               5,000,000 |                                                                                                    800 |
| Borrow Cap                       |                                                                                                                    7,200,000 |                                                                                               4,500,000 |                                                                                                    720 |
| Debt Ceiling                     |                                                                                                                        USD 0 |                                                                                                   USD 0 |                                                                                                  USD 0 |
| LTV                              |                                                                                                                         75 % |                                                                                                    75 % |                                                                                                   80 % |
| LT                               |                                                                                                                         78 % |                                                                                                    78 % |                                                                                                   83 % |
| Liquidation Bonus                |                                                                                                                          5 % |                                                                                                     5 % |                                                                                                    6 % |
| Liquidation Protocol Fee         |                                                                                                                         10 % |                                                                                                    10 % |                                                                                                   10 % |
| Reserve Factor                   |                                                                                                                         10 % |                                                                                                    10 % |                                                                                                   15 % |
| Base Variable Borrow Rate        |                                                                                                                          0 % |                                                                                                     0 % |                                                                                                    0 % |
| Variable Slope 1                 |                                                                                                                        5.5 % |                                                                                                   5.5 % |                                                                                                  2.7 % |
| Variable Slope 2                 |                                                                                                                         40 % |                                                                                                    40 % |                                                                                                   80 % |
| Uoptimal                         |                                                                                                                         90 % |                                                                                                    90 % |                                                                                                   90 % |
| Flashloanable                    |                                                                                                                      ENABLED |                                                                                                 ENABLED |                                                                                                ENABLED |
| Siloed Borrowing                 |                                                                                                                     DISABLED |                                                                                                DISABLED |                                                                                               DISABLED |
| Borrowable in Isolation          |                                                                                                                     DISABLED |                                                                                                DISABLED |                                                                                               DISABLED |
| Oracle                           | [Capped USDC/USD](https://soneium.blockscout.com/address/0xe9d6696fc74a8ef545d2c9c842f820763407e778?tab=read_write_contract) |    [Capped USDT/USD](https://soneium.blockscout.com/address/0x01bcEb741614D4388028EaF3284DCB04386c30D2) | [Chainlink ETH/USD](https://soneium.blockscout.com/address/0x291cF980BA12505D65ee01BDe0882F1d5e533525) |
| Oracle Underlying feed           |                      [Chainlink USDC/USD](https://soneium.blockscout.com/address/0x46522a7fD5bD5E7aaFF862C17E116152e07d7158) | [Chainlink USDT/USD](https://soneium.blockscout.com/address/0xE92d289831823c96C22592952C1cfA2584a65038) |                                                                                                    N/A |
| Oracle Latest Answer (18MAY2025) |                                                                                                                  $0.99987956 |                                                                                             $1.00022312 |                                                                                             $2499.1478 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://soneium.blockscout.com/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for USDCe and the corresponding aToken.

### Security procedures

- The proposal execution is simulated within the tests and the resulting pool configuration is tested for correctness.
- The deployed pool and other permissions have been programmatically verified, which can be found on the [aave-permissions-book](TODO)
- In addition, we have also checked the code diffs of the deployed sonic contracts with the production instance, which can be found [here](https://github.com/bgd-labs/aave-v3-origin/pull/58).

## References

- Implementation: [AaveV3Soneium](https://github.com/bgd-labs/aave-proposals-v3/blob/a37b5f28786d65dee5f2c952374c2f03f6cf9085/src/20250518_AaveV3Soneium_AaveV33SoneiumActivation/AaveV3Soneium_AaveV33SoneiumActivation_20250518.sol)
- Tests: [AaveV3Soneium](https://github.com/bgd-labs/aave-proposals-v3/blob/a37b5f28786d65dee5f2c952374c2f03f6cf9085/src/20250518_AaveV3Soneium_AaveV33SoneiumActivation/AaveV3Soneium_AaveV33SoneiumActivation_20250518.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xb996bda7e60f85de7f6f2d9f7f6c15ddddfbd871465d8f00b846f8ab014a5953)
- [Discussion](https://governance.aave.com/t/arfc-deploy-aave-on-soneium/21204/9)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
