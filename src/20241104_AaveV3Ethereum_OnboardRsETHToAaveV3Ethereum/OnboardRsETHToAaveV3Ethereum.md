---
title: "Onboard rsETH to Aave V3 Ethereum"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-add-rseth-to-aave-v3-ethereum/17696"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xe83b67dfdddd469c298ce6133f4fdb84c9796c671c023b88617d5a25b5933c7f"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **rsETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (rsETH)        |                                     19,000 |
| Borrow Cap (rsETH)        |                                      1,900 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       72 % |
| LT                        |                                       75 % |
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
| Oracle                    | 0x47F52B2e43D0386cF161e001835b03Ad49889e3b |

Additionaly [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for rsETH and the corresponding aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241104_AaveV3Ethereum_OnboardRsETHToAaveV3Ethereum/AaveV3Ethereum_OnboardRsETHToAaveV3Ethereum_20241104.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241104_AaveV3Ethereum_OnboardRsETHToAaveV3Ethereum/AaveV3Ethereum_OnboardRsETHToAaveV3Ethereum_20241104.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xe83b67dfdddd469c298ce6133f4fdb84c9796c671c023b88617d5a25b5933c7f)
- [Discussion](https://governance.aave.com/t/arfc-add-rseth-to-aave-v3-ethereum/17696)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
