---
title: "Prime Instance - Restore ETH LTV"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-prime-instance-restore-eth-ltv/20933"
snapshot: https://snapshot.box/#/s:aave.eth/proposal/0xe7251459edae302517bc471776d82069afb13441b058c9fc989e0c878f13c873
---

## Simple Summary

This publication proposes restoring ETH’s LTV to 82% on the Prime instance of Aave v3.

## Motivation

With the introduction of liquidity mining rewards for ETH deposits on Prime, some users exploited wETH/wETH leverage to farm rewards. In response, ETH’s LTV was set to 0, preventing new ETH collateral positions while preserving existing user positions.

Transitioning from direct liquidity mining emissions to a periodic Merkl distribution ensures that users leveraging wETH/wETH can be disqualified from rewards. By introducing a qualification criteria, incentives are directed towards users who engage with the protocol as intended.

This proposal focuses on re-enabling ETH collateral positions by restoring the LTV to 82%.

## Specification

The LTV for ETH on Prime is to be amended as outlined below:

| Parameter | Current | Proposed |
| :-------: | :-----: | :------: |
|    LTV    |  0.00%  |  82.00%  |

The ETH Correlated eMode category is to be amended as outlined below:

|      Parameter      | Value  | Value  |
| :-----------------: | :----: | :----: |
|        Asset        |  wETH  | wstETH |
|     Collateral      |   No   |  Yes   |
|     Borrowable      |  Yes   |   No   |
|         LTV         | 93.50% | 93.50% |
|         LT          | 95.50% | 95.50% |
| Liquidation Penalty | 1.00%  | 1.00%  |

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250210_AaveV3EthereumLido_PrimeInstanceRestoreETHLTV/AaveV3EthereumLido_PrimeInstanceRestoreETHLTV_20250210.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250210_AaveV3EthereumLido_PrimeInstanceRestoreETHLTV/AaveV3EthereumLido_PrimeInstanceRestoreETHLTV_20250210.t.sol)
  [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0xe7251459edae302517bc471776d82069afb13441b058c9fc989e0c878f13c873)
- [Discussion](https://governance.aave.com/t/arfc-prime-instance-restore-eth-ltv/20933)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
