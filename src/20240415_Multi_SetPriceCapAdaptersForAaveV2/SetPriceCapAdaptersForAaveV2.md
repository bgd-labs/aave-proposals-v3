---
title: "Set Price Cap Adapters for Aave V2"
author: "BGD Labs @bgdlabs"
discussions: ""
---

## Simple Summary

This proposal activates the correlated-assets price oracle (CAPO) system for fiat-pegged stable coins on Aave V2 pools.

## Motivation

To continue enhancing the security of the protocol using CAPO and to align with the recent V3 update, we are introducing the activation of the CAP adapters for the Aave V2 pools. As no LSTs are listed on the V2, we are only applying the adapters to the fiat-pegged stablecoins.

## Specification

- [Capped price adapters implementation](https://github.com/bgd-labs/aave-capo)
- [Risk providers parameters recommendations]()

| Asset | Cap |
| ----- | --- |
| USDC  | 4%  |
| USDT  | 4%  |
| DAI   | 4%  |
| USDP  | 4%  |
| sUSD  | 4%  |
| FRAX  | 4%  |
| LUSD  | 10% |
| BUSD  | 4%  |
| TUSD  | 4%  |
| UST   | 4%  |

GUSD and FEI won't be updated as the fixed price oracles are used for them.

As Ethereum and Polygon pools use ETH-based oracles, the composition of the adapters will be used: [CAP adapter for stables](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/PriceCapAdapterStable.sol) + [base-to-peg](https://github.com/bgd-labs/cl-synchronicity-price-adapter/blob/main/src/contracts/CLSynchronicityPriceAdapterBaseToPeg.sol).

Oracles will be updated using `ORACLE.setAssetSource()` method. Below is the list of assets per network to be updated:

| Network   | Stables                                                             |
| --------- | ------------------------------------------------------------------- |
| Mainnet   | USDC, USDT, DAI, USDP, sUSD, FRAX, GUSD, LUSD, BUSD, TUSD, UST, FEI |
| Avalanche | USDC.e, USDT.e, DAI.e                                               |
| Polygon   | USDC.e, USDT, DAI                                                   |

## References

- Implementation: [AaveV2Ethereum](), [AaveV2EthereumAMM](), [AaveV2Polygon](), [AaveV2Avalanche]()
- Tests: [AaveV2Ethereum](), [AaveV2EthereumAMM](), [AaveV2Polygon](), [AaveV2Avalanche]()
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
