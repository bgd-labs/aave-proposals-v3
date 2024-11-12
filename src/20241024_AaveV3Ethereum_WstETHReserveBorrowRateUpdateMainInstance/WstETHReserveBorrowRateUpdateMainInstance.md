---
title: "wstETH Reserve Borrow Rate Update - Main Instance"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-weth-wsteth-borrow-rate-updates/19550"
snapshot: "Direct-to-AIP"
---

## Simple Summary

This publication proposes reducing wstETH Slope1 parameter on the Main instance of Aave v3 on Ethereum.

## Motivation

With the goal of encouraging user to borrow wstETH on the Main instance of Aave v3, the wstETH borrow rate will be lowered.

The anticipated rsETH collateral and wETH debt eMode category is expected to create demand for wstETH debt. Given the size of the wstETH reserve the Uoptimal is not being increased by this proposal.

After monitoring how the market responds, future borrow rate adjustments across the Aave v3 instances on Ethereum will be assessed and any change presented for discussion.

## Specification

The Main instance the wstETH Slope1 and base parameter is to be revised as follows:

| Asset  | Parameter | Current | Proposed | Change |
| :----: | :-------: | :-----: | :------: | :----: |
| wstETH |   Base    |  0.25%  |  0.00%   | -0.25% |
| wstETH |  Slope1   |  4.50%  |  2.00%   | -2.50% |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/3a0085b8e9db515f846ee6fd54f7801e47b64d90/src/20241024_AaveV3Ethereum_WstETHReserveBorrowRateUpdateMainInstance/AaveV3Ethereum_WstETHReserveBorrowRateUpdateMainInstance_20241024.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/3a0085b8e9db515f846ee6fd54f7801e47b64d90/src/20241024_AaveV3Ethereum_WstETHReserveBorrowRateUpdateMainInstance/AaveV3Ethereum_WstETHReserveBorrowRateUpdateMainInstance_20241024.t.sol)
- [Snapshot](Direct-to-AIP)
- [Discussion](https://governance.aave.com/t/arfc-weth-wsteth-borrow-rate-updates/19550)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
