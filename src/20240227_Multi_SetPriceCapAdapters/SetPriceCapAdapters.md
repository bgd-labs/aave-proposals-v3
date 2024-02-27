---
title: "Set Price Cap Adapters"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/bgd-correlated-asset-price-oracle/16133"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x387f779952a20e850f941111ccf7aa49022ee35274fd219b9759c0ea240b72e1"
---

## Simple Summary

This proposal aims to use correlated-assets price oracle (CAPO) for LSTs and USD-pegged stable coins.

## Motivation

LSTs (Liquid Staking Tokens) are highly correlated to an underlying, with an additional growth component on top of it, and sometimes, slashing dynamics. CAPO for this use case adds an upper side protection. Every time the price adapter is queried, it will get the current ratio of the asset/underlying and compared it with a dynamically calculated upper value of that ratio, using the previously defined parameters. If the current ratio is above the ratio cap, the ratio cap is returned. If not, the current ratio is.

In some cases, the relation between an underlying asset and its correlated is direct, without any type of continuous growth expected. For example, this is the case of USD-pegged stable coins, where USD is the underlying and let's say USDC is the correlated asset. For this type of assets we'll apply the price adapter with the fixed price cap.

## Specification

- [Capped price adapters implementation](https://github.com/bgd-labs/aave-capo)
- [Risk providers parameters recommendations](https://governance.aave.com/t/chaos-labs-correlated-asset-price-oracle-framework/16605)

| Asset   | Growth percent | Snapshot delay |
| ------- | -------------- | -------------- |
| wstETH  | 9.68%          | 7 days         |
| rETH    | 9.3%           | 7 days         |
| sDAI    | 10.15%         | 7 days         |
| cbETH   | 8.12%          | 7 days         |
| MaticX  | 10.2%          | 14 days        |
| stMATIC | 10.45%         | 14 days        |
| sAVAX   | 10.1%          | 14 days        |
| stEUR   | 9.26%          |                |

All stablecoins are capped at 4%.

# Security

- [Audit by Certora](TODO: pase link when available)
- A retrospective test was conducted for the last half year with the parameters provided, which showed that the price was not capped, which is expected
- Inner review at BGD

## References

- Payloads: [AaveV3Ethereum](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV3EthereumPayload.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV3PolygonPayload.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV3AvalanchePayload.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV3ArbitrumPayload.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV3OptimismPayload.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV3MetisPayload.sol), [AaveV3Base](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV3BasePayload.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV3GnosisPayload.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV3BNBPayload.sol)
- Tests:

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
