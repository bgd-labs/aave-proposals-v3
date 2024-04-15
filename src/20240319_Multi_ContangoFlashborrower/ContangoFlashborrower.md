---
title: "Contango FlashBorrower"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-add-contango-protocol-cian-protocol-and-index-coop-to-flashborrowers-on-aave-v3/16478"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x09bb9e7cffc974d330d82ce7a0b0502b573d6f3b4f839ea15d6629613901e96d"
---

## Simple Summary

This AIP extend free Flashloans abilities of Contango protocol to every network Aave has presence except Metis Network

## Motivation

This AIP is the natural following of [AIP 48](https://vote.onaave.com/proposal/?proposalId=48&ipfsHash=0x925b92bc979665e02c8d91956e8c01dd9e5e4b9fbb3e2c5ab018b4a6a91e6d00) that successfully added a set of 4 protocols into the FlashBorrower protocol whitelist.
One of them was Contango and this proposal will extend this whitelisting to all networks.

## Specification

This proposal aims to implement a single AIP, utilizing several similar payloads (one for each network), which will call addFlashBorrower() on the ACL_MANAGER contract to whitelist `0xab515542d621574f9b5212d50593cD0C07e641bD` contract address.

Please note that for deployment reasons the contango contract address on Scroll, BNB & Avalanche networks is `0x14F8e5Fe35b2d0D67dBcE9329f1b5d09f60c06C3`

## References

- Implementation: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/e5a6d3cf7cbe31fb6485ef3998f8370e977d5ef9/src/20240319_Multi_ContangoFlashborrower/AaveV3Base_ContangoFlashborrower_20240319.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/e5a6d3cf7cbe31fb6485ef3998f8370e977d5ef9/src/20240319_Multi_ContangoFlashborrower/AaveV3Avalanche_ContangoFlashborrower_20240319.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/e5a6d3cf7cbe31fb6485ef3998f8370e977d5ef9/src/20240319_Multi_ContangoFlashborrower/AaveV3Polygon_ContangoFlashborrower_20240319.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/e5a6d3cf7cbe31fb6485ef3998f8370e977d5ef9/src/20240319_Multi_ContangoFlashborrower/AaveV3Gnosis_ContangoFlashborrower_20240319.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/e5a6d3cf7cbe31fb6485ef3998f8370e977d5ef9/src/20240319_Multi_ContangoFlashborrower/AaveV3BNB_ContangoFlashborrower_20240319.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/e5a6d3cf7cbe31fb6485ef3998f8370e977d5ef9/src/20240319_Multi_ContangoFlashborrower/AaveV3Scroll_ContangoFlashborrower_20240319.sol)
- Tests: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/e5a6d3cf7cbe31fb6485ef3998f8370e977d5ef9/src/20240319_Multi_ContangoFlashborrower/AaveV3Base_ContangoFlashborrower_20240319.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/e5a6d3cf7cbe31fb6485ef3998f8370e977d5ef9/src/20240319_Multi_ContangoFlashborrower/AaveV3Avalanche_ContangoFlashborrower_20240319.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/e5a6d3cf7cbe31fb6485ef3998f8370e977d5ef9/src/20240319_Multi_ContangoFlashborrower/AaveV3Polygon_ContangoFlashborrower_20240319.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/e5a6d3cf7cbe31fb6485ef3998f8370e977d5ef9/src/20240319_Multi_ContangoFlashborrower/AaveV3Gnosis_ContangoFlashborrower_20240319.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/e5a6d3cf7cbe31fb6485ef3998f8370e977d5ef9/src/20240319_Multi_ContangoFlashborrower/AaveV3BNB_ContangoFlashborrower_20240319.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/e5a6d3cf7cbe31fb6485ef3998f8370e977d5ef9/src/20240319_Multi_ContangoFlashborrower/AaveV3Scroll_ContangoFlashborrower_20240319.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x09bb9e7cffc974d330d82ce7a0b0502b573d6f3b4f839ea15d6629613901e96d)
- [Discussion](https://governance.aave.com/t/arfc-add-contango-protocol-cian-protocol-and-index-coop-to-flashborrowers-on-aave-v3/16478)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
