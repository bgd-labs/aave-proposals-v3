---
title: "Hyperlane bridge adapter update to V3"
author: "BGD Labs @bgdlabs"
discussions: ""
---

## Simple Summary

This proposal updates the bridge Hyperlane bridge adapters used on a.DI to connect Ethereum with Polygon, Avalanche, Binance and Gnosis to the new
Hyperlane V3 version.

## Motivation

The main motivation of this proposal is to bring the Hyperlane bridge adapters to the up to date version (V3)

## Specification

Updates the Hyperlane bridge adapters used to connect between networks to Hyperlane V3 and it also adds Adapter Name to the contracts
to make it easy to track off chain

| Network   | Hyperlane                                                                                                                |
| --------- | ------------------------------------------------------------------------------------------------------------------------ |
| Ethereum  | [0x01dcb90Cf13b82Cde4A0BAcC655585a83Af3cCC1](https://etherscan.io/address/0x01dcb90Cf13b82Cde4A0BAcC655585a83Af3cCC1)    |
| Polygon   | [0x3e72665008dC237bdd91C04C10782Ed1987a4019](https://polygonscan.com/address/0x3e72665008dC237bdd91C04C10782Ed1987a4019) |
| Avalanche | [0x617332a777780F546261247F621051d0b98975Eb](https://snowscan.xyz/address/0x617332a777780F546261247F621051d0b98975Eb)    |
| Binance   | [0x3F006299eC88985c18E6e885EeA29A49eC579882](https://bscscan.com/address/0x3F006299eC88985c18E6e885EeA29A49eC579882)     |
| Gnosis    | [0xA806DA549FcB2B4912a7dFFE4c1aA7A1ed0Bd5C9](https://bscscan.com/address/0xA806DA549FcB2B4912a7dFFE4c1aA7A1ed0Bd5C9)     |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Ethereum_HyperlaneBridgeAdapterUpdateToV3_20240320.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Polygon_HyperlaneBridgeAdapterUpdateToV3_20240320.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Gnosis_HyperlaneBridgeAdapterUpdateToV3_20240320.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3BNB_HyperlaneBridgeAdapterUpdateToV3_20240320.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Ethereum_HyperlaneBridgeAdapterUpdateToV3_20240320.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Polygon_HyperlaneBridgeAdapterUpdateToV3_20240320.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Gnosis_HyperlaneBridgeAdapterUpdateToV3_20240320.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3BNB_HyperlaneBridgeAdapterUpdateToV3_20240320.t.sol)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
