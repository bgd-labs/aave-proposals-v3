---
title: "Listing PT Ethena May"
author: "Aavechan Initiative @aci"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-usde-susde-may-expiry-pt-tokens-on-aave-v3-core-instance/23882"
---

## Simple Summary

We propose onboarding the USDe and sUSDe May-expiry PT tokens to the Aave V3 Core instance.

## Motivation

The previously onboarded USDe and sUSDe PT tokens have brought significant inflows to Aave. In preparation for their expiry and rollover, we propose onboarding the next expiry of these PT tokens. We expect deposits to at least match those of the current-expiry PT tokens, with the potential for additional sidelined demand.

## Specification

**PT-sUSDE-7MAY2026**: https://etherscan.io/address/0x3de0ff76e8b528c092d47b9dac775931cef80f49

**PT-USDe-7MAY2026**: https://etherscan.io/address/0xaebf0bb9f57e89260d57f31af34eb58657d96ce0

The table below illustrates the configured risk parameters for **PT_USDe_7MAY2026**

| Parameter                     |                                      Value |
| ----------------------------- | -----------------------------------------: |
| Isolation Mode                |                                      false |
| Borrowable                    |                                   DISABLED |
| Collateral Enabled            |                                      false |
| Supply Cap (PT_USDe_7MAY2026) |                                 45,000,000 |
| Borrow Cap (PT_USDe_7MAY2026) |                                          1 |
| Debt Ceiling                  |                                      USD 0 |
| LTV                           |                                        0 % |
| LT                            |                                        0 % |
| Liquidation Bonus             |                                        0 % |
| Liquidation Protocol Fee      |                                       10 % |
| Reserve Factor                |                                       45 % |
| Base Variable Borrow Rate     |                                        0 % |
| Variable Slope 1              |                                       10 % |
| Variable Slope 2              |                                      300 % |
| Uoptimal                      |                                       45 % |
| Flashloanable                 |                                    ENABLED |
| Siloed Borrowing              |                                   DISABLED |
| Borrowable in Isolation       |                                   DISABLED |
| Oracle                        | 0x0a72df02CE3E4185b6CEDf561f0AE651E9BeE235 |

**Initial E-Mode Risk Oracle**

| **Parameter** | **Value**   | **Value** |
| ------------- | ----------- | --------- |
| E-Mode        | Stablecoins | USDe      |
| LTV           | 87.2%       | 88.1%     |
| LT            | 89.2%       | 90.1%     |
| LB            | 4.4%        | 3.4%      |

**Linear Discount Rate Oracle**

| **Parameter**              | **Value**                                                                                                             |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| initialDiscountRatePerYear | 4.95%                                                                                                                 |
| maxDiscountRatePerYear     | 25.69%                                                                                                                |
| address                    | [0x0a72df02ce3e4185b6cedf561f0ae651e9bee235](https://etherscan.io/address/0x0a72df02ce3e4185b6cedf561f0ae651e9bee235) |
| Last answer                | 98521492 (0.98521492 USD)                                                                                             |

**PT-USDe Stablecoins E-Mode**

| **Asset**         | **PT-USDe-7MAY2026**   | **PT-USDe-5FEB2026**   | **USDe**               | **USDC** | **USDT** | **USDtb** |
| ----------------- | ---------------------- | ---------------------- | ---------------------- | -------- | -------- | --------- |
| Collateral        | Yes                    | Yes                    | Yes                    | No       | No       | No        |
| Borrowable        | No                     | No                     | Yes                    | Yes      | Yes      | Yes       |
| LTV               | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -        | -        | -         |
| LT                | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -        | -        | -         |
| Liquidation Bonus | Subject to Risk Oracle | Subject to Risk Oracle | Subject to Risk Oracle | -        | -        | -         |

The table below illustrates the configured risk parameters for **PT_sUSDe_7MAY2026**

| Parameter                      |                                      Value |
| ------------------------------ | -----------------------------------------: |
| Isolation Mode                 |                                      false |
| Borrowable                     |                                   DISABLED |
| Collateral Enabled             |                                      false |
| Supply Cap (PT_sUSDe_7MAY2026) |                                100,000,000 |
| Borrow Cap (PT_sUSDe_7MAY2026) |                                          1 |
| Debt Ceiling                   |                                      USD 0 |
| LTV                            |                                        0 % |
| LT                             |                                        0 % |
| Liquidation Bonus              |                                        0 % |
| Liquidation Protocol Fee       |                                       10 % |
| Reserve Factor                 |                                       45 % |
| Base Variable Borrow Rate      |                                        0 % |
| Variable Slope 1               |                                       10 % |
| Variable Slope 2               |                                      300 % |
| Uoptimal                       |                                       45 % |
| Flashloanable                  |                                    ENABLED |
| Siloed Borrowing               |                                   DISABLED |
| Borrowable in Isolation        |                                   DISABLED |
| Oracle                         | 0xa0dc0249c32fa79e8B9b17c735908a60b1141B40 |

### PT-sUSDe-7MAY2026

**Initial E-Mode Risk Oracle**

| **Parameter** | **Value**   | **Value** |
| ------------- | ----------- | --------- |
| E-Mode        | Stablecoins | USDe      |
| LTV           | 86.4%       | 87.2%     |
| LT            | 88.4%       | 89.2%     |
| LB            | 5.5%        | 4.5%      |

**Linear Discount Rate Oracle**

| **Parameter**              | **Value**                                                                                                              |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| initialDiscountRatePerYear | 5.02%                                                                                                                  |
| maxDiscountRatePerYear     | 25.67%                                                                                                                 |
| address                    | [0xa0dc0249c32fa79e8b9b17c735908a60b1141b40 ](https://etherscan.io/address/0xa0dc0249c32fa79e8b9b17c735908a60b1141b40) |
| Last answer                | 98502870 (0.98502870 USD)                                                                                              |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin both PTs.

## Disclaimer

ACI is not directly affiliated with Pendle and did not receive compensation for the creation of this proposal. Some ACI employees may hold Pendle tokens.

The parameters are the ones recommended by risk service providers.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260129_AaveV3Ethereum_ListingPTEthenaMay/AaveV3Ethereum_ListingPTEthenaMay_20260129.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260129_AaveV3Ethereum_ListingPTEthenaMay/AaveV3Ethereum_ListingPTEthenaMay_20260129.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-usde-susde-may-expiry-pt-tokens-on-aave-v3-core-instance/23882)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
