---
title: "Onboard Tbtc"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-onboard-tbtc-to-aave-v3-on-ethereum-arbitrum-and-optimism/17686"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x9e2e3bd26866212d0cbd8e7cefcfa21eec9522202fd25b02456b8ff59371db08"
---

## Simple Summary

The proposal aims to onboard Threshold Network’s tBTC, to the Aave v3 protocol on Ethereum.

## Motivation

tBTC is Threshold’s decentralized and permissionless bridge to bring BTC to the Ethereum network. tBTC has been designed to allow Bitcoin holders to participate in Ethereum’s Decentralized Finance (DeFi) applications. Users wishing to utilize their Bitcoin on Ethereum can use the tBTC decentralized bridge to deposit their Bitcoin into the system and get a minted tBTC token in their Ethereum wallet.

tBTC was created by a decentralized effort of contributors at the Threshold Network DAO, and extensively utilizes the Threshold Network’s threshold cryptography to create a secure BTC asset. tBTC is a product launched on Threshold Network, on which many other decentralized applications are being built.

## Specification

The table below illustrates the configured risk parameters for **tBTC**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (tBTC)         |                                        550 |
| Borrow Cap (tBTC)         |                                        275 |
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
| Stable Borrowing          |                                   DISABLED |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/7d06b33b64400eba3fa9841de0a61d74db949f11/src/20240917_AaveV3Ethereum_OnboardTbtc/AaveV3Ethereum_OnboardTbtc_20240917.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/7d06b33b64400eba3fa9841de0a61d74db949f11/src/20240917_AaveV3Ethereum_OnboardTbtc/AaveV3Ethereum_OnboardTbtc_20240917.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x9e2e3bd26866212d0cbd8e7cefcfa21eec9522202fd25b02456b8ff59371db08)
- [Discussion](https://governance.aave.com/t/arfc-onboard-tbtc-to-aave-v3-on-ethereum-arbitrum-and-optimism/17686)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
