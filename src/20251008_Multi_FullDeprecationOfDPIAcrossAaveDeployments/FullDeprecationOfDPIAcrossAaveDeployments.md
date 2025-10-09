---
title: "Full Deprecation of DPI Across Aave Deployments"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/direct-to-aip-full-deprecation-of-dpi-across-aave-deployments/23212"
---

## Simple Summary

This proposal outlines the final deprecation path for DPI (DeFi Pulse Index) across all Aave deployments where it remains listed: Ethereum v2, Polygon v2, and Polygon v3. DPI has been frozen across all instances for an extended period and now represents negligible exposure within the protocol.

The currently utilized DPI price feed has exhibited reduced stability and is scheduled for deprecation by Chainlink; it is thus timely for Aave to conclude DPI's lifecycle by adjusting its risk parameters and implementing a simplified valuation approach that maintains accurate accounting for the small number of remaining positions.

## Motivation

DPI has been frozen across all Aave instances for an extended period, with no new deposits or borrows permitted. Usage has steadily declined, and its residual exposure is now negligible across the protocol. Current positions are concentrated among a handful of users, with no material systemic or market risk implications.

Recently, Chainlink has indicated its intention to deprecate the DPI price feed due to reduced stability and limited data availability. Given that DPI's trading activity and liquidity have declined significantly, maintaining this feed is no longer viable from an oracle operations standpoint. This development necessitates an internal Aave decision on how to handle valuation of the remaining DPI positions once the feed is sunset.

To address this, the following proposal outlines a minimal-risk approach to finalizing DPI's deprecation across all Aave deployments while ensuring continuity for existing users.

## Specification

To finalize deprecation, the following adjustments are proposed:

- Set Liquidation Threshold (LT) to 0.05% on Polygon v3 (note: triggers one minor liquidation, ~$2.5K notional)
- Adjust Interest Rate Parameters (Polygon v3 and Ethereum v2):
  - Base rate: 20% (to encourage baseline debt repayment)
  - Slope 2: 40% (reduced from 300%) to avoid excessive reserve inflation on residual balances

| Asset | Instance    | Current Liquidation Threshold | Recommended Liquidation Threshold | Current Base Interest Rate | Recommended Base Interest Rate | Current Slope2 | Recommended Slope2 |
| ----- | ----------- | ----------------------------- | --------------------------------- | -------------------------- | ------------------------------ | -------------- | ------------------ |
| DPI   | Ethereum v2 | -                             | -                                 | -                          | -                              | 300%           | 40%                |
| DPI   | Polygon v3  | 45%                           | 0.05%                             | 0%                         | 20%                            | 300%           | 40%                |

Following the deprecation of Chainlink DPI feeds, the price feeds for DPI will be updated to a fixed equivalent of $102 across all instances:

| Asset | Instance    | Current Price Feed                                                                        | New Price Feed                                                                              | New Fixed Price Value |
| ----- | ----------- | ----------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | --------------------- |
| DPI   | Ethereum v2 | [CL DPI/USD/ETH](https://etherscan.io/address/0x2fe9EcF3024B5A63f50Ec0eFC53b8fF2C09F2E93) | [Fixed DPI/ETH](https://etherscan.io/address/0x92A6A444f5b433235297d849d2F93B405657234a)    | `0.022767 ETH`        |
| DPI   | Polygon v2  | [CL DPI/ETH](https://polygonscan.com/address/0xC70aAF9092De3a4E5000956E672cDf5E996B4610)  | [Fixed DPI/ETH](https://polygonscan.com/address/0xD550Bce1a506F48802C9A4464c64E14A3141cE73) | `0.022767 ETH`        |
| DPI   | Polygon v3  | [CL DPI/USD](https://polygonscan.com/address/0x2e48b7924FBe04d575BA229A59b64547d9da16e9)  | [Fixed DPI/USD](https://polygonscan.com/address/0x105fe43207ce8331555c9be8c13718d6ded2fd97) | `102 USD`             |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/0b7f233c4c8d93af5a3f8dfc0ef1419b485642d6/src/20251008_Multi_FullDeprecationOfDPIAcrossAaveDeployments/AaveV2Ethereum_FullDeprecationOfDPIAcrossAaveDeployments_20251008.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/0b7f233c4c8d93af5a3f8dfc0ef1419b485642d6/src/20251008_Multi_FullDeprecationOfDPIAcrossAaveDeployments/AaveV2Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/0b7f233c4c8d93af5a3f8dfc0ef1419b485642d6/src/20251008_Multi_FullDeprecationOfDPIAcrossAaveDeployments/AaveV3Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/0b7f233c4c8d93af5a3f8dfc0ef1419b485642d6/src/20251008_Multi_FullDeprecationOfDPIAcrossAaveDeployments/AaveV2Ethereum_FullDeprecationOfDPIAcrossAaveDeployments_20251008.t.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/0b7f233c4c8d93af5a3f8dfc0ef1419b485642d6/src/20251008_Multi_FullDeprecationOfDPIAcrossAaveDeployments/AaveV2Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/0b7f233c4c8d93af5a3f8dfc0ef1419b485642d6/src/20251008_Multi_FullDeprecationOfDPIAcrossAaveDeployments/AaveV3Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-full-deprecation-of-dpi-across-aave-deployments/23212)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
