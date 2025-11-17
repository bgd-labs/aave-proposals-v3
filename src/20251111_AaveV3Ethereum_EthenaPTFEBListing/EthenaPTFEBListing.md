---
title: "Ethena PT FEB Listing"
author: "ACI"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-usde-susde-february-expiry-pt-tokens-on-aave-v3-core-instance/23358"
---

## Simple Summary

This AIP proposes to onboard USDe and sUSDe February expiry PT tokens on Aave V3 Core Instance.

This proposal is Direct to AIP.

## Motivation

The previous USDe and sUSDe PT tokens that were onboarded have brought significant inflows to Aave, in preparation for the expiry and rollover we propose to onboard the next expiry of this PT token. We expect at a minimum that deposits will match those in the current expiry PT token, with potentially some sidelined demand.

## Specification

PT-sUSDE-5FEB2026: https://etherscan.io/address/0xe8483517077afa11a9b07f849cee2552f040d7b2

PT-USDe-5FEB2026: https://etherscan.io/address/0x1f84a51296691320478c98b8d77f2bbd17d34350

| **Parameter**            | **Value**                         | **Value**                           |
| ------------------------ | --------------------------------- | ----------------------------------- |
| Asset                    | PT-USDe-5FEB2026                  | PT-sUSDe-5FEB2026                   |
| Isolation Mode           | No                                | No                                  |
| Borrowable               | No                                | No                                  |
| Collateral Enabled       | Yes                               | Yes                                 |
| Supply Cap               | 30,000,000                        | 30,000,000                          |
| Borrow Cap               | -                                 | -                                   |
| Debt Ceiling             | -                                 | -                                   |
| LTV                      | 0.05%                             | 0.05%                               |
| LT                       | 0.1%                              | 0.1%                                |
| Liquidation Penalty      | 7.50%                             | 7.50%                               |
| Liquidation Protocol Fee | 10.00%                            | 10.00%                              |
| E-Mode Category          | PT-USDe Stablecoins, PT-USDe USDe | PT-sUSDe Stablecoins, PT-sUSDe USDe |

### PT-USDe-5FEB2026

**Initial E-mode Risk Oracle**

| **Parameter** | **Value**   | **Value** |
| ------------- | ----------- | --------- |
| E-Mode        | Stablecoins | USDe      |
| LTV           | 88.5%       | 89.3%     |
| LT            | 90.5%       | 91.3%     |
| LB            | 4.1%        | 3.1%      |

**Linear Discount Rate Oracle**

| **Parameter**          | **Value** |
| ---------------------- | --------- |
| discountRatePerYear    | 5.5266%   |
| maxDiscountRatePerYear | 27.1629%  |

**PT-USDe Stablecoins E-mode**

| **Asset**         | **PT-USDe-5FEB2026**   | **PT-USDe-27NOV2026**  | **USDC** | **USDT** | **USDe** | **USDtb** |
| ----------------- | ---------------------- | ---------------------- | -------- | -------- | -------- | --------- |
| Collateral        | Yes                    | Yes                    | No       | No       | No       | No        |
| Borrowable        | No                     | No                     | Yes      | Yes      | Yes      | Yes       |
| LTV               | Subject to Risk Oracle | Subject to Risk Oracle | -        | -        | -        |           |
| LT                | Subject to Risk Oracle | Subject to Risk Oracle | -        | -        | -        |           |
| Liquidation Bonus | Subject to Risk Oracle | Subject to Risk Oracle | -        | -        | -        |           |

**PT-USDe USDe E-mode**

| **Asset**         | **PT-USDe-5FEB2026**   | **PT-USDe-27NOV2026**  | **USDe** |
| ----------------- | ---------------------- | ---------------------- | -------- |
| Collateral        | Yes                    | Yes                    | No       |
| Borrowable        | No                     | No                     | Yes      |
| LTV               | Subject to Risk Oracle | Subject to Risk Oracle | -        |
| LT                | Subject to Risk Oracle | Subject to Risk Oracle | -        |
| Liquidation Bonus | Subject to Risk Oracle | Subject to Risk Oracle | -        |

### PT-sUSDe-5FEB2026

**Initial E-mode Risk Oracle**

| **Parameter** | **Value**   | **Value** |
| ------------- | ----------- | --------- |
| E-Mode        | Stablecoins | USDe      |
| LTV           | 87.6%       | 88.5%     |
| LT            | 89.6%       | 90.5%     |
| LB            | 5.1%        | 4.1%      |

**Linear Discount Rate Oracle**

| **Parameter**                 | **Value** |
| ----------------------------- | --------- |
| discountRatePerYear (Initial) | 6.1953%   |
| maxDiscountRatePerYear        | 27.1629%  |

**PT-sUSDe Stablecoins E-mode**

| **Asset**         | **PT-sUSDe-5FEB2026**  | **PT-sUSDe-27NOV2026** | **USDC** | **USDT** | **USDe** | **USDtb** |
| ----------------- | ---------------------- | ---------------------- | -------- | -------- | -------- | --------- |
| Collateral        | Yes                    | Yes                    | No       | No       | No       | No        |
| Borrowable        | No                     | No                     | Yes      | Yes      | Yes      | Yes       |
| LTV               | Subject to Risk Oracle | Subject to Risk Oracle | -        | -        | -        |           |
| LT                | Subject to Risk Oracle | Subject to Risk Oracle | -        | -        | -        |           |
| Liquidation Bonus | Subject to Risk Oracle | Subject to Risk Oracle | -        | -        | -        |           |

**PT-sUSDe USDe E-mode**

| **Asset**         | **PT-sUSDe-5FEB2026**  | **PT-sUSDe-27NOV2026** | **USDe** |
| ----------------- | ---------------------- | ---------------------- | -------- |
| Collateral        | Yes                    | Yes                    | No       |
| Borrowable        | No                     | No                     | Yes      |
| LTV               | Subject to Risk Oracle | Subject to Risk Oracle | -        |
| LT                | Subject to Risk Oracle | Subject to Risk Oracle | -        |
| Liquidation Bonus | Subject to Risk Oracle | Subject to Risk Oracle | -        |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_sUSDe_5FEB_2026 , PT_USDe_5FEB_2026 and their corresponding aTokens.

## Capo adapters

- PT USDe 5FEB: [0xc35d319fa5fec2bbe0eb4d0a826465b60f821f81](https://etherscan.io/address/0xc35d319fa5fec2bbe0eb4d0a826465b60f821f81)

- PT sUSDe 5FEB: [0x4e89f87f24c13819bbddb56f99b38746c91677d8](https://etherscan.io/address/0x4e89f87f24c13819bbddb56f99b38746c91677d8)

### Useful Links

https://docs.pendle.finance/ProtocolMechanics/YieldTokenization/PT

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251111_AaveV3Ethereum_EthenaPTFEBListing/AaveV3Ethereum_EthenaPTFEBListing_20251111.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251111_AaveV3Ethereum_EthenaPTFEBListing/AaveV3Ethereum_EthenaPTFEBListing_20251111.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-usde-susde-february-expiry-pt-tokens-on-aave-v3-core-instance/23358)

## Disclaimer

ACI is not directly affiliated with Pendle and did not receive compensation for the creation of this proposal. Some ACI employees may hold Pendle tokens.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
