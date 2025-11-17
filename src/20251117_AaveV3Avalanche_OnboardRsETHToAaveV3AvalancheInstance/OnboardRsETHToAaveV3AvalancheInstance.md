---
title: "Onboard rsETH to Aave V3 Avalanche Instance"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-rseth-to-aave-v3-avalanche-instance/23313"
---

## Simple Summary

This proposal seeks to onboard rsETH to the Aave V3 deployment on the Avalanche network.

As the onboarding of rsETH has already been approved and executed on the Ethereum, Arbitrum, and Base Aave V3 instances, this proposal follows the Direct-to-AIP path to extend rsETH support to the Avalanche instance without repeating the full ARFC process.

## Motivation

rsETH is a liquid staking token issued by Kelp DAO, offering users access to rewards from ETH staking while maintaining liquidity and DeFi composability. Its integrations on Aave across other networks have proven successful in terms of risk profile and utility.

Given that rsETH has already passed governance and risk assessments for Ethereum, Arbitrum, Linea, and Base this proposal aims to onboard rsETH to Avalanche V3 under the same configuration parameters used for other L2s, adjusted for market conditions where appropriate.

## Specification

The table below illustrates the configured risk parameters for **wrsETH**

| Parameter                 |    Value |
| ------------------------- | -------: |
| Isolation Mode            |    false |
| Borrowable                | DISABLED |
| Collateral Enabled        |     true |
| Supply Cap (wrsETH)       |    5,000 |
| Borrow Cap (wrsETH)       |        1 |
| Debt Ceiling              |    USD 0 |
| LTV                       |   0.05 % |
| LT                        |    0.1 % |
| Liquidation Bonus         |      7 % |
| Liquidation Protocol Fee  |     10 % |
| Reserve Factor            |     45 % |
| Base Variable Borrow Rate |      0 % |
| Variable Slope 1          |     10 % |
| Variable Slope 2          |    300 % |
| Uoptimal                  |     45 % |
| Flashloanable             |  ENABLED |
| Siloed Borrowing          | DISABLED |
| Borrowable in Isolation   | DISABLED |

### Oracle

| Parameter              |                                                                                                Value |
| ---------------------- | ---------------------------------------------------------------------------------------------------: |
| Oracle address         | [Capped wrsETH / ETH / USD](https://snowscan.xyz/address/0xe5af98d1c62c7d9c1378af187eefb0bee112ff64) |
| Ratio provider         |  [WRSETH-ETH Exchange Rate](https://snowscan.xyz/address/0xFA38289Fe9f043aD8CCD8e81b28C1D02666D51b6) |
| Underlying             |                 [ETH / USD](https://snowscan.xyz/address/0x976B3D034E162d8bD72D6b9C989d545b839003b0) |
| Max Yearly Growth      |                                                                                                9.83% |
| Minimum Snapshot delay |                                                                                              14 days |
| last answer            |                                                                       (2025-11-17) USD 3231.04489472 |

### E-mode

#### wrsETH/WETH E-Mode

| **Parameter**         | **wrsETH** | **WETH** |
| --------------------- | ---------- | -------- |
| Collateral            | Yes        | No       |
| Borrowable            | No         | Yes      |
| Max LTV               | 93%        | -        |
| Liquidation Threshold | 95%        | -        |
| Liquidation Bonus     | 1.0%       | -        |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://snowscan.xyz/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for wrsETH and the corresponding aToken.

## References

- Implementation: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251117_AaveV3Avalanche_OnboardRsETHToAaveV3AvalancheInstance/AaveV3Avalanche_OnboardRsETHToAaveV3AvalancheInstance_20251117.sol)
- Tests: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251117_AaveV3Avalanche_OnboardRsETHToAaveV3AvalancheInstance/AaveV3Avalanche_OnboardRsETHToAaveV3AvalancheInstance_20251117.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-rseth-to-aave-v3-avalanche-instance/23313)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
