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

**syrupUSDG**: [TO BE ADDED]

**Maple Spoke configuration**

| Parameter                        | syrupUSDG |
| -------------------------------- | --------: |
| Collateral Factor                |    92.00% |
| Max Liquidation Bonus            |     4.00% |
| Borrowable                       |     FALSE |
| Liquidation Fee                  |    10.00% |
| Dynamic Liquidation Bonus Factor |   100.00% |
| Target Health Factor             |    1.0277 |

**Caps**

| Asset     | Add Cap | Draw Cap |
| --------- | ------- | -------- |
| syrupUSDG | 10M     | 0        |
| USDG      | 10M     | 9.5M     |

**USDG interest rate configuration**

| Parameter     | Value  |
| ------------- | ------ |
| Base          | 0.00%  |
| Slope 1       | 4.00%  |
| Slope 2       | 35.00% |
| Uoptimal      | 90.00% |
| Liquidity Fee | 20.00  |

**Oracle configuration**

syrupUSDG is priced using the Maple syrupUSDG/USDG internal exchange rate (`convertToExitAssets`) combined with the Chainlink USDG/USD feed via a CAPO adapter, configured with a snapshot delay of 7 days and a `maxYearlyRatioGrowthPercent` of 8.45%.

## Disclaimer

Aave Labs has no direct financial relationship with Maple Finance, Global Dollar, or any of their affiliates and has not received compensation from either party in connection with this proposal.

## References

- Implementation: [TO BE ADDED]
- Tests: [TO BE ADDED]
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-syrupusdg-on-aave-v4-global-dollar-hub/25281)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
