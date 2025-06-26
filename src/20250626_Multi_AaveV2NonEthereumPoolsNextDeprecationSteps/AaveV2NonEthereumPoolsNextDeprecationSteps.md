---
title: "Aave v2 non-Ethereum pools next deprecation steps"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/direct-to-aip-aave-v2-non-ethereum-pools-next-deprecation-steps/22445"
---

## Simple Summary

Proposal to progress on the deprecation of the lowest-size Aave v2 pools (Polygon and Avalanche v2), by freezing all the assets, not allowing more growth on both pools, while same time being non-invasive for users (they can withdraw, repay, and migrate to v3).

## Motivation

All Aave v2 instances (Ethereum, Polygon, Avalanche) have undergone a process of continuous deprecation in favour of v3 during the last years, and for the last months, the non-Ethereum instances sit at low deposits, but with some of the assets unfrozen.

Keeping those v2 legacy pools in this stage is not ideal, as it creates monitoring overhead for all contributors, both on the risk and technical side.

So while on the Aave v2 Ethereum pool we think the outstanding pool size still points to waiting more time for a full freeze, we believe for v2 Polygon and Avalanche is fully reasonable to proceed.

## Specification

The on-chain AIP will call `freezeReserve(asset)` on the `LendingPoolConfigurator` of both Polygon and Avalanche v2 on all currently non-frozen assets.

- Assets frozen on Polygon V2: `DAI`, `USDC`, `USDT`, `WBTC`, `WETH`, `WPOL`
- Assets frozen on Avalanche V2: `DAI.e`, `USDC.e`, `USDT.e`, `WETH.e`, `WAVAX`

As previously commented, **_this is a non-invasive action, as liquidations will still be processable, and users will be able to repay their debt, withdraw assets, and consequently migrate to the v3 instances on each network_**.

## References

- Implementation: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/2339bc88c0cad4906fd7fff0f9f869319446d490/src/20250626_Multi_AaveV2NonEthereumPoolsNextDeprecationSteps/AaveV2Polygon_AaveV2NonEthereumPoolsNextDeprecationSteps_20250626.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/2339bc88c0cad4906fd7fff0f9f869319446d490/src/20250626_Multi_AaveV2NonEthereumPoolsNextDeprecationSteps/AaveV2Avalanche_AaveV2NonEthereumPoolsNextDeprecationSteps_20250626.sol)
- Tests: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/2339bc88c0cad4906fd7fff0f9f869319446d490/src/20250626_Multi_AaveV2NonEthereumPoolsNextDeprecationSteps/AaveV2Polygon_AaveV2NonEthereumPoolsNextDeprecationSteps_20250626.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/2339bc88c0cad4906fd7fff0f9f869319446d490/src/20250626_Multi_AaveV2NonEthereumPoolsNextDeprecationSteps/AaveV2Avalanche_AaveV2NonEthereumPoolsNextDeprecationSteps_20250626.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-aave-v2-non-ethereum-pools-next-deprecation-steps/22445)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
