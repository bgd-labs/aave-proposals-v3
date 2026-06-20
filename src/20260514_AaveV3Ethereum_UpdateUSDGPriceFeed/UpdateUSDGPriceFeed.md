---
title: "Update USDG price feed on Aave V3 Ethereum"
author: "Aave Labs"
discussions: TODO
---

## Simple Summary

This AIP migrates the USDG price reference on the Aave V3 Ethereum market from the fixed $1.00 feed to the live Chainlink USDG/USD market feed, wrapped in a `PriceCapAdapterStable` with a $1.04 upper cap. This aligns USDG pricing on V3 with the capped-adapter standard already used for USDC, USDT, and RLUSD.

## Motivation

Since the March 2026 USDG onboarding assessment, on-chain USDG liquidity has deepened and diversified across multiple venues, and the Chainlink USDG/USD feed now carries Chainlink's low market-risk categorization. USDG supply on Ethereum stands at approximately $493M as of June 2026, with a market price within a few basis points of par. These conditions support market-based pricing and liquidation for USDG, consistent with the treatment of other established fiat stablecoins on Aave.

The cap bounds upside oracle risk at 4% above par while the feed remains market-responsive on the downside, enabling timely liquidations in the event of a genuine depeg.

## Specification

The USDG reserve price source on the Aave V3 Ethereum market is updated to the capped Chainlink USDG/USD feed.

| Parameter       | Current               | Proposed                               |
| --------------- | --------------------- | -------------------------------------- |
| USDG reference  | Fixed USDG/USD, $1.00 | Chainlink USDG/USD market feed, capped |
| Upper price cap | None                  | $1.04 (4% above par)                   |

**USDG/USD market feed**: [0x14f0737d6b705259e521EA6E9E3506AC78dBd311](https://etherscan.io/address/0x14f0737d6b705259e521EA6E9E3506AC78dBd311)

**PriceCapAdapterStable**: [0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4](https://etherscan.io/address/0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4)

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260514_AaveV3Ethereum_UpdateUSDGPriceFeed/AaveV3Ethereum_UpdateUSDGPriceFeed_20260514.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260514_AaveV3Ethereum_UpdateUSDGPriceFeed/AaveV3Ethereum_UpdateUSDGPriceFeed_20260514.t.sol)
- Snapshot: Direct-To-AIP
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
