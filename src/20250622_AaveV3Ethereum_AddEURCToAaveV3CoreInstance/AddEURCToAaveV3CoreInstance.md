---
title: "Add EURC to Aave V3 Core Instance"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-add-eurc-to-aave-v3-core-instance/21837"
---

## Simple Summary

The current AIP proposes to add EURC on Aave V3 Core Instance.

EURC is Circle’s EUR-backed stablecoin, enhancing liquidity and expanding the platform’s appeal to Euro denominated users.

## Motivation

EURC is a fully backed stablecoin pegged to the Euro, issued by Circle, the same entity behind USDC. It is a reliable and transparent Euro-denominated asset gaining adoption across DeFi protocols.

- **Utility and Role:** EURC facilitates Euro-based transactions in DeFi, allowing for a stable store of value and an efficient medium of exchange within the ecosystem.
- **Backers:** Circle is a trusted issuer with a track record of regulatory compliance, providing confidence in EURC’s stability.
- **Performance:** EURC has demonstrated consistent performance and adoption within the broader DeFi space such as Morpho (3M), Alien(4M) and Aerodome (3M).
- **Euro Liquidity:** EURC will offer Aave users access to Euro-denominated liquidity, appealing to the European market.
- **Broader User Base:** Listing EURC could attract new users from Europe, diversifying Aave’s stablecoin offerings.
- **Increased Liquidity:** The addition of EURC can enhance liquidity across Aave’s markets, improving lending, borrowing, and trading experiences.

## Specification

The table below illustrates the configured risk parameters for **EURC**

| Parameter                 |     Value |
| ------------------------- | --------: |
| Isolation Mode            |     false |
| Borrowable                |   ENABLED |
| Collateral Enabled        |      true |
| Supply Cap (EURC)         | 7,000,000 |
| Borrow Cap (EURC)         | 6,500,000 |
| Debt Ceiling              |     USD 0 |
| LTV                       |      75 % |
| LT                        |      78 % |
| Liquidation Bonus         |       5 % |
| Liquidation Protocol Fee  |      10 % |
| Reserve Factor            |      10 % |
| Base Variable Borrow Rate |       0 % |
| Variable Slope 1          |       6 % |
| Variable Slope 2          |      50 % |
| Uoptimal                  |      90 % |
| Flashloanable             |   ENABLED |
| Siloed Borrowing          |  DISABLED |
| Borrowable in Isolation   |  DISABLED |

### Pricefeed details

| Parameter            |                                                                                         Value |
| -------------------- | --------------------------------------------------------------------------------------------: |
| Oracle               |    [Capped EURC/USD](https://etherscan.io/address/0xa6aB031A4d189B24628EC9Eb155F0a0f1A0E55a3) |
| Asset to USD Oracle  | [Chainlink EURC/USD](https://etherscan.io/address/0x04F84020Fdf10d9ee64D1dcC2986EDF2F556DA11) |
| Base to USD Oracle   |  [Chainlink EUR/USD](https://etherscan.io/address/0xb49f677943BC038e9857d61E7d053CaA2C1734C1) |
| Price Cap Ratio      |                                                                                            4% |
| Oracle Latest Answer |                                                                   (2025-06-22) USD 1.15156086 |

Additionally [lm.aci.eth](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for EURC and the corresponding aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/ebdb3a433f4618ae6be51ab5d8b333058cef473b/src/20250622_AaveV3Ethereum_AddEURCToAaveV3CoreInstance/AaveV3Ethereum_AddEURCToAaveV3CoreInstance_20250622.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/ebdb3a433f4618ae6be51ab5d8b333058cef473b/src/20250622_AaveV3Ethereum_AddEURCToAaveV3CoreInstance/AaveV3Ethereum_AddEURCToAaveV3CoreInstance_20250622.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-add-eurc-to-aave-v3-core-instance/21837)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
