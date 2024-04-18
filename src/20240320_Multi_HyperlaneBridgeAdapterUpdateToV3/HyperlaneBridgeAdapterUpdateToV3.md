---
title: "Hyperlane bridge adapter update to V3 and removal of old native bridge adapters"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/31"
---

## Simple Summary

This proposal updates the bridge Hyperlane bridge adapters used on a.DI to connect Ethereum with Polygon, Avalanche, Binance and Gnosis to the new
Hyperlane V3 version.
Additionally, removes old native bridges on Optimism, Base, Arbitrum, Scroll and Metis, after verifying that the new active versions work properly.

## Motivation

The main motivation of this proposal is to bring the Hyperlane bridge adapters to the up to date version (V3).

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

To add the new forwarder adapters the method `function enableBridgeAdapters(ForwarderBridgeAdapterConfigInput[] memory bridgeAdapters) external` will be used,
and to remove the old forwarder adapters, the method `function disableBridgeAdapters(BridgeAdapterToDisable[] memory bridgeAdapters) external` will be called on each CrossChainController.

To add the new receiver adapters the method `function allowReceiverBridgeAdapters(ReceiverBridgeAdapterConfigInput[] memory bridgeAdaptersInput) external` will be used,
and to remove the old receiver adapters, the method `function disallowReceiverBridgeAdapters(ReceiverBridgeAdapterConfigInput[] memory bridgeAdaptersInput) external` will be called on each CrossChainController.

The old native receiver bridge adapters to remove are:

| Network  | Native adapters                                                                                                                   |
| -------- | --------------------------------------------------------------------------------------------------------------------------------- |
| Arbitrum | [0x3829943c53F2d00e20B58475aF19716724bF90Ba](https://arbiscan.io/address/0x3829943c53F2d00e20B58475aF19716724bF90Ba)              |
| Base     | [0x7b62461a3570c6AC8a9f8330421576e417B71EE7](https://basescan.org/address/0x7b62461a3570c6AC8a9f8330421576e417B71EE7)             |
| Metis    | [0x746c675dAB49Bcd5BB9Dc85161f2d7Eb435009bf](https://explorer.metis.io/address/0x746c675dAB49Bcd5BB9Dc85161f2d7Eb435009bf)        |
| Optimism | [0x81d32B36380e6266e1BDd490eAC56cdB300afBe0](https://optimistic.etherscan.io//address/0x81d32B36380e6266e1BDd490eAC56cdB300afBe0) |
| Scroll   | [0x118DFD5418890c0332042ab05173Db4A2C1d283c](https://scrollscan.com/address/0x118DFD5418890c0332042ab05173Db4A2C1d283c)           |

Code diffs for the different networks can be checked on a.DI diff repository for [revision 2](https://github.com/bgd-labs/aDI-diffs/tree/main/diffs/rev2).
Adapter diffs: [HLAdapter](https://github.com/bgd-labs/aDI-diffs/tree/main/diffs/rev2/hyperlane), [BaseAdapter](https://github.com/bgd-labs/aDI-diffs/tree/main/diffs/rev2/base_adapter), [IBaseAdapter](https://github.com/bgd-labs/aDI-diffs/tree/main/diffs/rev2/i_base_adapter)

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Ethereum_HyperlaneBridgeAdapterUpdateToV3_20240320.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Polygon_HyperlaneBridgeAdapterUpdateToV3_20240320.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Gnosis_HyperlaneBridgeAdapterUpdateToV3_20240320.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3BNB_HyperlaneBridgeAdapterUpdateToV3_20240320.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Scroll_HyperlaneBridgeAdapterUpdateToV3_20240320.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Arbitrum_HyperlaneBridgeAdapterUpdateToV3_20240320.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Optimism_HyperlaneBridgeAdapterUpdateToV3_20240320.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Metis_HyperlaneBridgeAdapterUpdateToV3_20240320.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Base_HyperlaneBridgeAdapterUpdateToV3_20240320.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Ethereum_HyperlaneBridgeAdapterUpdateToV3_20240320.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Polygon_HyperlaneBridgeAdapterUpdateToV3_20240320.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Gnosis_HyperlaneBridgeAdapterUpdateToV3_20240320.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3BNB_HyperlaneBridgeAdapterUpdateToV3_20240320.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Scroll_HyperlaneBridgeAdapterUpdateToV3_20240320.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Arbitrum_HyperlaneBridgeAdapterUpdateToV3_20240320.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Optimism_HyperlaneBridgeAdapterUpdateToV3_20240320.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Metis_HyperlaneBridgeAdapterUpdateToV3_20240320.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_Multi_HyperlaneBridgeAdapterUpdateToV3/AaveV3Base_HyperlaneBridgeAdapterUpdateToV3_20240320.t.sol)
- [Discussion](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/31)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
