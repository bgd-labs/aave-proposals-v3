---
title: "Add FXS to Ethereum V3"
author: "Alice Rozengarden (@Rozengarden - Aave-chan initiative)"
discussions: "https://governance.aave.com/t/arfc-add-fxs-to-ethereum-v3/15112"
---

## Simple Summary

This publication presents the community with an opportunity to add FXS to the Ethereum Aave v3 Liquidity Pool.

## Motivation

Frax Finance is a DeFi protocol that offers a stable protocol for issuing FRAX/FPI/frxETH and subprotocols such as Fraxlend, Fraxswap, and Fraxferry. The Frax Shares Token ($FXS) serves a dual role as both a governance token and a utility token.

The addition of FXS to Aave V3 represents the introduction of a new asset, encouraging the transition from Aave V2 to V3 and diversifying collateral assets for GHO. Furthermore, Aave DAO can utilize FXS obtained from the pool to kickstart the adoption of GHO and/or new aTokens.

## Specification

The parameters shown below are supported by @Gauntlet
Ticker: FXS
Contract Adress: [0x3432B6A60D23Ca0dFCa7761B7ab56459D9C964D0](https://etherscan.io/address/0x3432B6A60D23Ca0dFCa7761B7ab56459D9C964D0)
Chainlink Oracle: [0x6Ebc52C8C1089be9eB3945C4350B68B8E4C2233f](https://etherscan.io/address/0x6Ebc52C8C1089be9eB3945C4350B68B8E4C2233f)

| Parameter                          | Recommendation (Gauntlet) |
| ---------------------------------- | ------------------------- |
| Isolation Mode                     | YES                       |
| Borrowable                         | YES                       |
| Collateral Enabled                 | YES                       |
| Supply Cap (FXS)                   | 800,000                   |
| Borrow Cap (FXS)                   | 500,000                   |
| Debt Ceiling                       | $4M                       |
| LTV                                | 35.00%                    |
| LT                                 | 45.00%                    |
| Liquidation Bonus                  | 10.00%                    |
| Liquidation Protocol Fee           | 10.00%                    |
| Reserve Factor                     | 20.00%                    |
| Base Variable Borrow Rate          | 0.00%                     |
| Variable Slope 1                   | 9.00%                     |
| Variable Slope 2                   | 300.00%                   |
| Uoptimal                           | 45.00%                    |
| Stable Borrowing                   | NO                        |
| Stable Slope1                      | 13.00%                    |
| Stable Slope2                      | 300.00%                   |
| Base Stable Rate Offset            | 3.00%                     |
| Stable Rate Excess Offset          | 5.00%                     |
| Optimal Stable To Total Debt Ratio | 20.00%                    |
| Flahloanable                       | YES                       |
| Siloed Borrowing                   | NO                        |
| Borrowable in Isolation            | NO                        |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/5b7e8bf699f382382e8f4ac337ac5c5328ccf9c6/src/20231108_AaveV3Ethereum_AddFXSToEthereumV3/AaveV3Ethereum_AddFXSToEthereumV3_20231108.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/5b7e8bf699f382382e8f4ac337ac5c5328ccf9c6/src/20231108_AaveV3Ethereum_AddFXSToEthereumV3/AaveV3Ethereum_AddFXSToEthereumV3_20231108.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xd8a8bdf3692666195895efbe0e885887c73b614273d6f0bd584c68afa9c11600)
- [Discussion](https://governance.aave.com/t/arfc-add-fxs-to-ethereum-v3/15112)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
