---
title: "Onboard SCR to Aave V3 Scroll"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-onboard-scr-to-aave-v3-scroll-instance/19688"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xef7dfa4e96e5f6a7337648d2dd3882f7b10e969c9564c118a34ce99eccec9383"
---

## Simple Summary

The current ARFC aims to onboard SCR, the native token of Scroll, on the Aave V3 Scroll Instance. This onboarding will allow Aave users to supply and borrow SCR, thereby enhancing the utility and liquidity of the Scroll token within the DeFi ecosystem and more specifically, within the Aave ecosystem.

## Motivation

Scroll is an Ethereum Layer 2 chain which already has an Aave instance deployment and SCR is the governance token for the Scroll L2. By onboarding SCR to Aave V3, we aim to create new opportunities for Aave users to engage with this emerging staking ecosystem, while expanding SCR’s liquidity.

**Benefits of listing this token:**

Provide opportunities for Aave users to borrow against their SCR to unlock liquidity, or alternatively to borrow SCR against other collateral allowing them to participate in Scroll governance.

**Market Impact:**

We see no significant market impact from onboarding SCR except for providing new opportunities to Aave users which may cause users to switch from borrowing other tokens against their collateral. Overall we see onboarding SCR as net good for Aave users as it expands opportunities for them to engage in a new L2 ecosystem.

**Chain to be deployed/listed:**

Scroll.

**Proof of Liquidity (POL) and Deposit Commitments:**

POL and Deposit Commitments will be discussed at the ARFC stage.

As disclosed by Marc Zeller, founder of ACI, the ACI Multisig has received 510K SCR on behalf of Aave DAO. Those funds will be coordinated with Karpatkey and Tokenlogic to define best usage of this airdrop.

## Specification

The table below illustrates the configured risk parameters for **SCR**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (SCR)          |                                    360,000 |
| Borrow Cap (SCR)          |                                    180,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                        0 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        7 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x26f6F7C468EE309115d19Aa2055db5A74F8cE7A5 |

Additionaly [0xac140648435d03f784879cd789130F22Ef588Fcd](https://scrollscan.com/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for SCR and the corresponding aToken.

## References

- Implementation: [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/954b89856136225da3f868e651cc9462b58c76cb/src/20241203_AaveV3Scroll_OnboardSCRToAaveV3Scroll/AaveV3Scroll_OnboardSCRToAaveV3Scroll_20241203.sol)
- Tests: [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/954b89856136225da3f868e651cc9462b58c76cb/src/20241203_AaveV3Scroll_OnboardSCRToAaveV3Scroll/AaveV3Scroll_OnboardSCRToAaveV3Scroll_20241203.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xef7dfa4e96e5f6a7337648d2dd3882f7b10e969c9564c118a34ce99eccec9383)
- [Discussion](https://governance.aave.com/t/arfc-onboard-scr-to-aave-v3-scroll-instance/19688)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
