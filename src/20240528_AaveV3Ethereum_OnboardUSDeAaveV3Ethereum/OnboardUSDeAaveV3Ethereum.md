---
title: "Onboard USDe Aave V3 Ethereum"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-onboard-usde-to-aave-v3-on-ethereum/17690"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xc1b6d0d390a2dabf81206f592f740c69163dd028dcb0f50182d0ad3a50e744b0"
---

## Simple Summary

This proposal seek approval for the addition of USDe to Aave V3 on Ethereum

## Motivation

Ethena’s synthetic dollar, USDe, provides a stable crypto-native solution for a cash and carry structured product. The staked version of USDe, sUSDe, earns yield from the protocol and has high potential for strong borrow demand.

## Specification

The table below illustrates the configured risk parameters for **USDe**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (USDe)                  |                                 80,000,000 |
| Borrow Cap (USDe)                  |                                 72,000,000 |
| Debt Ceiling                       |                             USD 40,000,000 |
| LTV                                |                                       72 % |
| LT                                 |                                       75 % |
| Liquidation Bonus                  |                                      8.5 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       25 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                        9 % |
| Variable Slope 2                   |                                       75 % |
| Uoptimal                           |                                       80 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        9 % |
| Stable Slope2                      |                                       75 % |
| Base Stable Rate Offset            |                                        0 % |
| Stable Rate Excess Offset          |                                        0 % |
| Optimal Stable To Total Debt Ratio |                                        0 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                    ENABLED |
| Oracle                             | 0x55B6C4D3E8A27b8A1F5a263321b602e0fdEEcC17 |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/636bb0b17753c7e2af5d81933e7b61022e44e7e8/src/20240528_AaveV3Ethereum_OnboardUSDeAaveV3Ethereum/AaveV3Ethereum_OnboardUSDeAaveV3Ethereum_20240528.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/636bb0b17753c7e2af5d81933e7b61022e44e7e8/src/20240528_AaveV3Ethereum_OnboardUSDeAaveV3Ethereum/AaveV3Ethereum_OnboardUSDeAaveV3Ethereum_20240528.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xc1b6d0d390a2dabf81206f592f740c69163dd028dcb0f50182d0ad3a50e744b0)
- [Discussion](https://governance.aave.com/t/arfc-onboard-usde-to-aave-v3-on-ethereum/17690)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
