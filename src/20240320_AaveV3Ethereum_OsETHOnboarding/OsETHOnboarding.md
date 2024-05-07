---
title: "osETH Onboarding"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboard-oseth-to-aave-v3-on-ethereum/16913"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x3dc8b06441d0f1dcd6f4a53d06d62e9bb1ac87ced19020d9c735854bbf68b835"
---

## Simple Summary

This is a ARFC proposal for adding borrow/lend support for StakeWise’s new over-collateralized staked ETH token, osETH, on AAVE V3 Ethereum.

## Motivation

Liquid staking tokens (LSTs) have proven to be popular collateral assets on Aave, with Lido’s stETH the largest Reserve across all Aave deployments and rETH quickly reaching its supply caps. As productive assets, LSTs are high quality collateral to borrow against. Given their high correlation to ETH, LSTs are commonly used as collateral to borrow ETH and engage in yield leveraged staking, with several communities having built products that automate such strategies on top of Aave. The introduction of eMode only made such strategies more popular.

osETH in particular is overcollateralized by design, providing in-built slashing protection and consequently an increased level of protection for the Aave protocol.

As StakeWise V3 provides solo stakers to ability to mint osETH against their own nodes, on-boarding osETH will benefit Aave, StakeWise, and the Ethereum ecosystem as a whole, and be an important step in the pursuit to diversify Ethereum staking and encourage staking from home.

The onboarding of osETH will consequently create increased osETH demand and increased revenues for both Aave and StakeWise protocols, whilst also bolstering the liquidity and peg stability of osETH.

## Specification

The table below illustrates the configured risk parameters for **osETH**

| Parameter                          |                                                                                                                 Value |
| ---------------------------------- | --------------------------------------------------------------------------------------------------------------------: |
| Isolation Mode                     |                                                                                                                 False |
| Borrowable                         |                                                                                                               ENABLED |
| Collateral Enabled                 |                                                                                                                  true |
| Supply Cap (osETH)                 |                                                                                                                10,000 |
| Borrow Cap (osETH)                 |                                                                                                                 1,000 |
| Debt Ceiling                       |                                                                                                                 USD 0 |
| LTV                                |                                                                                                                72.5 % |
| LT                                 |                                                                                                                  75 % |
| Liquidation Bonus                  |                                                                                                                 7.5 % |
| Liquidation Protocol Fee           |                                                                                                                  10 % |
| Reserve Factor                     |                                                                                                                  15 % |
| Base Variable Borrow Rate          |                                                                                                                   0 % |
| Variable Slope 1                   |                                                                                                                   7 % |
| Variable Slope 2                   |                                                                                                                 300 % |
| Uoptimal                           |                                                                                                                  45 % |
| Stable Borrowing                   |                                                                                                              DISABLED |
| Stable Slope1                      |                                                                                                                   0 % |
| Stable Slope2                      |                                                                                                                   0 % |
| Base Stable Rate Offset            |                                                                                                                   0 % |
| Stable Rate Excess Offset          |                                                                                                                   0 % |
| Optimal Stable To Total Debt Ratio |                                                                                                                   0 % |
| Flashloanable                      |                                                                                                               ENABLED |
| Siloed Borrowing                   |                                                                                                              DISABLED |
| Borrowable in Isolation            |                                                                                                              DISABLED |
| Oracle                             | [0x0A2AF898cEc35197e6944D9E0F525C2626393442](https://etherscan.io/address/0x0A2AF898cEc35197e6944D9E0F525C2626393442) |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_AaveV3Ethereum_OsETHOnboarding/AaveV3Ethereum_OsETHOnboarding_20240320.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240320_AaveV3Ethereum_OsETHOnboarding/AaveV3Ethereum_OsETHOnboarding_20240320.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x3dc8b06441d0f1dcd6f4a53d06d62e9bb1ac87ced19020d9c735854bbf68b835)
- [Discussion](https://governance.aave.com/t/arfc-onboard-oseth-to-aave-v3-on-ethereum/16913)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
