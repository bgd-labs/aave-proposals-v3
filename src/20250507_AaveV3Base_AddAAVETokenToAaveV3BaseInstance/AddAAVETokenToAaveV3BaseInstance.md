---
title: "Add AAVE token to Aave V3 Base Instance"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-add-aave-token-to-aave-v3-base-instance/21105"
snapshot: "snapshot.box/#/s:aavedao.eth/proposal/0x54efdfaaccf429320071c7e56dd8f14759f2027c8f1c1fb4ef0596374c7558d8"
---

## Simple Summary

This publication presents the community an opportunity to expand AAVE governance token integration on the AAVE platform by adding AAVE collateral option to Base.

AAVE token has wide integrations into all other major AAVE instances including ETH Mainnet, Arbitrum, Optimism, Polygon, and Avalanche. Adding AAVE to the Base instance is the next logical step in AAVE token integration within the AAVE lending platform.

## Motivation

- AAVE token is a versatile governance token which is already accepted collateral on all major AAVE instances.
- The Base Market is growing in TVL, the addition of collateral options already found on other AAVE instances will increase Base Market growth.
- There is deep liquidity on Base chain for the AAVE token already. Price impact of just **0.77%** for $1m ETH/AAVE trades using jumper.exchange on Base.
- Aerodrome (Base DEX) has $10m TVL in WETH/AAVE concentrated liquidity.

Base has seen expansion in its TVL now surpassing Arbitrum by ~15%. Base chain is a small but significant part of total Defi TVL (all chains) of 3%.
Source: https://defillama.com/chains

## Specification

The table below illustrates the configured risk parameters for **AAVE**

| Parameter                 |                                                                                        Value |
| ------------------------- | -------------------------------------------------------------------------------------------: |
| Isolation Mode            |                                                                                        false |
| Borrowable                |                                                                                     DISABLED |
| Collateral Enabled        |                                                                                         true |
| Supply Cap (AAVE)         |                                                                                       30,000 |
| Borrow Cap (AAVE)         |                                                                                            1 |
| Debt Ceiling              |                                                                                        USD 0 |
| LTV                       |                                                                                         60 % |
| LT                        |                                                                                         65 % |
| Liquidation Bonus         |                                                                                         10 % |
| Liquidation Protocol Fee  |                                                                                         10 % |
| Reserve Factor            |                                                                                         20 % |
| Base Variable Borrow Rate |                                                                                          0 % |
| Variable Slope 1          |                                                                                         10 % |
| Variable Slope 2          |                                                                                        300 % |
| Uoptimal                  |                                                                                         45 % |
| Flashloanable             |                                                                                      ENABLED |
| Siloed Borrowing          |                                                                                     DISABLED |
| Borrowable in Isolation   |                                                                                     DISABLED |
| Oracle                    | [Chainlink AAVE/USD](https://basescan.org/address/0x3d6774EF702A10b20FCa8Ed40FC022f7E4938e07) |
| Oracle Latest Answer      |                                                                (2025-05-07) USD 169.65627000 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://basescan.org/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for AAVE and the corresponding aToken.

## References

- Implementation: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250507_AaveV3Base_AddAAVETokenToAaveV3BaseInstance/AaveV3Base_AddAAVETokenToAaveV3BaseInstance_20250507.sol)
- Tests: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250507_AaveV3Base_AddAAVETokenToAaveV3BaseInstance/AaveV3Base_AddAAVETokenToAaveV3BaseInstance_20250507.t.sol)
- [Snapshot](snapshot.box/#/s:aavedao.eth/proposal/0x54efdfaaccf429320071c7e56dd8f14759f2027c8f1c1fb4ef0596374c7558d8)
- [Discussion](https://governance.aave.com/t/arfc-add-aave-token-to-aave-v3-base-instance/21105)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
