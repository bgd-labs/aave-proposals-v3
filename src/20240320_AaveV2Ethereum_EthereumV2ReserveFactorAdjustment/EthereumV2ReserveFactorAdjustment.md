---
title: "Ethereum v2 Reserve Factor Adjustment"
author: "Karpatkey, TokenLogic, ChaosLabs"
discussions: "https://governance.aave.com/t/arfc-ethereum-v2-reserve-factor-adjustment/16764/3"
---

## Simple Summary

This AIP is a continuation of proposal 49 on Governance v3 and increases the Reserve Factor (RF) for assets on Ethereum v2 by 5.00%, up to a maximum of 99.99%.

## Motivation

This AIP will reduce deposit yield for assets on Ethereum v2 by increasing the RF. With this upgrade being passed, users will be further encouraged to migrate from Ethereum v2 to v3.

Increasing the RF routes a larger portion of the interest paid by users to Aave DAO's Treasury. User's funds are not at risk of liquidation and the borrowing rate remains unchanged.

Of the assets with an RF set at 99.99%, there is no change. All other asset reserves will have the RF increased by up to 5%.

## Specification

The following parameters are to be updated as follows:

| Asset | Previous Reserve Factor | New Reserve Factor |
| ----- | ----------------------- | ------------------ |
| DAI   | 30.00%                  | 35.00%             |
| FRAX  | 35.00%                  | 40.00%             |
| GUSD  | 25.00%                  | 30.00%             |
| LINK  | 35.00%                  | 40.00%             |
| LUSD  | 30.00%                  | 35.00%             |
| sUSD  | 35.00%                  | 40.00%             |
| USDC  | 30.00%                  | 35.00%             |
| USDP  | 25.00%                  | 30.00%             |
| USDT  | 30.00%                  | 35.00%             |
| WBTC  | 35.00%                  | 40.00%             |
| WETH  | 30.00%                  | 35.00%             |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_AaveV2Ethereum_EthereumV2ReserveFactorAdjustment/AaveV2Ethereum_EthereumV2ReserveFactorAdjustment_20240320.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_AaveV2Ethereum_EthereumV2ReserveFactorAdjustment/AaveV2Ethereum_EthereumV2ReserveFactorAdjustment_20240320.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x26a03c08359c340f63b78b0c3e96d37aa0adeda65814643b0886d4719048ea7e)
- [Discussion](https://governance.aave.com/t/arfc-ethereum-v2-reserve-factor-adjustment/16764)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
