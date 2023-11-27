---
title: "Update PriceOracleSentinel"
author: "BGD Labs (@bgdlabs)"
---

## Simple Summary

Patches PriceOracleSentinel contract on Aave V3 Arbitrum, Optimism, Base and Metis.

## Motivation

The PriceOracleSentinel contract was incorrectly reading the Chainlink L2 sequencer upfeed state, instead of reading the timestamp value when the sequencer status changed, the contract was reading the timestamp value of the health check which was updated every 24 hours.
This resulted in borrowing and liquidation being paused everyday for 1 hour on Aave V3 Arbitrum, Optimism, Base and Metis. This AIP patches this issue, and updates the PriceOracleSentinel contract.

This issue was submitted via the immunefi program.

## Specification

Upon execution, the proposal will call `POOL_ADDRESSES_PROVIDER.setPriceOracleSentinel(NEW_PRICE_ORACLE_SENTINEL)` on the addresses provider contract and set the new implementation of the PriceOracleSentinel contract on Aave V3 Arbitrum, Optimism, Base and Metis.

## References

- Implementation: [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231125_Multi_UpdatePriceOracleSentinel/AaveV3Optimism_UpdatePriceOracleSentinel_20231125.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231125_Multi_UpdatePriceOracleSentinel/AaveV3Arbitrum_UpdatePriceOracleSentinel_20231125.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231125_Multi_UpdatePriceOracleSentinel/AaveV3Metis_UpdatePriceOracleSentinel_20231125.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231125_Multi_UpdatePriceOracleSentinel/AaveV3Base_UpdatePriceOracleSentinel_20231125.sol)
- Tests: [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231125_Multi_UpdatePriceOracleSentinel/AaveV3Optimism_UpdatePriceOracleSentinel_20231125.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231125_Multi_UpdatePriceOracleSentinel/AaveV3Arbitrum_UpdatePriceOracleSentinel_20231125.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231125_Multi_UpdatePriceOracleSentinel/AaveV3Metis_UpdatePriceOracleSentinel_20231125.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231125_Multi_UpdatePriceOracleSentinel/AaveV3Base_UpdatePriceOracleSentinel_20231125.t.sol)
- Diffs:

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
