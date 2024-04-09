---
title: "weETH Onbaording"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboard-weeth-to-aave-v3-on-ethereum/16758"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xd5807ee6ec3d33e7d86805a4287540b0a9801430ee0900ff6babb698e4f2a273"
---

## Simple Summary

The current ARFC seeks to add [Ether.fi ](http://Ether.fi) Liquid Restaking Token weETH to Aave V3 Ethereum, after the successful [TEMP CHECK ](https://governance.aave.com/t/temp-check-onboarding-weeth-to-aave-v3-ethereum/16546) and [TEMP CHECK Snapshot ](https://snapshot.org/#/aave.eth/proposal/0xffe122a2fb0b34e713b7bb8e74e943b35c6cb298bafc4e50c464b62167e3246e).

The intention behind this initiative is to enhance the diversity of assets on Aave and bolster liquidity within the ecosystem.

## Motivation

eETH is an LRT that allows users to stake their ETH, accrue staking rewards, and receive additional rewards through native restaking on EigenLayer. As of February 3rd, approximately 290,310 ETH ($670M) in TVL has been deposited into the [ether.fi 1 ](http://ether.fi/) protocol, and XX has been natively restaked in EigenLayer.

[Ether.fi ](http://ether.fi/) stands as the pioneering decentralized and non-custodial delegated staking protocol featuring an LRT (eETH). A notable feature of [ether.fi ](http://ether.fi/) is the control it provides stakers over their keys. The team behind the protocol is guided by the following principles:

1. Decentralization is the foremost objective. [Ether.fi ](http://ether.fi/) is unwavering in its commitment to maintain the protocol’s non-custodial and decentralized nature, ensuring that stakers always have control over their ETH.
2. [Ether.fi ](http://ether.fi/) operates as a legitimate business with a sustainable revenue model, with the team dedicated to its long-term success. There is no place for deceptive or unsustainable financial practices.
3. [Ether.fi ](http://ether.fi/) is committed to always acting in the best interest of the Ethereum community. In the event of any missteps, the team at [ether.fi ](http://ether.fi/) will take responsibility and swiftly rectify the situation.

Risks:

[ether.fi ](http://ether.fi/)’s LRT eETH is 100% redeemable. Users who deposit ETH into the protocol can withdraw their stake at any time. The holdings are publicly auditable on-chain and the protocol retains healthy reserves to offset any losses.

## Proof of Liquidity and Deposit Commitments

Anyone who deposits weETH into Aave will accumulate [ether.fi ](http://ether.fi/) and EigenLayer points to be used for future incentives.

Users are given eETH on a 1:1 basis with a minimum deposit of 0.001 ETH.

[ether.fi ](http://ether.fi/) is also the first LSP to natively restake on EigenLayer — a move that helps improve network efficiency and provides stakers with additional rewards for their network contributions. [ether.fi ](http://ether.fi/) has also launched a series of partnerships with DeFi protocols to incentivize users and drive liquidity (weETH) to various platforms.

## Specification

The table below illustrates the configured risk parameters for [weETH](https://etherscan.io/token/0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee)

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (weETH)                 |                                      8,000 |
| Borrow Cap (weETH)                 |                                        800 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                     72.5 % |
| LT                                 |                                       75 % |
| Liquidation Bonus                  |                                      7.5 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       15 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                        7 % |
| Variable Slope 2                   |                                      300 % |
| Uoptimal                           |                                       45 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        0 % |
| Stable Slope2                      |                                        0 % |
| Base Stable Rate Offset            |                                        0 % |
| Stable Rate Excess Offset          |                                        0 % |
| Optimal Stable To Total Debt Ratio |                                        0 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0xf112aF6F0A332B815fbEf3Ff932c057E570b62d3 |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_AaveV3Ethereum_WeETHListing/AaveV3Ethereum_WeETHListing_20240320.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_AaveV3Ethereum_WeETHListing/AaveV3Ethereum_WeETHListing_20240320.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xd5807ee6ec3d33e7d86805a4287540b0a9801430ee0900ff6babb698e4f2a273)
- [Discussion](https://governance.aave.com/t/arfc-onboard-weeth-to-aave-v3-on-ethereum/16758)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
