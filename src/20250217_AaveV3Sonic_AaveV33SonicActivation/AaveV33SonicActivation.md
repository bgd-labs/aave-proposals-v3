---
title: "Aave V3.3 Sonic Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-deploy-aave-v3-on-sonic/20543/26"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0x8d41750cae27326ac50a84a25846747baeb99c57d371c536ec9219ff662f7497"
---

## Simple Summary

This proposal allows the Aave governance to activate the Aave V3 Sonic pool (3.3) by completing all the initial setup and listing USDC, WETH, wS as suggested by the risk service providers engaged with the DAO on the governance forum.

All the Aave Sonic V3 addresses can be found in the [aave-address-book](https://github.com/bgd-labs/aave-address-book/blob/dd41430542a8699de58fc9ea36f7606574bf9455/src/AaveV3Sonic.sol).

## Motivation

All the governance procedures for the expansion of Aave v3 to Sonic have been finished, said:

- Positive signaling and approval regarding the expansion on the governance [forum](https://governance.aave.com/t/arfc-deploy-aave-v3-on-sonic/20543), and [snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x8d41750cae27326ac50a84a25846747baeb99c57d371c536ec9219ff662f7497).
- Positive technical evaluation done by BGD Labs of the Sonic network, as described in the [forum](https://governance.aave.com/t/bgd-aave-sonic-infrastructure-technical-evaluation/20849) in detail.
- Positive risk analysis and assets/parameters recommendation by the risk service providers.

## Specification

The proposal will do the following:

- List the following assets on Aave V3 Sonic: USDC, WETH, wS.
- Set the risk steward as the risk admin by executing `ACL_MANAGER.addRiskAdmin()`.
- Set the guardian address as the pool admin by executing `ACL_MANAGER.addPoolAdmin()`. This is following the standard procedure of keeping pool admin on the Aave Guardian during the bootstrap period, for security.
- Set ACI [multi-sig](https://sonicscan.org/address/0xac140648435d03f784879cd789130F22Ef588Fcd) as liquidity mining admin for all aTokens and underlying tokens by calling `EMISSION_MANAGER.setEmissionAdmin()` method.

The table below illustrates the configured risk parameters for the assets to be listed:

| Parameter                 |    [WETH](https://sonicscan.org/address/0x50c42dEAcD8Fc9773493ED674b675bE577f2634b) |            [USDC](https://sonicscan.org/address/0x29219dd400f2Bf60E5a23d13Be72B486D4038894) |    [wS](https://sonicscan.org/address/0x039e2fB66102314Ce7b64Ce5Ce3E5183bc94aD38) |
| ------------------------- | ----------------------------------------------------------------------------------: | ------------------------------------------------------------------------------------------: | --------------------------------------------------------------------------------: |
| Borrowable                |                                                                             ENABLED |                                                                                     ENABLED |                                                                           ENABLED |
| Collateral Enabled        |                                                                                true |                                                                                        true |                                                                              true |
| Supply Cap                |                                                                               3,000 |                                                                                  20,000,000 |                                                                        20,000,000 |
| Borrow Cap                |                                                                               2,750 |                                                                                  19,000,000 |                                                                        10,000,000 |
| Isolation Mode            |                                                                               false |                                                                                       false |                                                                             false |
| Debt Ceiling              |                                                                               USD 0 |                                                                                       USD 0 |                                                                             USD 0 |
| LTV                       |                                                                                80 % |                                                                                        75 % |                                                                              68 % |
| LT                        |                                                                                83 % |                                                                                        78 % |                                                                              70 % |
| Liquidation Bonus         |                                                                                 6 % |                                                                                         5 % |                                                                              10 % |
| Liquidation Protocol Fee  |                                                                                10 % |                                                                                        10 % |                                                                              10 % |
| Reserve Factor            |                                                                                15 % |                                                                                        10 % |                                                                              15 % |
| Uoptimal                  |                                                                                90 % |                                                                                        90 % |                                                                              45 % |
| Base Variable Borrow Rate |                                                                                 0 % |                                                                                         0 % |                                                                               0 % |
| Variable Slope 1          |                                                                               2.7 % |                                                                                       9.5 % |                                                                               7 % |
| Variable Slope 2          |                                                                                80 % |                                                                                        40 % |                                                                             300 % |
| Flashloanable             |                                                                             ENABLED |                                                                                     ENABLED |                                                                           ENABLED |
| Siloed Borrowing          |                                                                            DISABLED |                                                                                    DISABLED |                                                                          DISABLED |
| Borrowable in Isolation   |                                                                            DISABLED |                                                                                     ENABLED |                                                                          DISABLED |
| Oracle                    | [ETH/USD](https://sonicscan.org/address/0x824364077993847f71293B24ccA8567c00c2de11) | [Capped USDC/USD](https://sonicscan.org/address/0x7A8443a2a5D772db7f1E40DeFe32db485108F128) | [S/USD](https://sonicscan.org/address/0xc76dFb89fF298145b417d221B2c747d84952e01d) |

### Security procedures

- The proposal execution is simulated within the tests and the resulting pool configuration is tested for correctness.
- The deployed pool and other permissions have been programmatically verified, which can be found on the [aave-permissions-book](https://github.com/bgd-labs/aave-permissions-book/blob/bc10f3db28fc73a2204ac828cf5ae4f35ede1def/out/SONIC-V3.md)
- In addition, we have also checked the code diffs of the deployed sonic contracts with the production instance, which can be found [here](https://github.com/bgd-labs/aave-v3-origin/pull/51).

## References

- Implementation: [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/953a2e36d58132f7497ee62b98492e156809a91e/src/20250217_AaveV3Sonic_AaveV33SonicActivation/AaveV3Sonic_AaveV33SonicActivation_20250217.sol)
- Tests: [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/953a2e36d58132f7497ee62b98492e156809a91e/src/20250217_AaveV3Sonic_AaveV33SonicActivation/AaveV3Sonic_AaveV33SonicActivation_20250217.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x8d41750cae27326ac50a84a25846747baeb99c57d371c536ec9219ff662f7497)
- [Discussion](https://governance.aave.com/t/arfc-deploy-aave-v3-on-sonic/20543/26)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
