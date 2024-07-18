---
title: "Increase Bridged USDC Reserve Factor Across All Deployments"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-increase-bridged-usdc-reserve-factor-across-all-deployments/17787"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x9cc7906f04f45cebeaa48a05ed281f49da00d89c4dd988a968272fa179f14d06"
---

## Simple Summary

This AIP is composed of three actions:

1. To start periodically increasing the Reserve Factor (RF) for Bridged USDC(USDC.e & USDbC) across Arbitrum, Optimism, Polygon and Base Aave deployments.
2. A continuation of the proposals on Governance V3 that increases the Reserve Factor (RF) for assets on [Ethereum V2](https://governance.aave.com/t/arfc-ethereum-v2-reserve-factor-adjustment/16764), [Avalanche V2](https://governance.aave.com/t/arfc-avalanche-v2-reserve-factor-adjustment/17040), and [Polygon V2](https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/23?u=dd0sxx) by 5.00%, up to a maximum of 99.99%.
3. A continuation of the [proposal](https://governance.aave.com/t/arfc-polygon-v2-borrow-rate-adjustments/17252) to adjust Polygon v2 Borrow Rate.

## Motivation

Presently, Bridged USDC (USDC.e & USDbC) competes with native USDC on the listed markets. By gradually increasing the RF for Bridged USDC(USDC.e & USDbC), the deposit rate on these markets will become less attractive over time. Similar to other proposals, this action is expected to encourage users to switch to native USDC on the respective market.

Upon implementing this proposal, a subsequent AIP will be submitted that increases the RF by 5.00% up to a maximum of 99.99% every 2 weeks, subject to market conditions. The RF amendments will be incorporated into the fortnightly RF and Borrow Rate adjustment AIP to reduce voting overhead.

This AIP will also reduce deposit yield for assets on Ethereum, Avalanche, and Polygon V2 deployments by increasing the RF. With this upgrade being passed, users will be further encouraged to migrate from Ethereum V2 to V3.

Increasing the RF routes a larger portion of the interest paid by users to Aave DAO's Treasury. User's funds are not at risk of liquidation and the borrowing rate remains unchanged.

## Specification

| Market       | Asset  | Current RF | New RF |
| ------------ | ------ | ---------- | ------ |
| Polygon V3   | USDC.e | 20%        | 25%    |
| Optimism V3  | USDC.e | 20%        | 25%    |
| Arbitrum V3  | USDC.e | 20%        | 25%    |
| Base V3      | USDC.e | 20%        | 25%    |
| Ethereum V2  | DAI    | 55%        | 60%    |
| Ethereum V2  | LINK   | 60%        | 65%    |
| Ethereum V2  | USDC   | 55%        | 60%    |
| Ethereum V2  | USDT   | 55%        | 60%    |
| Ethereum V2  | WBTC   | 60%        | 65%    |
| Ethereum V2  | WETH   | 55%        | 60%    |
| Avalanche V2 | DAIe   | 50%        | 55%    |
| Avalanche V2 | USDCe  | 50%        | 55%    |
| Avalanche V2 | USDTe  | 50%        | 55%    |
| Avalanche V2 | WAVAX  | 50%        | 55%    |
| Avalanche V2 | WBTCe  | 55%        | 60%    |
| Avalanche V2 | WETHe  | 50%        | 55%    |
| Polygon V2   | DAI    | 96%        | 99.99% |
| Polygon V2   | USDC   | 98%        | 99.99% |
| Polygon V2   | USDT   | 97%        | 99.99% |

| Market     | Asset  | Current Slope1 | New Slope1 |
| ---------- | ------ | -------------- | ---------- |
| Polygon V2 | DAI    | 9.75%          | 11.25%     |
| Polygon V2 | USDT   | 9.75%          | 11.25%     |
| Polygon V2 | wBTC   | 4.75%          | 6.25%      |
| Polygon V2 | wETH   | 4.75%          | 6.25%      |
| Polygon V2 | wUSDC  | 9.75%          | 11.25%     |
| Polygon V2 | wMATIC | 4.75%          | 8.25%      |

## References

- Implementation: [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/603d947dd7a5a42181ae694f2efcbc365df02cf3/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV2Avalanche_ReserveFactorUpgrades_20240528.sol),[AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/603d947dd7a5a42181ae694f2efcbc365df02cf3/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV2Ethereum_ReserveFactorUpgrades_20240528.sol),[AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/603d947dd7a5a42181ae694f2efcbc365df02cf3/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV2Polygon_BorrowRateUpdates_20240528.sol),[AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/603d947dd7a5a42181ae694f2efcbc365df02cf3/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV3Polygon_IncreaseUSDCeRF_20240528.sol),[AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/603d947dd7a5a42181ae694f2efcbc365df02cf3/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV3Optimism_IncreaseUSDCeRF_20240528.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/603d947dd7a5a42181ae694f2efcbc365df02cf3/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV3Arbitrum_IncreaseUSDCeRF_20240528.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/603d947dd7a5a42181ae694f2efcbc365df02cf3/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV3Base_IncreaseUSDCeRF_20240528.t.sol)
- Tests: [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/603d947dd7a5a42181ae694f2efcbc365df02cf3/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV2Avalanche_ReserveFactorUpgrades_20240528.t.sol),[AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/603d947dd7a5a42181ae694f2efcbc365df02cf3/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV2Ethereum_ReserveFactorUpgrades_20240528.t.sol),[AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/603d947dd7a5a42181ae694f2efcbc365df02cf3/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV2Polygon_BorrowRateUpdates_20240528.t.sol),[AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/603d947dd7a5a42181ae694f2efcbc365df02cf3/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV3Polygon_IncreaseUSDCeRF_20240528.t.sol),[AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/603d947dd7a5a42181ae694f2efcbc365df02cf3/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV3Optimism_IncreaseUSDCeRF_20240528.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/603d947dd7a5a42181ae694f2efcbc365df02cf3/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV3Arbitrum_IncreaseUSDCeRF_20240528.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/603d947dd7a5a42181ae694f2efcbc365df02cf3/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV3Base_IncreaseUSDCeRF_20240528.t.sol)
- [Snapshot for USDCe updates](https://snapshot.org/#/aave.eth/proposal/0x9cc7906f04f45cebeaa48a05ed281f49da00d89c4dd988a968272fa179f14d06)
- [Discussion for USDCe updates](https://governance.aave.com/t/arfc-increase-bridged-usdc-reserve-factor-across-all-deployments/17787)
- [Discussion for Ethereum V2 Reserve Factor Updates](https://governance.aave.com/t/arfc-ethereum-v2-reserve-factor-adjustment/16764/13?u=luigy)
- [Snapshot for Ethereum V2 Reserve Factor Updates](https://snapshot.org/#/aave.eth/proposal/0x26a03c08359c340f63b78b0c3e96d37aa0adeda65814643b0886d4719048ea7e)
- [Discussion for Avalanche V2 Reserve Factor Updates](https://governance.aave.com/t/arfc-avalanche-v2-reserve-factor-adjustment/17040/8?u=luigy)
- [Snapshot for Avalanche V2 Reserve Factor Updates](https://snapshot.org/#/aave.eth/proposal/0x770ff4e02634c77aaa09952345551168920f7878b32ab03fcef92763a5fb70ab)
- [Discussion for Polygon V2 Borrow Rate Updates](https://governance.aave.com/t/arfc-polygon-v2-borrow-rate-adjustments/17252/8?u=luigy)
- [Snapshot for Polygon V2 Borrow Rate Updates](https://snapshot.org/#/aave.eth/proposal/0x95643085ee16eb0eaa4110a9f0ea8223009f9521e596e1a958303705a5001363)
- [Discussion for Polygon V2 RF update](https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/23?u=dd0sxx)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
