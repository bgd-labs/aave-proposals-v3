---
title: "Core Instance - Add ezETH and update rsETH eMode Parameters"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-core-instance-add-ezeth-and-update-rseth-emode-parameters/21505"
---

## Simple Summary

This publication proposes the following update to the Core Instance on Ethereum:

- Add ezETH;
- Increase rsETH supply cap; and,
- Create rsETH/WETH liquid eMode.

## Motivation

This proposal aims to create a more equitable and accessible market for Kelp and Renzo Liquid Restaking Tokens (LRTs) by enabling efficient access to WETH liquidity within the Core Instance.

To streamline implementation, all parameter updates will be included in a single AIP submission.

### Add ezETH

ezETH is currently available on Aave v3 across Prime, Linea, Base, and Arbitrum. However, only on Linea can ezETH borrow WETH, where it has already exhausted the available liquidity. Onboarding ezETH to Core is expected to drive additional demand for WETH. Moreover, with ezETH/wstETH pairs available on both Prime and Core, ezETH holders will gain the ability to optimize their positions across the two Ethereum instances of Aave v3.

### rsETH/wETH eMode

Liquid eModes allow for more precise risk parameter configurations, enhancing capital efficiency by tailoring settings to specific asset pairs. Given rsETH’s strong peg stability, deep liquidity, and consistent growth, we propose aligning its eMode parameters with those of EtherFi’s weETH. This alignment ensures balanced, risk-adjusted competition while supporting the expansion of the rsETH market.

### rsETH Supply Cap

To accommodate growing demand and prepare for the new eMode, we recommend increasing the supply cap for rsETH. Utilization is currently at approximately 91.92%, nearing its limit. Raising the cap will ensure continued market growth and prevent liquidity constraints.

## Specification

The following adjustments are to be implemented on Core instance within the same AIP.

### Add ezETH

Add ezETH to Core instance on Ethereum.

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (ezETH)        |                                    150,000 |
| Borrow Cap (ezETH)        |                                          0 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       75 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       15 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        7 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       40 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x68C9c7Bf43DBd0EBab102116bc7C3C9f7d9297Ee |

### ezETH/wETH eMode

| Parameter             | Value  | Value  |
| :-------------------- | :----- | :----- |
| Asset                 | ezETH  | WETH   |
| Collateral            | Yes    | No     |
| Borrowable            | No     | Yes    |
| Max LTV               | 93.00% | 93.00% |
| Liquidation Threshold | 95.00% | 95.00% |
| Liquidation Penalty   | 1.00%  | 1.00%  |

### ezETH/wstETH eMode

| Parameter             | Value  | Value  |
| :-------------------- | :----- | :----- |
| Asset                 | ezETH  | wstETH |
| Collateral            | Yes    | No     |
| Borrowable            | No     | Yes    |
| Max LTV               | 93.00% | 93.00% |
| Liquidation Threshold | 95.00% | 95.00% |
| Liquidation Penalty   | 1.00%  | 1.00%  |

### rsETH Supply Cap

| Parameter  | Current | Proposed | Change  |
| :--------- | :------ | :------- | :------ |
| Supply Cap | 480,000 | 550,000  | +70,000 |

### rsETH/wETH eMode

| Parameter             | Value  | Value  |
| :-------------------- | :----- | :----- |
| Asset                 | rsETH  | WETH   |
| Collateral            | Yes    | No     |
| Borrowable            | No     | Yes    |
| Max LTV               | 93.00% | 93.00% |
| Liquidation Threshold | 95.00% | 95.00% |
| Liquidation Penalty   | 1.00%  | 1.00%  |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250319_AaveV3Ethereum_CoreInstanceAddEzETHAndUpdateRsETHEModeParameters/AaveV3Ethereum_CoreInstanceAddEzETHAndUpdateRsETHEModeParameters_20250319.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250319_AaveV3Ethereum_CoreInstanceAddEzETHAndUpdateRsETHEModeParameters/AaveV3Ethereum_CoreInstanceAddEzETHAndUpdateRsETHEModeParameters_20250319.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-core-instance-add-ezeth-and-update-rseth-emode-parameters/21505)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
