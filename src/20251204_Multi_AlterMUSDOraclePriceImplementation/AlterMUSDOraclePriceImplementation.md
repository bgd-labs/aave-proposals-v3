---
title: "Alter mUSD Oracle Price Implementation"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/direct-to-aip-alter-musd-oracle-price-implementation/23489"
---

## Simple Summary

This proposal re-enables economically meaningful supply and borrow caps for MetaMask USD (mUSD) on the Aave v3 Ethereum and Linea deployments while swapping the oracle feed on both networks to a static $1 adapter. The action follows the Chaos Labs recommendation to neutralize transient oracle mispricing that briefly pushed the feed below parity despite the asset remaining redeemable at $1.

## Motivation

Chaos Labs observed short-lived but material negative deviations in the current mUSD feed, driven by thin liquidity on the reporting venues. Because mUSD is borrow-only on the affected markets, these deviations solely benefit borrowers by letting them accrue liabilities below their true value, exposing the DAO to manipulation and accounting risk. Hardcoding the oracle to a $1 adapter eliminates this tail while keeping the protocol conservative in a genuine depeg: debt remains denominated at par, enabling liquidators to source cheaper mUSD and reducing the likelihood of bad debt. After the Risk Steward temporarily set the caps to 1 to block opportunistic borrowing during the governance process, this payload restores capacity to levels aligned with the forum specification.

## Specification

### Ethereum v3

| Parameter  | Current     | Proposed                                                              |
| ---------- | ----------- | --------------------------------------------------------------------- |
| Supply Cap | 1 mUSD      | 5,000,000 mUSD                                                        |
| Borrow Cap | 1 mUSD      | 4,500,000 mUSD                                                        |
| Oracle     | Market feed | Fixed mUSD / USD adapter `0x8adb5187695F773513dEC4b569d21db0341931dA` |

### Linea v3

| Parameter  | Current     | Proposed                                                              |
| ---------- | ----------- | --------------------------------------------------------------------- |
| Supply Cap | 1 mUSD      | 20,000,000 mUSD                                                       |
| Borrow Cap | 1 mUSD      | 18,000,000 mUSD                                                       |
| Oracle     | Market feed | Fixed mUSD / USD adapter `0xA77b1C51a76bbB72D17BF467393a540868103097` |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251204_Multi_AlterMUSDOraclePriceImplementation/AaveV3Ethereum_AlterMUSDOraclePriceImplementation_20251204.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251204_Multi_AlterMUSDOraclePriceImplementation/AaveV3Linea_AlterMUSDOraclePriceImplementation_20251204.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251204_Multi_AlterMUSDOraclePriceImplementation/AaveV3Ethereum_AlterMUSDOraclePriceImplementation_20251204.t.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251204_Multi_AlterMUSDOraclePriceImplementation/AaveV3Linea_AlterMUSDOraclePriceImplementation_20251204.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-alter-musd-oracle-price-implementation/23489)
- Snapshot: Direct To AIP

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
