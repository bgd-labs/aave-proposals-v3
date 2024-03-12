---
title: "Set Price Cap Adapters (CAPO)"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/bgd-correlated-asset-price-oracle/16133"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x387f779952a20e850f941111ccf7aa49022ee35274fd219b9759c0ea240b72e1"
---

## Simple Summary

This proposal activates the correlated-assets price oracle (CAPO) system for LSTs and fiat-pegged stable coins.

## Motivation

LSTs (Liquid Staking Tokens) are highly correlated to an underlying, with an additional growth component on top of it, and sometimes, slashing dynamics. CAPO for this use case adds an upper side protection. Every time the price adapter is queried, it will get the current ratio of the asset/underlying and compared it with a dynamically calculated upper value of that ratio, using the previously defined parameters. If the current ratio is above the ratio cap, the ratio cap is returned. If not, the current ratio is.

In some cases, the relation between an underlying asset and its correlated is direct, without any type of continuous growth expected. For example, this is the case of USD-pegged stable coins, where USD is the underlying and let's say USDC is the correlated asset. For this type of assets we'll apply the price adapter with the fixed price cap.

## Specification

- [Capped price adapters implementation](https://github.com/bgd-labs/aave-capo)
- [Risk providers parameters recommendations](https://governance.aave.com/t/chaos-labs-correlated-asset-price-oracle-framework/16605/5)

| Asset   | Growth percent | Snapshot delay |
| ------- | -------------- | -------------- |
| wstETH  | 9.68%          | 7 days         |
| rETH    | 9.3%           | 7 days         |
| cbETH   | 8.12%          | 7 days         |
| MaticX  | 10.2%          | 14 days        |
| stMATIC | 10.45%         | 14 days        |
| sAVAX   | 10.1%          | 14 days        |

All stablecoins are capped at 4%, except LUSD, which is capped at 10%.

sDAI is not included at the moment, given the recent un-stability on its growth rate.

Oracles will be updated using `priceFeedsUpdates()` method of the Config Engine on every network. Below is the list of assets per network to be updated:

| Network   | LSTs                    | Stables                                    |
| --------- | ----------------------- | ------------------------------------------ |
| Mainnet   | wstETH, rETH, cbETH     | USDC, USDT, DAI, FRAX, LUSD, crvUSD, pyUSD |
| Arbitrum  | wstETH, rETH            | USDC, USDC.e, USDT, FRAX, LUSD, MAI        |
| Avalanche | sAvax                   | USDC, USDT, DAI.e, FRAX, MAI               |
| Optimism  | wstETH, rETH            | USDC, USDC.e, USDT, DAI, LUSD, sUSD, MAI   |
| Polygon   | wstETH, stMatic, MaticX | USDC, USDC.e, USDT, DAI, MAI               |
| Gnosis    | wstETH                  | USDC, xDAI                                 |
| Base      | wstETH, cbETH           | USDC                                       |
| Metis     |                         | USDC, USDT, m.DAI                          |
| BNB       |                         | USDC, USDT, fdUSD                          |
| Scroll    | wstETH                  | USDC                                       |

# Security

- [Audit by Certora](https://github.com/bgd-labs/aave-capo/blob/main/certora/CAPO%20report.pdf)
- A retrospective test was conducted for the last half year with the parameters provided, which showed that the price was not capped, which is expected

## References

- Payloads: [AaveV3Ethereum](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV3EthereumPayload.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV3PolygonPayload.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV3AvalanchePayload.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV3ArbitrumPayload.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV3OptimismPayload.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV3MetisPayload.sol), [AaveV3Base](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV3BasePayload.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV3GnosisPayload.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV3BNBPayload.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV3ScrollPayload.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-capo/tree/main/tests/ethereum), [AaveV3Polygon](https://github.com/bgd-labs/aave-capo/tree/main/tests/polygon), [AaveV3Avalanche](https://github.com/bgd-labs/aave-capo/tree/main/tests/avalanche), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-capo/tree/main/tests/arbitrum), [AaveV3Optimism](https://github.com/bgd-labs/aave-capo/tree/main/tests/optimism), [AaveV3Base](https://github.com/bgd-labs/aave-capo/tree/main/tests/base), [AaveV3Gnosis](https://github.com/bgd-labs/aave-capo/tree/main/tests/gnosis), [AaveV3Scroll](https://github.com/bgd-labs/aave-capo/tree/main/tests/scroll)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
