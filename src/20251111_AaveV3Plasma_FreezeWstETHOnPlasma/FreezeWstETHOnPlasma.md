---
title: "Freeze wstETH Plasma"
author: "Lido (implemented by ACI via Skyward)"
discussions: "https://governance.aave.com/t/direct-to-aip-freeze-wsteth-on-plasma/23400"
snapshot: Direct to AIP
---

## Simple Summary

Freeze wstETH on Plasma instance

## Motivation

Last week, Lido [announced](https://blog.lido.fi/announcing-partnership-with-chainlink-on-adopting-ccip-as-official-cross-chain-infrastructure-for-wsteth/) that Chainlink's CCIP will be the official cross-chain infrastructure for wstETH. While the wstETH representation on Plasma was already deployed through CCIP, it was unfortunately not set up in a fully future-proof manner.

Together with Chainlink, they have decided to redeploy the token contract to ensure the deployment is in line with the new cross-chain strategy. They ask us to deprecate the asset.

Right now, there is about 0.044 wstETH on Aave Plasma instance / 0.12 wstETH on Plasma.

## Specification

If passed, this AIP will freeze wstETH reserve on Plasma, preventing new deposits, borrows, or collateral enablement.

### Copyright

Copyright and related rights waived under [CC0](https://creativecommons.org/publicdomain/zero/1.0/)

## References

- Implementation: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251111_AaveV3Plasma_FreezeWstETHPlasma/AaveV3Plasma_FreezeWstETHPlasma_20251111.sol)
- Tests: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251111_AaveV3Plasma_FreezeWstETHPlasma/AaveV3Plasma_FreezeWstETHPlasma_20251111.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-freeze-wsteth-on-plasma/23400)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
