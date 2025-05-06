---
title: "Onboard USDtb to Aave v3 Core Instance"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboard-usdtb-to-aave-v3-core-instance/21746"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xf7ff963e0572d684bfd0c6d572a070d1b6ea60f4bcebbd6f68fc2af9c1e46659"
---

## Simple Summary

We propose to onboard USDtb to the v3 Core Instance with borrow enabled, collateral disabled.

## Motivation

USDtb is a digital dollar, otherwise known as a USD stablecoin. USDtb can be used the same way a holder would use any other dollar, whether to send and receive payments, acquire and trade assets, or to simply hold dollars.

Unlike actual dollars, USDtb is a blockchain-based token, which enables faster and cheaper spending than the traditional fiat banking system. Unlike many digital assets, USDtb is fully backed by institutional-grade tokenized U.S. treasury fund products (alongside a stablecoin reserve designed to facilitate rapid redemptions) to support stability. Initially, USDtb will be backed by BlackRock’s USD Institutional Digital Liquidity Fund Token, BUIDL.

By onboarding USDtb, deeper borrow liquidity will be generated to allow sUSDe leverage at an attractive borrow rate. We believe this will help revitalise and accelerate growth in sUSDe activity on the Core Instance.

Backed by BUIDL issued by Blackrock, one of the largest asset managers in the world we believe this asset aligns well with Aave’s history of providing liquidity to the highest quality assets in DeFi and should attract significant deposits.

## Specification

The table below illustrates the configured risk parameters for **USDtb**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (USDtb)        |                                 50,000,000 |
| Borrow Cap (USDtb)        |                                 40,000,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                        0 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        6 % |
| Variable Slope 2          |                                       50 % |
| Uoptimal                  |                                       80 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x2FA6A78E3d617c1013a22938411602dc9Da98dBa |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for USDtb and the corresponding aToken.

### CAPO feed

| Parameter                      |                                                                                            Value |
| ------------------------------ | -----------------------------------------------------------------------------------------------: |
| Contract                       |    [Capped USDtb / USD](https://etherscan.io/address/0x2fa6a78e3d617c1013a22938411602dc9da98dba) |
| Underlying Oracle              | [Chainlink USDtb / USD](https://etherscan.io/address/0x66704DAD467A7cA508B3be15865D9B9F3E186c90) |
| OracleLatestAnswer (05 may 25) |                                                                                   USD 0.99983211 |
| Capped Price                   |                                                                                         USD 1.04 |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/4f77f232f2bed02e5c0ed869cec911dbdd76f8be/src/20250430_AaveV3Ethereum_OnboardUSDtbToAaveV3CoreInstance/AaveV3Ethereum_OnboardUSDtbToAaveV3CoreInstance_20250430.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/4f77f232f2bed02e5c0ed869cec911dbdd76f8be/src/20250430_AaveV3Ethereum_OnboardUSDtbToAaveV3CoreInstance/AaveV3Ethereum_OnboardUSDtbToAaveV3CoreInstance_20250430.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xf7ff963e0572d684bfd0c6d572a070d1b6ea60f4bcebbd6f68fc2af9c1e46659)
- [Discussion](https://governance.aave.com/t/arfc-onboard-usdtb-to-aave-v3-core-instance/21746)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
