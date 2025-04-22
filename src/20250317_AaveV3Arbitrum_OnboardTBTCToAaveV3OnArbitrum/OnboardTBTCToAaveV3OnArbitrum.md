---
title: "Onboard tBTC to Aave v3 on Arbitrum"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboard-tbtc-to-aave-v3-on-arbitrum/19756"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0xb55325cab6b35918810443de265b8cf2f5908acdde935f3e5b57e6625c4615d5"
---

## Simple Summary

This proposal seeks to onboard tBTC to Aave v3 on Arbitrum following a successful launch on Mainnet ([Aave - Open Source Liquidity Protocol](https://app.aave.com/reserve-overview/?underlyingAsset=0x18084fba666a33d37592fa2633fd49a74dd93a88&marketName=proto_mainnet_v3)).

## Motivation

tBTC is Threshold’s decentralized and permissionless bridge to bring BTC to Ethereum, Arbitrum and 6 other chains. Users wishing to utilize their Bitcoin on Ethereum & Arbitrum can use the tBTC decentralized bridge to deposit their Bitcoin into the system and get a minted tBTC token in their EVM wallet.

Threshold Network has brought native minting of tBTC to Arbitrum, is live on GMX and has strong, sticky liquidity to support liquidations.

Following its approval on AAVE V3 Ethereum, tBTC’s initial supply cap was reached within 72 hours, prompting an increase to meet the overwhelming demand and now sits at over 1,000 BTC TVL. This rapid adoption underscores the market’s appetite for trust-minimized BTC solutions in DeFi.

## Specification

The table below illustrates the configured risk parameters for **tBTC**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (tBTC)         |                                         50 |
| Borrow Cap (tBTC)         |                                         1 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       73 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        4 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                   DISABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x6ce185860a4963106506C203335A2910413708e9 |

Additionally [0xac140648435d03f784879cd789130f22ef588fcd](https://arbiscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for tBTC and the corresponding aToken.

## References

- Implementation: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250317_AaveV3Arbitrum_OnboardTBTCToAaveV3OnArbitrum/AaveV3Arbitrum_OnboardTBTCToAaveV3OnArbitrum_20250317.sol)
- Tests: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250317_AaveV3Arbitrum_OnboardTBTCToAaveV3OnArbitrum/AaveV3Arbitrum_OnboardTBTCToAaveV3OnArbitrum_20250317.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0xb55325cab6b35918810443de265b8cf2f5908acdde935f3e5b57e6625c4615d5)
- [Discussion](https://governance.aave.com/t/arfc-onboard-tbtc-to-aave-v3-on-arbitrum/19756)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
