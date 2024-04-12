---
title: "LayerZero bridge adapter update to V2"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/29"
---

## Simple Summary

This proposal updates the LayerZero bridge adapters used on a.DI to connect Ethereum with Polygon, Avalanche, Binance and Gnosis to the new
LayerZero V2 version.

## Motivation

The main motivation of this proposal is to bring the LayerZero bridge adapters to the up to date version (V2)

## Specification

Updates the LayerZero bridge adapters used to connect between networks to LayerZero V2 and it also adds Adapter Name to the contracts
to make it easy to track off chain

| Network   | LayerZero                                                                                                                |
| --------- | ------------------------------------------------------------------------------------------------------------------------ |
| Ethereum  | [0x8410d9BD353b420ebA8C48ff1B0518426C280FCC](https://etherscan.io/address/0x8410d9BD353b420ebA8C48ff1B0518426C280FCC)    |
| Polygon   | [0x7FAE7765abB4c8f778d57337bB720d0BC53057e3](https://polygonscan.com/address/0x7FAE7765abB4c8f778d57337bB720d0BC53057e3) |
| Avalanche | [0x10f02995a399C0dC0FaF29914220E9C1bCdE8640](https://snowscan.xyz/address/0x10f02995a399C0dC0FaF29914220E9C1bCdE8640)    |
| Binance   | [0xa5cc218513305221201f196760E9e64e9D49d98A](https://bscscan.com/address/0xa5cc218513305221201f196760E9e64e9D49d98A)     |
| Gnosis    | [0x9b6f5ef589A3DD08670Dd146C11C4Fb33E04494F](https://gnosisscan.io/address/0x9b6f5ef589A3DD08670Dd146C11C4Fb33E04494F)   |

Code diffs for the different networks can be checked on a.DI diff repository for [revision 2](https://github.com/bgd-labs/aDI-diffs/tree/main/diffs/rev2).
Adapter diffs: [LayerZeroAdapter](https://github.com/bgd-labs/aDI-diffs/tree/main/diffs/rev2/layerzero), [BaseAdapter](https://github.com/bgd-labs/aDI-diffs/tree/main/diffs/rev2/base_adapter), [IBaseAdapter](https://github.com/bgd-labs/aDI-diffs/tree/main/diffs/rev2/i_base_adapter)

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240322_Multi_LayerZeroBridgeAdapterUpdateToV2/AaveV3Ethereum_LayerZeroBridgeAdapterUpdateToV2_20240322.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240322_Multi_LayerZeroBridgeAdapterUpdateToV2/AaveV3Polygon_LayerZeroBridgeAdapterUpdateToV2_20240322.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240322_Multi_LayerZeroBridgeAdapterUpdateToV2/AaveV3Avalanche_LayerZeroBridgeAdapterUpdateToV2_20240322.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240322_Multi_LayerZeroBridgeAdapterUpdateToV2/AaveV3Gnosis_LayerZeroBridgeAdapterUpdateToV2_20240322.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240322_Multi_LayerZeroBridgeAdapterUpdateToV2/AaveV3BNB_LayerZeroBridgeAdapterUpdateToV2_20240322.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240322_Multi_LayerZeroBridgeAdapterUpdateToV2/AaveV3Ethereum_LayerZeroBridgeAdapterUpdateToV2_20240322.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240322_Multi_LayerZeroBridgeAdapterUpdateToV2/AaveV3Polygon_LayerZeroBridgeAdapterUpdateToV2_20240322.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240322_Multi_LayerZeroBridgeAdapterUpdateToV2/AaveV3Avalanche_LayerZeroBridgeAdapterUpdateToV2_20240322.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240322_Multi_LayerZeroBridgeAdapterUpdateToV2/AaveV3Gnosis_LayerZeroBridgeAdapterUpdateToV2_20240322.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240322_Multi_LayerZeroBridgeAdapterUpdateToV2/AaveV3BNB_LayerZeroBridgeAdapterUpdateToV2_20240322.t.sol)
- [Discussion](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/29)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
