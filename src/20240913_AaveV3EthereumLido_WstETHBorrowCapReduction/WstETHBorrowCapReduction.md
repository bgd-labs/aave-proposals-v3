---
title: "wstETH Borrow Cap Reduction"
author: "Tokenlogic"
discussions: "https://governance.aave.com/t/arfc-lido-instance-reduce-wsteth-borrow-cap/19016"
snapshot: "Direct-To-Aip"
---

## Simple Summary

Reduce wstETH Borrow Cap from 12,000 to 100 in preparation for wstETH deposit incentives.

## Motivation

With the upcoming implementation of wstETH deposit liquidity mining rewards, this proposal suggests reducing the wstETH Borrow Cap to prevent recursive looping of wstETH deposits.

If liquidity mining rewards are added to wstETH deposits, we may see users looping wstETH/wstETH to farm the rewards. This could lead to the dilution of wstETH deposit rewards, and with low utilization of the wstETH reserve, the strategy will be less effective in encouraging users to engage in the wstETH/wETH yield-maximizing strategy.

To mitigate this risk, we propose reducing the wstETH Borrow Cap to levels near current utilization.

When the first Liquid Restaking Token (LRT) is added to the Lido instance, the Borrow Cap will be increased, and wstETH deposit rewards will taper off or stop. We expect this to coincide with external teams providing deposit incentives for their respective LRTs.

A separate proposal will outline changes to the wstETH Borrow Rate to encourage wstETH as the preferred debt asset for yield strategies utilizing LRTs as collateral.

## Specification

Reduce Borrow Cap for wstETH reserve from 12,000 to 100 wstETH.

When the first LRT is onboarded, the wstETH Borrow Cap will be increased to 12,000 as part of the asset onboarding AIP submission.

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/96388eed7be2ddcd287cf2abf08bc221e63a56bc/src/20240913_AaveV3EthereumLido_WstETHBorrowCapReduction/AaveV3EthereumLido_WstETHBorrowCapReduction_20240913.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/96388eed7be2ddcd287cf2abf08bc221e63a56bc/src/20240913_AaveV3EthereumLido_WstETHBorrowCapReduction/AaveV3EthereumLido_WstETHBorrowCapReduction_20240913.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-lido-instance-reduce-wsteth-borrow-cap/19016)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
