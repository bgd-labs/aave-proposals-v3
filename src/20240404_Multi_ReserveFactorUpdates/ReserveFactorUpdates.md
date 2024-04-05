---
title: "Reserve Factor Updates"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-ethereum-v2-reserve-factor-adjustment/16764/6"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x26a03c08359c340f63b78b0c3e96d37aa0adeda65814643b0886d4719048ea7e"
---

## Simple Summary

This AIP is composed of two actions: (1) a continuation of proposal 49 on Governance V3 that increases the Reserve Factor (RF) for assets on Ethereum V2 by 5.00%, up to a maximum of 99.99%; and (2) to start periodically increasing the RF across Avalanche V2.

## Motivation

This AIP will reduce deposit yield for assets on Ethereum & Avalanche V2 by increasing the RF. With this upgrade being passed, users will be further encouraged to migrate from Ethereum V2 to V3.

Increasing the RF routes a larger portion of the interest paid by users to Aave DAO's Treasury. User's funds are not at risk of liquidation and the borrowing rate remains unchanged.

Of the assets with an RF set at 99.99%, there is no change. All other asset reserves will have the RF increased by up to 5.00%.

## Specification

For Ethereum V2, the following parameters are to be updated as follows:

| Asset | Previous Reserve Factor | New Reserve Factor |
| ----- | ----------------------- | ------------------ |
| DAI   | 35.00%                  | 40.00%             |
| FRAX  | 40.00%                  | 45.00%             |
| GUSD  | 30.00%                  | 35.00%             |
| LINK  | 40.00%                  | 45.00%             |
| LUSD  | 35.00%                  | 40.00%             |
| sUSD  | 40.00%                  | 45.00%             |
| USDC  | 35.00%                  | 40.00%             |
| USDP  | 30.00%                  | 35.00%             |
| USDT  | 35.00%                  | 40.00%             |
| WBTC  | 40.00%                  | 45.00%             |
| WETH  | 35.00%                  | 40.00%             |

For Avalanche V2, the following parameters are to be updated as follows:

| Asset | Previous Reserve Factor | New Reserve Factor |
| ----- | ----------------------- | ------------------ |
| DAIe  | 10.00%                  | 35.00%             |
| USDCe | 10.00%                  | 35.00%             |
| USDTe | 10.00%                  | 35.00%             |
| WAVAX | 15.00%                  | 35.00%             |
| WBTCe | 10.00%                  | 40.00%             |
| WETHe | 10.00%                  | 35.00%             |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240404_Multi_ReserveFactorUpdates/AaveV2Ethereum_ReserveFactorUpdates_20240404.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240404_Multi_ReserveFactorUpdates/AaveV2Avalanche_ReserveFactorUpdates_20240404.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240404_Multi_ReserveFactorUpdates/AaveV2Ethereum_ReserveFactorUpdates_20240404.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240404_Multi_ReserveFactorUpdates/AaveV2Avalanche_ReserveFactorUpdates_20240404.t.sol)
- [Discussion for Ethereum Reserve Factor Updates](https://governance.aave.com/t/arfc-ethereum-v2-reserve-factor-adjustment/16764/6)
- [Snapshot for Ethereum Reserve Factor Updates](https://snapshot.org/#/aave.eth/proposal/0x26a03c08359c340f63b78b0c3e96d37aa0adeda65814643b0886d4719048ea7e)
- [Discussion for Avalanche Reserve Factor Updates](https://governance.aave.com/t/arfc-avalanche-v2-reserve-factor-adjustment/17040)
- [Snapshot for Avalanche Reserve Factor Updates](https://snapshot.org/#/aave.eth/proposal/0x770ff4e02634c77aaa09952345551168920f7878b32ab03fcef92763a5fb70ab)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
