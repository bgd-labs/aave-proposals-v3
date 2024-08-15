---
title: "Reserve Factor Updates August"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-increase-bridged-usdc-reserve-factor-across-all-deployments/17787"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x9cc7906f04f45cebeaa48a05ed281f49da00d89c4dd988a968272fa179f14d06"
---

## Simple Summary

This AIP shall implement the following parameter adjustments:

- Increase Slope1 across Polygon v2 by 75bps;
- Increase Reserve Factor (RF) on Ethereum v2 and Avalanche v2 by 5.00%; and,
- Increase USDC.e and USDbC RF by 5.00% on Arbitrum, Optimism, Polygon, and Base.

## Motivation

This AIP will reduce deposit yield for assets on Ethereum v2 and Avalanche v2 instances of Aave Protocol by increasing the RF by 5.00%. By increasing the RF a greater portion of the interest paid by borrowers is directed to the Aave DAO's treasury.

This results in a lower deposit rate for users and encourages migration from v2 instances of the Aave Protocol to v3. User's funds are not at risk of liquidation and the borrowing rate remains unchanged.

The RF across all USDC.e and USDbC reserves will be increased by 5.00% to encourage migration from bridged USDC to native USDC on each respective network.

By increasing the Slope1 parameter by 75bps on Polygon v2, the cost of capital to users increases and further encourages migration to Polygon v3.

## Specification

Slope1 Parameter 75bps Increases:

| Asset  |   Market   | Current Slope1 | Proposed Slope1 |
| :----: | :--------: | :------------: | :-------------: |
|  DAI   | Polygon v2 |      12%       |     12.75%      |
|  USDT  | Polygon v2 |      12%       |     12.75%      |
|  wBTC  | Polygon v2 |       7%       |      7.75%      |
|  wETH  | Polygon v2 |       7%       |      7.75%      |
|  USDC  | Polygon v2 |      12%       |     12.75%      |
| wMATIC | Polygon v2 |       9%       |      9.75%      |

Reserve Factor 5.00% Increases:

| Asset  |    Market    | Current RF | Proposed RF |
| ------ | :----------: | :--------: | :---------: |
| DAI.e  | Avalanche v2 |   60.00%   |   65.00%    |
| USDC.e | Avalanche v2 |   60.00%   |   65.00%    |
| USDT.e | Avalanche v2 |   60.00%   |   65.00%    |
| wAVAX  | Avalanche v2 |   60.00%   |   65.00%    |
| WBTC.e | Avalanche v2 |   65.00%   |   70.00%    |
| WETH.e | Avalanche v2 |   60.00%   |   65.00%    |
| DAI    | Ethereum v2  |   65.00%   |   70.00%    |
| LINK   | Ethereum v2  |   70.00%   |   75.00%    |
| USDC   | Ethereum v2  |   65.00%   |   70.00%    |
| USDT   | Ethereum v2  |   65.00%   |   70.00%    |
| wBTC   | Ethereum v2  |   70.00%   |   75.00%    |
| wETH   | Ethereum v2  |   65.00%   |   70.00%    |
| USDC.e |   Arbitrum   |   30.00%   |   35.00%    |
| USDC.e |   Optimism   |   30.00%   |   35.00%    |
| USDC.e |   Polygon    |   30.00%   |   35.00%    |
| USDbC  |     Base     |   30.00%   |   35.00%    |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240726_Multi_ReserveFactorUpdatesAugust/AaveV2Ethereum_ReserveFactorUpdatesAugust_20240726.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240726_Multi_ReserveFactorUpdatesAugust/AaveV2Polygon_ReserveFactorUpdatesAugust_20240726.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240726_Multi_ReserveFactorUpdatesAugust/AaveV2Avalanche_ReserveFactorUpdatesAugust_20240726.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240726_Multi_ReserveFactorUpdatesAugust/AaveV3Polygon_ReserveFactorUpdatesAugust_20240726.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240726_Multi_ReserveFactorUpdatesAugust/AaveV3Optimism_ReserveFactorUpdatesAugust_20240726.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240726_Multi_ReserveFactorUpdatesAugust/AaveV3Arbitrum_ReserveFactorUpdatesAugust_20240726.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240726_Multi_ReserveFactorUpdatesAugust/AaveV3Base_ReserveFactorUpdatesAugust_20240726.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240726_Multi_ReserveFactorUpdatesAugust/AaveV2Ethereum_ReserveFactorUpdatesAugust_20240726.t.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240726_Multi_ReserveFactorUpdatesAugust/AaveV2Polygon_ReserveFactorUpdatesAugust_20240726.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240726_Multi_ReserveFactorUpdatesAugust/AaveV2Avalanche_ReserveFactorUpdatesAugust_20240726.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240726_Multi_ReserveFactorUpdatesAugust/AaveV3Polygon_ReserveFactorUpdatesAugust_20240726.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240726_Multi_ReserveFactorUpdatesAugust/AaveV3Optimism_ReserveFactorUpdatesAugust_20240726.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240726_Multi_ReserveFactorUpdatesAugust/AaveV3Arbitrum_ReserveFactorUpdatesAugust_20240726.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240726_Multi_ReserveFactorUpdatesAugust/AaveV3Base_ReserveFactorUpdatesAugust_20240726.t.sol)
- [Snapshot for USDCe updates](https://snapshot.org/#/aave.eth/proposal/0x9cc7906f04f45cebeaa48a05ed281f49da00d89c4dd988a968272fa179f14d06)
- [Discussion for USDCe updates](https://governance.aave.com/t/arfc-increase-bridged-usdc-reserve-factor-across-all-deployments/17787/6)
- [Discussion for Ethereum V2 Reserve Factor Updates](https://governance.aave.com/t/arfc-ethereum-v2-reserve-factor-adjustment/16764/15)
- [Snapshot for Ethereum V2 Reserve Factor Updates](https://snapshot.org/#/aave.eth/proposal/0x26a03c08359c340f63b78b0c3e96d37aa0adeda65814643b0886d4719048ea7e)
- [Discussion for Avalanche V2 Reserve Factor Updates](https://governance.aave.com/t/arfc-avalanche-v2-reserve-factor-adjustment/17040/10)
- [Snapshot for Avalanche V2 Reserve Factor Updates](https://snapshot.org/#/aave.eth/proposal/0x770ff4e02634c77aaa09952345551168920f7878b32ab03fcef92763a5fb70ab)
- [Discussion for Polygon V2 Borrow Rate Updates](https://governance.aave.com/t/arfc-polygon-v2-borrow-rate-adjustments/17252/10)
- [Snapshot for Polygon V2 Borrow Rate Updates](https://snapshot.org/#/aave.eth/proposal/0x95643085ee16eb0eaa4110a9f0ea8223009f9521e596e1a958303705a5001363)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
