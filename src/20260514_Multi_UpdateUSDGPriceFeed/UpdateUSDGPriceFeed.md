---
title: "Update USDG Price Feed in Aave V3 Instances"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/132"
---

## Simple Summary

This AIP migrates the USDG price reference on the Aave V3 Ethereum and Aave V3 X Layer markets from the fixed $1.00 feed to the live Chainlink USDG/USD market feed, wrapped in a `PriceCapAdapterStable` with a $1.04 upper cap. This aligns USDG pricing with the capped-adapter standard already used for USDC, USDT, and RLUSD.

## Motivation

Since the March 2026 USDG onboarding assessment, on-chain USDG liquidity has deepened and diversified across multiple venues, and the Chainlink USDG/USD feed now carries Chainlink's low market-risk categorization, with the market price within a few basis points of par. These conditions support market-based pricing and liquidation for USDG, consistent with the treatment of other established fiat stablecoins on Aave.

The cap bounds upside oracle risk at 4% above par while the feed remains market-responsive on the downside, enabling timely liquidations in the event of a genuine depeg.

## Specification

The USDG reserve price source is updated on each market to the capped Chainlink USDG/USD feed (`PriceCapAdapterStable`, $1.04 cap):

| Market           | New USDG price feed                          |
| ---------------- | -------------------------------------------- |
| Aave V3 Ethereum | `0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4` |
| Aave V3 X Layer  | `0xe00B2732396a1f047d4A00e0165025A9cF400245` |

On Aave V3 Ethereum, the matured PT-USDG-28MAY2026 reserve is also repointed to the capped USDG feed; having reached maturity it redeems 1:1 to USDG, so it no longer needs a dedicated Pendle adapter.

| Parameter       | Current               | Proposed                               |
| --------------- | --------------------- | -------------------------------------- |
| USDG reference  | Fixed USDG/USD, $1.00 | Chainlink USDG/USD market feed, capped |
| Upper price cap | None                  | $1.04 (4% above par)                   |

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260514_Multi_UpdateUSDGPriceFeed/AaveV3Ethereum_UpdateUSDGPriceFeed_20260514.sol), [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260514_Multi_UpdateUSDGPriceFeed/AaveV3XLayer_UpdateUSDGPriceFeed_20260514.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260514_Multi_UpdateUSDGPriceFeed/AaveV3Ethereum_UpdateUSDGPriceFeed_20260514.t.sol), [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260514_Multi_UpdateUSDGPriceFeed/AaveV3XLayer_UpdateUSDGPriceFeed_20260514.t.sol)
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/132)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
