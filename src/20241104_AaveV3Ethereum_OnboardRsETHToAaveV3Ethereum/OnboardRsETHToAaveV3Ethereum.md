---
title: "Onboard rsETH to Aave V3 Ethereum"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-add-rseth-to-aave-v3-ethereum/17696"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xe83b67dfdddd469c298ce6133f4fdb84c9796c671c023b88617d5a25b5933c7f"
---

## Simple Summary

Kelp DAO is seeking community support for adding its Liquid Restaking Token, rsETH, to Aave V3 on Ethereum. In addition, rsETH depositors into Aave will accumulate additional Kelp miles and EigenLayer points.

## Motivation

KelpDAO (https://www.kelpdao.xyz/restake/) is one of the largest liquid restaking protocol built on top of the Eigen Layer. Restakers on Kelp get access to multiple benefits like restaking rewards, staking rewards and DeFi yields.

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

A new rsETH LST main e-mode has also been added:

| Parameter             | Value | Value  | Value |
| --------------------- | ----- | ------ | ----- |
| Asset                 | rsETH | wstETH | ETHx  |
| Collateral            | Yes   | No     | No    |
| Borrowable            | No    | Yes    | Yes   |
| Max LTV               | 92.5% | -      | -     |
| Liquidation Threshold | 94.5% | -      | -     |
| Liquidation Penalty   | 1.00% | -      | -     |

The caps of the e-mode related assets have also been updated:

|        | Current Borrow Cap | Recommended Borrow Cap |
| ------ | ------------------ | ---------------------- |
| wstETH | 48,000             | 60,000                 |
| ETHx   | 320                | 5,000                  |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/7a55e9d529097bedca83167e2dfd5c82380e2ab6/src/20241104_AaveV3Ethereum_OnboardRsETHToAaveV3Ethereum/AaveV3Ethereum_OnboardRsETHToAaveV3Ethereum_20241104.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/7a55e9d529097bedca83167e2dfd5c82380e2ab6/src/20241104_AaveV3Ethereum_OnboardRsETHToAaveV3Ethereum/AaveV3Ethereum_OnboardRsETHToAaveV3Ethereum_20241104.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xe83b67dfdddd469c298ce6133f4fdb84c9796c671c023b88617d5a25b5933c7f)
- [Discussion](https://governance.aave.com/t/arfc-add-rseth-to-aave-v3-ethereum/17696)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
