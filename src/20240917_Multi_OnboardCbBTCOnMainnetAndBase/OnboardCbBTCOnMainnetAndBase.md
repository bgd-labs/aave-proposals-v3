---
title: "Onboard CbBTC on Mainnet and Base"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-onboard-cbbtc-to-aave-v3-on-base-and-mainnet/18988"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x7dd65a983a069e9e4def961e116b78acef6965ecb63aebfb26e34a1dcd97b060"
---

## Simple Summary

The proposal aims to onboard Coinbase’s cbBTC, to the Aave v3 protocol on Mainnet main instance & Base.

## Motivation

cbBTC, a new Bitcoin wrapper offering from Coinbase, is marking Coinbase’s entry into the wrapped Bitcoin market with cbBTC brings a unique value proposition to the Aave ecosystem.

This new asset will diversify the options available for Bitcoin holders looking to participate in DeFi activities on Aave v3.

Furthermore, cbBTC’s integration aligns with Aave’s commitment to offering a wide range of high-quality assets. It will enable users to tap into Coinbase’s liquidity and reputation while benefiting from Aave’s established lending and borrowing functionalities. This synergy between a major centralized exchange and a leading DeFi protocol could attract more mainstream users to Aave, contributing to the overall growth and adoption of the platform.

## Specification

The table below illustrates the configured risk parameters for **cbBTC** on Ethereum main pool and Base pool:

| Parameter                 | Ethereum Main Pool                         | Base Pool                                  |
| ------------------------- | ------------------------------------------ | ------------------------------------------ |
| Isolation Mode            | false                                      | false                                      |
| Borrowable                | ENABLED                                    | ENABLED                                    |
| Collateral Enabled        | true                                       | true                                       |
| Supply Cap (cbBTC)        | 450                                        | 200                                        |
| Borrow Cap (cbBTC)        | 45                                         | 20                                         |
| Debt Ceiling              | USD 0                                      | USD 0                                      |
| LTV                       | 73 %                                       | 73 %                                       |
| LT                        | 78 %                                       | 78 %                                       |
| Liquidation Bonus         | 7.5 %                                      | 7.5 %                                      |
| Liquidation Protocol Fee  | 10 %                                       | 10 %                                       |
| Reserve Factor            | 20 %                                       | 20 %                                       |
| Base Variable Borrow Rate | 0 %                                        | 0 %                                        |
| Variable Slope 1          | 4 %                                        | 4 %                                        |
| Variable Slope 2          | 300 %                                      | 300 %                                      |
| Uoptimal                  | 45 %                                       | 45 %                                       |
| Stable Borrowing          | DISABLED                                   | DISABLED                                   |
| Flashloanable             | ENABLED                                    | ENABLED                                    |
| Siloed Borrowing          | DISABLED                                   | DISABLED                                   |
| Borrowable in Isolation   | DISABLED                                   | DISABLED                                   |
| Oracle                    | 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c | 0x64c911996D3c6aC71f9b455B1E8E7266BcbD848F |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/c22b3826ab26493f46310656fd2adbce146ba36a/src/20240917_Multi_OnboardCbBTCOnMainnetAndBase/AaveV3Ethereum_OnboardCbBTCOnMainnetAndBase_20240917.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/c22b3826ab26493f46310656fd2adbce146ba36a/src/20240917_Multi_OnboardCbBTCOnMainnetAndBase/AaveV3Base_OnboardCbBTCOnMainnetAndBase_20240917.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/c22b3826ab26493f46310656fd2adbce146ba36a/src/20240917_Multi_OnboardCbBTCOnMainnetAndBase/AaveV3Ethereum_OnboardCbBTCOnMainnetAndBase_20240917.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/c22b3826ab26493f46310656fd2adbce146ba36a/src/20240917_Multi_OnboardCbBTCOnMainnetAndBase/AaveV3Base_OnboardCbBTCOnMainnetAndBase_20240917.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x7dd65a983a069e9e4def961e116b78acef6965ecb63aebfb26e34a1dcd97b060)
- [Discussion](https://governance.aave.com/t/arfc-onboard-cbbtc-to-aave-v3-on-base-and-mainnet/18988)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
