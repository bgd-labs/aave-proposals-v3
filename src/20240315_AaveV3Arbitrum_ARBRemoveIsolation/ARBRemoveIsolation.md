---
title: "Remove ARB from Isolation Mode on Arbitrum"
author: "karpatkey_TokenLogic_ACI"
discussions: "https://governance.aave.com/t/arfc-remove-arb-from-isolation-mode-on-arbitrum-market/16703"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xbc5471496bbc2beda343625cee22c34fc9672785112cc5d19a25ca87c5b422c3"
---

## Summary

This publication proposes disabling Isolation Mode for ARB on Aave v3 Arbitrum.

## Motivation

Since the ARB airdrop, April 2023, the Arbitrum ecosystem has experienced exponential like growth and the ARB liquidity has improved significantly.

With the support of the Risk Service providers, this proposal is to disable Isolation Mode and enable ARB to be used in combination with other assets as collateral.

## Specification:

Ticker: ARB
Contract Address: [0x912CE59144191C1204E64559FE8253a0e49E6548](https://arbiscan.io/address/0x912CE59144191C1204E64559FE8253a0e49E6548)

The following parameters are to be updated as follows in Arbitrum market:

| Asset | Debt Ceiling |
| ----- | ------------ |
| ARB   | 0            |

The executor will call the ArbitrumV3 configurator and use the "setDebtCeiling" method.

## Disclaimer:

TokenLogic and karpatkey receive no payment for this proposal. TokenLogic and karpatkey are both delegates within the Aave community.

## References

- Implementation: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240315_AaveV3Arbitrum_ARBRemoveIsolation/AaveV3Arbitrum_ARBRemoveIsolation_20240315)
- Tests: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240315_AaveV3Arbitrum_ARBRemoveIsolation/AaveV3Arbitrum_ARBRemoveIsolation_20240315.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xbc5471496bbc2beda343625cee22c34fc9672785112cc5d19a25ca87c5b422c3)
- [Discussion](https://governance.aave.com/t/arfc-remove-arb-from-isolation-mode-on-arbitrum-market/16703)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
