---
title: "Update AAVE Token LTV/Liquidation Percentages"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-update-aave-token-ltv-liquidation-percentages/20973"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0x50d01665cddf8ea977051cf6de8534cd37b107be52e863e168a8ece2ea4b544f"
---

## Simple Summary

This proposal increases the AAVE's LTV and liquidation threshold values on ethereum core and arbitrum instances.
AAVE's LTV is increased from 66% to 69% on core instance and 63% to 66% on arbitrum instance while the liquidation threshold is increased from 73% to 76% on core instance and 70% to 73% on arbitrum instance.

## Motivation

Aave’s token (AAVE) has meaningfully grown in its liquidity, market capitalization, and market share in the DeFi space. As a result of these meaningful gains, a modest upward adjustment to AAVE’s ratios is worth considering.

A higher Loan-to-Value (LTV) and Liquidation Threshold (LT) can improve capital efficiency for AAVE holders, allowing them to access greater borrowing power without significantly increasing systemic risk. This change aligns with AAVE’s broader goal of maintaining a competitive and sustainable lending environment. Additionally, similar assets with comparable liquidity and adoption levels already operate at or above the proposed thresholds, reinforcing the prudence of this adjustment.

To be clear – we do not want to create excess endogenous collateral risk by moving the LTV and Liquidation ratios too high. With that balance in mind, the proposed percentages are not aggressive. Indeed, the newly proposed 71% LTV and 78% liquidation percentage is still meaningfully below other more liquid and mature collateral.

## Specification

This proposal will achieve the following:

| Instance      | Asset | Current LTV | Rec. LTV | Current LT | Rec. LT |
| ------------- | ----- | ----------- | -------- | ---------- | ------- |
| Ethereum Core | AAVE  | 66.0%       | 69.0%    | 73.0%      | 76.0%   |
| Arbitrum      | AAVE  | 63.0%       | 66.0%    | 70.0%      | 73.0%   |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/4d1150ec13a442a7ab76bbdcbc8dd0ad072aa725/src/20250218_Multi_UpdateAAVETokenLTVLiquidationPercentages/AaveV3Ethereum_UpdateAAVETokenLTVLiquidationPercentages_20250218.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/4d1150ec13a442a7ab76bbdcbc8dd0ad072aa725/src/20250218_Multi_UpdateAAVETokenLTVLiquidationPercentages/AaveV3Arbitrum_UpdateAAVETokenLTVLiquidationPercentages_20250218.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/4d1150ec13a442a7ab76bbdcbc8dd0ad072aa725/src/20250218_Multi_UpdateAAVETokenLTVLiquidationPercentages/AaveV3Ethereum_UpdateAAVETokenLTVLiquidationPercentages_20250218.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/4d1150ec13a442a7ab76bbdcbc8dd0ad072aa725/src/20250218_Multi_UpdateAAVETokenLTVLiquidationPercentages/AaveV3Arbitrum_UpdateAAVETokenLTVLiquidationPercentages_20250218.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x50d01665cddf8ea977051cf6de8534cd37b107be52e863e168a8ece2ea4b544f)
- [Discussion](https://governance.aave.com/t/arfc-update-aave-token-ltv-liquidation-percentages/20973)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
