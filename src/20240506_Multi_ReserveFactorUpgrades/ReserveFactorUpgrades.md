---
title: "Reserve Factor Upgrades"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-avalanche-v2-reserve-factor-adjustment/17040/4"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x770ff4e02634c77aaa09952345551168920f7878b32ab03fcef92763a5fb70ab"
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
|  DAI  |         45.00%          |       50.00%       |
| FRAX  |         50.00%          |       55.00%       |
| GUSD  |         40.00%          |       45.00%       |
| LINK  |         50.00%          |       55.00%       |
| LUSD  |         45.00%          |       50.00%       |
| sUSD  |         50.00%          |       55.00%       |
| USDC  |         45.00%          |       50.00%       |
| USDP  |         40.00%          |       45.00%       |
| USDT  |         45.00%          |       50.00%       |
| WBTC  |         50.00%          |       55.00%       |
| WETH  |         45.00%          |       50.00%       |

For Avalanche V2, the following parameters are to be updated as follows:

| Asset | Previous Reserve Factor | New Reserve Factor |
| :---: | :---------------------: | :----------------: |
| DAIe  |         40.00%          |       45.00%       |
| USDCe |         40.00%          |       45.00%       |
| USDTe |         40.00%          |       45.00%       |
| WAVAX |         40.00%          |       45.00%       |
| WBTCe |         45.00%          |       50.00%       |
| WETHe |         40.00%          |       45.00%       |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/d90e14550053f219ecc816ecaa0fa9b3f5215872/src/20240506_Multi_ReserveFactorUpgrades/AaveV2Ethereum_ReserveFactorUpgrades_20240506.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/d90e14550053f219ecc816ecaa0fa9b3f5215872/src/20240506_Multi_ReserveFactorUpgrades/AaveV2Avalanche_ReserveFactorUpgrades_20240506.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/d90e14550053f219ecc816ecaa0fa9b3f5215872/src/20240506_Multi_ReserveFactorUpgrades/AaveV2Ethereum_ReserveFactorUpgrades_20240506.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/d90e14550053f219ecc816ecaa0fa9b3f5215872/src/20240506_Multi_ReserveFactorUpgrades/AaveV2Avalanche_ReserveFactorUpgrades_20240506.t.sol)
- [Discussion for Ethereum Reserve Factor Updates](https://governance.aave.com/t/arfc-ethereum-v2-reserve-factor-adjustment/16764/8)
- [Snapshot for Ethereum Reserve Factor Updates](https://snapshot.org/#/aave.eth/proposal/0x26a03c08359c340f63b78b0c3e96d37aa0adeda65814643b0886d4719048ea7e)
- [Discussion for Avalanche Reserve Factor Updates](https://governance.aave.com/t/arfc-avalanche-v2-reserve-factor-adjustment/17040/4)
- [Snapshot for Avalanche Reserve Factor Updates](https://snapshot.org/#/aave.eth/proposal/0x770ff4e02634c77aaa09952345551168920f7878b32ab03fcef92763a5fb70ab)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
