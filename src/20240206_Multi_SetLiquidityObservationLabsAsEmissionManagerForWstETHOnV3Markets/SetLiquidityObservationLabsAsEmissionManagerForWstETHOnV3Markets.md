---
title: " Set Liquidity Observation Labs as Emission manager for wstETH on V3 markets"
author: "Aave Chan Initiative (ACI)"
discussions: "https://governance.aave.com/t/arfc-set-liquidity-observation-labs-as-emission-manager-for-wsteth-on-v3-markets/16479"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xf30c35c586e283bae81fe1c22bd4b3cfc7f6da37bde19ac9e633414f28dc9e74"
---

## Simple Summary

This ARFC proposes to set the Lido "Lido Liquidity Observation Labs wallet as the emission manager for the wstETH token on Ethereum, Base, Arbitrum, Optimism and Polygon Aave V3 markets. This will enable the Lido "Lido Liquidity Observation Labs to define and fund incentive programs for all wstETH markets, promoting growth and expanding the user base of Aave.

## Motivation

The Lido "Lido Liquidity Observation Labs has expressed a desire to actively contribute to the growth and development of the Aave V3. By setting their wallet as the emission manager for the wstETH token, the Foundation will be able to directly fund incentive programs that can attract more users to the pool and stimulate activity. This aligns with the broader goals of the Aave community to foster active and engaged markets.

## Specification

The Lido "Lido Liquidity Observation Labs Gnosis safe wallet address is `0xC18F11735C6a1941431cCC5BcF13AF0a052A5022` on every network.

The AIP calls  `EMISSION_MANAGER.setEmissionAdmin(asset, admin)` for each respective network. With asset `wstETH` as asset and the Gnosis safe as admin.

EMISSION_MANAGER.setEmissionAdmin(wstETH, EMISSION_ADMIN);

This method will set the Lido "Lido Liquidity Observation Labs wallet as the emission admin for the wstETH token on Ethereum, Base, Arbitrum, Optimism and Polygon V3 markets.

After synchronizing with Liquidity Observation Labs, it was decided not to favor, in the short term, a bridged version of StETH on the gnosis chain.

As such, and following their request, no role will be attributed to the gnosis chain in the context of this AIP.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240206_Multi_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets/AaveV3Ethereum_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets_20240206.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240206_Multi_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets/AaveV3Polygon_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets_20240206.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240206_Multi_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets/AaveV3Optimism_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets_20240206.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240206_Multi_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets/AaveV3Arbitrum_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets_20240206.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240206_Multi_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets/AaveV3Base_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets_20240206.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240206_Multi_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets/AaveV3Ethereum_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets_20240206.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240206_Multi_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets/AaveV3Polygon_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets_20240206.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240206_Multi_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets/AaveV3Optimism_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets_20240206.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240206_Multi_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets/AaveV3Arbitrum_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets_20240206.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240206_Multi_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets/AaveV3Base_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets_20240206.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xf30c35c586e283bae81fe1c22bd4b3cfc7f6da37bde19ac9e633414f28dc9e74)
- [Discussion](https://governance.aave.com/t/arfc-set-liquidity-observation-labs-as-emission-manager-for-wsteth-on-v3-markets/16479)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
