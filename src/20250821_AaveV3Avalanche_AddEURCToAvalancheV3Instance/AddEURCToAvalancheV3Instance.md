---
title: "Add EURC to Avalanche V3 Instance"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-add-eurc-to-avalanche-v3-instance/21734"
---

## Simple Summary

The current ARFC proposes to add EURC on Avalanche V3 Instance. EURC is Circle’s EUR-backed stablecoin, enhancing liquidity and expanding the platform’s appeal to European users.

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
| Supply Cap (EURC)         | 3,000,000 |
| Borrow Cap (EURC)         | 2,800,000 |
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

### Oracle details

| Parameter |                                                                                         Value |
| --------- | --------------------------------------------------------------------------------------------: |
| Oracle    | [Chainlink EURC/USD](https://snowtrace.io/address/0x3368310bC4AeE5D96486A73bae8E6b49FcDE62D3) |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://snowtrace.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for EURC and the corresponding aToken.

## References

- Implementation: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/0879652a8fe718fd47ac3e53287c60aa49a6e2d4/src/20250821_AaveV3Avalanche_AddEURCToAvalancheV3Instance/AaveV3Avalanche_AddEURCToAvalancheV3Instance_20250821.sol)
- Tests: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/0879652a8fe718fd47ac3e53287c60aa49a6e2d4/src/20250821_AaveV3Avalanche_AddEURCToAvalancheV3Instance/AaveV3Avalanche_AddEURCToAvalancheV3Instance_20250821.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-add-eurc-to-avalanche-v3-instance/21734)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
