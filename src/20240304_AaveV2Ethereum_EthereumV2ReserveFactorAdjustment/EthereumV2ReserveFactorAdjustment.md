---
title: "Ethereum v2 Reserve Factor Adjustment"
author: "Karpatkey, TokenLogic, ChaosLabs"
discussions: "https://governance.aave.com/t/arfc-ethereum-v2-reserve-factor-adjustment/16764"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x26a03c08359c340f63b78b0c3e96d37aa0adeda65814643b0886d4719048ea7e"
---

## Simple Summary

This publication proposes periodically increasing the Aave v2 Ethereum Reserve Factor (RF) to encourage users to migrate to Aave v3.

## Motivation

With Aave v3 now crossing the $8 Billion TVL threshold and $3 Billion remaining in Aave v2, this publication seeks to encourage users to migrate from v2 to v3 by increasing the RF.

With all other variables held constant, increasing the RF over time in isolation will result in a reduced deposit rate. Users are encourage to migrate to v3 in search of higher yield.

With market conditions permitting, we propose initiating a periodic 5.00% RF increase across all assets every 14 days as mentioned [here](https://governance.aave.com/t/arfc-chaos-labs-incremental-reserve-factor-updates-aave-v2-ethereum/13766) up to a threshold of 99.99%. During each increase cycle we will monitor how users respond and, if any potential risks are identified, the next RF increase will be delayed until it is safe to implement.

Do note that increasing the RF parameter does not directly affect users' health factor, and this method has already been [implemented on Polygon v2](https://governance.aave.com/t/temp-check-polygon-v2-to-v3-liquidity-migration/12350) for some time.

## Specification

The below shows the current and proposed RF for each reserve.

| Asset    | Current RF | Recommended RF |
| -------- | ---------- | -------------- |
| ONE_INCH | 99.00%     | 99.99%         |
| AMPL     | 99.90%     | 99.99%         |
| BUSD     | 99.90%     | 99.99%         |
| BAL      | 99.00%     | 99.99%         |
| BAT      | 99.00%     | 99.99%         |
| CRV      | 99.00%     | 99.99%         |
| CVX      | 99.00%     | 99.99%         |
| DAI      | 25.00%     | 30.00%         |
| DPI      | 99.00%     | 99.99%         |
| ENS      | 99.00%     | 99.99%         |
| ENJ      | 99.00%     | 99.99%         |
| FEI      | 99.00%     | 99.99%         |
| FRAX     | 30.00%     | 35.00%         |
| GUSD     | 20.00%     | 25.00%         |
| KNC      | 99.00%     | 99.99%         |
| LINK     | 30.00%     | 35.00%         |
| LUSD     | 25.00%     | 30.00%         |
| MANA     | 99.00%     | 99.99%         |
| MKR      | 99.00%     | 99.99%         |
| RAI      | 99.00%     | 99.99%         |
| REN      | 99.00%     | 99.99%         |
| SNX      | 99.00%     | 99.99%         |
| sUSD     | 30.00%     | 35.00%         |
| xSUSHI   | 99.00%     | 99.99%         |
| TUSD     | 99.00%     | 99.99%         |
| UNI      | 99.00%     | 99.99%         |
| USDC     | 25.00%     | 30.00%         |
| USDP     | 20.00%     | 25.00%         |
| USDT     | 25.00%     | 30.00%         |
| UST      | 99.00%     | 99.99%         |
| WBTC     | 30.00%     | 35.00%         |
| WETH     | 25.00%     | 30.00%         |
| YFI      | 99.00%     | 99.99%         |
| ZRX      | 99.00%     | 99.99%         |

Upon implementing this proposal, a subsequent AIP will be submitted every 2 weeks that increases the RF by 5.00% up to a maximum of 99.99%, subject to market conditions.

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240304_AaveV2Ethereum_EthereumV2ReserveFactorAdjustment/AaveV2Ethereum_EthereumV2ReserveFactorAdjustment_20240304.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240304_AaveV2Ethereum_EthereumV2ReserveFactorAdjustment/AaveV2Ethereum_EthereumV2ReserveFactorAdjustment_20240304.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x26a03c08359c340f63b78b0c3e96d37aa0adeda65814643b0886d4719048ea7e)
- [Discussion](https://governance.aave.com/t/arfc-ethereum-v2-reserve-factor-adjustment/16764)

# Disclosure

TokenLogic, karpatkey and Chaos Labs receive no payment for this proposal. TokenLogic and karpatkey are both delegates within the Aave community.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
