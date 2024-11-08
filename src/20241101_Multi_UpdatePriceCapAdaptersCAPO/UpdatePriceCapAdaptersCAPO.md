---
title: "CAPO Adapter Maintenance Update"
author: "BGD Labs (@bgdlabs)"
discussions: ""
---

## Simple Summary

Maintenance proposal to update stable price cap adapters across all v2 and v3 instances to the latest version. This proposal also renames WMATIC aToken, variableDebtToken to WPOL on Aave V2 and V3 Polygon instances, and migrates Collector MATIC tokens to POL. The sDAI adapters on Ethereum and Gnosis Aave instances are also updated from non-capo to capo adapters.

## Motivation

Correlated-assets price oracle (CAPO) which introduced extra upper price protections for assets highly correlated with an underlying like LST's or stablecoins was activated earlier this year. With the Aave Generalized Risk Stewards (AGRS) being activated, it is important to update the CAPO adapters for stablecoins across both Aave V2 and V3 instances for it to work seamlessly with the AGRS system. The AGRS system can be used to update the price caps of the CAPO adapters, currently the stablecoin CAPO adapters are missing a getter method `getPriceCap()` which prevents the AGRS system to update the price caps. Updating the stablecoin CAPO adapters to the latest version enables AGRS system to update the price caps.

The Polygon ecosystem has migrated its MATIC token to POL token on both Ethereum and Polygon PoS chains. POL is the upgraded native token of Polygon 2.0 and has replaced MATIC as the native gas and staking token of the Polygon PoS network playing a crucial role in the network’s AggLayer. With the MATIC to POL migration complete, we think its a good idea to rename Aave contracts such as aToken and variableDebtToken from WMATIC to WPOL for consistency (more on the [forum](https://governance.aave.com/t/bgd-technical-analysis-matic-pol-migration/18811)). The collector on Ethereum holds around ~580'000 MATIC tokens and it seems reasonable to also migrate it to the new POL token.

CAPO adapter for sDAI was not activated before due to its un-stability on its growth rate, but with positive signaling from Chaos Labs it seems fair to update it to CAPO on Aave V3 Ethereum and Aave V3 Gnosis instances.

## Specification

The following stable-coin CAPO feeds are being updated across all networks and instances:

| Aave Instances        | Underlying assets for which CAPO feed is updated         |
| --------------------- | -------------------------------------------------------- |
| AaveV3Ethereum        | USDC, USDT, DAI, LUSD, FRAX, crvUSD, pyUSD, sDAI         |
| AaveV3EthereumLido    | USDC                                                     |
| AaveV3EthereumEtherFi | USDC, pyUSD, FRAX                                        |
| AaveV2Ethereum        | USDC, USDT, DAI, FRAX, LUSD, USDP, sUSD, BUSD, TUSD, UST |
| AaveV3Polygon         | USDC, USDCn, USDT, DAI, miMATIC,                         |
| AaveV2Polygon         | USDC, USDT, DAI                                          |
| AaveV3Avalanche       | USDC, USDT, DAI, FRAX, MAI                               |
| AaveV2Avalanche       | USDC, USDT, DAI                                          |
| AaveV3Arbitrum        | USDC, USDCn, USDT, DAI, MAI, LUSD, FRAX                  |
| AaveV3Optimism        | USDC, USDCn, USDT, DAI, MAI, LUSD, FRAX                  |
| AaveV3Base            | USDC, USDbC                                              |
| AaveV3BNB             | USDC, USDT, fdUSD                                        |
| AaveV3Gnosis          | USDC, USDCe, wxDAI, sDAI                                 |
| AaveV3Metis           | USDC, USDT, DAI                                          |
| AaveV3Scroll          | USDC                                                     |

Price Feeds will be updated using AAVE\_`ORACLE.setAssetSource()` method on Aave V2 Instances and using config-engine on Aave V3 Instances.

_Please note that the configurations for the Price Caps adapters and the underlying chainlink feeds are exactly the same as before. Also price feeds of AaveV2 instances are updated as their underlying feed used ASSET/USD could also be updated via the Stewards using the AaveV3 ACL_MANAGER contract_

As suggested by Risk Contributors (Chaos Labs), the following configuration for CAPO has been set for sDAI on Aave V3 Ethereum and Gnosis instances:
| maxYearlyRatioGrowthPercent | MINIMUM_SNAPSHOT_DELAY |
| --- | --- |
| 9.69% | 7 days |

For updating the name and symbol for aToken, variableDebtToken on Polygon V3 and V2 contracts, the same instances of contracts have been deployed with bumped revision and are being updated with the following method: `POOL_CONFIGURATOR.updateAToken()` and `POOL_CONFIGURATOR.updateVariableDebtToken()`.

Migration of WMATIC token to WPOL on the Ethereum collector is done 1-to-1 using the [migration contract](https://etherscan.io/address/0x29e7df7b6a1b2b07b731457f499e1696c60e2c4e) with the following method: `MATIC_POL_MIGRATION_CONTRACT.migrate(amount)`

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Ethereum_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Avalanche_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Arbitrum_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Metis_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Base_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Gnosis_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Scroll_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Ethereum_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Avalanche_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Arbitrum_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Metis_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Base_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Gnosis_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Scroll_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101.t.sol)
- Snapshot: Direct To AIP
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
