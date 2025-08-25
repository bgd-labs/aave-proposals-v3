---
title: "Onboard sUSDe November expiry PT tokens on Aave V3 Core Instance"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-susde-november-expiry-pt-tokens-on-aave-v3-core-instance/22894"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **PT_sUSDe_27NOV2025**

| Parameter                       |                                      Value |
| ------------------------------- | -----------------------------------------: |
| Isolation Mode                  |                                      false |
| Borrowable                      |                                   DISABLED |
| Collateral Enabled              |                                       true |
| Supply Cap (PT_sUSDe_27NOV2025) |                                 75,000,000 |
| Borrow Cap (PT_sUSDe_27NOV2025) |                                          1 |
| Debt Ceiling                    |                                      USD 0 |
| LTV                             |                                     0.05 % |
| LT                              |                                      0.1 % |
| Liquidation Bonus               |                                      7.5 % |
| Liquidation Protocol Fee        |                                       10 % |
| Reserve Factor                  |                                       45 % |
| Base Variable Borrow Rate       |                                        0 % |
| Variable Slope 1                |                                       10 % |
| Variable Slope 2                |                                      300 % |
| Uoptimal                        |                                       45 % |
| Flashloanable                   |                                    ENABLED |
| Siloed Borrowing                |                                   DISABLED |
| Borrowable in Isolation         |                                   DISABLED |
| Oracle                          | 0x8B8B73598a2c4b1de6d3b075618434CfC4826632 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_sUSDe_27NOV2025 and the corresponding aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250825_AaveV3Ethereum_OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance/AaveV3Ethereum_OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance_20250825.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250825_AaveV3Ethereum_OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance/AaveV3Ethereum_OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance_20250825.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-susde-november-expiry-pt-tokens-on-aave-v3-core-instance/22894)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
