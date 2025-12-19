---
title: "December Funding Update"
author: "@TokenLogic"
discussions: https://governance.aave.com/t/direct-to-aip-december-2025-funding-update/23619
snapshot: Direct-to-AIP
---

## Simple Summary

This publication presents the December Funding Update, consisting of the following key activities:

- Acquire GHO to support runway;
- Expand the remit of the AFC & Ahab SAFEs to support GHO liquidity; and
- Create allowances to support operations.

## Motivation

## Specification

### Runway

Using the MainnetSwapSteward and the already approved allowances, acquire 2M GHO to be deposited into the Prime instance.

Replenish the budgets on the MainnetSwapSteward, as they will be consumed by the rebalancing of assets mentioned above.

- USDC: 2M increase
- USDT: 4M increase
- USDS: 2M increase

### Collector Assets

Deposit idle ETH held on the Ethereum Collector into the Prime instance of Aave v3.

Create allowances for the following assets to be transferred from the Treasury to the AFC, where stkAAVE will be redeemed for AAVE and held on the AFC SAFE.

Amount: All `stkAAVE`
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`
Method: `approve()` stkAAVE on the Aave Collector contract to the AFC address.

Amount: 2,300 `aEthLidoWETH`
Spender: Ahab `0xAA2461f0f0A3dE5fEAF3273eAe16DEF861cf594e`
Method: `approve()` aEthLidoWETH on the Aave Collector contract to the ahab address

_Note_: To support ongoing DEX liquidity, launching GHO on Plasma and other networks, this publication grants the Aave Finance Committee (AFC) ability to provide DEX liquidity and reduce the reliance on incentive distribution. These assets now held in the AFC and Ahab SAFEs will be used as collateral to borrow GHO and fund the DEX liquidity.

Amount: 20,000 `AAVE`
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`
Method: `approve()` AAVE on the Aave Collector contract to the AFC address

_Note_: We have transitioned to using the MainnetSwapSteward for buybacks, with the acquired AAVE going directly to the collector, thus we'll create an allowance enabling the AAVE acquired to be held on the AFC SAFE. The Allowance is larger than the current balance to facilitate future buyback movements.

Redeem expired Principle Tokens to the underlying and convert to GHO.

Amount: 175.190155978359917557 `PT_eUSDe_14AUG2025`
Amount: 3,043.54299785406069585 `PT_sUSDE_25SEP2025`
Amount: 1,583.144136895510331668 `aEthPT_USDe_31JUL2025`
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`
Method: `approve()` on the Aave Collector contract to the AFC address

### Merit Program

Asset: 3,000,000 `aEthLidoGHO`
Spender: Merit `0xdeadD8aB03075b7FBA81864202a2f59EE25B312b`
Method: `approve()` aEthLidoGHO on the Aave Collector contract to the Merit address

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251214_AaveV3Ethereum_DecemberFundingUpdate/AaveV3Ethereum_DecemberFundingUpdate_20251214.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251214_AaveV3Ethereum_DecemberFundingUpdate/AaveV3Ethereum_DecemberFundingUpdate_20251214.t.sol)
  [Snapshot] Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-december-2025-funding-update/23619)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
