---
title: "May Funding Update"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-may-2025-funding-update/21906"
---

## Simple Summary

This publication presents the May Funding Update, consisting of the following key activities:

- Bridge funds to Ethereum;
- Consolidate funds from the Collector;
- Merit, Ahab allowances
- Create 6M USD Allowance for AAVE buybacks; and,
- Acquire 4M GHO for Operations.

## Motivation

This publication combines near term operational needs and migrating assets held on L2s and side chains in preparation for funding future incentive campaigns.

The below outlines the objectives of this publication:

- Consolidating funds to Ethereum; and,
- Support near term operational requirements;

### Bridge Funds to Ethereum

Each month, the DAO will bridge its funds held on sidechains and Layer 2 networks back to Ethereum, where they will be allocated to support ongoing incentive and buyback programs. With the Umbrella upgrade pending, Horizon and AAVE buybacks already underway, consolidating assets on Ethereum ensures that sufficient capital is available and accessible when needed.

### Acquire GHO

In the short term, we anticipate multiple initiatives will seek funding from the DAO. This proposal, once enacted, will secure a sufficient amount of GHO to support the DAO’s operations. This ensures the DAO remains consistently well-capitalized.

Upcoming anticipated expenses include:

- Renewal of Service Provider agreements;
- Merit and ALC distributions; and,
- Incentive campaign(s).

### Acquire ETH

The Aave DAO continues its treasury rebalancing by converting a portion of its MATIC holdings into ETH. This action builds upon the funding update initiated in April, during which the first batch of Polygon-based assets was bridged back to Ethereum mainnet.

The ETH acquired through this reallocation will be directed toward the Frontier program, where it will support Ethereum decentralization efforts while simultaneously generating yield for the DAO.

## Specification

This proposal shall be submitted as several AIPs that align with operational readiness timelines and ease of review given the volume of funds being moved.

### Bridge Assets to Ethereum

Bridge the following assets to Ethereum.

|                                       Polygon                                       |                                    Arbitrum                                    |                                          Optimism                                          |
| :---------------------------------------------------------------------------------: | :----------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------: |
|   [DAI](https://polygonscan.com/token/0x8f3cf7ad23cd3cadbd9735aff958023239c6a063)   |  [DAI](https://arbiscan.io/token/0xda10009cbd5d07dd0cecc66161fc93d7c9000da1)   |  [DAI](https://optimistic.etherscan.io/token/0xda10009cbd5d07dd0cecc66161fc93d7c9000da1)   |
|  [USDT](https://polygonscan.com/token/0xc2132d05d31c914a87c6611c10748aeb04b58e8f)   | [USDC.e](https://arbiscan.io/token/0xff970a61a04b1ca14834a43f5de4533ebddb5cc8) |  [USDT](https://optimistic.etherscan.io/token/0x94b008aa00579c1307b0ef2c499ad98a8ce58e58)  |
| [ USDC.e](https://polygonscan.com/token/0x2791bca1f2de4661ed88a30c99a7a9449aa84174) |                                                                                | [USDC.e](https://optimistic.etherscan.io/token/0x7f5c764cbc14f9669b88837ca1490cca17c31607) |
|  [WPOL](https://polygonscan.com/token/0x0d500b1d8e8ef31e21c99d1db9a6444d3adf1270)   |                                                                                |
|  [WBTC](https://polygonscan.com/token/0x1bfd67037b42cf73acf2047067bd4f2c47d9bfd6)   |                                                                                |
| [MATICX](https://polygonscan.com/token/0xfa68fb4628dff1028cfec22b4162fccd0d45efb6)  |                                                                                |
|   [ETH](https://polygonscan.com/token/0xe50fa9b3c56ffb159cb0fca61f5c9d750e8128c8)   |

### Transfer Assets

Transfer all AAVE to the Ecosystem Reserve.

### Deposit Assets

Deposit 115 ETH held on the Treasury into the Core instance of Aave.

### Ethereum - Swaps

Swap the following from the Collector as outlined in the table below:

| Ethereum | Amount | Swap |
| :------: | :----: | :--: |
|   USDT   | 2.00M  | GHO  |
|   USDC   | 2.00M  | GHO  |
|   DAI    |  All   | USDS |
|   LUSD   |  All   | WETH |
|   CVX    |  All   | WETH |
|   FRAX   |  All   | WETH |

### Create Allowances

**Acquire WETH**

Create a MATIC and stMATIC allowance for the Aave Finance Committee to then swap each asset to ETH and transfer to the Treasury.

- Asset: `MATIC` [0x7D1AfA7B718fb893dB30A3aBc0Cfc608AaCfeBB0](https://etherscan.io/address/0x7d1afa7b718fb893db30a3abc0cfc608aacfebb0)
- Amount: All Available Balance ~580,156
- Asset: `stMATIC` [0x9ee91F9f426fA633d227f7a9b000E28b9dfd8599](https://etherscan.io/address/0x9ee91f9f426fa633d227f7a9b000e28b9dfd8599)
- Amount: All Available Balance ~28,547
- Spender: AFC [0x22740deBa78d5a0c24C58C740e3715ec29de1bFa](https://app.safe.global/home?safe=eth:0x22740deBa78d5a0c24C58C740e3715ec29de1bFa)
- Method: `approve()` MATIC and stMATIC on the Aave Collector contract to the AFC safe

**AAVE Buybacks**

Create a 3M aEthUSDT and 3M aEthUSDC allowance for the Aave Finance Committee to perform 6 weeks of AAVE buybacks.

- Asset: `aEthUSDT` [0x23878914EFE38d27C4D67Ab83ed1b93A74D4086a](https://etherscan.io/address/0x23878914EFE38d27C4D67Ab83ed1b93A74D4086a)
- Amount: 3M
- Asset: `aEthUSDC` [0x98C23E9d8f34FEFb1B7BD6a91B7FF122F4e16F5c](https://etherscan.io/address/0x98C23E9d8f34FEFb1B7BD6a91B7FF122F4e16F5c)
- Amount: 3M
- Spender: AFC [0x22740deBa78d5a0c24C58C740e3715ec29de1bFa](https://app.safe.global/home?safe=eth:0x22740deBa78d5a0c24C58C740e3715ec29de1bFa)
- Method: `approve()` aEthUSDT and `aEthUSDC on the Aave Collector contract to the AFC safe

**Merit + Ahab Programs**

Create allowances to the Merit and Ahab, 3M aEthLidoGHO and 800 aEthWETH from Aave v3 Prime and Core respectively on Ethereum:

- Asset: `aEthLidoGHO` [0x18eFE565A5373f430e2F809b97De30335B3ad96A](https://etherscan.io/address/0x18eFE565A5373f430e2F809b97De30335B3ad96A)
- Amount: 3M
- Asset: `aEthWETH` [0x4d5F47FA6A74757f35C14fD3a6Ef8E3C9BC514E8](https://etherscan.io/address/0x4d5F47FA6A74757f35C14fD3a6Ef8E3C9BC514E8)
- Amount: 800
- Spender: Merit [0xdeadD8aB03075b7FBA81864202a2f59EE25B312b](https://app.safe.global/transactions/history?safe=eth:0xdeadD8aB03075b7FBA81864202a2f59EE25B312b)
- Method: `approve()` aEthLidoGHO and aEthWETH on the Aave Collector contract to the Merit safe

**Gnosis Liquidity Mining Rewards**

- Asset: `aGnoEURe` [0xEdBC7449a9b594CA4E053D9737EC5Dc4CbCcBfb2](https://gnosisscan.io/address/0xedbc7449a9b594ca4e053d9737ec5dc4cbccbfb2)
- Amount: 25k
- Spender: Merit [0xdef1FA4CEfe67365ba046a7C630D6B885298E210](https://app.safe.global/home?safe=gno:0xdef1FA4CEfe67365ba046a7C630D6B885298E210)
- Method: `approve()` aEthLidoGHO and aEthWETH on the Aave Collector contract to the Merit safe

**Gas Reimbursement**
Transfer 0.5847 ETH to ACI to reimburse expenses incurred.

This reimburses associated gas costs linked to AIP submissions and administering various incentive reward programs.

ACI Receiving Address: [0xdef1FA4CEfe67365ba046a7C630D6B885298E210](https://app.safe.global/home?safe=eth:0xdef1FA4CEfe67365ba046a7C630D6B885298E210)

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250426_Multi_MayFundingUpdate/AaveV3Ethereum_MayFundingUpdate_20250426.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250426_Multi_MayFundingUpdate/AaveV3Polygon_MayFundingUpdate_20250426.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250426_Multi_MayFundingUpdate/AaveV3Optimism_MayFundingUpdate_20250426.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250426_Multi_MayFundingUpdate/AaveV3Arbitrum_MayFundingUpdate_20250426.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250426_Multi_MayFundingUpdate/AaveV3Ethereum_MayFundingUpdate_20250426.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250426_Multi_MayFundingUpdate/AaveV3Polygon_MayFundingUpdate_20250426.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250426_Multi_MayFundingUpdate/AaveV3Optimism_MayFundingUpdate_20250426.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250426_Multi_MayFundingUpdate/AaveV3Arbitrum_MayFundingUpdate_20250426.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-may-2025-funding-update/21906)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
