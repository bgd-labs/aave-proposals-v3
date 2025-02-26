---
title: "Aave V2 Deprecation Update"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-aave-v2-deprecation-update-disable-new-borrows-ir-curve-and-reserve-factor-adjustments/20918"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0xe1f53fe1748e6b31068eca832a07e5be5765ca3bf4ec1c900a13d78f29ed1d51"
---

## Simple Summary

Chaos labs recommends further risk parameters changes to deprecate Aave V2 protocol and encourage user migration to Aave V3

## Motivation

at standardizing the parameters in the market, improving the deprecation speed of frozen markets, and reducing the risks posed by volatile collateral assets.

In order to reduce risk we recommend disabling borrows across all assets, preventing further growth of risky debt positions. This measure ensures that positions utilizing volatile or risky collateral cannot increase their leverage within the legacy implementation. It also reduces the risk of price manipulation via oracle dependencies within the V2 instance.

We also recommend standardizing the interest rate parameters of all the frozen assets by setting a minimum base rate of 20% and a Slope 2 of 300%. This step will ensure that existing positions will be strongly incentivized to repay in order to avoid fast debt accrual that can lead to liquidations. As some of the borrow utilization of the assets in question comes from bad debt accrued over the lifespan of Aave V2, we recommend setting the reserve factor of all the frozen assets to 99%. This measure prevents Aave DAO from accruing additional net bad debt.

## Specification

### Ethereum V2

Implement previously proposed modifications to Aave V2 as per [here](https://governance.aave.com/t/arfc-reduction-of-reserve-factor-and-slope2-for-stablecoin-markets-on-aave-v2/20041).

| **Asset** | Chain    | **Current RF** | **Recommended RF** | **Current Slope2** | **Recommended Slope2** |
| --------- | -------- | -------------- | ------------------ | ------------------ | ---------------------- |
| USDC      | Ethereum | 85%            | 70%                | 60%                | 60%                    |
| USDT      | Ethereum | 85%            | 70%                | 100%               | 60%                    |
| DAI       | Ethereum | 85%            | 70%                | 75%                | 60%                    |

## Net new Borrow deactivation

Disable new borrows across all assets in Aave V2 to prevent further debt accumulation.

| Asset  | Chain     | Borrowable Current Value | Borrowable Recommended |
| ------ | --------- | ------------------------ | ---------------------- |
| WAVAX  | Avalanche | Yes                      | No                     |
| DAI.e  | Avalanche | Yes                      | No                     |
| USDT.e | Avalanche | Yes                      | No                     |
| WETH.e | Avalanche | Yes                      | No                     |
| WBTC.e | Avalanche | Yes                      | No                     |
| ENJ    | Ethereum  | Yes                      | No                     |
| USDT   | Ethereum  | Yes                      | No                     |
| KNC    | Ethereum  | Yes                      | No                     |
| renFIL | Ethereum  | Yes                      | No                     |
| DAI    | Ethereum  | Yes                      | No                     |
| WBTC   | Ethereum  | Yes                      | No                     |
| UST    | Ethereum  | Yes                      | No                     |
| BUSD   | Ethereum  | Yes                      | No                     |
| USDC   | Ethereum  | Yes                      | No                     |
| MANA   | Ethereum  | Yes                      | No                     |
| YFI    | Ethereum  | Yes                      | No                     |
| RAI    | Ethereum  | Yes                      | No                     |
| AMPL   | Ethereum  | Yes                      | No                     |
| WETH   | Ethereum  | Yes                      | No                     |
| FEI    | Ethereum  | Yes                      | No                     |
| CRV    | Polygon   | Yes                      | No                     |
| LINK   | Polygon   | Yes                      | No                     |
| BAL    | Polygon   | Yes                      | No                     |
| USDT   | Polygon   | Yes                      | No                     |
| WETH   | Polygon   | Yes                      | No                     |
| USDC.e | Polygon   | Yes                      | No                     |
| WBTC   | Polygon   | Yes                      | No                     |
| WPOL   | Polygon   | Yes                      | No                     |
| DAI    | Polygon   | Yes                      | No                     |

Adjust interest rate parameters in markets where bad debt constitutes a significant portion of the total outstanding debt, ensuring that accrual rates do not exacerbate financial losses.

| Asset  | Chain     | Current Base | Current Slope 1 | Current Slope 2 | Current UOptimal | Current Reserve Factor | Recommended Base | Recommended Slope 1 | Recommended Slope 2 | Recommended UOptimal | Recommended Reserve Factor |
| ------ | --------- | ------------ | --------------- | --------------- | ---------------- | ---------------------- | ---------------- | ------------------- | ------------------- | -------------------- | -------------------------- |
| BUSD   | Ethereum  | 10%          | 0%              | 0%              | 1%               | 99.99%                 | 1%               | 0%                  | 0%                  | 1%                   | -                          |
| ZRX    | Ethereum  | 20%          | 0%              | 300%            | 45%              | 99.99%                 | 1%               | 0%                  | 0%                  | 1%                   | -                          |
| BAT    | Ethereum  | 20%          | 0%              | 300%            | 45%              | 99.99%                 | 1%               | 0%                  | 0%                  | 1%                   | -                          |
| MANA   | Ethereum  | 20%          | 0%              | 300%            | 45%              | 99.99%                 | 1%               | 0%                  | 0%                  | 1%                   | -                          |
| FEI    | Ethereum  | 0%           | 4%              | 100%            | 1%               | 99.99%                 | 20%              | 0%                  | 300%                | 45%                  | -                          |
| sUSD   | Ethereum  | 3%           | 15%             | 200%            | 20%              | 99.99%                 | 20%              | 0%                  | 300%                | 45%                  | -                          |
| LUSD   | Ethereum  | 3%           | 15%             | 200%            | 20%              | 99.99%                 | 20%              | 0%                  | 300%                | 45%                  | -                          |
| USDP   | Ethereum  | 3%           | 15%             | 200%            | 20%              | 99.99%                 | 20%              | 0%                  | 300%                | 45%                  | -                          |
| FRAX   | Ethereum  | 3%           | 15%             | 200%            | 20%              | 99.99%                 | 20%              | 0%                  | 300%                | 45%                  | -                          |
| GUSD   | Ethereum  | 3%           | 15%             | 200%            | 20%              | 99.99%                 | 20%              | 0%                  | 300%                | 45%                  | -                          |
| TUSD   | Ethereum  | 10%          | 0%              | 0%              | 1%               | 99.99%                 | 20%              | -                   | 300%                | 45%                  | -                          |
| renFIL | Ethereum  | 0%           | 0%              | 0%              | 0%               | 35.00%                 | 20%              | -                   | 300%                | 45%                  | 99.99%                     |
| LINK   | Ethereum  | 0%           | 7%              | 300%            | 45%              | 90.00%                 | 20%              | 0%                  | -                   | -                    | 99.99%                     |
| UST    | Ethereum  | 20%          | 0%              | 300%            | 80%              | 99.99%                 | -                | 0%                  | -                   | 45%                  | -                          |
| RAI    | Ethereum  | 20%          | 0%              | 300%            | 80%              | 99.99%                 | -                | -                   | -                   | 45%                  | -                          |
| KNC    | Ethereum  | 20%          | 0%              | 300%            | 65%              | 99.99%                 | -                | -                   | -                   | 45%                  | -                          |
| AMPL   | Ethereum  | 20%          | 0%              | 300%            | 80%              | 99.99%                 | -                | -                   | -                   | 45%                  | -                          |
| BAL    | Ethereum  | 20%          | 0%              | 300%            | 80%              | 99.99%                 | -                | -                   | -                   | 45%                  | -                          |
| DPI    | Ethereum  | 20%          | 0%              | 300%            | 50%              | 99.99%                 | -                | -                   | -                   | 45%                  | -                          |
| SNX    | Ethereum  | 20%          | 0%              | 300%            | 80%              | 99.99%                 | -                | -                   | -                   | 45%                  | -                          |
| UNI    | Ethereum  | 20%          | 0%              | 300%            | 45%              | 99.99%                 | -                | 0%                  | -                   | -                    | -                          |
| CRV    | Ethereum  | 20%          | 0%              | 300%            | 45%              | 99.99%                 | -                | 0%                  | -                   | -                    | -                          |
| YFI    | Ethereum  | 20%          | 0%              | 300%            | 45%              | 99.99%                 | -                | 0%                  | -                   | -                    | -                          |
| BAL    | Polygon   | 5%           | 50%             | 134%            | 20%              | 99.99%                 | 20%              | 0%                  | 300%                | 45%                  | -                          |
| GHST   | Polygon   | 0%           | 50%             | 134%            | 10%              | 99.99%                 | 20%              | 0%                  | 300%                | 45%                  | -                          |
| CRV    | Polygon   | 3%           | 50%             | 134%            | 10%              | 99.99%                 | 20%              | 0%                  | 300%                | 45%                  | -                          |
| LINK   | Polygon   | 0%           | 50%             | 134%            | 10%              | 99.99%                 | 20%              | 0%                  | 300%                | 45%                  | -                          |
| WBTC.e | Avalanche | 0%           | 7%              | 300%            | 45%              | 85.00%                 | 20%              | 0%                  | -                   | -                    | 99.99%                     |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250220_Multi_AaveV2DeprecationUpdate/AaveV2Ethereum_AaveV2DeprecationUpdate_20250220.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250220_Multi_AaveV2DeprecationUpdate/AaveV2Polygon_AaveV2DeprecationUpdate_20250220.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250220_Multi_AaveV2DeprecationUpdate/AaveV2Avalanche_AaveV2DeprecationUpdate_20250220.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250220_Multi_AaveV2DeprecationUpdate/AaveV2Ethereum_AaveV2DeprecationUpdate_20250220.t.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250220_Multi_AaveV2DeprecationUpdate/AaveV2Polygon_AaveV2DeprecationUpdate_20250220.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250220_Multi_AaveV2DeprecationUpdate/AaveV2Avalanche_AaveV2DeprecationUpdate_20250220.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0xe1f53fe1748e6b31068eca832a07e5be5765ca3bf4ec1c900a13d78f29ed1d51)
- [Discussion](https://governance.aave.com/t/arfc-aave-v2-deprecation-update-disable-new-borrows-ir-curve-and-reserve-factor-adjustments/20918)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
