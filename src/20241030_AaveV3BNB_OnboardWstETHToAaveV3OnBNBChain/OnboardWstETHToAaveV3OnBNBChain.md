---
title: "Onboard wstETH to Aave V3 on BNB Chain"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-onboard-wsteth-to-aave-v3-on-bnb-chain/18501"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x752c396a86f1f9b60d3e43b7ed223d9d2f66014e03b6b3eb7ac59e8a169d1fe5"
---

## Simple Summary

This AIP proposes the onboard of wstETH (wrapped staked ETH) to Aave V3 on BNB Chain to improve Aave’s reach across alternative chains and provide increased choice for Aave users on BNB Chain.

## Motivation

wstETH is one of the most popular collateral and borrow tokens on Aave, with over $4 billion in deposits and $100m in borrows across Aave deployments. The onboarding of wstETH to the Aave V3 on BNB Chain will give Aave users more options for generating staking yield on their collateral and increase dominance of Aave on BNB Chain.

## Specification

The table below illustrates the configured risk parameters for **wstETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (wstETH)       |                                      1,900 |
| Borrow Cap (wstETH)       |                                        190 |
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
| Oracle                    | 0xc1377B4cdF9116bf7b3d7F72A4f8A7Be8506cE80 |

The table below illustrate the configured "ETH-Correlated" E-mode

| Parameter             | wstETH | WETH  |
| --------------------- | ------ | ----- |
| Collateral            | Yes    | No    |
| Borrowable            | No     | Yes   |
| Max LTV               | 93%    | 93%   |
| Liquidation Threshold | 95%    | 95%   |
| Liquidation Penalty   | 1.00%  | 1.00% |

Additionaly [0xac140648435d03f784879cd789130F22Ef588Fcd](https://bscscan.com/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for wstETH and the corresponding aToken.

## References

- Implementation: [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/4d2ca786411ef6f1207f81498ee298142721ddfd/src/20241030_AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain/AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain_20241030.sol)
- Tests: [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/4d2ca786411ef6f1207f81498ee298142721ddfd/src/20241030_AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain/AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain_20241030.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x752c396a86f1f9b60d3e43b7ed223d9d2f66014e03b6b3eb7ac59e8a169d1fe5)
- [Discussion](https://governance.aave.com/t/arfc-onboard-wsteth-to-aave-v3-on-bnb-chain/18501)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
