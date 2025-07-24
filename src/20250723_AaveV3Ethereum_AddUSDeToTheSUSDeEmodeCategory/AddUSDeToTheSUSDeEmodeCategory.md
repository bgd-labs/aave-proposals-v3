---
title: "Add USDe to the sUSDe emode Category"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-add-usde-to-the-susde-emode-category/22657"
---

## Simple Summary

This proposal aims to add USDe as collateral to the existing sUSDe/Stablecoins emode category to improve capital efficiency and provide a more cohesive borrowing experience for users of Ethena assets on Aave.

## Motivation

Currently, the sUSDe (Ethena Synthetic USD) has its own e-mode category in Aave, allowing for optimized borrowing for this specific asset. However, USDe, the native stablecoin from Ethena, is not included in this same e-mode category despite being the underlying asset for sUSDe.

### Rationale

- USDe and sUSDe are intrinsically linked, with sUSDe being the staked version of USDe
- Both assets have similar risk profiles and high correlation
- Adding USDe as collateral to the same e-mode category would allow users to add USDe exposure while maintaining their leverage.
- This change would allow borrowers to use either asset as collateral more effectively

## Specification

USDe will be added as collateral to the sUSDe stablecoin emode (id:2)

| Asset | Current    | Proposed   |
| ----- | ---------- | ---------- |
| sUSDe | Collateral | Collateral |
| USDe  | None       | Collateral |
| USDC  | Borrowable | Borrowable |
| USDT  | Borrowable | Borrowable |
| USDS  | Borrowable | Borrowable |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/19c0d37a685dbd81c220d3e2a2f13501f53e6d45/src/20250723_AaveV3Ethereum_AddUSDeToTheSUSDeEmodeCategory/AaveV3Ethereum_AddUSDeToTheSUSDeEmodeCategory_20250723.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/19c0d37a685dbd81c220d3e2a2f13501f53e6d45/src/20250723_AaveV3Ethereum_AddUSDeToTheSUSDeEmodeCategory/AaveV3Ethereum_AddUSDeToTheSUSDeEmodeCategory_20250723.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-add-usde-to-the-susde-emode-category/22657)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
