---
title: "May Funding Update"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-may-funding-update/17768"
snapshot: "Direct-to-AIP"
---

## Simple Summary

This proposal presents May’s funding update, including the following key activities:

- Migrating holdings from v2 to v3 (Polygon and Ethereum)
- Extending the DAO’s GHO runway to cover upcoming expenses
- Create Allowances for Frontier Program funding

## Motivation

This proposal seeks to enhance the financial sustainability of the DAO and will follow the Direct-To-AIP as outlined in this [proposal](https://governance.aave.com/t/arfc-funding-update/16675).

## Specification

### Consolidate GHO Funding and Migrate funds from V2 to V3

Perform the following Swaps and migration of assets from Aave v2 to v3. Assets are to be swapped for GHO.

| Withdraw & Swap to GHO | Migrate Eth v2 to v3 | Migrate Pol v2 to v3 |
| :--------------------: | :------------------: | :------------------: |
|    aEthDAI (All-1)     |    awETH (All-1)     |    amUSDT (All-1)    |
|      aDAI (All-1)      |                      |    amwETH (All-1)    |
|    aEthLUSD (All-1)    |                      |    amDAI (All-1)     |
|   aEthPYUSD (All-1)    |                      |                      |
|     aUSDC (All-1)      |                      |                      |
|       DPI (All)        |                      |                      |
|     aEthUSDT (2M)      |                      |                      |
|    aEthUSDC (1.5M)     |                      |                      |

Transfer the following assets to Ethereum.

|     Polygon      |     Arbitrum     |     Optimism     |
| :--------------: | :--------------: | :--------------: |
|   USDC.e (All)   |   USDC.e (All)   |   USDC.e (All)   |
| aPolUSDC (All-1) | aArbUSDC (All-1) | aOptUSDC (All-1) |
|  amUSDC (All-1)  |                  |                  |

Deposit the following small holdings into the respective v3 deployment:

| Deposit into Eth v3 |
| :-----------------: |
|        LINK         |

### Frontier Funding

The following LSTs are to be unstaked for ETH in order to fund the [Frontier initiative](https://snapshot.org/#/aave.eth/proposal/0x17da8b848323ed88b9c3ab391057c45a5737635dfe995ad66a84b389821b0867).

| Unwrap Asset | Quantity | Methodology |
| :----------: | :------: | :---------: |
|     rETH     |   All    |   Cowswap   |
|    wstETH    |   350    |  Use Lido   |

Note that Cowswap solvers will use the underlying rETH redemptions mechanisms if required.

A description of how the ETH is to be deployed has been outlined by ACI [here](https://governance.aave.com/t/arfc-expansion-of-frontier/17749).

| Quantity Deployed |  Provider  |
| :---------------: | :--------: |
|      248 ETH      |   Stader   |
|     2,085 ETH     | RocketPool |
|      160 ETH      | StakeWise  |

The Frontier SAFE `0xCDb4fA6ba08bF1FB7Aa9fDf6002E78EDc431a642` will be able to use the allowance function on `0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c` to claim the equivalent to 2,493 ETH.

Any residual ETH will be deposited into Aave v3.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/7cc3a0fecc565693c5ffef79b46621780fa96b96/src/20240603_Multi_MayFundingUpdate/AaveV3Ethereum_MayFundingUpdate_20240603.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/7cc3a0fecc565693c5ffef79b46621780fa96b96/src/20240603_Multi_MayFundingUpdate/AaveV3Polygon_MayFundingUpdate_20240603.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/7cc3a0fecc565693c5ffef79b46621780fa96b96/src/20240603_Multi_MayFundingUpdate/AaveV3Optimism_MayFundingUpdate_20240603.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/7cc3a0fecc565693c5ffef79b46621780fa96b96/src/20240603_Multi_MayFundingUpdate/AaveV3Arbitrum_MayFundingUpdate_20240603.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/7cc3a0fecc565693c5ffef79b46621780fa96b96/src/20240603_Multi_MayFundingUpdate/AaveV3Ethereum_MayFundingUpdate_20240603.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/7cc3a0fecc565693c5ffef79b46621780fa96b96/src/20240603_Multi_MayFundingUpdate/AaveV3Polygon_MayFundingUpdate_20240603.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/7cc3a0fecc565693c5ffef79b46621780fa96b96/src/20240603_Multi_MayFundingUpdate/AaveV3Optimism_MayFundingUpdate_20240603.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/7cc3a0fecc565693c5ffef79b46621780fa96b96/src/20240603_Multi_MayFundingUpdate/AaveV3Arbitrum_MayFundingUpdate_20240603.t.sol)
- [Snapshot](Direct-to-AIP)
- [Discussion](https://governance.aave.com/t/arfc-may-funding-update/17768)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
