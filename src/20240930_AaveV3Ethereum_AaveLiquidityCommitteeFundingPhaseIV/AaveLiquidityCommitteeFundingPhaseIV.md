---
title: "Aave Liquidity Committee Funding Phase IV"
author: "@karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-aave-liquidity-committee-funding-phase-iv/19188"
---

## Simple Summary

Upon implementation, this AIP will make available 950,000 GHO to the Aave Liquidity Committee (ALC).

## Motivation

Phase IV of the ALC focuses on sustaining and improving GHO liquidity across the Ethereum and Arbitrum networks, while also encouraging broader adoption of GHO through various integrations with other protocols.

In the near future, we expect GHO to be listed on InstadApp, with several curated vaults providing additional utility and yield opportunities for GHO.

GHO is also expected to feature in the upcoming Royco launch, aimed at driving flows into several yield strategies across Ethereum and Arbitrum.

We anticipate achieving the first perpetual market integration for GHO with a strataGHO listing on Synthetix on Arbitrum.

Each integration is expected to provide a use case that strengthens GHO's on-chain liquidity.

The table below presents the performance metrics for the ALC.

| Description                                |                                   Ethereum Value                                   |                                   Arbitrum Value                                   |
| ------------------------------------------ | :--------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------: |
| TVL DEX Liquidity Pools                    |                                        50M                                         |                                        30M                                         |
| TVL Utility Liquidity Pools (Excl. stkGHO) |                                        15M                                         |                                        10M                                         |
| DEX Liquidity Composition                  |                            < 50% GHO (< 33% for 3pools)                            |                            < 50% GHO (< 33% for 3pools)                            |
| Swap Price Impact $5M Swap (GHO to USDC)   |                                      < 0.10%                                       |                                      < 0.25%                                       |
| Annualised Peg Volatility                  |                                      < 5.00%                                       |                                      < 5.00%                                       |
| Price level for >90% time                  | $0.995 using [Redstone Medium Price](https://app.redstone.finance/#/app/token/GHO) | $0.995 using [Redstone Medium Price](https://app.redstone.finance/#/app/token/GHO) |

Achieving 50M of DEX liquidity on Ethereum across various integrations remains a key focus. Whilst we are yet to acheive this target, we are currently very well positioned for current market conditions.

## Specification

Create an Allowance for GHO on Ethereum for a total of 950,000 GHO.

ALC Ethereum SAFE: [`0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b`](https://etherscan.io/address/0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b)

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240930_AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseIV/AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseIV_20240930.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240930_AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseIV/AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseIV_20240930.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x7b59c555f5a51a3377b1aee0f5f21fc205958f1388926efb94172644bacfa1d6)
- [Discussion](https://governance.aave.com/t/arfc-aave-liquidity-committee-funding-phase-iv/19188)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
