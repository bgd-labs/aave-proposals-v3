---
title: "MaticX Supply Cap Increase in Polygon V3"
author: "Aave Chan Initiative (ACI)"
discussions: "https://governance.aave.com/t/arfc-maticx-supply-cap-increase-in-polygon-v3/16449"
---

## Simple Summary

This proposal aims to increase the MaticX Supply Cap on Polygon V3 to match market demand.

## Motivation

Increasing the supply cap of Polygon MaticX in the Aave market is a strategic move to accommodate growing demand, and follow a previous DAO decision to maintain aggressive supply caps for correlated assets.

Deposits of MaticX have been over 95% of the supply cap for some time. Increasing the Supply Cap will enable users to continue depositing MaticX and enter the recursive MaticX/wMATIC yield strategy.

The DAO has previously voted to allow assets with correlated borrow supply caps to be up to 75% of cumulative supply. Since this exceeds the supply cap increase allowable by risk stewards, this proposal will increase supply caps through the typical ARFC process. Current circulating supply is over 100M, so this proposal will increase the supply cap to 75M.

## Specification

Increase the supply cap for MaticX on Polygon V3 to the following.

| Parameter | Current Value | Proposed Value |
| --------- | ------------- | -------------- |
| SupplyCap | 62M           | 75M            |

Useful Links

- [Previous ARFC MaticX Supply Cap Increase ](https://governance-v2.aave.com/governance/proposal/278/)
- [MaticX in Polygon V3 Market](https://app.aave.com/reserve-overview/?underlyingAsset=0xfa68fb4628dff1028cfec22b4162fccd0d45efb6&marketName=proto_polygon_v3)

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240206_AaveV3Polygon_MaticXSupplyCapIncreaseInPolygonV3/AaveV3Polygon_MaticXSupplyCapIncreaseInPolygonV3_20240206.sol)
- Tests: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240206_AaveV3Polygon_MaticXSupplyCapIncreaseInPolygonV3/AaveV3Polygon_MaticXSupplyCapIncreaseInPolygonV3_20240206.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x73b2f1d14eb6710deabe84639ea8b06929738ef1973fee21c26945d17bf57a5b)
- [Discussion](https://governance.aave.com/t/arfc-maticx-supply-cap-increase-in-polygon-v3/16449)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
