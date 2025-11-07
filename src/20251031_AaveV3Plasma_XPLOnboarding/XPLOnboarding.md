---
title: "XPL Onboarding"
author: "ACI"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-xpl-on-aave-v3-plasma-instance/23197"
---

## Simple Summary

This AIP proposes to onboard XPL to Aave V3 Plasma Instance.

This proposal will be a Direct to AIP.

## Motivation

XPL is the native token of the Plasma blockchain. It was initially approved by governance for onboarding to the Plasma instance during the Plasma instance deployment yet was paused due to reservations of some service providers. Given there is now sufficient liquidity for the token we believe it is time to reconsider onboarding XPL to the Plasma instance.

## Specification

| **Parameter**            | **Value**  |
| ------------------------ | ---------- |
| Asset                    | WXPL       |
| Isolation Mode           | No         |
| Borrowable               | No         |
| Collateral Enabled       | Yes        |
| Supply Cap               | 14,000,000 |
| Borrow Cap               | -          |
| Debt Ceiling             | -          |
| LTV                      | 0.05%      |
| LT                       | 0.1%       |
| Liquidation Bonus        | 10%        |
| Liquidation Protocol Fee | 10%        |
| Variable Base            | -          |
| Variable Slope1          | -          |
| Variable Slope2          | -          |
| Uoptimal                 | -          |
| Reserve Factor           | -          |

### **E-Mode**

| **Parameter**         | **Value** | **Value** |
| --------------------- | --------- | --------- |
| Asset                 | WXPL      | USDT0     |
| Collateral            | Yes       | No        |
| Borrowable            | No        | Yes       |
| Max LTV               | 50%       | -         |
| Liquidation Threshold | 55%       | -         |
| Liquidation Bonus     | 10%       | -         |

Additionally add ACI LM (0xac140648435d03f784879cd789130F22Ef588Fcd](https://plasmascan.to/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has emission admin for XPL incentive.

## References

- Implementation: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/4714955c7abb431abfd363b4cdde42f50892a8c9/src/20251031_AaveV3Plasma_XPLOnboarding/AaveV3Plasma_XPLOnboarding_20251031.sol)
- Tests: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/4714955c7abb431abfd363b4cdde42f50892a8c9/src/20251031_AaveV3Plasma_XPLOnboarding/AaveV3Plasma_XPLOnboarding_20251031.t.sol)
  Snapshot: Direct to AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-xpl-on-aave-v3-plasma-instance/23197)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
