---
title: "Set Price Cap Adapters for Aave V2"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/30"
---

## Simple Summary

This proposal activates the correlated-assets price oracle (CAPO) system for fiat-pegged stable coins on Aave V2 pools, and does extra miscellaneous updates on price feeds of Aave v2.

## Motivation

To continue enhancing the security of the protocol using CAPO and to align with the recent [approved proposal for Aave v3](https://vote.onaave.com/proposal/?proposalId=51), we are introducing the activation of CAPO adapters for Aave v2 pools. As no LSTs are listed on the v2 (stETH is not applicable), we are only applying the adapters to the fiat-pegged stablecoins.

This proposal also includes an update of the oracle for DPI from DPI / ETH to DPI / USD.

## Specification

- [Capped price adapters implementation](https://github.com/bgd-labs/aave-capo)
- Risk providers parameters recommendations: we have requested recommendations from Chaos Labs for the most appropriate caps for each asset.

Oracles will be updated using `ORACLE.setAssetSource()` method. Below is the list of assets per network to be updated:

**All assets affected**

| Network   | Stables                                                        | Other |
| --------- | -------------------------------------------------------------- | ----- |
| Mainnet   | USDC, USDT, DAI, USDP, sUSD, FRAX, GUSD, LUSD, BUSD, TUSD, UST | DPI   |
| Avalanche | USDC.e, USDT.e, DAI.e                                          |       |
| Polygon   | USDC.e, USDT, DAI                                              |       |

**CAPO configurations**

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

**Misc specifications**

- The adapter for BUSD will be using fdUSD / USD oracle under the hood as the asset is redeemable for fdUSD, and the pure BUSD liquidity is continuously decreasing.
- GUSD and FEI won’t be updated as fixed price oracles are used for them.
- As Ethereum and Polygon pools use ETH-based oracles, the composition of the adapters will be used: [CAP adapter for stables](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/PriceCapAdapterStable.sol) + [base-to-peg](https://github.com/bgd-labs/cl-synchronicity-price-adapter/blob/main/src/contracts/CLSynchronicityPriceAdapterBaseToPeg.sol). This also adds [synchronicity for stablecoins, adding extra protection on edge market conditions](https://governance.aave.com/t/bgd-generalised-price-sync-adapters/11416).
  |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV2/AaveV2EthereumPayload.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV2/AaveV2PolygonPayload.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-capo/blob/main/src/contracts/payloads/AaveV2/AaveV2AvalanchePayload.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-capo/blob/main/tests/AaveV2/payloads/AaveV2EthereumPayloadTest.t.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-capo/blob/main/tests/AaveV2/payloads/AaveV2PolygonPayloadTest.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-capo/blob/main/tests/AaveV2/payloads/AaveV2AvalanchePayloadTest.t.sol)
- [Discussion](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/30)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
