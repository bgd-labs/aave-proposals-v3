---
title: "Onboard USDe to the Aave V3 MegaETH Instance"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-usde-to-the-aave-v3-megaeth-instance/24389"
---

## Summary

This proposal seeks to onboard USDe to the Aave V3 MegaETH instance. The asset is already established across multiple Aave deployments, and on MegaETH it is expected to support stablecoin borrowing and yield-oriented usage with an initial onchain liquidity base already seeded for the market.

## Motivation

USDe has clear user demand and strategic relevance for the MegaETH deployment. Listing it would expand the stablecoin and yield-oriented collateral set available on the instance, improve market completeness early in the market’s lifecycle, and align MegaETH more closely with assets already familiar to a broad segment of DeFi users. LlamaRisk also notes that the MegaETH setup is designed so supplied USDe offers yield passthrough, making the asset functionally similar to sUSDe exposure for looping strategies without requiring a separate sUSDe listing.

## Technical Specifications

This proposal recommends onboarding the following asset to the Aave V3 MegaETH instance:

- USDe

### Asset Configuration

| Parameter                 |             USDe |
| ------------------------- | ---------------: |
| Isolation Mode            |               No |
| Borrowable                |              Yes |
| Collateral Enabled        | No (E-Mode only) |
| Supply Cap                |       50,000,000 |
| Borrow Cap                |       40,000,000 |
| Debt Ceiling              |              N/A |
| LTV                       |                — |
| Liquidation Threshold     |                — |
| Liquidation Bonus         |                — |
| Liquidation Protocol Fee  |              10% |
| Reserve Factor            |              25% |
| Base Variable Borrow Rate |               0% |
| Variable Rate Slope 1     |               4% |
| Variable Rate Slope 2     |              12% |
| Optimal Utilization       |              85% |

### USDe-Stablecoins E-Mode

| Parameter             | USDe | USDm | USDT0 |
| --------------------- | ---: | ---: | ----: |
| Collateral            |  Yes |   No |    No |
| Borrowable            |   No |  Yes |   Yes |
| Max LTV               |  90% |    — |     — |
| Liquidation Threshold |  93% |    — |     — |
| Liquidation Bonus     | 2.0% |    — |     — |

### Price Feed

A Cap Adapter using the USDT price feed has been deployed for USDe, with the configuration aligned with the LlamaRisk recommendations. Adapter implementation reference: https://github.com/aave-dao/aave-price-feeds/pull/150

## References

- Implementation: [AaveV3MegaEth](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260409_AaveV3MegaEth_OnboardUSDeToTheAaveV3MegaETHInstance/AaveV3MegaEth_OnboardUSDeToTheAaveV3MegaETHInstance_20260409.sol)
- Tests: [AaveV3MegaEth](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260409_AaveV3MegaEth_OnboardUSDeToTheAaveV3MegaETHInstance/AaveV3MegaEth_OnboardUSDeToTheAaveV3MegaETHInstance_20260409.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-usde-to-the-aave-v3-megaeth-instance/24389)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
