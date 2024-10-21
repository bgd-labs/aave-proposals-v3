---
title: "Onboard ezETH to Lido Instance"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-onboard-ezeth-to-aave-v3-lido-instance/18504/11"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x7ef22a28cb6729ea4a978b02332ff1af8ed924a726915f9a6debf835d8bf8048"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **ezETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (ezETH)        |                                     15,000 |
| Borrow Cap (ezETH)        |                                        100 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                     0.05 % |
| LT                        |                                      0.1 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       15 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        7 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xcbc95f18d2d9019aae596c82094e724fa2213224 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for ezETH and the corresponding aToken.

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241021_AaveV3EthereumLido_OnboardEzETHToLidoInstance/AaveV3EthereumLido_OnboardEzETHToLidoInstance_20241021.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241021_AaveV3EthereumLido_OnboardEzETHToLidoInstance/AaveV3EthereumLido_OnboardEzETHToLidoInstance_20241021.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x7ef22a28cb6729ea4a978b02332ff1af8ed924a726915f9a6debf835d8bf8048)
- [Discussion](https://governance.aave.com/t/arfc-onboard-ezeth-to-aave-v3-lido-instance/18504/11)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
