---
title: "Add PYUSD to Aave v3 Ethereum Pool"
author: "JosepBove (ACI)"
discussions: "https://governance.aave.com/t/arfc-add-pyusd-to-aave-v3-ethereum-market/16218/"
---

## Simple Summary

This AIP proposes the onboarding of the PYUSD stablecoin, minted by Paxos Trust Company, into the Aave V3 Ethereum pool.

## Motivation

PYUSD is a USD-pegged stablecoin minted through Paxos. While it’s still young, it has grown to a circulating supply of over $230M with strong peg resilience. Onboarding this asset into Aave will:

Build synergies between Aave and PYUSD.
Offer Aave users an additional stablecoin option.
Strengthen the relationship between the PYUSD & the GHO stablecoin. (Trident may explore the deployment of a PYUSD/GHO pool)
We propose a PYUSD onboarding outside isolation mode but without collateral properties.

## Specification

Ticker: PYUSD
Contract address: 0x6c3ea9036406852006290770bedfcaba0e23a0e8
Price Feed: 0x8f1df6d7f2db73eece86a18b4381f4707b918fb1

Chainlink Oracle: https://data.chain.link/ethereum/mainnet/stablecoins/PYUSD-usd

The table below illustrates the configured risk parameters for **PYUSD**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                      false |
| Supply Cap (PYUSD)        |                                 10,000,000 |
| Borrow Cap (PYUSD)        |                                  9,000,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        6 % |
| Variable Slope 2          |                                       80 % |
| Uoptimal                  |                                       80 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x8f1df6d7f2db73eece86a18b4381f4707b918fb1 |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240125_AaveV3Ethereum_AddPYUSDToAaveV3EthereumMarket/AaveV3Ethereum_AddPYUSDToAaveV3EthereumMarket_20240125.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240125_AaveV3Ethereum_AddPYUSDToAaveV3EthereumMarket/AaveV3Ethereum_AddPYUSDToAaveV3EthereumMarket_20240125.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb91949efad61b134b913d93b00f73ca8a122259e6d1458cf793f22a0eebfd5d5)
- [Discussion](https://governance.aave.com/t/arfc-add-pyusd-to-aave-v3-ethereum-market/16218/)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
