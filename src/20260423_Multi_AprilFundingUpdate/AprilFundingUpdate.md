---
title: "April Funding Update"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-april-2026-funding-update/24447"
---

## Simple Summary

This publication presents the April Funding Update, consisting of the following key activities:

- Acquire GHO to support the runway; and,
- Create Allowances to support Operations,
- Paying out bug bounties and reimbursements.

## Motivation

This publication addresses near-term operational requirements, consolidates asset holdings, and refreshes the MainnetSwapSteward’s Allowances to support buyback and runway initiatives.

The MainnetSwapSteward will continue executing a rolling GHO acquisition strategy to maintain adequate runway, support AAVE buybacks, and preserve sufficient budget to fund ongoing growth initiatives.

Reimburse TokenLogic for costs incurred in facilitating the audit of one PR intended to streamline the UX for moving from USDC or USDT to GHO or sGHO. The Gho Router contract allows users to swap underlying or stata tokens for GHO, use GSMs (Gho Stability Modules), and enter/exit sGHO. The total cost of ChainSecurity’s audit was 21,322 GHO.

## Specification

### Runway

Deposit idle ETH on the Collector into the Aave v3 Core instance.

### Merit Program

Create an allowance for Merit of 2M aEthLidoGHO from Aave V3 Prime on Ethereum, sufficient to cover slightly more than 7 weeks of duration at the current 275k/week spend rate:

Asset: aEthLidoGHO: `0x18eFE565A5373f430e2F809b97De30335B3ad96A`
Amount: 2M
Spender: Merit `0xdeadD8aB03075b7FBA81864202a2f59EE25B312b`
Method: `approve() aEthLidoGHO` on the Aave Collector contract to the Merit address

### Avalanche

To support asset bridging, an Allowance will be created, enabling the AFC to bridge the following assets from Avalanche to Ethereum.

Amount: 1.55M aAvaUSDT `0x6ab707Aca953eDAeFBc4fD23bA73294241490620`
Amount: 650k avUSDT `0x532E6537FEA298397212F09A61e03311686f548e`
Amount: 2.25M avUSDC `0x46A51127C3ce23fb7AB1DE06226147F446e4a857`
Amount: 3.5M aAvaUSDC `0x625E7708f30cA75bfd92586e17077590C60eb4cD`
Amount: 2.75M aAvaDAI `0x82E64f49Ed5EC1bC6e43DAD4FC8Af9bb3A2312EE`
Amount: 118,000 aAvaWAVAX `0x6d80113e533a2C0fe82EaBD35f1875DcEA89Ea97`
Amount: 4 aAvaBTC.b `0x8ffdf2de812095b1d19cb146e4c004587c0a0692`
Amount: 8 aAvaWETH `0xe50fA9b3c56FfB159cB0FCA61F5c9D750e8128c8`
Amount: 335 WETH.e `0x49D5c2BdFfac6CE2BFdB6640F4F80f226bc10bAB`
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`

Method: `approve()` the above assets on the Aave Collector contract to the AFC address.
The holdings shall be consolidated into USDT, USDC and WETH before being deposited into the Ethereum Core instance.

### Base

Wrap native ETH to wETH.

To support asset bridging, an Allowance will be created, enabling the AFC to bridge the following assets from Base to Ethereum.

Amount: 625 WETH `0x4200000000000000000000000000000000000006`
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`

Method: `approve()` the above assets on the Aave Collector contract to the AFC address.
The holdings shall be transferred to the Collector Contract in the form of wETH on Ethereum.

### Arbitrum

To support asset bridging, an Allowance will be created, enabling the AFC to bridge the following assets from Arbitrum to Ethereum.

Amount: 1,350 aArbWETH `0xe50fA9b3c56FfB159cB0FCA61F5c9D750e8128c8`
Amount: 65 aArbweETH `0x8437d7C167dFB82ED4Cb79CD44B7a32A1dd95c77`
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`

Method: `approve()` the above assets on the Aave Collector contract to the AFC address.
The holdings shall be transferred and consolidated into wETH, then sent to the Collector Contract on Ethereum.

### Linea

To support asset bridging, an Allowance will be created, enabling the AFC to bridge the following assets from Linea to Ethereum.

Amount: 190 aLinWETH `0x787897dF92703BB3Fc4d9Ee98e15C0b8130Bf163`
Amount: 220k aLinUSDC `0x374D7860c4f2f604De0191298dD393703Cce84f3`
Amount: 140k aLinUSDT `0x88231dfEC71D4FF5c1e466D08C321944A7adC673`
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`

Method: approve() the above assets on the Aave Collector contract to the AFC address.
The holdings shall be transferred and consolidated into USDC, USDT and wETH, then sent to the Collector Contract on Ethereum.

### Scroll

To support asset bridging, an Allowance will be created, enabling the AFC to bridge the following assets from Scroll to Ethereum.

Amount: 175 aScrWETH `0xf301805bE1Df81102C957f6d4Ce29d2B8c056B2a`
Amount: 101k aScrUSDC `0x1D738a3436A8C49CefFbaB7fbF04B660fb528CbD`
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`

Method: `approve()` the above assets on the Aave Collector contract to the AFC address.
The holdings shall be transferred and consolidated into USDC and wETH, then sent to the Collector Contract on Ethereum.

### Plasma

To support asset bridging, an Allowance will be created, enabling the AFC to bridge the following assets from Plasma to Ethereum.

Amount: 55 aPlaWETH `0xf1aB7f60128924d69f6d7dE25A20eF70bBd43d07`
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`

Method: `approve()` the above assets on the Aave Collector contract to the AFC address.
The holdings shall be transferred and consolidated into wETH, then sent to the Collector Contract on Ethereum.

### Ethereum

To support the continued success of the friendly Tydro deployment, an AAVE Allowance from the Ecosystem Reserve will be created to fund an upcoming incentive campaign.

Amount: 200,000 AAVE `0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9`
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`
Method: `approve()` the above assets on the Ecosystem Reserve contract to the AFC address from which it will be routed to the Ink Network.

### Funding Flexibility

Wrap native ETH to wETH.

To support continued operations and provide flexible funding optionality, create the following Allowance.

Amount: 25k WETH `0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2`
Amount: 600 weETH `0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee`
Amount: 220 wstETH `0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0`
Amount: 60 rETH `0xae78736Cd615f374D3085123A210448E74Fc6393`
Amount: 4k aEthWETH `0x4d5F47FA6A74757f35C14fD3a6Ef8E3C9BC514E8`

Spender: Ahab `0xAA2461f0f0A3dE5fEAF3273eAe16DEF861cf594e`
Method: `approve()` on the Aave Collector contract to the ahab address

### Token Budget

| Token | Amount |
| ----- | ------ |
| WBTC  | 80     |
| cbBTC | 7      |
| ETH   | 10k    |
| LINK  | 60k    |
| USDC  | 10M    |
| USDT  | 10M    |
| USDe  | 10M    |
| USDS  | 10M    |
| DAI   | 5M     |

Reference: [MainnetSwapSteward forum post](https://governance.aave.com/t/arfc-steward-deployment-mainnetswapsteward-and-rewardssteward/23070).

Alongside these budgets, add ability to swap tokens to WETH.
Add WBTC as a swappable asset, with corresponding oracle.
Add cbBTC as a swappable asset, with corresponding oracle.
Add LINK as a swappable asset, with corresponding oracle.
Add 1Inch to WETH path.
Add SNX to WETH path.
Add UNI to WETH path.

### Update Stream

Cancel StreamID `100015` due to misconfiguration. The respective Service Provider will refund the portion of AAVE tokens corresponding to the remaining stream duration.

### Reimbursements

Reimburse 21,322.38 GHO to TokenLogic for GhoRouter audit expenses incurred.

Asset: GHO: `0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f`
Amount: 21,322.38
Spender: TokenLogic `0xAA088dfF3dcF619664094945028d44E779F19894`

Create 1M aEthLidoGHO allowance to Aave Labs in order to reimburse for on-going audit costs.

Asset: aEthLidoGHO: `0x18eFE565A5373f430e2F809b97De30335B3ad96A`
Amount: 1M
Spender: Aave Labs `0xaaf400e4bbc38b5e2136c1a36946bf841a357307`
Method: `approve()` the above assets on the Collector.

### Bug Bounty

- 5,000 GHO to `0xa9E6B917F3e0a89664d648B6DF474AB88D0D15ff`
- $500 GHO to `0x7119f398b6C06095c6E8964C1f58e7C1BAa79E18` (immunefi.eth).
  This is the fee corresponding to 10% of the previous bounty.

  Reference: https://governance.aave.com/t/bgd-request-for-bounty-payout-march-2026/24364

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260423_Multi_AprilFundingUpdate/AaveV3Ethereum_AprilFundingUpdate_20260423.sol), [AaveV3Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260423_Multi_AprilFundingUpdate/AaveV3Avalanche_AprilFundingUpdate_20260423.sol), [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260423_Multi_AprilFundingUpdate/AaveV3Arbitrum_AprilFundingUpdate_20260423.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260423_Multi_AprilFundingUpdate/AaveV3Base_AprilFundingUpdate_20260423.sol), [AaveV3Scroll](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260423_Multi_AprilFundingUpdate/AaveV3Scroll_AprilFundingUpdate_20260423.sol), [AaveV3Linea](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260423_Multi_AprilFundingUpdate/AaveV3Linea_AprilFundingUpdate_20260423.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260423_Multi_AprilFundingUpdate/AaveV3Plasma_AprilFundingUpdate_20260423.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260423_Multi_AprilFundingUpdate/AaveV3Ethereum_AprilFundingUpdate_20260423.t.sol), [AaveV3Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260423_Multi_AprilFundingUpdate/AaveV3Avalanche_AprilFundingUpdate_20260423.t.sol), [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260423_Multi_AprilFundingUpdate/AaveV3Arbitrum_AprilFundingUpdate_20260423.t.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260423_Multi_AprilFundingUpdate/AaveV3Base_AprilFundingUpdate_20260423.t.sol), [AaveV3Scroll](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260423_Multi_AprilFundingUpdate/AaveV3Scroll_AprilFundingUpdate_20260423.t.sol), [AaveV3Linea](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260423_Multi_AprilFundingUpdate/AaveV3Linea_AprilFundingUpdate_20260423.t.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260423_Multi_AprilFundingUpdate/AaveV3Plasma_AprilFundingUpdate_20260423.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-april-2026-funding-update/24447)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
