---
title: "Onboard PT sUSDe July on Core Instance"
author: "ACI and BGD Labs"
discussions: "https://governance.aave.com/t/arfc-onboard-susde-july-expiry-pt-tokens-on-aave-v3-core-instance/21878"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xc039953e4f18804bb017876d27621da1ab3e4de53acd3b32d0f1fe94d4bbb6a0"
---

## Simple Summary

This proposal seeks to onboard pendle PT-sUSDe-31July2025 on the Aave V3 core instance.
This is a resubmission of PT-sUSDe-31July2025 listing payload of [Proposal 299](https://vote.onaave.com/proposal/?proposalId=299), which was cancelled due to a detected misconfiguration.

## Motivation

Pendle allows users to split yield bearing tokens into principal (PT) and yield (YT) components. This opens the door to trading yield for the growing number of yield bearing tokens, and gives users additional options for yield farming strategies. A notable feature of the PT tokens is that at the maturity date, the value of the PT equals the value of the underlying asset and can be redeemed for the underlying. This means PT tokens, which can be bought at a discount within Pendle pools, represent the fixed rate part of a Pendle asset pair.

Pendle has seen extremely high growth this year, with current TVL of circa $4.5 billion. Along with this growth has come the desire for yield traders to borrow against their Pendle PT tokens. This represents a multi-billion dollar growth opportunity for Aave, without a large increase in risk if PT tokens are onboarded for already listed assets such as sUSDe. With this, it makes sense to onboard PT-sUSDe-31July2025 asset.

## Specification

The table below illustrates the configured risk parameters for **PT_sUSDE_31JUL2025**:

| Parameter                 | PT_sUSDE_31JUL2025 |
| ------------------------- | -----------------: |
| Borrowable                |           DISABLED |
| Collateral Enabled        |               true |
| Supply Cap                |         85,000,000 |
| Borrow Cap                |                  1 |
| Isolation Mode            |              false |
| Debt Ceiling              |              USD 0 |
| LTV                       |             0.05 % |
| LT                        |              0.1 % |
| Liquidation Bonus         |              7.5 % |
| Liquidation Protocol Fee  |               10 % |
| Reserve Factor            |               20 % |
| Base Variable Borrow Rate |                0 % |
| Variable Slope 1          |                7 % |
| Variable Slope 2          |              300 % |
| Uoptimal                  |               45 % |
| Flashloanable             |            ENABLED |
| Siloed Borrowing          |           DISABLED |
| Borrowable in Isolation   |           DISABLED |

The following EMode categories will be created for the assets listed:

**PT-sUSDe Stablecoins E-Mode (id: 8)**:

| Asset             | PT-sUSDe | USDC | USDT | USDS |
| ----------------- | -------- | ---- | ---- | ---- |
| Collateral        | Yes      | No   | No   | No   |
| Borrowable        | No       | Yes  | Yes  | Yes  |
| LTV               | 87.4%    | -    | -    | -    |
| LT                | 89.4%    | -    | -    | -    |
| Liquidation Bonus | 4.6%     | -    | -    | -    |

The Pendle PT Capo with linear discount have been deployed with the following configurations:

| **Parameter**                    | **Value**                                                                                                                     |
| -------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| Oracle                           | [PT Capped sUSDe USDT/USD linear discount 31JUL2025](https://etherscan.io/address/0x759B9B72700A129CD7AD8e53F9c99cb48Fd57105) |
| Underlying Oracle                | [Capped USDT/USD](https://etherscan.io/address/0xC26D4a1c46d884cfF6dE9800B6aE7A8Cf48B4Ff8)                                    |
| Underlying Oracle                | [Chainlink USDT/USD](https://etherscan.io/address/0x3E7d1eAB13ad0104d2750B8863b489D65364e32D)                                 |
| OracleLatestAnswer (28 April 25) | USD 0.98089311                                                                                                                |
| discountRatePerYear              | 7.5124%                                                                                                                       |
| maxDiscountRatePerYear           | 21.22%                                                                                                                        |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_sUSDE_31JUL2025 and its aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/73ed5a749ac9f57abecc3879729b1e3d6cd79f7a/src/20250428_AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance/AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250428.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/73ed5a749ac9f57abecc3879729b1e3d6cd79f7a/src/20250428_AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance/AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250428.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xc039953e4f18804bb017876d27621da1ab3e4de53acd3b32d0f1fe94d4bbb6a0)
- [Discussion](https://governance.aave.com/t/arfc-onboard-susde-july-expiry-pt-tokens-on-aave-v3-core-instance/21878)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
