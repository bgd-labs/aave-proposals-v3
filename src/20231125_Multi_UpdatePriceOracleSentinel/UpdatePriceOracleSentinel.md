---
title: "Update PriceOracleSentinel"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/8"
---

## Simple Summary

This proposal aligns the Aave PriceOracleSentinel in both Arbitrum and OP stack, to common and correct logic.

## Motivation

Compared with Arbitrum, the L2Sequencer Chainlink feed on OP stack networks behaves differently: it updates every 24 hours as a health check, instead of only when the status (up or down) of the sequencer changes.

In order to be fully precise and avoid unexpected downtime, the approach should be unified across networks.

## Specification

Upon execution, the proposal will call `POOL_ADDRESSES_PROVIDER.setPriceOracleSentinel(NEW_PRICE_ORACLE_SENTINEL)` on the addresses provider contract and set the new implementation of the PriceOracleSentinel contract on Aave V3 Arbitrum, Optimism, Base and Metis.

## References

- Implementation: [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/8db6f521a4d8eb9da7a258c4e99c8ac1695ba64f/src/20231125_Multi_UpdatePriceOracleSentinel/AaveV3Optimism_UpdatePriceOracleSentinel_20231125.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/8db6f521a4d8eb9da7a258c4e99c8ac1695ba64f/src/20231125_Multi_UpdatePriceOracleSentinel/AaveV3Arbitrum_UpdatePriceOracleSentinel_20231125.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/8db6f521a4d8eb9da7a258c4e99c8ac1695ba64f/src/20231125_Multi_UpdatePriceOracleSentinel/AaveV3Metis_UpdatePriceOracleSentinel_20231125.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/8db6f521a4d8eb9da7a258c4e99c8ac1695ba64f/src/20231125_Multi_UpdatePriceOracleSentinel/AaveV3Base_UpdatePriceOracleSentinel_20231125.sol)
- Tests: [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/8db6f521a4d8eb9da7a258c4e99c8ac1695ba64f/src/20231125_Multi_UpdatePriceOracleSentinel/AaveV3Optimism_UpdatePriceOracleSentinel_20231125.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/8db6f521a4d8eb9da7a258c4e99c8ac1695ba64f/src/20231125_Multi_UpdatePriceOracleSentinel/AaveV3Arbitrum_UpdatePriceOracleSentinel_20231125.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/8db6f521a4d8eb9da7a258c4e99c8ac1695ba64f/src/20231125_Multi_UpdatePriceOracleSentinel/AaveV3Metis_UpdatePriceOracleSentinel_20231125.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/8db6f521a4d8eb9da7a258c4e99c8ac1695ba64f/src/20231125_Multi_UpdatePriceOracleSentinel/AaveV3Base_UpdatePriceOracleSentinel_20231125.t.sol)
- [Discussion](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/8)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
