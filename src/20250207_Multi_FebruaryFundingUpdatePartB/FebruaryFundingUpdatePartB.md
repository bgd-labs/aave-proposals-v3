---
title: "February Funding Update - Part B"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-february-funding-update/20712"
---

## Simple Summary

This publication presents the February Funding Update - Part B, which consists of performing the following key activities:

- Bridging funds to Ethereum;
- Create Merit & Ahab Allowances;
- Deposit previously swapped assets on [Part A](https://github.com/bgd-labs/aave-proposals-v3/pull/595)

## Motivation

This proposal is a continuation of [February Funding Update Part A](https://github.com/bgd-labs/aave-proposals-v3/pull/595) and as part of our ongoing Treasury asset rebalancing strategy, this proposal when implemented will continue to:

- Bridging assets from Polygon, Arbitrum and Optimism to Ethereum;
  - Continue reducing bridged USDC exposure in support of Native USDC adoption;
  - Convert DAI to USDS;
  - Prepare to unstake wstMATIC;
  - Transfer BAL and CRV to ALC.

## Specification

### Bridge Assets to Ethereum Mainnet

Withdraw from respective Aave Protocol and bridge the following assets to Ethereum mainnet.

| Polygon v2 & Passive |      Polygon v3      |    Arbitrum v3     |    Optimism v3     |
| :------------------: | :------------------: | :----------------: | :----------------: |
|  amUSDC.e (All-100)  |   aPolDAI (All-1)    |  aArbLUSD (All-1)  |  aOptLUSD (All-1)  |
|    amBAL (All-1)     |   aPolWETH (All-1)   | aArbUSDC (All-100) | aOptUSDC (All-100) |
|      BAL (All)       |   aPolBAL (All-1)    |   aEthDai(All-1)   |                    |
|     USDC.e (All)     | aPolUSDC.e (All-100) |      Dai(All)      |                    |
|      AAVE (All)      |   aPolAAVE (All-1)   |                    |                    |
|    amWETH (All-1)    | aPolstMATIC (All-1)  |                    |                    |
|    amDAI (All-1)     |   aPolDPI (All-1)    |                    |                    |
|      wETH (All)      |  aPolwstETH (All-1)  |                    |                    |
|      CRV (All)       |   aPolCRV (All-1)    |                    |                    |
|     wstETH (All)     |                      |                    |                    |

### Deposit into Aave V3

|      Instance       | Asset | Amount |
| :-----------------: | :---: | :----: |
| AaveV3EthereumCore  |  ETH  |  All   |
| AaveV3EthereumPrime |  GHO  |   3M   |
| AaveV3EthereumCore  | USDS  |  All   |

### Withdraw and burn 3M GHO on Prime instance

As per Chaos Labs' recommendation, withdraw and burn 3 Million GHO from Prime instance that had been previously been minted and supplied via the GhoDirectMinter Facilitator. Read more [here](https://governance.aave.com/t/arfc-update-usds-gho-borrow-rate/20892/5).

### Merit + Ahab Programs

Create allowances to the Merit_Ahab Safe, 3M GHO aEthLidoGHO and 800 aEthWETH from Aave v3 Prime and Core instances respectively:

SAFE: `0xdeadD8aB03075b7FBA81864202a2f59EE25B312b`

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/8aaeab3030190b8b8f89bdb907883af4fa7308f3/src/20250207_Multi_FebruaryFundingUpdatePartB/AaveV3Ethereum_FebruaryFundingUpdatePartB_20250207.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/8aaeab3030190b8b8f89bdb907883af4fa7308f3/src/20250207_Multi_FebruaryFundingUpdatePartB/AaveV3Polygon_FebruaryFundingUpdatePartB_20250207.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/8aaeab3030190b8b8f89bdb907883af4fa7308f3/src/20250207_Multi_FebruaryFundingUpdatePartB/AaveV3Optimism_FebruaryFundingUpdatePartB_20250207.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/8aaeab3030190b8b8f89bdb907883af4fa7308f3/src/20250207_Multi_FebruaryFundingUpdatePartB/AaveV3Arbitrum_FebruaryFundingUpdatePartB_20250207.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/8aaeab3030190b8b8f89bdb907883af4fa7308f3/src/20250207_Multi_FebruaryFundingUpdatePartB/AaveV3Ethereum_FebruaryFundingUpdatePartB_20250207.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/8aaeab3030190b8b8f89bdb907883af4fa7308f3/src/20250207_Multi_FebruaryFundingUpdatePartB/AaveV3Polygon_FebruaryFundingUpdatePartB_20250207.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/8aaeab3030190b8b8f89bdb907883af4fa7308f3/src/20250207_Multi_FebruaryFundingUpdatePartB/AaveV3Optimism_FebruaryFundingUpdatePartB_20250207.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/8aaeab3030190b8b8f89bdb907883af4fa7308f3/src/20250207_Multi_FebruaryFundingUpdatePartB/AaveV3Arbitrum_FebruaryFundingUpdatePartB_20250207.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-february-funding-update/20712)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
