---
title: "Reserve Factor Updates Mid October"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-increase-bridged-usdc-reserve-factor-across-all-deployments/17787"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x9cc7906f04f45cebeaa48a05ed281f49da00d89c4dd988a968272fa179f14d06"
---

## Simple Summary

This AIP shall implement the following parameter adjustments:

- Increase Slope1 across Polygon v2 by 75bps;
- Increase Reserve Factor (RF) on Ethereum v2 and Avalanche v2 by 5.00%; and,
- Increase USDC.e and USDbC RF by 5.00% on Arbitrum, Optimism, Polygon, Base and Gnosis.

## Motivation

This AIP will reduce deposit yield for assets on Ethereum v2 and Avalanche v2 instances of Aave Protocol by increasing the RF by 5.00%. By increasing the RF a greater portion of the interest paid by borrowers is directed to the Aave DAO's treasury.

This results in a lower deposit rate for users and encourages migration from v2 instances of the Aave Protocol to v3. User's funds are not at risk of liquidation and the borrowing rate remains unchanged.

The RF across all USDC.e and USDbC reserves will be increased by 5.00% to encourage migration from bridged USDC to native USDC on each respective network.

By increasing the Slope1 parameter by 75bps on Polygon v2, the cost of capital to users increases and further encourages migration to Polygon v3.

## Specification

Slope1 Parameter 75bps Increases:

| Asset  |   Market   | Current Slope1 | Proposed Slope1 |
| :----: | :--------: | :------------: | :-------------: |
|  DAI   | Polygon v2 |     14.25%     |       15%       |
|  USDT  | Polygon v2 |     14.25%     |       15%       |
|  wBTC  | Polygon v2 |     9.25%      |       10%       |
|  wETH  | Polygon v2 |     9.25%      |       10%       |
|  USDC  | Polygon v2 |     14.25%     |       15%       |
| wMATIC | Polygon v2 |     11.25%     |       12%       |

Reserve Factor 5.00% Increases:

| Asset  |    Market    | Current RF | Proposed RF |
| ------ | :----------: | :--------: | :---------: |
| DAI.e  | Avalanche v2 |   75.00%   |   80.00%    |
| USDC.e | Avalanche v2 |   75.00%   |   80.00%    |
| USDT.e | Avalanche v2 |   75.00%   |   80.00%    |
| wAVAX  | Avalanche v2 |   75.00%   |   80.00%    |
| WBTC.e | Avalanche v2 |   80.00%   |   85.00%    |
| WETH.e | Avalanche v2 |   75.00%   |   80.00%    |
| DAI    | Ethereum v2  |   80.00%   |   85.00%    |
| LINK   | Ethereum v2  |   85.00%   |   90.00%    |
| USDC   | Ethereum v2  |   80.00%   |   85.00%    |
| USDT   | Ethereum v2  |   80.00%   |   85.00%    |
| wBTC   | Ethereum v2  |   85.00%   |   90.00%    |
| wETH   | Ethereum v2  |   80.00%   |   85.00%    |
| USDC.e |   Arbitrum   |   45.00%   |   50.00%    |
| USDC.e |   Optimism   |   45.00%   |   50.00%    |
| USDC.e |   Polygon    |   45.00%   |   50.00%    |
| USDbC  |     Base     |   45.00%   |   50.00%    |
| USDC.e |    Gnosis    |   20.00%   |   25.00%    |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV2Ethereum_ReserveFactorUpdatesMidOctober_20241004.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV2Polygon_ReserveFactorUpdatesMidOctober_20241004.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV2Avalanche_ReserveFactorUpdatesMidOctober_20241004.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV3Polygon_ReserveFactorUpdatesMidOctober_20241004.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV3Optimism_ReserveFactorUpdatesMidOctober_20241004.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV3Arbitrum_ReserveFactorUpdatesMidOctober_20241004.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV3Base_ReserveFactorUpdatesMidOctober_20241004.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV3Gnosis_ReserveFactorUpdatesMidOctober_20241004.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV2Ethereum_ReserveFactorUpdatesMidOctober_20241004.t.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV2Polygon_ReserveFactorUpdatesMidOctober_20241004.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV2Avalanche_ReserveFactorUpdatesMidOctober_20241004.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV3Polygon_ReserveFactorUpdatesMidOctober_20241004.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV3Optimism_ReserveFactorUpdatesMidOctober_20241004.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV3Arbitrum_ReserveFactorUpdatesMidOctober_20241004.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV3Base_ReserveFactorUpdatesMidOctober_20241004.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV3Gnosis_ReserveFactorUpdatesMidOctober_20241004.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x9cc7906f04f45cebeaa48a05ed281f49da00d89c4dd988a968272fa179f14d06)
- [Discussion](https://governance.aave.com/t/arfc-increase-bridged-usdc-reserve-factor-across-all-deployments/17787)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
