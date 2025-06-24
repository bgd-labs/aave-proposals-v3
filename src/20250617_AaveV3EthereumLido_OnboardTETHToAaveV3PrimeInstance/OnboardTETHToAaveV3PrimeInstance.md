---
title: "Onboard tETH to Aave v3 Prime Instance"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboard-teth-to-aave-v3-prime-instance/21873"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x0cef1b470bf48c23d66386816d6a88d97abefb9364fda4e8e28b6ed2cd169945"
---

## Simple Summary

This proposal aims to onboard tETH to Aave V3 Prime Instance.

## Motivation

Assets like tETH are designed to unify fragmented interest rate markets and optimize yield generation. Users contribute ETH and receive tETH, redeemable for their initial ETH plus additional yield. This yield comes from a dynamic strategy that balances staking rewards and interest rate arbitrage on lending protocols. For tETH, this ensures baseline yields equivalent to native ETH staking while capturing additional returns from rate inefficiencies. These assets are composable across DeFi, enabling broader usability.

By onboarding tETH to Aave V3 Prime Instance, we can:

- **Enhance capital efficiency**: Users can borrow against tETH, unlocking liquidity while continuing to earn restaking rewards.
- **Increase protocol revenue**: More borrowing activity leads to higher interest income for Aave.
- **Expand Aave’s influence in restaking finance**: Positioning Aave as a central lending hub for LRTs.

## Specification

The table below illustrates the configured risk parameters for **tETH**

| Parameter                 |    Value |
| ------------------------- | -------: |
| Isolation Mode            |    false |
| Borrowable                | DISABLED |
| Collateral Enabled        |     true |
| Supply Cap (tETH)         |   20,000 |
| Borrow Cap (tETH)         |        1 |
| Debt Ceiling              |    USD 0 |
| LTV                       |   0.05 % |
| LT                        |    0.1 % |
| Liquidation Bonus         |    7.5 % |
| Liquidation Protocol Fee  |     10 % |
| Reserve Factor            |     50 % |
| Base Variable Borrow Rate |      0 % |
| Variable Slope 1          |     10 % |
| Variable Slope 2          |    300 % |
| Uoptimal                  |     45 % |
| Flashloanable             |  ENABLED |
| Siloed Borrowing          | DISABLED |
| Borrowable in Isolation   | DISABLED |

**Pricefeed details**

| Parameter                  |                                                                                             Value |
| -------------------------- | ------------------------------------------------------------------------------------------------: |
| Oracle                     | [Capped tETH/wstETH/USD](https://etherscan.io/address/0x85968026294b8f8Fb86d6bF3Cda079f9376aD05A) |
| Ratio provider             |                   [tETH](https://etherscan.io/address/0xD11c452fc99cF405034ee446803b6F6c1F6d5ED8) |
| Underlying Oracle          |      [Capped wstETH/USD](https://etherscan.io/address/0xe1D97bF61901B075E9626c8A2340a7De385861Ef) |
| Oracle Latest Answer       |                                                                    (2025-05-21) USD 3085.41598338 |
| maxYearlyGrowthRatePercent |                                                                                             4.50% |
| Snapshot Delay             |                                                                                           14 days |

**tETH/wstETH E-Mode**

| **Parameter**         | **Value** | **Value** |
| --------------------- | --------- | --------- |
| Asset                 | tETH      | wstETH    |
| Collateral            | Yes       | No        |
| Borrowable            | No        | Yes       |
| Max LTV               | 92.00%    | -         |
| Liquidation Threshold | 94.00%    | -         |
| Liquidation Bonus     | 2.00%     | -         |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for tETH and the corresponding aToken.

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/25332db83cecc9fa8dae586ea9be87664d0ca93b/src/20250617_AaveV3EthereumLido_OnboardTETHToAaveV3PrimeInstance/AaveV3EthereumLido_OnboardTETHToAaveV3PrimeInstance_20250617.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/25332db83cecc9fa8dae586ea9be87664d0ca93b/src/20250617_AaveV3EthereumLido_OnboardTETHToAaveV3PrimeInstance/AaveV3EthereumLido_OnboardTETHToAaveV3PrimeInstance_20250617.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x0cef1b470bf48c23d66386816d6a88d97abefb9364fda4e8e28b6ed2cd169945)
- [Discussion](https://governance.aave.com/t/arfc-onboard-teth-to-aave-v3-prime-instance/21873)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
