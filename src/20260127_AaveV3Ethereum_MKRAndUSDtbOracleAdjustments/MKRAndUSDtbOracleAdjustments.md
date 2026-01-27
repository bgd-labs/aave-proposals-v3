---
title: "MKR and USDtb oracle adjustments"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/direct-to-aip-mkr-and-usdtb-oracle-adjustments/23911"
---

## Simple Summary

Proposal to, on Aave v3 Ethereum Core, replace the price feed of MKR with one calculated from SKY/USD Chainlink and the MKR-to-SKY migration contract, and USDtb by one statically pegged to 1 USD.

## Motivation

As described by Aave risk providers, with the running MKR to SKY migration, liquidity on secondary market for MKR has decreased, and sourcing its price from that has become fragile. Given that the asset can be migrated at a fixed exchange rate (24000 SKY for 1 MKR) on-chain, it is natural to price the legacy MKR statically, based on that rate and the discount progressively increasing to encourage migration.

Regarding USDtb, similar to other only-borrowable assets, for the Aave protocol is only positive to price it at a price of 1 USD, conservatively, thereby abstracting from temporary liquidity (hence price) dislocations.

There is a slight deviation on the technical implementation of the MKR/USD feed, to be dynamic in regards to the migration discount, instead of the initially defined 6% static by risk providers. More details in the References section.

## Specification

The proposal payload will do the following oracle price feeds replacement v3 Ethereum Core.

| Network | Parameter  | Current                                                                                                                  | Proposed                                                                                                                                                 |
| ------- | ---------- | ------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| MKR     | Price Feed | [MKR / USD Chainlink](https://etherscan.io/address/0xec1D1B3b0443256cc3860e24a46F108e699484Aa#code) (~$1501.49)          | [MKR / USD (calculated from SKY/USD and migration contract)](https://etherscan.io/address/0x44Bb2a64bAf94210B583338D3D97b1e8288Bd478#code) (~$1494.9540) |
| USDtb   | Price Feed | [CAPO over USDtb / USD Chainlink](https://etherscan.io/address/0x2FA6A78E3d617c1013a22938411602dc9Da98dBa#code) ($0.999) | [Fixed ONE USD](https://etherscan.io/address/0x88025072a7db6db5e54e46d43850bb44ca93d6c0#code) ($1)                                                       |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_AaveV3Ethereum_MKRAndUSDtbOracleAdjustments/AaveV3Ethereum_MKRAndUSDtbOracleAdjustments_20260127.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_AaveV3Ethereum_MKRAndUSDtbOracleAdjustments/AaveV3Ethereum_MKRAndUSDtbOracleAdjustments_20260127.t.sol)
- [DiscountedMKRSKYAdapter](https://github.com/bgd-labs/aave-price-feeds/blob/main/src/contracts/misc-adapters/DiscountedMKRSKYAdapter.sol)
- [OneUSDFixedAdapter](https://github.com/bgd-labs/aave-price-feeds/blob/main/src/contracts/misc-adapters/OneUSDFixedAdapter.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-mkr-and-usdtb-oracle-adjustments/23911)
- [Final pricing approach for MKR/USD by BGD](https://governance.aave.com/t/direct-to-aip-mkr-and-usdtb-oracle-adjustments/23911/4)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
