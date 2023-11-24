---
title: "Chaos Labs Risk Parameter Updates - Increase MKR Debt Ceiling on V3 Ethereum"
author: "Chaos Labs (@yonikesel, @ori-chaoslabs)"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-increase-mkr-debt-ceiling-on-v3-ethereum-11-07-2023/15406"
---

## Simple Summary

A proposal to increase the debt ceiling of MKR on V3 Ethereum

## Motivation

The current debt ceiling for MKR on V3 Ethereum, set at $6M, has reached 100% utilization.

Given current market conditions and improved liquidity for MKR on Ethereum over the past months, our [Isolation Mode Methodology](https://governance.aave.com/t/chaos-labs-isolation-mode-methodology/12440) supports increasing the debt ceiling for MKR to $8.5M.

It is important to note that the majority of MKR debt positions are concentrated within two accounts, accounting for over 80% of the total debt, as outlined below. While this concentration does not affect the current recommendation, it is something to continue monitoring and will be considered in future MKR recommendations and in cases of significant market changes.

### V2 → V3 Migration

There are still nearly 3,400 MKR supplied on V2 Ethereum, with nearly $750K in stablecoins borrowed against MKR collateral. The current supply caps and proposed debt ceiling should allow for the migration of these positions.

### Positions Analysis

There are currently two major users utilizing MKR as collateral on V3 Ethereum:

1. [0xa9dee54892713f43c221509cfedbd717d16791a0](https://community-staging.chaoslabs.xyz/aave/risk/wallets/0xa9dee54892713f43c221509cfedbd717d16791a0) - borrowing $3.11M DAI against his 5,914 MKR collateral, accounting for nearly 52% of the debt ceiling. The user's current health score is 1.77.
2. [0x8af700ba841f30e0a3fcb0ee4c4a9d223e1efa05](https://community-staging.chaoslabs.xyz/aave/risk/wallets/0x8af700ba841f30e0a3fcb0ee4c4a9d223e1efa05) - borrowing $1.84M USDC against his 4,077 MKR collateral, accounting for nearly 31% of the debt ceiling. The user's current health score is 2.06.

## Specification

| Asset | Parameter    | Current   | Recommended |
| ----- | ------------ | --------- | ----------- |
| MKR   | Debt Ceiling | 6,000,000 | 8,500,000   |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/b2c837e7494896a29d73d2bcc3de8d6c995674c6/src/20231116_AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseMKRDebtCeilingOnV3Ethereum/AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseMKRDebtCeilingOnV3Ethereum_20231116.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/b2c837e7494896a29d73d2bcc3de8d6c995674c6/src/20231116_AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseMKRDebtCeilingOnV3Ethereum/AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseMKRDebtCeilingOnV3Ethereum_20231116.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb3163709f822b662241395c1fde5ecaa8b39d52b1bc81722136c6084a4b3959c)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-increase-mkr-debt-ceiling-on-v3-ethereum-11-07-2023/15406)

## Disclaimer

Chaos Labs has not been compensated by any third party for publishing this ARFC.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
