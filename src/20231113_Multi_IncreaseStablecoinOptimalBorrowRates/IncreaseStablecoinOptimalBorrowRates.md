---
title: "Increase Stablecoin Optimal Borrow Rates"
author: "monet-supply + Gauntlet (impl: Alice Rozengarden (@Rozengarden - Aave-chan initiative))"
discussions: "https://governance.aave.com/t/arfc-increase-optimal-borrow-rates-for-ethereum-stablecoin-markets/15096/3"
---

## Simple Summary

This AIP propose to modify the parameters of stablecoins across all the Aave pools. Mainly by setting the slope1 to 5%, as well as changing the RF to 25% and Uopt to 90% of some of them.

## Motivation

According to [research](https://governance.aave.com/t/arfc-increase-optimal-borrow-rates-for-ethereum-stablecoin-markets/15096/3) by @monet-supply, the borrowing parameters of the stablecoins on Aave have diverged from the broader market leading to potentials inefficiencies and bad user experience.

Those proposed changes have been approved by both risk providers, with additional suggestion by @Gauntlet.

Stablecoin across all the V2 and V3 markets are concerned by those change. Namely USDC, USDT, LUSD, FRAX, sUSD, DAI, MAI, GUSD, USDP on ethereum (V2 and V3), polygon (V2 and V2), Arbitrum, Gnosis, Optimism, Avalanche (v2 and V3) and Metis. However the changes of RF and Uopt would be more limited, with the Uopt changes being limited to USDC, USDT, DAI and FRAX across all V3s and the RF ones to USDC, USDT and LUSD only for Ethereum V2.

## Specification

The following stablecoins would see changes to their parameters:
(Blank means no changes)

| Market  | Asset  | slope1 | Uopt | RF  |
| ------- | ------ | ------ | ---- | --- |
| Ethv2   | USDC   | 5%     |      | 25% |
| Ethv2   | USDT   | 5%     |      | 25% |
| Ethv2   | FRAX   | 5%     |      |     |
| Ethv2   | sUSD   | 5%     |      |     |
| Ethv2   | GUSD   | 5%     |      |     |
| Ethv2   | LUSD   | 5%     |      | 25% |
| Ethv2   | USDP   | 5%     |      |     |
| ---     | ---    | ---    | ---  | --- |
| Ethv3   | USDC   | 5%     | 90%  |     |
| Ethv3   | USDT   | 5%     | 90%  |     |
| Ethv3   | FRAX   | 5%     | 90%  |     |
| Ethv3   | LUSD   | 5%     |      |     |
| ---     | ---    | ---    | ---  | --- |
| AvaxV2  | USDC   | 5%     |      |     |
| AvaxV2  | USDT   | 5%     |      |     |
| AvaxV2  | DAI    | 5%     |      |     |
| ---     | ---    | ---    | ---  | --- |
| AvaxV3  | USDC   | 5%     | 90%  |     |
| AvaxV3  | USDT   | 5%     | 90%  |     |
| AvaxV3  | DAI    | 5%     | 90%  |     |
| AvaxV3  | MAI    | 5%     |      |     |
| AvaxV3  | FRAX   | 5%     | 90%  |     |
| ---     | ---    | ---    | ---  | --- |
| PolV2   | USDC   | 5%     |      |     |
| PolV2   | USDT   | 5%     |      |     |
| PolV2   | DAI    | 5%     |      |     |
| ---     | ---    | ---    | ---  | --- |
| PolV3   | USDC   | 5%     | 90%  |     |
| PolV3   | USDT   | 5%     | 90%  |     |
| PolV3   | DAI    | 5%     | 90%  |     |
| PolV3   | MAI    | 5%     |      |     |
| ---     | ---    | ---    | ---  | --- |
| OpV3    | USDC   | 5%     | 90%  |     |
| OpV3    | USDT   | 5%     | 90%  |     |
| OpV3    | DAI    | 5%     | 90%  |     |
| OpV3    | sUSD   | 5%     |      |     |
| OpV3    | LUSD   | 5%     |      |     |
| OpV3    | MAI    | 5%     |      |     |
| ---     | ---    | ---    | ---  | --- |
| ArbV3   | USDC   | 5%     | 90%  |     |
| ArbV3   | USDC.e | 5%     |      |     |
| ArbV3   | USDT   | 5%     | 90%  |     |
| ArbV3   | DAI    | 5%     | 90%  |     |
| ArbV3   | LUSD   | 5%     |      |     |
| ArbV3   | FRAX   | 5%     | 90%  |     |
| ArbV3   | MAI    | 5%     |      |     |
| ---     | ---    | ---    | ---  | --- |
| BaseV3  | USDC   | 5%     | 90%  |     |
| ---     | ---    | ---    | ---  | --- |
| MetisV3 | USDC   | 5%     | 90%  |     |
| MetisV3 | USDT   | 5%     | 90%  |     |
| ---     | ---    | ---    | ---  | --- |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/8cf09317c749ddf7bed46b5f260c0f399897e11a/src/20231113_Multi_IncreaseStablecoinOptimalBorrowRates/AaveV2Ethereum_IncreaseStablecoinOptimalBorrowRates_20231113.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/8cf09317c749ddf7bed46b5f260c0f399897e11a/src/20231113_Multi_IncreaseStablecoinOptimalBorrowRates/AaveV2Polygon_IncreaseStablecoinOptimalBorrowRates_20231113.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/8cf09317c749ddf7bed46b5f260c0f399897e11a/src/20231113_Multi_IncreaseStablecoinOptimalBorrowRates/AaveV2Avalanche_IncreaseStablecoinOptimalBorrowRates_20231113.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/8cf09317c749ddf7bed46b5f260c0f399897e11a/src/20231113_Multi_IncreaseStablecoinOptimalBorrowRates/AaveV3Ethereum_IncreaseStablecoinOptimalBorrowRates_20231113.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/8cf09317c749ddf7bed46b5f260c0f399897e11a/src/20231113_Multi_IncreaseStablecoinOptimalBorrowRates/AaveV3Polygon_IncreaseStablecoinOptimalBorrowRates_20231113.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/8cf09317c749ddf7bed46b5f260c0f399897e11a/src/20231113_Multi_IncreaseStablecoinOptimalBorrowRates/AaveV3Avalanche_IncreaseStablecoinOptimalBorrowRates_20231113.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/8cf09317c749ddf7bed46b5f260c0f399897e11a/src/20231113_Multi_IncreaseStablecoinOptimalBorrowRates/AaveV3Optimism_IncreaseStablecoinOptimalBorrowRates_20231113.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/8cf09317c749ddf7bed46b5f260c0f399897e11a/src/20231113_Multi_IncreaseStablecoinOptimalBorrowRates/AaveV3Arbitrum_IncreaseStablecoinOptimalBorrowRates_20231113.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/8cf09317c749ddf7bed46b5f260c0f399897e11a/src/20231113_Multi_IncreaseStablecoinOptimalBorrowRates/AaveV3Metis_IncreaseStablecoinOptimalBorrowRates_20231113.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/8cf09317c749ddf7bed46b5f260c0f399897e11a/src/20231113_Multi_IncreaseStablecoinOptimalBorrowRates/AaveV3Base_IncreaseStablecoinOptimalBorrowRates_20231113.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/8cf09317c749ddf7bed46b5f260c0f399897e11a/src/20231113_Multi_IncreaseStablecoinOptimalBorrowRates/AaveV2Ethereum_IncreaseStablecoinOptimalBorrowRates_20231113.t.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/8cf09317c749ddf7bed46b5f260c0f399897e11a/src/20231113_Multi_IncreaseStablecoinOptimalBorrowRates/AaveV2Polygon_IncreaseStablecoinOptimalBorrowRates_20231113.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/8cf09317c749ddf7bed46b5f260c0f399897e11a/src/20231113_Multi_IncreaseStablecoinOptimalBorrowRates/AaveV2Avalanche_IncreaseStablecoinOptimalBorrowRates_20231113.t.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/8cf09317c749ddf7bed46b5f260c0f399897e11a/src/20231113_Multi_IncreaseStablecoinOptimalBorrowRates/AaveV3Ethereum_IncreaseStablecoinOptimalBorrowRates_20231113.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/8cf09317c749ddf7bed46b5f260c0f399897e11a/src/20231113_Multi_IncreaseStablecoinOptimalBorrowRates/AaveV3Polygon_IncreaseStablecoinOptimalBorrowRates_20231113.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/8cf09317c749ddf7bed46b5f260c0f399897e11a/src/20231113_Multi_IncreaseStablecoinOptimalBorrowRates/AaveV3Avalanche_IncreaseStablecoinOptimalBorrowRates_20231113.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/8cf09317c749ddf7bed46b5f260c0f399897e11a/src/20231113_Multi_IncreaseStablecoinOptimalBorrowRates/AaveV3Optimism_IncreaseStablecoinOptimalBorrowRates_20231113.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/8cf09317c749ddf7bed46b5f260c0f399897e11a/src/20231113_Multi_IncreaseStablecoinOptimalBorrowRates/AaveV3Arbitrum_IncreaseStablecoinOptimalBorrowRates_20231113.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/8cf09317c749ddf7bed46b5f260c0f399897e11a/src/20231113_Multi_IncreaseStablecoinOptimalBorrowRates/AaveV3Metis_IncreaseStablecoinOptimalBorrowRates_20231113.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/8cf09317c749ddf7bed46b5f260c0f399897e11a/src/20231113_Multi_IncreaseStablecoinOptimalBorrowRates/AaveV3Base_IncreaseStablecoinOptimalBorrowRates_20231113.t.sol)
- Snapshot: [Slope1](https://snapshot.org/#/aave.eth/proposal/0x914862039828294f4277ad63087ffae295b7693ba365c9036326cca802bfc7af), [Uopt & RF](https://snapshot.org/#/aave.eth/proposal/0xb9b28f57f7633dd6b987de9abcede23da62fe4fab6b002f189b8b25a7c02ea93)
- [Discussion](https://governance.aave.com/t/arfc-increase-optimal-borrow-rates-for-ethereum-stablecoin-markets/15096/3)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
