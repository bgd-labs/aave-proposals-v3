---
title: "Multichain Stable Debt Token Upgrades"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/aave-v2-v3-security-incident-04-11-2023/15335/26"
---

## Simple Summary

This proposal updates the stable borrow implementations for all tokens that have stable debt across all pools on all networks.
The implementation will effectively stop minting new stable debt tokens.

## Motivation

In response to an attack vector reported by a white-hat, some immediate steps where taken to protect the Aave Pools by pausing, freezing, and disabling stable borrowing on the affected assets.

Upon further investigation it turned out to be necessary to also prevent new minting of StableDebt.

## Specification

On AaveV2Ethereum the proposal will call:

- `AaveV2Ethereum.POOL_CONFIGURATOR.updateStableDebtToken(underlyingAsset,newSTokenImpl);`

On AaveV3Arbitrum, AaveV3Optimism, AaveV3Avalanche, AaveV3Polygon the proposal will call:

- `POOL_CONFIGURATOR.updateStableDebtToken(input);`

The proposal has been tested by BGD Labs and reviewed by Aave Companies and Certora.

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/stable-rate-patch/blob/main/src/payloads/V2EthSTokenPayload.sol), [AaveV3Polygon](https://github.com/bgd-labs/stable-rate-patch/blob/main/src/payloads/V3PolSTokenPayload.sol), [AaveV3Avalanche](https://github.com/bgd-labs/stable-rate-patch/blob/main/src/payloads/V3AvaxSTokenPayload.sol), [AaveV3Optimism](https://github.com/bgd-labs/stable-rate-patch/blob/main/src/payloads/V3OptSTokenPayload.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/stable-rate-patch/blob/main/src/payloads/V3ArbSTokenPayload.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/a279b5dcb8a3b233681ef308337a1b1728200da3/src/20231106_Multi_DebtTokenUpdates/AaveV2Ethereum_DebtTokenUpdates_20231106.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/a279b5dcb8a3b233681ef308337a1b1728200da3/src/20231106_Multi_DebtTokenUpdates/AaveV3Polygon_DebtTokenUpdates_20231106.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/a279b5dcb8a3b233681ef308337a1b1728200da3/src/20231106_Multi_DebtTokenUpdates/AaveV3Avalanche_DebtTokenUpdates_20231106.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/a279b5dcb8a3b233681ef308337a1b1728200da3/src/20231106_Multi_DebtTokenUpdates/AaveV3Optimism_DebtTokenUpdates_20231106.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/a279b5dcb8a3b233681ef308337a1b1728200da3/src/20231106_Multi_DebtTokenUpdates/AaveV3Arbitrum_DebtTokenUpdates_20231106.t.sol)
- Stable debt token tests: [AaveV2Ethereum](https://github.com/bgd-labs/stable-rate-patch/blob/main/tests/V2EthSToken.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/stable-rate-patch/blob/main/tests/V3PolSToken.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/stable-rate-patch/blob/main/tests/V3AvaxSToken.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/stable-rate-patch/blob/main/tests/V3OptSToken.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/stable-rate-patch/blob/main/tests/V3ArbSToken.t.sol)
- [Discussion](https://governance.aave.com/t/aave-v2-v3-security-incident-04-11-2023/15335/26)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
