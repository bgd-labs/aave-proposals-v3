---
title: "June Funding Update - Part II"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-june-2025-funding-update/22352/2"
---

## Simple Summary

This publication presents the June Funding Update, consisting of the following key activities:

- Acquire 3M GHO for Operations;
- Continue AAVE buybacks for 6 weeks; and,
- Create Merit & Ahab Allowances.

## Motivation

This publication focuses on supporting near term operational funding requirements.

##### Acquire GHO

In the short term, we anticipate multiple initiatives will seek funding from the DAO. This proposal, once enacted, will secure a sufficient amount of GHO to support the DAO’s operations. This ensures the DAO remains consistently well-capitalized.

Upcoming anticipated expenses include:

- Renewal of Service Provider agreements, eg: Chaos Labs;
- Create 6M USD Allowance for AAVE buybacks; and,
- Future Merit and ALC distributions up until November; and,
- Incentive campaign(s).

#### Fund Merit + Ahab Programs

Merit is $12M per year at 3M per quarter or 1M per month. Merit is currently funded up until end of July. With the implementation of this proposal, Merit will be funded until beginning of November.

Ahab is $8M per year with the amount of ETH being distributed subject to ETH price fluctuations. The previous 3 month period’s budget was 800 ETH and of this 800 ETH, not all has been consumed. As a result, the next budget period will receive only 800 ETH.

## Specification

Perform the following swaps:

| Token | Amount | Acquire |
| ----- | ------ | ------- |
| USDT  | 1.00M  | GHO     |
| USDC  | 2.00M  | GHO     |

### Create Allowances

##### AAVE Buybacks

Create a 4M aEthUSDT and 2M aEthUSDC allowance for the Aave Finance Committee to perform 6 weeks of AAVE buybacks.

Asset: aEthUSDT `0x23878914EFE38d27C4D67Ab83ed1b93A74D4086a`
Amount: 4M

Asset: aEthUSDC `0x98C23E9d8f34FEFb1B7BD6a91B7FF122F4e16F5c`
Amount: 2M

Spender: AFC [0x22740deBa78d5a0c24C58C740e3715ec29de1bFa](https://etherscan.io/address/0x22740deBa78d5a0c24C58C740e3715ec29de1bFa)

Method: approve() aEthUSDT and aEthUSDC on the Aave Collector contract to the AFC address.

#### Merit + Ahab Programs

Create allowances to the Merit and Ahab, 3M aEthLidoGHO and 800 aEthWETH from Aave v3 Prime and Core respectively on Ethereum:

Asset: aEthLidoGHO: `0x18eFE565A5373f430e2F809b97De30335B3ad96A`
Amount: 3M

Asset: aEthWETH: `0x4d5F47FA6A74757f35C14fD3a6Ef8E3C9BC514E8`
Amount: 800

Spender: Merit [0xdeadD8aB03075b7FBA81864202a2f59EE25B312b](https://etherscan.io/address/0xdeadD8aB03075b7FBA81864202a2f59EE25B312b)
Method: approve() aEthLidoGHO and aEthWETH on the Aave Collector contract to the Merit address

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250616_AaveV3Ethereum_JuneFundingUpdate/AaveV3Ethereum_JuneFundingUpdate_20250616.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250616_AaveV3Ethereum_JuneFundingUpdate/AaveV3Ethereum_JuneFundingUpdate_20250616.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-june-2025-funding-update/22352/2)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
