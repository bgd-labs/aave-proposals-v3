---
title: "Aave V3.3 Celo Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-aave-deployment-on-celo/17636"
snapshot: "https://snapshot.box/#/aave.eth/proposal/0x645981c18f5dc61c07324a39d57bcb873ebd8fb9e4a435280cac57cb07a8090b"
---

## Simple Summary

This proposal allows the Aave governance to activate the Aave V3 Celo pool (3.3) by completing all the initial setup and listing CELO, USDC, USDT, cUSD, cEUR as suggested by the risk service providers engaged with the DAO on the governance forum.

All the Aave Celo V3 addresses can be found in the [aave-address-book](https://github.com/bgd-labs/aave-address-book/blob/300841c0c3cbc884dca90d168053a3f8df25f767/src/AaveV3Celo.sol).

## Motivation

All the governance procedures for the expansion of Aave v3 to Celo have been finished, said:

- Positive signaling and approval regarding the expansion on the governance [forum](https://governance.aave.com/t/arfc-aave-deployment-on-celo/17636), and [snapshot](https://snapshot.box/#/aave.eth/proposal/0x645981c18f5dc61c07324a39d57bcb873ebd8fb9e4a435280cac57cb07a8090b).
- Positive technical evaluation done by BGD Labs of the Celo network, as described in the [forum](https://governance.aave.com/t/bgd-aave-celo-infrastructure-technical-evaluation/16588) in detail.
- Positive risk analysis and assets/parameters recommendation by the risk service providers.

## Specification

The proposal will do the following:

- List the following assets on Aave V3 Celo: CELO, USDC, USDT, cUSD, cEUR.
- Set the risk steward as the risk admin by executing `ACL_MANAGER.addRiskAdmin()`.
- Set the guardian address as the pool admin by executing `ACL_MANAGER.addPoolAdmin()`. This is following the standard procedure of keeping pool admin on the Aave Guardian during the bootstrap period, for security.
- Set ACI multi-sig as liquidity mining admin for all aTokens and underlying tokens by calling `EMISSION_MANAGER.setEmissionAdmin()` method.

The table below illustrates the configured risk parameters for the assets to be listed:

| Parameter                 |            [USDC](https://celoscan.io/address/0xcebA9300f2b948710d2653dD7B07f33A8B32118C) |            [USDT](https://celoscan.io/address/0x48065fbBE25f71C9282ddf5e1cD6D6A887483D5e) |    [cEUR](https://celoscan.io/address/0xD8763CBa276a3738E6DE85b4b3bF5FDed6D6cA73) |            [cUSD](https://celoscan.io/address/0x765DE816845861e75A25fCA122bb6898B8B1282a) |     [CELO](https://celoscan.io/address/0x471EcE3750Da237f93B8E339c536989b8978a438) |
| ------------------------- | ----------------------------------------------------------------------------------------: | ----------------------------------------------------------------------------------------: | --------------------------------------------------------------------------------: | ----------------------------------------------------------------------------------------: | ---------------------------------------------------------------------------------: |
| Borrowable                |                                                                                   ENABLED |                                                                                   ENABLED |                                                                           ENABLED |                                                                                   ENABLED |                                                                            ENABLED |
| Collateral Enabled        |                                                                                      true |                                                                                      true |                                                                             false |                                                                                     false |                                                                               true |
| Supply Cap                |                                                                                 3,500,000 |                                                                                 2,000,000 |                                                                            80,000 |                                                                                 1,300,000 |                                                                          1,000,000 |
| Borrow Cap                |                                                                                 3,150,000 |                                                                                 1,800,000 |                                                                            72,000 |                                                                                 1,170,000 |                                                                            100,000 |
| Isolation Mode            |                                                                                     false |                                                                                     false |                                                                             false |                                                                                     false |                                                                               true |
| Debt Ceiling              |                                                                                     USD 0 |                                                                                     USD 0 |                                                                             USD 0 |                                                                                     USD 0 |                                                                        USD 500,000 |
| LTV                       |                                                                                      75 % |                                                                                      75 % |                                                                               0 % |                                                                                       0 % |                                                                               55 % |
| LT                        |                                                                                      78 % |                                                                                      78 % |                                                                               0 % |                                                                                       0 % |                                                                               61 % |
| Liquidation Bonus         |                                                                                       5 % |                                                                                       5 % |                                                                               0 % |                                                                                       0 % |                                                                               10 % |
| Liquidation Protocol Fee  |                                                                                      10 % |                                                                                      10 % |                                                                               0 % |                                                                                       0 % |                                                                               10 % |
| Reserve Factor            |                                                                                      10 % |                                                                                      10 % |                                                                              15 % |                                                                                      15 % |                                                                               20 % |
| Uoptimal                  |                                                                                      90 % |                                                                                      90 % |                                                                              90 % |                                                                                      90 % |                                                                               45 % |
| Base Variable Borrow Rate |                                                                                       0 % |                                                                                       0 % |                                                                               0 % |                                                                                       0 % |                                                                                0 % |
| Variable Slope 1          |                                                                                     7.5 % |                                                                                     7.5 % |                                                                             7.5 % |                                                                                     7.5 % |                                                                               10 % |
| Variable Slope 2          |                                                                                      40 % |                                                                                      40 % |                                                                              75 % |                                                                                      75 % |                                                                              150 % |
| Flashloanable             |                                                                                   ENABLED |                                                                                   ENABLED |                                                                           ENABLED |                                                                                   ENABLED |                                                                            ENABLED |
| Siloed Borrowing          |                                                                                  DISABLED |                                                                                  DISABLED |                                                                          DISABLED |                                                                                  DISABLED |                                                                           DISABLED |
| Borrowable in Isolation   |                                                                                   ENABLED |                                                                                   ENABLED |                                                                           ENABLED |                                                                                   ENABLED |                                                                           DISABLED |
| Oracle                    | [Capped USDC/USD](https://celoscan.io/address/0xBF704f2FfdB856805cE64D085cD50427823696D7) | [Capped USDT/USD](https://celoscan.io/address/0x6e3d991C965364481796116dE68A8036d1b3Ecd0) | [EUR/USD](https://celoscan.io/address/0x3D207061Dbe8E2473527611BFecB87Ff12b28dDa) | [Capped cUSD/USD](https://celoscan.io/address/0xdCdA3E7E90fe827776b8FDaEa3C5977F123354DA) | [CELO/USD](https://celoscan.io/address/0x0568fD19986748cEfF3301e55c0eb1E729E0Ab7e) |

### Security procedures

- The proposal execution is simulated within the tests and the resulting pool configuration is tested for correctness.
- The deployed pool and other permissions have been programmatically verified, which can be found on the [aave-permissions-book](https://github.com/bgd-labs/aave-permissions-book/blob/a659b5cccaa5f6b5e681dcdd0177490d1c857688/out/CELO-V3.md#contracts).
- In addition, we have also checked the code diffs of the deployed celo contracts with the production instance, which can be found [here](https://github.com/bgd-labs/aave-v3-origin/pull/54).

## References

- Implementation: [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/b3840ee71a53d01a18d58b2b6a03d419020bf760/src/20250224_AaveV3Celo_AaveV33CeloActivation/AaveV3Celo_AaveV33CeloActivation_20250224.sol)
- Tests: [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/b3840ee71a53d01a18d58b2b6a03d419020bf760/src/20250224_AaveV3Celo_AaveV33CeloActivation/AaveV3Celo_AaveV33CeloActivation_20250224.t.sol)
- [Snapshot](https://snapshot.box/#/aave.eth/proposal/0x645981c18f5dc61c07324a39d57bcb873ebd8fb9e4a435280cac57cb07a8090b)
- [Discussion](https://governance.aave.com/t/arfc-aave-deployment-on-celo/17636)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
