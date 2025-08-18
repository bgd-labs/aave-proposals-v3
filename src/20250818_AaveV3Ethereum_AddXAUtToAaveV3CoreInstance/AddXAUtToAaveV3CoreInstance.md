---
title: "Add XAUt to Aave v3 Core Instance"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-add-xaut-to-aave-v3-core-instance/22385"
snapshot: TODO
---

## Simple Summary

The proposal aims to onboard Tether’s XAUt gold-denominated stablecoin, to the Aave v3 Core Instance.

## Motivation

XAUt is a gold backed digital currency offered by Tether.

XAUt represents a unique opportunity to bring gold-backed assets into DeFi lending markets. Adding XAUt to Aave v3 would:

1. Diversify the protocol’s offerings with a historically stable store of value
2. Enable users to use gold-backed tokens as collateral or for lending, creating new DeFi use cases
3. Allow users a hedge against market volatility through exposure to physical gold
4. Attract traditional finance users who are familiar with gold as an asset class

The addition of XAUt aligns with Aave’s goal of expanding DeFi accessibility while maintaining strong risk management practices through the use of established, well-backed assets.

## Specification

The table below illustrates the configured risk parameters for **XAUt**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                       true |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (XAUt)         |                                      5,000 |
| Borrow Cap (XAUt)         |                                          1 |
| Debt Ceiling              |                              USD 3,000,000 |
| LTV                       |                                       70 % |
| LT                        |                                       75 % |
| Liquidation Bonus         |                                        6 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                       10 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |


### oracle details

| Parameter                 |                                                                                         Value |
| ------------------------- | --------------------------------------------------------------------------------------------: |
| Oracle                    | [Chainlink XAU/USD](https://etherscan.io/address/0x214eD9Da11D2fbe465a6fc601a91E62EbEc1a0D6)  |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for XAUt and the corresponding aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250818_AaveV3Ethereum_AddXAUtToAaveV3CoreInstance/AaveV3Ethereum_AddXAUtToAaveV3CoreInstance_20250818.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250818_AaveV3Ethereum_AddXAUtToAaveV3CoreInstance/AaveV3Ethereum_AddXAUtToAaveV3CoreInstance_20250818.t.sol)
  [Snapshot](TODO)
- [Discussion](https://governance.aave.com/t/arfc-add-xaut-to-aave-v3-core-instance/22385)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
