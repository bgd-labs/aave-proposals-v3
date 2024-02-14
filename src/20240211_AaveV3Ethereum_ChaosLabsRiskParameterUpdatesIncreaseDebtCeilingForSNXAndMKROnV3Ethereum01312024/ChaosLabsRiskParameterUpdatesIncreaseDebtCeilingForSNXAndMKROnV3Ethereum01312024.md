---
title: "Chaos Labs Risk Parameter Updates - Increase Debt Ceiling for SNX and MKR on V3 Ethereum - 01.31.2024"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-increase-debt-ceiling-for-snx-and-mkr-on-v3-ethereum-01-31-2024/16480/1"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xe1a36b7daaf5ab8555510edf53fc75645c7a0ac26b3d47cfe9295b94f96bcf3a"
---

## Simple Summary

A proposal to increase the debt ceiling of SNX and MKR on V3 Ethereum

## Motivation

SNX
The current debt ceiling for SNX on V3 Ethereum set at $2.5M, has reached 94% utilization.

Given current market conditions our Isolation Mode Methodology 1 supports increasing the debt ceiling to $4M.

It is important to note that the majority of SNX debt positions are concentrated within two accounts, accounting for over 90% of the total debt, as outlined below. While this concentration does not affect the current recommendation, it is something to continue monitoring and will be considered in future recommendations and cases of significant market changes.

Positions Analysis
There are currently two major users utilizing SNX as collateral on V3 Ethereum:

1. 0x09d86d566092bec46d449e72087ee788937599d2 1 - borrowing $1.81M in stables (USDC and USDT) against his 1.4M SNX collateral, accounting for nearly 73% of the debt ceiling. The user’s current health score is 1.59.
   Wallet etherscan link - https://etherscan.io/address/0x09d86d566092bec46d449e72087ee788937599d2
2. 0x97cfb214adcd7243efd6b491a6c719c493d04122 - borrowing ~$448K USDT against his ~595K SNX collateral, accounting for nearly 18% of the debt ceiling. The user’s current health score is 2.73.
   Wallet etherscan link - https://etherscan.io/address/0x97cfb214adcd7243efd6b491a6c719c493d04122

MKR
The current debt ceiling for MKR on V3 Ethereum set at $8.5M, has reached 99% utilization.

Given current market conditions our Isolation Mode Methodology 1 supports increasing the debt ceiling to $12M.

There are currently four major users using MKR as collateral on V3 Ethereum, utilizing 87.5% of the debt ceiling. While this concentration does not affect the current recommendation, it is something to continue monitoring and will be considered in future recommendations and cases of significant market changes

Positions Analysis

1. 0xa9dee54892713f43c221509cfedbd717d16791a0 - borrowing ~$3.79M DAI against his ~6,27K MKR collateral, accounting for nearly 45% of the debt ceiling. The user’s current health score is 2.27.
   Wallet etherscan link - https://etherscan.io/address/0xa9dee54892713f43c221509cfedbd717d16791a0
2. 0x09eda5af6b634dcee8e4c563a97a18dde1a11c81 - borrowing ~$2.11M USDC against his ~2.79K MKR collateral, accounting for nearly 25% of the debt ceiling. The user’s current health score is 1.81.
   Wallet etherscan link - https://etherscan.io/address/0x09eda5af6b634dcee8e4c563a97a18dde1a11c81
3. 0xf47841f562689ad85363b41c235d61136c0ccf26 - borrowing ~$801K USDC against his ~1.04K MKR collateral, accounting for nearly 9.5% of the debt ceiling. The user’s current health score is 1.79.
   Wallet etherscan link - https://etherscan.io/address/0xf47841f562689ad85363b41c235d61136c0ccf26
4. 0x1e7267fa2628d66538822fc44f0edb62b07272a4 - borrowing ~$711K in stables (USDC and USDT) against his ~700 MKR collateral, accounting for nearly 8% of the debt ceiling. The user’s current health score is 1.59.
   Wallet etherscan link - https://etherscan.io/address/0x1e7267fa2628d66538822fc44f0edb62b07272a4

## Specification

| Asset | Parameter    | Current   | Recommendations |
| ----- | ------------ | --------- | --------------- |
| SNX   | Debt Ceiling | 2,500,000 | 4,000,000       |
| MKR   | Debt Ceiling | 8,500,000 | 12,000,000      |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/b579a68dfbb445e7fc46e5f848426b9f6170797c/src/20240211_AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseDebtCeilingForSNXAndMKROnV3Ethereum01312024/AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseDebtCeilingForSNXAndMKROnV3Ethereum01312024_20240211.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/b579a68dfbb445e7fc46e5f848426b9f6170797c/src/20240211_AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseDebtCeilingForSNXAndMKROnV3Ethereum01312024/AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseDebtCeilingForSNXAndMKROnV3Ethereum01312024_20240211.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xe1a36b7daaf5ab8555510edf53fc75645c7a0ac26b3d47cfe9295b94f96bcf3a)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-increase-debt-ceiling-for-snx-and-mkr-on-v3-ethereum-01-31-2024/16480/1)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
