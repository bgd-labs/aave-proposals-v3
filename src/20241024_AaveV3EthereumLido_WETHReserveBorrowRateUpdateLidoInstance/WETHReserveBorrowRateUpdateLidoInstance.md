---
title: "wstETH and wETH Borrow Rate Update - Lido Instance"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-weth-wsteth-borrow-rate-updates/19550"
snapshot: "Direct-to-AIP"
---

## Simple Summary

This AIP when implemented will increase the wETH Slope1 and wstETH Base parameters on the Lido instance of Aave v3.

## Motivation

After onboarding ezETH, the demand for wstETH debt has increased significantly.

This AIP increases the wstETH borrow rate by adjusting the Base parameter from 0 bps to 50bps to better reflect prevailing market conditions.

The wETH borrow rate will be increased by raising Slope1 by 25bps. This is expected to lead to a higher wETH deposit rate and reduce dependency on rewards being emitted to wETH deposits.

## Specification

The Lido instance wETH Slope1 and wstETH Base are to be revised as follows:

| Asset  | Parameter | Current | Proposed | Change |
| :----: | :-------: | :-----: | :------: | :----: |
|  wETH  |  Slope1   |  2.50%  |  2.75%   | +0.25% |
| wstETH |   Base    |  0.00%  |  0.50%   | +0.50% |

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241024_AaveV3EthereumLido_WETHReserveBorrowRateUpdateLidoInstance/AaveV3EthereumLido_WETHReserveBorrowRateUpdateLidoInstance_20241024.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241024_AaveV3EthereumLido_WETHReserveBorrowRateUpdateLidoInstance/AaveV3EthereumLido_WETHReserveBorrowRateUpdateLidoInstance_20241024.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-weth-wsteth-borrow-rate-updates/19550)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
