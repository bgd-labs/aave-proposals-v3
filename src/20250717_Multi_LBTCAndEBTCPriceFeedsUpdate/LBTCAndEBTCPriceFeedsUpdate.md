---
title: "LBTC and eBTC Price Feeds Update"
author: "BGD Labs @bgdlabs"
discussions: https://governance.aave.com/t/direct-to-aip-lbtc-oracle-and-capo-implementation-update/22614
snapshot: Direct-to-AIP
---

## Simple Summary

AIP for updating the price feeds of LBTC and eBTC, ensuring accurate prices for both assets that will be upgraded to yield-bearing tokens.

## Motivation

Lombard is upgrading LBTC into a yield-bearing asset launching on August 11th, 2025. The asset will start accruing BABY rewards from Babylon; therefore, we need to upgrade the LBTC price strategy to reflect value accrual after the upgrade.

Currently, LBTC has been priced with the BTC / USD price feed as previously recommended in the [LBTC analysis](https://governance.aave.com/t/arfc-onboard-lbtc-on-aave-v3-core-instance/20142/8). In the price strategy section, it was mentioned that in the future, the asset would start generating yield from Babylon stake rewards and would need to upgrade the price strategy.

eBTC is an LRT that is mainly backed by LBTC. We also highlight in the [eBTC technical analysis](https://governance.aave.com/t/arfc-enable-ebtc-wbtc-liquid-e-mode-on-aave-v3-core-instance/20141/9) that the price cap adapter must be updated as soon as restaking rewards start accruing.

## Specification

The table below illustrates the configuration parameters recommended by Chaos Labs:

**Price feed details**

<br>

**LBTC**

| Parameter (Mainnet)         |                                                                                              Value |
| --------------------------- | -------------------------------------------------------------------------------------------------: |
| Oracle                      | [Capped LBTC / BTC / USD](https://etherscan.io/address/0xf8c04B50499872A5B5137219DEc0F791f7f620D0) |
| Ratio Provider              |        [StakedLBTCOracle](https://etherscan.io/address/0x1De9fcfeDF3E51266c188ee422fbA1c7860DA0eF) |
| Underlying Feed             |   [Chainlink SVR BTC/USD](https://etherscan.io/address/0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A) |
| Oracle Latest Answer        |                                                                 (Aug-11-2025) USD 119,667.05332541 |
| Snapshot Ratio              |                                                                                               1.00 |
| Snapshot Timestamp          |                                                                                        Jun-15-2025 |
| maxYearlyRatioGrowthPercent |                                                                                              2.00% |

| Parameter (Base)            |                                                                                              Value |
| --------------------------- | -------------------------------------------------------------------------------------------------: |
| Oracle                      | [Capped LBTC / BTC / USD](https://basescan.org/address/0xA04669FE5cba4Bb21f265B562D23e562E45A1C67) |
| Ratio Provider              |        [StakedLBTCOracle](https://basescan.org/address/0x1De9fcfeDF3E51266c188ee422fbA1c7860DA0eF) |
| Underlying Feed             |       [Chainlink BTC/USD](https://basescan.org/address/0x64c911996D3c6aC71f9b455B1E8E7266BcbD848F) |
| Oracle Latest Answer        |                                                                 (Aug-11-2025) USD 119,714.02384483 |
| Snapshot Ratio              |                                                                                               1.00 |
| Snapshot Timestamp          |                                                                                        Jun-15-2025 |
| maxYearlyRatioGrowthPercent |                                                                                              2.00% |

<br>

**eBTC**

| Parameter (Mainnet)         |                                                                                                  Value |
| --------------------------- | -----------------------------------------------------------------------------------------------------: |
| Oracle                      |     [Capped eBTC / BTC / USD](https://etherscan.io/address/0x03bB418e89B75407585f8198178f253DA3216218) |
| Ratio Provider              | [AccountantWithRateProviders](https://etherscan.io/address/0x1b293DC39F94157fA0D1D36d7e0090C8B8B8c13F) |
| Underlying Feed             |       [Chainlink SVR BTC/USD](https://etherscan.io/address/0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A) |
| Oracle Latest Answer        |                                                                     (Aug-11-2025) USD 119,665.73000000 |
| Snapshot Ratio              |                                                                                                   1.00 |
| Snapshot Timestamp          |                                                                                            Jul-12-2025 |
| maxYearlyRatioGrowthPercent |                                                                                                  1.90% |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/1f7fdad01de6d4d123e87ba6a34fe0c82b7c4e75/src/20250717_Multi_LBTCAndEBTCPriceFeedsUpdate/AaveV3Ethereum_LBTCAndEBTCPriceFeedsUpdate_20250717.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/1f7fdad01de6d4d123e87ba6a34fe0c82b7c4e75/src/20250717_Multi_LBTCAndEBTCPriceFeedsUpdate/AaveV3Base_LBTCAndEBTCPriceFeedsUpdate_20250717.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/1f7fdad01de6d4d123e87ba6a34fe0c82b7c4e75/src/20250717_Multi_LBTCAndEBTCPriceFeedsUpdate/AaveV3Ethereum_LBTCAndEBTCPriceFeedsUpdate_20250717.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/1f7fdad01de6d4d123e87ba6a34fe0c82b7c4e75/src/20250717_Multi_LBTCAndEBTCPriceFeedsUpdate/AaveV3Base_LBTCAndEBTCPriceFeedsUpdate_20250717.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-lbtc-oracle-and-capo-implementation-update/22614)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
