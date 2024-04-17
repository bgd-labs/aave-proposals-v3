---
title: "Scroll wstETH Emission Manager"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-set-liquidity-observation-labs-as-emission-manager-for-wsteth-on-scroll/16813"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xb70490f6b0623631686d34f4ca99a7d45394ad29fdd504df3cd6e68790b22b9c"
---

## Simple Summary

This AIP proposes to set Liquidity Observation Labs wallet as the emission manager for the wstETH token on Scroll. This will enable the Liquidity Observation Labs to define and fund incentive programs for all wstETH markets, including Scroll, promoting growth and expanding the user base of Aave.

## Motivation

Governance have already approved setting Liquidity Observation Labs as Emission manager for wstETH on the current Aave V3 Markets.

But since Scroll market is live, the current AIP is set to establish Liquidity Observation Labs as Emission manager for wstETH, aligning with the desire to actively contribute to the growth and development of the Aave V3.

By setting their wallet as the emission manager for the wstETH token, the Foundation will be able to directly fund incentive programs that can attract more users to the pool and stimulate activity. This aligns with the broader goals of the Aave community to foster active and engaged markets.

## Specification

The Liquidity Observation Labs wallet address is:

Emission Admin Wallet (Liquidity Observation Labs): [0xC18F11735C6a1941431cCC5BcF13AF0a052A5022](https://safe.scroll.xyz/home?safe=scr:0xC18F11735C6a1941431cCC5BcF13AF0a052A5022)

The AIP call setEmissionAdmin() method in the emission manager contract.

`EMISSION_MANAGER.setEmissionAdmin(wstETH,0xC18F11735C6a1941431cCC5BcF13AF0a052A5022);`

This method will set the Liquidity Observation Labs wallet as the emission admin for the wstETH token on Scroll, besides the current Ethereum, Base, Arbitrum, Optimism, Polygon and Gnosis V3 markets.

## References

- Implementation: [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/9e52d09720c29a2999f07ae97f71063c0ed32c53/src/20240312_AaveV3Scroll_ScrollWstETHEmissionManager/AaveV3Scroll_ScrollWstETHEmissionManager_20240312.sol)
- Tests: [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/9e52d09720c29a2999f07ae97f71063c0ed32c53/src/20240312_AaveV3Scroll_ScrollWstETHEmissionManager/AaveV3Scroll_ScrollWstETHEmissionManager_20240312.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb70490f6b0623631686d34f4ca99a7d45394ad29fdd504df3cd6e68790b22b9c)
- [Discussion](https://governance.aave.com/t/arfc-set-liquidity-observation-labs-as-emission-manager-for-wsteth-on-scroll/16813)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
