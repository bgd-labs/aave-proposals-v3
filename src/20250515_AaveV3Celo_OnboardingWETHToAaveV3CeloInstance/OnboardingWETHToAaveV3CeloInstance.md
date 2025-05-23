---
title: " Onboarding wETH to Aave V3 Celo Instance"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboarding-weth-to-aave-v3-celo-instance/21750"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xcf4e56350b6dc4615f4206a02d41c8f5958bc9a71594bed975e2657c9bc0b9b8"
---

## Simple Summary

This AIP proposes the onboarding of Wrapped Ether (wETH) as a supported asset on the Aave V3 Celo Instance. The integration aims to expand the protocol’s utility and provide users with additional opportunities for lending and borrowing.

## Motivation

The addition of wETH to Aave V3 on Celo would:

- Increase TVL and protocol revenue
- Provide users with a major DeFi asset for lending/borrowing
- Enable cross-chain strategies involving ETH
- Enhance the protocol’s competitive position in the Celo ecosystem

## Specification

The table below illustrates the configured risk parameters for **WETH**

| Parameter                 |                                                                                       Value |
| ------------------------- | ------------------------------------------------------------------------------------------: |
| Isolation Mode            |                                                                                       false |
| Borrowable                |                                                                                     ENABLED |
| Collateral Enabled        |                                                                                        true |
| Supply Cap (WETH)         |                                                                                         500 |
| Borrow Cap (WETH)         |                                                                                         450 |
| Debt Ceiling              |                                                                                       USD 0 |
| LTV                       |                                                                                        78 % |
| LT                        |                                                                                        80 % |
| Liquidation Bonus         |                                                                                       7.5 % |
| Liquidation Protocol Fee  |                                                                                        10 % |
| Reserve Factor            |                                                                                        15 % |
| Base Variable Borrow Rate |                                                                                         0 % |
| Variable Slope 1          |                                                                                       2.7 % |
| Variable Slope 2          |                                                                                        80 % |
| Uoptimal                  |                                                                                        90 % |
| Flashloanable             |                                                                                     ENABLED |
| Siloed Borrowing          |                                                                                    DISABLED |
| Borrowable in Isolation   |                                                                                    DISABLED |
| Oracle                    | [Chainlink ETH/USD](https://celoscan.io/address/0x1FcD30A73D67639c1cD89ff5746E7585731c083B) |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://celoscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for WETH and the corresponding aToken.

## References

- Implementation: [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250515_AaveV3Celo_OnboardingWETHToAaveV3CeloInstance/AaveV3Celo_OnboardingWETHToAaveV3CeloInstance_20250515.sol)
- Tests: [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250515_AaveV3Celo_OnboardingWETHToAaveV3CeloInstance/AaveV3Celo_OnboardingWETHToAaveV3CeloInstance_20250515.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xcf4e56350b6dc4615f4206a02d41c8f5958bc9a71594bed975e2657c9bc0b9b8)
- [Discussion](https://governance.aave.com/t/arfc-onboarding-weth-to-aave-v3-celo-instance/21750)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
