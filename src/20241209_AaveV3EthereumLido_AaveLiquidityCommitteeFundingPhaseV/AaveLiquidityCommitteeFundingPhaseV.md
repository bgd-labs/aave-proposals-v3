---
title: "Aave Liquidity Committee Funding Phase V"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-aave-liquidity-committee-funding-phase-v/20043"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0xe6740e5aec256ccf1dfbf538591f6b1631927f8d950b17067fe6912b74158332"
---

## Summary

This publication presents the Aave Liquidity Committee (ALC) Phase V request.

## Motivation

Phase V focuses on reinforcing GHO’s peg stability and enhancing liquidity to enable seamless large swaps with minimal price impact.
It also involves GHO's growth by expanding GHO to new networks, such as Base and Avalanche.
New integrations aim to drive adoption by partnering with protocols such as Synthetix on Arbitrum, Fluid, and Gearbox on Mainnet. Additionally, innovative liquidity incentives, like Royco Quests, will further enhance user engagement and ecosystem participation. These initiatives are designed to boost GHO’s utility, broaden its ecosystem reach, and ensure stability across chains, all while being guided by clear and measurable performance metrics.

Some high-level GHO performance metrics Phase V aims to achieve:

| Description                                |        Ethereum Value        |        Arbitrum Value        |       Avalanche Value        |          Base Value          |
| ------------------------------------------ | :--------------------------: | :--------------------------: | :--------------------------: | :--------------------------: |
| TVL DEX Liquidity Pools                    |             50M              |             20M              |             20M              |             20M              |
| TVL Utility Liquidity Pools (Excl. stkGHO) |             15M              |             7.5M             |             7.5M             |             7.5M             |
| DEX Liquidity Composition                  | < 50% GHO (< 33% for 3pools) | < 50% GHO (< 33% for 3pools) | < 50% GHO (< 33% for 3pools) | < 50% GHO (< 33% for 3pools) |
| Swap Price Impact $5M Swap (GHO to USDC)   |           < 0.10%            |           < 0.25%            |           < 0.25%            |           < 0.25%            |
| Annualised Peg Volatility                  |           < 5.00%            |           < 5.00%            |           < 5.00%            |           < 5.00%            |
| Price level for >90% time                  |            $0.995            |            $0.995            |            $0.995            |            $0.995            |

## Specification

Deposit 2.5M GHO into the Prime Instance on Ethereum.

Swap the following assets to GHO and transfer to the Collector.

|     Ethereum     |
| :--------------: |
| aEthUSDT (1.25M) |
| aEthUSDC (1.25M) |

Create an Allowance allowing the ALC to withdraw GHO from the Prime instance for a total of 2,000,000 GHO.

ALC Ethereum SAFE: `0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b`

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/412c18f5a13b11b34244e949b8f37a5aa6e75940/src/20241209_AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseV/AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseV_20241209.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/412c18f5a13b11b34244e949b8f37a5aa6e75940/src/20241209_AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseV/AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseV_20241209.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0xe6740e5aec256ccf1dfbf538591f6b1631927f8d950b17067fe6912b74158332)
- [Discussion](https://governance.aave.com/t/arfc-aave-liquidity-committee-funding-phase-v/20043)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
