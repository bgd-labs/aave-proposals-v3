---
title: "Multichain Stable Debt Token Upgrades"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/aave-v2-v3-security-incident-04-11-2023/15335/26"
---

## Simple Summary

This proposal updates the stable borrow implementations for 4 tokens that have stable debt across all ethereum v2 and polygon v3 pools.
The implementation will effectively stop minting new stable debt tokens.

## Motivation

In response to an attack vector reported by a white-hat, some immediate steps where taken to protect the Aave Pools by pausing, freezing, and disabling stable borrowing on the affected assets.

Upon further investigation it turned out to be necessary to also prevent new minting of StableDebt on some tokens excluded in a previous proposal.

## Specification

On AaveV2Ethereum the proposal will call:

- `AaveV2Ethereum.POOL_CONFIGURATOR.updateStableDebtToken(underlyingAsset,newSTokenImpl);` for `TUSD`, `UNI` and `DAI`

On AaveV3Polygon the proposal will call:

- `POOL_CONFIGURATOR.updateStableDebtToken(input);` for `CRV`

The proposal has been tested by BGD Labs and reviewed by Aave Companies and Certora.

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231107_Multi_MultichainStableDebtTokenUpgrades/AaveV2Ethereum_MultichainStableDebtTokenUpgrades_20231107.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231107_Multi_MultichainStableDebtTokenUpgrades/AaveV3Polygon_MultichainStableDebtTokenUpgrades_20231107.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231107_Multi_MultichainStableDebtTokenUpgrades/AaveV2Ethereum_MultichainStableDebtTokenUpgrades_20231107.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231107_Multi_MultichainStableDebtTokenUpgrades/AaveV3Polygon_MultichainStableDebtTokenUpgrades_20231107.t.sol)
- [Discussion](https://governance.aave.com/t/aave-v2-v3-security-incident-04-11-2023/15335/26)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
