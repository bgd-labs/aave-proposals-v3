---
title: "Reserve Factor Upgrades"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-ethereum-v2-reserve-factor-adjustment/16764/10"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x26a03c08359c340f63b78b0c3e96d37aa0adeda65814643b0886d4719048ea7e"
---

## Simple Summary

This AIP is composed of two actions: (1) a continuation of proposal 73 on Governance V3 that increases the Reserve Factor (RF) for assets on Ethereum V2 by 5.00%, up to a maximum of 99.99%; and (2) to start periodically increasing the RF across Avalanche V2.

## Motivation

This AIP will reduce deposit yield for assets on Ethereum & Avalanche V2 by increasing the RF. With this upgrade being passed, users will be further encouraged to migrate from Ethereum V2 to V3.

Increasing the RF routes a larger portion of the interest paid by users to Aave DAO's Treasury. User's funds are not at risk of liquidation and the borrowing rate remains unchanged.

Of the assets with an RF set at 99.99%, there is no change. All other asset reserves will have the RF increased by up to 5.00%.

## Specification

For Ethereum V2, the following parameters are to be updated as follows:

| Asset | Previous Reserve Factor | New Reserve Factor |
| :---: | :---------------------: | :----------------: |
|  DAI  |         50.00%          |       55.00%       |
| FRAX  |         95.00%          |       99.99%       |
| GUSD  |         95.00%          |       99.99%       |
| LINK  |         55.00%          |       60.00%       |
| LUSD  |         95.00%          |       99.99%       |
| sUSD  |         95.00%          |       99.99%       |
| USDC  |         50.00%          |       55.00%       |
| USDP  |         95.00%          |       99.99%       |
| USDT  |         50.00%          |       55.00%       |
| WBTC  |         55.00%          |       60.00%       |
| WETH  |         50.00%          |       55.00%       |

For Avalanche V2, the following parameters are to be updated as follows:

| Asset | Previous Reserve Factor | New Reserve Factor |
| :---: | :---------------------: | :----------------: |
| DAIe  |         45.00%          |       50.00%       |
| USDCe |         45.00%          |       50.00%       |
| USDTe |         45.00%          |       50.00%       |
| WAVAX |         45.00%          |       50.00%       |
| WBTCe |         50.00%          |       55.00%       |
| WETHe |         45.00%          |       50.00%       |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/4d1d71e284bacc7244fc1388f0c7f750eac8ece9/src/20240524_Multi_ReserveFactorUpgrades/AaveV2Ethereum_ReserveFactorUpgrades_20240524.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/4d1d71e284bacc7244fc1388f0c7f750eac8ece9/src/20240524_Multi_ReserveFactorUpgrades/AaveV2Avalanche_ReserveFactorUpgrades_20240524.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/4d1d71e284bacc7244fc1388f0c7f750eac8ece9/src/20240524_Multi_ReserveFactorUpgrades/AaveV2Ethereum_ReserveFactorUpgrades_20240524.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/4d1d71e284bacc7244fc1388f0c7f750eac8ece9/src/20240524_Multi_ReserveFactorUpgrades/AaveV2Avalanche_ReserveFactorUpgrades_20240524.t.sol)
- [Discussion for Ethereum Reserve Factor Updates](https://governance.aave.com/t/arfc-ethereum-v2-reserve-factor-adjustment/16764/10)
- [Snapshot for Ethereum Reserve Factor Updates](https://snapshot.org/#/aave.eth/proposal/0x26a03c08359c340f63b78b0c3e96d37aa0adeda65814643b0886d4719048ea7e)
- [Discussion for Avalanche Reserve Factor Updates](https://governance.aave.com/t/arfc-avalanche-v2-reserve-factor-adjustment/17040/5)
- [Snapshot for Avalanche Reserve Factor Updates](https://snapshot.org/#/aave.eth/proposal/0x770ff4e02634c77aaa09952345551168920f7878b32ab03fcef92763a5fb70ab)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
