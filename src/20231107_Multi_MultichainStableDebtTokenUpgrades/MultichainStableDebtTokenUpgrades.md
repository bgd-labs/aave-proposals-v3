---
title: "Liquidations Grace Sentinel activation"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/aave-v2-v3-security-incident-04-11-2023/15335/26"
---

## Simple Summary

This proposal actives a new Aave v2 feature, the Liquidations Grace Sentinel, an emergency mechanism allowing controlled unpause by the Aave Guardian whenever a pause was enabled.

Additionally, extra stable debt token upgrades are included, following the same approach as proposal 359

## Motivation

The Liquidation Grace Sentinel is a new feature introduced into Aave v2, allowing for the Aave Guardian to granularly (per asset) set a "grace period" for an asset.
An asset being in "grace period" implies that liquidations involving it as collateral OR repaid debt can't be processed, so factually is a less aggressive pool-wide pause.

The main objective of this mechanism, is to allow a gracefully unpause of an Aave v2 pool: if market conditions allow, a grace period of X minutes/hours/days can be set for when a pool will be unpaused.

Same as with the pause mechanism (as they are complementary), the usage of the liquidation grace sentinel will be allowed only for the current `emergencyAdmin`` of the Aave v2 pool: the Aave Guardian.

## Specification

On AaveV2Etherem, AaveV2Polygon and AaveV2Avalanche the proposal will call:

- `POOL_ADDRESSES_PROVIDER.setLendingPoolCollateralManager(NEW_COLLATERAL_MANAGER);` to update the COLLATERAL_MANAGER with a new version containing the `LiquidationsGraceSentinel`

In addition stable debt tokens are upgraded analog to aip 359.

The proposal has been tested by BGD Labs and reviewed by Aave Companies and Certora.

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/stable-rate-patch/blob/main/src/payloads/V2EthLiquidationSentinelPayload.sol), [AaveV2Polygon](https://github.com/bgd-labs/stable-rate-patch/blob/main/src/payloads/V2PolLiquidationSentinelPayload.sol), [AaveV2Avalanche](https://github.com/bgd-labs/stable-rate-patch/blob/main/src/paayloads/V2AvaLiquidationSentinelPayload.sol)
- [Tests](https://github.com/bgd-labs/stable-rate-patch/blob/main/tests/LiquidationsGraceSentinel.t.sol)
- [Discussion](https://governance.aave.com/t/aave-v2-v3-security-incident-04-11-2023/15335/26)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
