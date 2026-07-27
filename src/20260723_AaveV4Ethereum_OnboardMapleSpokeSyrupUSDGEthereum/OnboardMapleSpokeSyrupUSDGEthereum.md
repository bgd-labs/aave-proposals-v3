---
title: "[Direct to AIP] Onboard syrupUSDG on Aave V4 Global Dollar Hub"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-syrupusdg-on-aave-v4-global-dollar-hub/25281"
---

## Simple Summary

This proposal deploys a dedicated Maple Spoke on the Aave V4 Global Dollar Hub and onboards syrupUSDG, a yield-bearing token from Maple Finance, as a collateral asset on that spoke. The listing follows the parameters recommended by the Risk Service Providers engaged with the DAO on the governance forum.

## Motivation

syrupUSDG is a yield-bearing token issued by [Maple Finance](https://docs.maple.finance/syrupusdc-usdt-usdg-for-lenders/introduction), launched on 2 July 2026. Users deposit USDG and receive syrupUSDG, a liquid and transferable token that accrues returns from Maple's institutional lending operations. The token operates through a segregated legal entity with verifiable onchain reserves.

Onboarding syrupUSDG to the Global Dollar Hub:

- It adds a yield-bearing USDG asset to the Global Dollar Hub, letting users to borrow against syrupUSDG while the underlying position continues to accrue yield from Maple's institutional lending.
- It deepens the utility of USDG within Aave, extending the Global Dollar Hub beyond the base stablecoin to its productive representations.
- It strengthens Aave's position as the primary onchain venue for Global Dollar Network assets and supports demand from institutional participants entering DeFi.
- It expands the asset-base on an already existing Aave V4 Liquidity Hub, purpose-made for USDG-related assets.

## Specification

This proposal deploys a dedicated Maple Spoke on the Aave V4 Global Dollar Hub and lists syrupUSDG as a collateral asset on it.

**syrupUSDG**: [https://etherscan.io/address/0x87b65C4aAFFA76881f9E96F3e7ED945ddFC3Cd7A](https://etherscan.io/address/0x87b65C4aAFFA76881f9E96F3e7ED945ddFC3Cd7A)

**Maple Spoke configuration**

| Parameter             | syrupUSDG |  USDG |
| --------------------- | --------: | ----: |
| Collateral Factor     |    92.00% | 0.00% |
| Max Liquidation Bonus |     4.00% | 0.00% |
| Liquidation Fee       |    10.00% | 0.00% |
| Borrowable            |     FALSE |  TRUE |

**Dynamic liquidation configuration**

| Parameter                   |   Value |
| --------------------------- | ------: |
| Target Health Factor        |  1.0277 |
| Health Factor for Max Bonus |    0.99 |
| Liquidation Bonus Factor    | 100.00% |

**Caps**

| Hub               | Spoke                    | Reserve   | Add Cap | Draw Cap |
| ----------------- | ------------------------ | --------- | ------- | -------- |
| Global Dollar Hub | Maple Spoke              | syrupUSDG | 10M     | 0        |
| Global Dollar Hub | Maple Spoke              | USDG      | 10M     | 9.5M     |
| Global Dollar Hub | waGlobalDollarUSDG Spoke | USDG      | 1M      | 0        |

**USDG interest rate configuration**

| Parameter     | Value  |
| ------------- | ------ |
| Base          | 0.00%  |
| Slope 1       | 4.00%  |
| Slope 2       | 35.00% |
| Uoptimal      | 90.00% |
| Liquidity Fee | 20.00  |

**Oracle configuration**

syrupUSDG is priced through two stacked capped adapters, each applying its own cap.

_USDG / USD_

The USDG leg is a `PriceCapAdapterStable` over the Chainlink USDG/USD feed, so an upward USDG depeg is not passed through to the protocol. This adapter is also the price source of the USDG reserve on the Maple Spoke.

| Parameter       |                                                                                                                                        Value |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------------------: |
| Contract        |                                                                                                   0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4 |
| Underlying feed | Chainlink USDG / USD ([0x14f0737d6b705259e521EA6E9E3506AC78dBd311](https://etherscan.io/address/0x14f0737d6b705259e521EA6E9E3506AC78dBd311)) |
| `priceCap`      |                                                                                                                                     1.04 USD |

_syrupUSDG / USDG / USD_

The syrupUSDG leg is a CAPO adapter combining the Maple syrupUSDG/USDG internal exchange rate (`convertToExitAssets`) with the capped USDG/USD price above, capping the yearly growth of that ratio.

| Parameter                     |                                      Value |
| ----------------------------- | -----------------------------------------: |
| Contract                      | 0x5A6FcB0ebc018b6FD94Fc5f5A9F0948d0D40f040 |
| `MINIMUM_SNAPSHOT_DELAY`      |                                     7 days |
| `maxYearlyRatioGrowthPercent` |                                      8.45% |

## Disclaimer

Aave Labs has no direct financial relationship with Maple Finance, Global Dollar, or any of their affiliates and has not received compensation from either party in connection with this proposal.

## References

- Implementation: [AaveV4Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260723_AaveV4Ethereum_OnboardMapleSpokeSyrupUSDGEthereum/AaveV4Ethereum_OnboardMapleSpokeSyrupUSDGEthereum_20260723.sol)
- Tests: [AaveV4Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260723_AaveV4Ethereum_OnboardMapleSpokeSyrupUSDGEthereum/AaveV4Ethereum_OnboardMapleSpokeSyrupUSDGEthereum_20260723.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-syrupusdg-on-aave-v4-global-dollar-hub/25281)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
