---
title: "June Funding Update - Part I"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-june-2025-funding-update/22352/2"
---

## Simple Summary

This publication presents the Part 1 of the June Funding Update, consisting of the following key activities:

- Continue AAVE buybacks for 2 weeks.

## Motivation

This publication focuses on supporting near term operational funding requirements.
Specifically, this proposal funds the next 2 weeks of AAVE buybacks, while part 2 will focus on acquiring GHO and funding Merit and Ahab.

## Specification

##### AAVE Buybacks

Create a 2M aEthUSDT allowance for the Aave Finance Committee to perform AAVE buybacks over the next two out of the eight weeks.

Asset: aEthUSDT `0x23878914EFE38d27C4D67Ab83ed1b93A74D4086a`
Amount: 2M

Spender: AFC [0x22740deBa78d5a0c24C58C740e3715ec29de1bFa](https://etherscan.io/address/0x22740deBa78d5a0c24C58C740e3715ec29de1bFa)

Method: approve() aEthUSDT on the Aave Collector contract to the AFC address.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250613_AaveV3Ethereum_JuneFundingUpdate/AaveV3Ethereum_JuneFundingUpdate_20250613.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250613_AaveV3Ethereum_JuneFundingUpdate/AaveV3Ethereum_JuneFundingUpdate_20250613.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-june-2025-funding-update/22352/2)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
