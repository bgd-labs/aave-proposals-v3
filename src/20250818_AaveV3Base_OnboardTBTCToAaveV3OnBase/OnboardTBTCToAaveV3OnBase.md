---
title: "Onboard tBTC to Aave v3 on Base"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboard-tbtc-to-aave-v3-on-base/22226"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x1c12498028d114d73fd1614a7f5c8ba7e922ff129b5807d35d83f436bf8b4bcd"
---

## Simple Summary

This proposal seeks to onboard tBTC to Aave v3 on Base following a successful launch on Mainnet.

## Motivation

tBTC is Threshold’s decentralized and permissionless bridge to bring BTC to Ethereum, Base and 7 other chains. Users wishing to utilize their Bitcoin on Ethereum & Base can use the tBTC decentralized bridge to deposit their Bitcoin into the system and get a minted tBTC token in their EVM wallet.

Threshold Network has recently brought direct minting of tBTC to Arbitrum and Base. It is live on Aave, Compound, GMX, EigenLayer, Synthetix, Morpho, Symbiotic and has strong, sticky liquidity to support liquidations.

Following its approval on AAVE 3 Ethereum, tBTC’s initial supply cap was reached within 72 hours, prompting an increase to meet the overwhelming demand and now sits at over 2,200 BTC TVL. This rapid adoption underscores the market’s appetite for trust-minimized BTC solutions in DeFi.

tBTC on AAVE v3 Arbitrum is just lacking an AIP and has already passed on ARFC and relevant risk analysis.

tBTC on Base has a current supply of 116 BTC worth $12M at current price.

### Benefits for Aave

- High User Demand, since its initial deployment on Aave’s Ethereum market, tBTC reached its initial 500 BTC supply cap within the first week. The cap has been increased multiple times, now sitting at 2200 BTC, highlighting strong user interest. Something we hope to replicate on Base.
- Easy, direct onboarding of BTC capital via Threshold’s Base direct minting.
- Further decentralization and trust minimisation in the Aave stack.
- A range of lending options for those who wish to earn yield on their BTC.
- Preferable yields on tBTC through active incentive participation, boosting Aave protocol use, fees and TVL.

## Specification

The table below illustrates the configured risk parameters for **tBTC**

| Parameter                 |    Value |
| ------------------------- | -------: |
| Isolation Mode            |    false |
| Borrowable                |  ENABLED |
| Collateral Enabled        |     true |
| Supply Cap (tBTC)         |      130 |
| Borrow Cap (tBTC)         |       13 |
| Debt Ceiling              |    USD 0 |
| LTV                       |     73 % |
| LT                        |     78 % |
| Liquidation Bonus         |    7.5 % |
| Liquidation Protocol Fee  |     10 % |
| Reserve Factor            |     20 % |
| Base Variable Borrow Rate |      0 % |
| Variable Slope 1          |      4 % |
| Variable Slope 2          |     60 % |
| Uoptimal                  |     45 % |
| Flashloanable             |  ENABLED |
| Siloed Borrowing          | DISABLED |
| Borrowable in Isolation   | DISABLED |

### Oracles details

| Parameter |                                                                                        Value |
| --------- | -------------------------------------------------------------------------------------------: |
| Oracle    | [Chainlink BTC/USD](https://basescan.org/address/0x64c911996D3c6aC71f9b455B1E8E7266BcbD848F) |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://basescan.org/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for tBTC and the corresponding aToken.

## References

- Implementation: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/465115492c7b29459fea390a965f1ae6b1245bfd/src/20250818_AaveV3Base_OnboardTBTCToAaveV3OnBase/AaveV3Base_OnboardTBTCToAaveV3OnBase_20250818.sol)
- Tests: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/465115492c7b29459fea390a965f1ae6b1245bfd/src/20250818_AaveV3Base_OnboardTBTCToAaveV3OnBase/AaveV3Base_OnboardTBTCToAaveV3OnBase_20250818.t.sol)
  [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x1c12498028d114d73fd1614a7f5c8ba7e922ff129b5807d35d83f436bf8b4bcd)
- [Discussion](https://governance.aave.com/t/arfc-onboard-tbtc-to-aave-v3-on-base/22226)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
