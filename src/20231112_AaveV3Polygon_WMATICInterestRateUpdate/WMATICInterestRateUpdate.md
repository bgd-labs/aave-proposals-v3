---
title: "wMATIC Interest Rate Update"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-wmatic-interest-rate-update/15309"
---

## Simple Summary

This AIP will reduce the wMATIC Slope1 parameters from 6.10% to 5.00% Aave v3 Polygon.

## Motivation

This AIP will reduce the slope1 paramter to 5.00%. This is higher than the current MaticX and stMATIC yield rate whilst marginally lower than the existing borrow rate.

v3 wMATIC Borrow Rate: [5.96% APY](https://app.aave.com/reserve-overview/?underlyingAsset=0x0d500b1d8e8ef31e21c99d1db9a6444d3adf1270)
MaticX APR: [4.68%](https://www.staderlabs.com/polygon/stake/)
stMATIC APR: [4.30%](https://lido.fi/)

Upon implementing this AIP, the borrow rate is anticipated to decrease to below 5.00%, current utilization is less than the Uoptimal value. The demand from yield-maximizing strategies is expected to create consistent demand for borrowing wMATIC. Over time, this is projected to establish a floor under wMATIC borrow rates.

## Specification

Revise the interest rate strategy as per below:

wMATIC Address: [`0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270`](https://polygonscan.com/address/0x0d500b1d8e8ef31e21c99d1db9a6444d3adf1270)

variableRateSlope1: From 6.10% to 5.00%

All other parameters remain the same as the [existing interest rate startegy](https://polygonscan.com/address/0xFB0898dCFb69DF9E01DBE625A5988D6542e5BdC5#code).

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/c048473176d13990128cba052353ad4de524ab5c/src/20231112_AaveV3Polygon_WMATICInterestRateUpdate/AaveV3Polygon_WMATICInterestRateUpdate_20231112.sol)
- Tests: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/c048473176d13990128cba052353ad4de524ab5c/src/20231112_AaveV3Polygon_WMATICInterestRateUpdate/AaveV3Polygon_WMATICInterestRateUpdate_20231112.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xdc1c37a14bd416c6c8ab15a472348bf933c2fec33678fe94ba6c15cbc30c2812)
- [Discussion](https://governance.aave.com/t/arfc-wmatic-interest-rate-update/15309)

# Disclaimer

TokenLogic receives no compensation beyond Aave protocol for the creation of this proposal. TokenLogic is a delegate within the Aave ecosystem.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
