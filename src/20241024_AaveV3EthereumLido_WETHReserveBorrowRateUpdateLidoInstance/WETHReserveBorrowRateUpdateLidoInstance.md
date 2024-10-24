---
title: "wETH Reserve Borrow Rate Update - Lido Instance"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-weth-wsteth-borrow-rate-updates/19550"
snapshot: "Direct-to-AIP"
---

## Simple Summary

This publication proposes increasing the Slope1 parameter by 25bps for wETH on Lido instance

## Motivation

When ezETH is onboarded, we expect an organic wstETH deposit rate to emerge. In response, this proposal intends to direct a portion of this yield to wETH deposits by increasing the wETH Borrow Rate (Slope1).

The resulting increase in wETH deposit rate is expected to enable the DAO to revise lower the ETH deposit liquidity mining rewards.

## Specification

The Lido instance wETH Slope1 is to be revised as follows:

| Asset | Parameter | Current | Proposed | Change |
| :---: | :-------: | :-----: | :------: | :----: |
| wETH  |  Slope1   |  2.50%  |  2.75%   | +0.25% |

The wETH Slope1 adjustment will only be presented as an AIP when market conditions are favourable post onboarding ezETH.

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241024_AaveV3EthereumLido_WETHReserveBorrowRateUpdateLidoInstance/AaveV3EthereumLido_WETHReserveBorrowRateUpdateLidoInstance_20241024.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241024_AaveV3EthereumLido_WETHReserveBorrowRateUpdateLidoInstance/AaveV3EthereumLido_WETHReserveBorrowRateUpdateLidoInstance_20241024.t.sol)
- [Snapshot](Direct-to-AIP)
- [Discussion](https://governance.aave.com/t/arfc-weth-wsteth-borrow-rate-updates/19550)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
