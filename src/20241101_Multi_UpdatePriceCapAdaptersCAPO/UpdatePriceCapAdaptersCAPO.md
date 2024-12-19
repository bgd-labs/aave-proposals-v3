---
title: "CAPO Adapter Maintenance Update"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/55"
---

## Simple Summary

Maintenance proposal to update stable price cap adapters across all v2 and v3 instances to the latest version.
The sDAI adapters on Ethereum and Gnosis Aave instances are also updated from non-capo to capo adapters, and USDS adapters are updated to use USDS/USD feed from the previous DAI/USD feed, given that liquidity of USDS is perfectly normalized.

## Motivation

With the Aave Generalized Risk Stewards (AGRS) being activated on proposal 197 it is important to update the CAPO adapters for stablecoins across both Aave V2 and V3 instances for it to work seamlessly with the new system. Currently this is not possible, because certain CAPOs are missing a getter method getPriceCap() which prevents the AGRS system from updating the price caps.

The CAPO adapter for sDAI was not activated before due to its un-stability on its growth rate, but with positive signaling from Chaos Labs, it is now to be enabled on Aave V3 Ethereum and Aave V3 Gnosis instances.

USDS asset was listed with a Chainlink DAI/USD underlying feed as given the asset was just released, and its underlying equivalence with DAI. Since USDS is totally stable now, it is reasonable to migrate to an USDS/USD feed.

## Specification

The following stable-coin CAPO feeds are being updated across all networks and instances:

| Aave Instances        | Underlying assets for which CAPO feed is updated         |
| --------------------- | -------------------------------------------------------- |
| AaveV3Ethereum        | USDC, USDT, USDS, DAI, LUSD, FRAX, crvUSD, pyUSD, sDAI   |
| AaveV3EthereumLido    | USDC, USDS                                               |
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

Price Feeds will be updated using `AAVE_ORACLE.setAssetSource()` method on Aave V2 Instances and using config-engine on Aave V3 Instances.

_Please note that the configurations for the Price Caps adapters and the underlying chainlink feeds are exactly the same as before. Also, price feeds of AaveV2 instances are updated as their underlying feed used ASSET/USD could also be updated via the Stewards using the AaveV3 ACL_MANAGER contract_

To be more explicit on the code changes between the previous stablecoin CAPO feed and the new one on v3 markets, the following method is being added on the new stablecoin CAPO feed:

```
/// @inheritdoc IPriceCapAdapterStable
function getPriceCap() external view returns (int256) {
	return _priceCap;
}
```

On v2 markets, the code diff between the previous feed and the new feed is zero, however the `ASSET_TO_PEG` underlying feed of the `CLSynchronicityPriceAdapterBaseToPeg` contract uses the new CAPO feed than the previous.

As suggested by Risk Contributors (Chaos Labs), the following configuration for CAPO has been set for sDAI on Aave V3 Ethereum and Gnosis instances:
| maxYearlyRatioGrowthPercent | MINIMUM_SNAPSHOT_DELAY |
| --- | --- |
| 16% | 7 days |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/3fbd35ad5f68b8a91262bb10a9d585ea882142eb/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Ethereum_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/3fbd35ad5f68b8a91262bb10a9d585ea882142eb/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/3fbd35ad5f68b8a91262bb10a9d585ea882142eb/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Avalanche_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/3fbd35ad5f68b8a91262bb10a9d585ea882142eb/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/3fbd35ad5f68b8a91262bb10a9d585ea882142eb/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Arbitrum_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/3fbd35ad5f68b8a91262bb10a9d585ea882142eb/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Metis_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/3fbd35ad5f68b8a91262bb10a9d585ea882142eb/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Base_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/3fbd35ad5f68b8a91262bb10a9d585ea882142eb/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Gnosis_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/3fbd35ad5f68b8a91262bb10a9d585ea882142eb/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Scroll_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/3fbd35ad5f68b8a91262bb10a9d585ea882142eb/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/3fbd35ad5f68b8a91262bb10a9d585ea882142eb/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Ethereum_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/3fbd35ad5f68b8a91262bb10a9d585ea882142eb/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/3fbd35ad5f68b8a91262bb10a9d585ea882142eb/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Avalanche_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/3fbd35ad5f68b8a91262bb10a9d585ea882142eb/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/3fbd35ad5f68b8a91262bb10a9d585ea882142eb/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Arbitrum_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/3fbd35ad5f68b8a91262bb10a9d585ea882142eb/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Metis_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/3fbd35ad5f68b8a91262bb10a9d585ea882142eb/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Base_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/3fbd35ad5f68b8a91262bb10a9d585ea882142eb/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Gnosis_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/3fbd35ad5f68b8a91262bb10a9d585ea882142eb/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Scroll_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/3fbd35ad5f68b8a91262bb10a9d585ea882142eb/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101.t.sol)
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/55)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
