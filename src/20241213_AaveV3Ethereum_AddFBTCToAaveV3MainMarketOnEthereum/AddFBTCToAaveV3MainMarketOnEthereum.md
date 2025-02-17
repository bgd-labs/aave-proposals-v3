---
title: "Add FBTC to Aave v3 Main Market on Ethereum"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-add-fbtc-to-aave-v3-main-market-on-ethereum/19937"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0x2ca8db490e132cebfec25ddbf460b89abd710456c5177bca784abaae9d6009d9"
---

## Simple Summary

The proposal aims to onboard Ignition’s FBTC, to the Aave v3 protocol Main Market on Ethereum.

## Motivation

FBTC is a cross-chain BTC protocol that uses the Threshold Signature Scheme network to enable secure, decentralized Bitcoin scalability across multiple blockchains. By leveraging multi-party computation, FBTC strengthens bridge security, safeguarding user assets and ensuring robust cross-chain interoperability. This setup also integrates a cross-chain hub, allowing seamless BTC transfers while reducing issues linked to Bitcoin L2 growth.

This new asset will broaden opportunities for Bitcoin holders aiming to participate in DeFi on Aave v3. The introduction of FBTC offers users more flexibility in leveraging their Bitcoin, enhancing liquidity and driving increased engagement within the Aave protocol.

With $480M in total value locked (TVL), FBTC is emerging as a compelling solution in Bitcoin bridging, supported by its upcoming Chainlink Oracle integration to accelerate growth across EVM networks.

Aave is positioned to benefit from a material increase in AUM resulting from FBTC deposits. This capital is being sourced by from within the Ignition team’s network. Several sophisticated investors are looking to user Aave at size and some teams have built products specifical for investors in anticipationg of the Aave listing. The Ignition team is expected to provide incentives supporting Aave users directly and also strategy providers built on top of Aave. @TokenLogic has been coordinating with various prospective users to ensure there is adequate demand ahead of the listing.

### Benefits of listing FBTC

With the evolving landscape surrounding wBTC, having alternative wrapped BTC tokens available for use on Aave is crucial. With Antalpha and Mantle serving as core contributors, Ignition strong reputations position this initiative as a credible alternative to wBTC. This collaborative effort has already garnered over $850 million in TVL.

The cbBTC listing has demonstrated how impactful an Aave integration can be for both parties involved. Aave successfully captured 74% of the cbBTC supply, showcasing the significant growth potential and mutual benefits such integrations can bring.

### Liquidity commitments

FBTC current points campaign is focused on maximizing user engagement and incentivizing interactions within the DeFi ecosystem. As part of this initiative, they aim to highlight Aave by listing it in the featured section, providing prominent exposure to its offerings. Additionally, they plan to create a new DeFi lending category, with Aave being the inaugural protocol, further showcasing its significance in this space.

To enhance user participation, they will introduce boosted points under the Sparks program, with Aave receiving 2x-4x sparks by default; double the rewards compared to other protocols, which offer 1x-2x.

For a limited period, it will further amplify rewards by offering a 4x-8x sparks boost on Aave V3 instance, driving even greater engagement and usage.

## Specification

The table below illustrates the configured risk parameters for **FBTC**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (FBTC)         |                                        200 |
| Borrow Cap (FBTC)         |                                        100 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       73 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       50 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        4 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c |

Additionaly [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for FBTC and the corresponding aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241213_AaveV3Ethereum_AddFBTCToAaveV3MainMarketOnEthereum/AaveV3Ethereum_AddFBTCToAaveV3MainMarketOnEthereum_20241213.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241213_AaveV3Ethereum_AddFBTCToAaveV3MainMarketOnEthereum/AaveV3Ethereum_AddFBTCToAaveV3MainMarketOnEthereum_20241213.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x2ca8db490e132cebfec25ddbf460b89abd710456c5177bca784abaae9d6009d9)
- [Discussion](https://governance.aave.com/t/arfc-add-fbtc-to-aave-v3-main-market-on-ethereum/19937)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
