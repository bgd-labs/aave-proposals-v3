---
title: "Add EURC to BASE Aave V3"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-add-eurc-to-base-aave-v3/20680"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0xa2d0c8f06e8fae4ba961407f77732c0b6f870e00a349f826a032d20e291e48f6"
---

## Simple Summary

The current ARFC proposes to add EURC on Base V3. EURC is Circle’s EUR-backed stablecoin, enhancing liquidity and expanding the platform’s appeal to European users. Original proposal was [**[TEMP CHECK] Add EURC to BASE Aave V3**](https://governance.aave.com/t/temp-check-add-eurc-to-base-aave-v3/20423) but has been reformatted to be governance compliant. It has also passed [TEMP CHECK Snapshot](https://snapshot.org/#/s:aave.eth/proposal/0x4ead0ee7c538878f1584b20f12ee99e62fb7e08517042b9820836cd9fe7375c7) .

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

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (EURC)         |                                  4,200,000 |
| Borrow Cap (EURC)         |                                  3,800,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       75 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                        5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      8.5 % |
| Variable Slope 2          |                                       40 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x215f25556f91b30afcf0a12da51c9d4374b22570 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://basescan.org/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for EURC and the corresponding aToken.

## References

- Implementation: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/020379982368ec1eda21b589140ff013b1e33bad/src/20250219_AaveV3Base_AddEURCToBASEAaveV3/AaveV3Base_AddEURCToBASEAaveV3_20250219.sol)
- Tests: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/020379982368ec1eda21b589140ff013b1e33bad/src/20250219_AaveV3Base_AddEURCToBASEAaveV3/AaveV3Base_AddEURCToBASEAaveV3_20250219.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0xa2d0c8f06e8fae4ba961407f77732c0b6f870e00a349f826a032d20e291e48f6)
- [Discussion](https://governance.aave.com/t/arfc-add-eurc-to-base-aave-v3/20680)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
