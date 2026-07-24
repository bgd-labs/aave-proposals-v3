---
title: "Aave V4 Caps Increase #11"
author: "Llama Risk (implemented by Aave Labs)"
discussions: "https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/38"
---

## Summary

LlamaRisk recommends an eleventh round of Add Cap and Draw Cap increases for Aave V4.
This proposal covers the Ethereum and Avalanche deployments.

## Motivation

Utilization and recent growth across the affected Ethereum spokes support additional headroom.
The Avalanche changes provide additional capacity following activation. All configuration parameters
other than the specified Add Caps and Draw Caps remain unchanged.

## Specification

### Ethereum

#### Core Hub

| Spoke   | Asset  | Current Add Cap | Proposed Add Cap | Current Draw Cap | Proposed Draw Cap |
| ------- | ------ | --------------- | ---------------- | ---------------- | ----------------- |
| EtherFi | WETH   | 0               | -                | 13,000           | 20,000            |
| EtherFi | weETH  | 18,000          | 28,000           | 0                | -                 |
| Gold    | USDG   | 0               | -                | 1,000,000        | 2,000,000         |
| Gold    | XAUt   | 2,500           | 3,800            | 0                | -                 |
| Gold    | frxUSD | 0               | -                | 1,000,000        | 2,000,000         |
| Main    | LINK   | 750,000         | 900,000          | 0                | -                 |
| Main    | USDG   | 50,000,000      | 65,000,000       | 27,200,000       | 35,000,000        |
| Main    | WBTC   | 1,150           | 1,350            | 100              | 120               |
| Main    | WETH   | 30,000          | 38,000           | 2,600            | 3,300             |

#### Prime Hub

| Spoke    | Asset  | Current Add Cap | Proposed Add Cap | Current Draw Cap | Proposed Draw Cap |
| -------- | ------ | --------------- | ---------------- | ---------------- | ----------------- |
| Bluechip | WBTC   | 400             | 700              | 0                | -                 |
| Bluechip | WETH   | 5,000           | 8,000            | 0                | -                 |
| Bluechip | cbBTC  | 130             | 300              | 0                | -                 |
| Bluechip | wstETH | 7,000           | 14,000           | 0                | -                 |

### Avalanche

#### Core Hub

| Spoke | Asset | Current Add Cap | Proposed Add Cap | Current Draw Cap | Proposed Draw Cap |
| ----- | ----- | --------------- | ---------------- | ---------------- | ----------------- |
| Forex | USDC  | 200,000         | 400,000          | 150,000          | 350,000           |
| Forex | USDt  | 200,000         | 400,000          | 150,000          | 350,000           |

## References

- Ethereum implementation: [AaveV4Ethereum](https://github.com/aave/aave-proposals-v3/blob/main/src/20260723_Multi_AaveV4CapsIncreaseRound11/AaveV4Ethereum_IncreaseCaps_20260723.sol)
- Ethereum tests: [AaveV4Ethereum](https://github.com/aave/aave-proposals-v3/blob/main/src/20260723_Multi_AaveV4CapsIncreaseRound11/AaveV4Ethereum_IncreaseCaps_20260723.t.sol)
- Avalanche implementation: [AaveV4Avalanche](https://github.com/aave/aave-proposals-v3/blob/main/src/20260723_Multi_AaveV4CapsIncreaseRound11/AaveV4Avalanche_IncreaseCaps_20260723.sol)
- Avalanche tests: [AaveV4Avalanche](https://github.com/aave/aave-proposals-v3/blob/main/src/20260723_Multi_AaveV4CapsIncreaseRound11/AaveV4Avalanche_IncreaseCaps_20260723.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/38)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
