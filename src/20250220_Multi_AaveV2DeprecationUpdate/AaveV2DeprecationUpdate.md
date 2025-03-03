---
title: "Aave V2 Deprecation Update"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-aave-v2-deprecation-update-disable-new-borrows-ir-curve-and-reserve-factor-adjustments/20918"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0xe1f53fe1748e6b31068eca832a07e5be5765ca3bf4ec1c900a13d78f29ed1d51"
---

## Simple Summary

Chaos labs recommends further risk parameters changes to deprecate Aave V2 protocol and encourage user migration to Aave V3

## Motivation

The proposal is aimed at standardizing the parameters in the market, improving the deprecation speed of frozen markets, and reducing the risks posed by volatile collateral assets.

In order to reduce risk we recommend disabling borrows across all assets, preventing further growth of risky debt positions. This measure ensures that positions utilizing volatile or risky collateral cannot increase their leverage within the legacy implementation. It also reduces the risk of price manipulation via oracle dependencies within the V2 instance.

We also recommend standardizing the interest rate parameters of all the frozen assets by setting a minimum base rate of 20% and a Slope 2 of 300%. This step will ensure that existing positions will be strongly incentivized to repay in order to avoid fast debt accrual that can lead to liquidations. As some of the borrow utilization of the assets in question comes from bad debt accrued over the lifespan of Aave V2, we recommend setting the reserve factor of all the frozen assets to 99%. This measure prevents Aave DAO from accruing additional net bad debt.

## Specification

### Ethereum V2

Implement previously proposed modifications to Aave V2 as per [here](https://governance.aave.com/t/arfc-reduction-of-reserve-factor-and-slope2-for-stablecoin-markets-on-aave-v2/20041).

| **Asset** | Chain    | **Recommended RF** | **Recommended Slope2** |
| --------- | -------- | ------------------ | ---------------------- |
| USDC      | Ethereum | 70%                | 60%                    |
| USDT      | Ethereum | 70%                | 60%                    |
| DAI       | Ethereum | 70%                | 60%                    |

## Net new Borrow deactivation

Disable new borrows across all assets in Aave V2 to prevent further debt accumulation.

| Asset  | Chain     | Borrowable Recommended |
| ------ | --------- | ---------------------- |
| WAVAX  | Avalanche | No                     |
| DAI.e  | Avalanche | No                     |
| USDT.e | Avalanche | No                     |
| WETH.e | Avalanche | No                     |
| WBTC.e | Avalanche | No                     |
| ENJ    | Ethereum  | No                     |
| USDT   | Ethereum  | No                     |
| KNC    | Ethereum  | No                     |
| renFIL | Ethereum  | No                     |
| DAI    | Ethereum  | No                     |
| WBTC   | Ethereum  | No                     |
| UST    | Ethereum  | No                     |
| BUSD   | Ethereum  | No                     |
| USDC   | Ethereum  | No                     |
| MANA   | Ethereum  | No                     |
| YFI    | Ethereum  | No                     |
| RAI    | Ethereum  | No                     |
| AMPL   | Ethereum  | No                     |
| WETH   | Ethereum  | No                     |
| FEI    | Ethereum  | No                     |
| CRV    | Polygon   | No                     |
| LINK   | Polygon   | No                     |
| BAL    | Polygon   | No                     |
| USDT   | Polygon   | No                     |
| WETH   | Polygon   | No                     |
| USDC.e | Polygon   | No                     |
| WBTC   | Polygon   | No                     |
| WPOL   | Polygon   | No                     |
| DAI    | Polygon   | No                     |

Adjust interest rate parameters in markets where bad debt constitutes a significant portion of the total outstanding debt, ensuring that accrual rates do not exacerbate financial losses.

| Asset  | Chain     | Recommended Base | Recommended Slope 1 | Recommended Slope 2 | Recommended UOptimal | Recommended Reserve Factor |
| ------ | --------- | ---------------- | ------------------- | ------------------- | -------------------- | -------------------------- |
| BUSD   | Ethereum  | 1%               | -                   | -                   | -                    | -                          |
| ZRX    | Ethereum  | 1%               | -                   | 0%                  | 1%                   | -                          |
| BAT    | Ethereum  | 1%               | -                   | 0%                  | 1%                   | -                          |
| MANA   | Ethereum  | 1%               | -                   | 0%                  | 1%                   | -                          |
| FEI    | Ethereum  | 20%              | 0%                  | 300%                | 45%                  | -                          |
| sUSD   | Ethereum  | 20%              | 0%                  | 300%                | 45%                  | -                          |
| LUSD   | Ethereum  | 20%              | 0%                  | 300%                | 45%                  | -                          |
| USDP   | Ethereum  | 20%              | 0%                  | 300%                | 45%                  | -                          |
| FRAX   | Ethereum  | 20%              | 0%                  | 300%                | 45%                  | -                          |
| GUSD   | Ethereum  | 20%              | 0%                  | 300%                | 45%                  | -                          |
| TUSD   | Ethereum  | 1%               | -                   | -                   | -                    | -                          |
| renFIL | Ethereum  | 20%              | -                   | 300%                | 45%                  | 99.99%                     |
| LINK   | Ethereum  | 20%              | 0%                  | -                   | -                    | 99.99%                     |
| UST    | Ethereum  | -                | -                   | -                   | 45%                  | -                          |
| RAI    | Ethereum  | -                | -                   | -                   | 45%                  | -                          |
| KNC    | Ethereum  | -                | -                   | -                   | 45%                  | -                          |
| AMPL   | Ethereum  | -                | -                   | -                   | 45%                  | -                          |
| BAL    | Ethereum  | -                | -                   | -                   | 45%                  | -                          |
| DPI    | Ethereum  | -                | -                   | -                   | 45%                  | -                          |
| SNX    | Ethereum  | -                | -                   | -                   | 45%                  | -                          |
| BAL    | Polygon   | 20%              | 0%                  | 300%                | 45%                  | -                          |
| GHST   | Polygon   | 20%              | 0%                  | 300%                | 45%                  | -                          |
| CRV    | Polygon   | 20%              | 0%                  | 300%                | 45%                  | -                          |
| LINK   | Polygon   | 20%              | 0%                  | 300%                | 45%                  | -                          |
| WBTC.e | Avalanche | 20%              | 0%                  | -                   | -                    | 99.99%                     |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/c8c2e94ff7a0f71bb6a7f23fbd50026c07d65f49/src/20250220_Multi_AaveV2DeprecationUpdate/AaveV2Ethereum_AaveV2DeprecationUpdate_20250220.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/c8c2e94ff7a0f71bb6a7f23fbd50026c07d65f49/src/20250220_Multi_AaveV2DeprecationUpdate/AaveV2Polygon_AaveV2DeprecationUpdate_20250220.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/c8c2e94ff7a0f71bb6a7f23fbd50026c07d65f49/src/20250220_Multi_AaveV2DeprecationUpdate/AaveV2Avalanche_AaveV2DeprecationUpdate_20250220.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/c8c2e94ff7a0f71bb6a7f23fbd50026c07d65f49/src/20250220_Multi_AaveV2DeprecationUpdate/AaveV2Ethereum_AaveV2DeprecationUpdate_20250220.t.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/c8c2e94ff7a0f71bb6a7f23fbd50026c07d65f49/src/20250220_Multi_AaveV2DeprecationUpdate/AaveV2Polygon_AaveV2DeprecationUpdate_20250220.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/c8c2e94ff7a0f71bb6a7f23fbd50026c07d65f49/src/20250220_Multi_AaveV2DeprecationUpdate/AaveV2Avalanche_AaveV2DeprecationUpdate_20250220.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0xe1f53fe1748e6b31068eca832a07e5be5765ca3bf4ec1c900a13d78f29ed1d51)
- [Discussion](https://governance.aave.com/t/arfc-aave-v2-deprecation-update-disable-new-borrows-ir-curve-and-reserve-factor-adjustments/20918)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
