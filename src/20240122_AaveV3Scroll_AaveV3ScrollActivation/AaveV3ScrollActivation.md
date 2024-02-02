---
title: "Aave v3 Scroll Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-aave-v3-deployment-on-scroll-mainnet/16126/"
---

## Simple Summary

This proposal allows the Aave governance to activate the Aave V3 Scroll pool (3.0.2) by completing all the initial setup and listing WETH, USDC, wstETH as suggested by the risk service providers engaged with the DAO (Gauntlet and Chaos Labs) on the [governance forum](https://governance.aave.com/t/arfc-aave-v3-deployment-on-scroll-mainnet/16126/6).

All the Aave Scroll V3 addresses can be found in the [aave-address-book](https://github.com/bgd-labs/aave-address-book/blob/main/src/AaveV3Scroll.sol).

## Motivation

All the governance procedures for the expansion of Aave v3 to Scroll have been finished, said:

- Positive signaling and approval regarding the expansion on the [governance forum](https://governance.aave.com/t/tempcheck-aave-v3-mvp-deployment-on-scroll-mainnet/13265), [temp check snapshot](https://snapshot.org/#/aave.eth/proposal/0x0c9447367d5223863e829393a9e8937a54b2af85adef883542f063df4fb86db6), and [final snapshot](https://snapshot.org/#/aave.eth/proposal/0x8110de95ff2827946ede0a9b8c5b9c1876605163bb1e7f8c637b6b80848224c8).
- Positive technical evaluation done by BGD Labs of the Scroll chain network, as described in the [forum](https://governance.aave.com/t/bgd-aave-scroll-infrastructure-technical-evaluation/15854) in detail.
- Positive risk analysis and assets/parameters recommendation by the service providers Gauntlet and Chaos Labs.

## Specification

The proposal will do the following:

- Set risk steward and freezing steward as the risk admin by executing `ACL_MANAGER.addRiskAdmin()`.
- Set the guardian address as the pool admin by executing `ACL_MANAGER.addPoolAdmin()`.
  This is following the standard procedure of keeping pool admin on the Aave Guardian during the bootstrap period, for security.
- List the following assets on Aave V3 Scroll: WETH, USDC, wstETH.

The table below illustrates the initial suggested risk parameters for each asset:

| Parameter                          |                                                                                 WETH |                                                                                  USDC |                                                                                  wstETH |
| ---------------------------------- | -----------------------------------------------------------------------------------: | ------------------------------------------------------------------------------------: | --------------------------------------------------------------------------------------: |
| Isolation Mode                     |                                                                                false |                                                                                  true |                                                                                    true |
| Borrowable                         |                                                                              ENABLED |                                                                               ENABLED |                                                                                 ENABLED |
| Collateral Enabled                 |                                                                                 true |                                                                                  true |                                                                                    true |
| Supply Cap                         |                                                                                  240 |                                                                             1,000,000 |                                                                                     130 |
| Borrow Cap                         |                                                                                  200 |                                                                               900,000 |                                                                                      45 |
| Debt Ceiling                       |                                                                                USD 0 |                                                                                 USD 0 |                                                                                   USD 0 |
| LTV                                |                                                                                 75 % |                                                                                  77 % |                                                                                    75 % |
| LT                                 |                                                                                 78 % |                                                                                  80 % |                                                                                    78 % |
| Liquidation Bonus                  |                                                                                  6 % |                                                                                   5 % |                                                                                     7 % |
| Liquidation Protocol Fee           |                                                                                 10 % |                                                                                  10 % |                                                                                    10 % |
| Reserve Factor                     |                                                                                 15 % |                                                                                  10 % |                                                                                    15 % |
| Base Variable Borrow Rate          |                                                                                  0 % |                                                                                   0 % |                                                                                     0 % |
| Variable Slope 1                   |                                                                                3.3 % |                                                                                   6 % |                                                                                     7 % |
| Variable Slope 2                   |                                                                                  8 % |                                                                                  60 % |                                                                                   300 % |
| Uoptimal                           |                                                                                 80 % |                                                                                  90 % |                                                                                    45 % |
| Stable Borrowing                   |                                                                             DISABLED |                                                                              DISABLED |                                                                                DISABLED |
| Stable Slope1                      |                                                                                3.3 % |                                                                                   6 % |                                                                                     7 % |
| Stable Slope2                      |                                                                                  8 % |                                                                                  60 % |                                                                                   300 % |
| Base Stable Rate Offset            |                                                                                  2 % |                                                                                   1 % |                                                                                     2 % |
| Stable Rate Excess Offset          |                                                                                  8 % |                                                                                   8 % |                                                                                     8 % |
| Optimal Stable To Total Debt Ratio |                                                                                 20 % |                                                                                  20 % |                                                                                    20 % |
| Flashloanable                      |                                                                              ENABLED |                                                                               ENABLED |                                                                                 ENABLED |
| Siloed Borrowing                   |                                                                             DISABLED |                                                                              DISABLED |                                                                                DISABLED |
| Borrowable in Isolation            |                                                                             DISABLED |                                                                               ENABLED |                                                                                DISABLED |
| Oracle                             | [ETH/USD](https://scrollscan.com/address/0x6bF14CB0A831078629D993FDeBcB182b21A8774C) | [USDC/USD](https://scrollscan.com/address/0x43d12Fb3AfCAd5347fA764EeAB105478337b7200) | [wstETH/USD](https://scrollscan.com/address/0xdb93e2712a8b36835078f8d28c70fcc95fd6d37c) |

## References

- Implementation: [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240122_AaveV3Scroll_AaveV3ScrollActivation/AaveV3Scroll_AaveV3ScrollActivation_20240122.sol)
- Tests: [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240122_AaveV3Scroll_AaveV3ScrollActivation/AaveV3Scroll_AaveV3ScrollActivation_20240122.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x8110de95ff2827946ede0a9b8c5b9c1876605163bb1e7f8c637b6b80848224c8)
- [Discussion](https://governance.aave.com/t/arfc-aave-v3-deployment-on-scroll-mainnet/16126/)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
