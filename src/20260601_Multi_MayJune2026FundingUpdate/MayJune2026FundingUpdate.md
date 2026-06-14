---
title: "May/June 2026 Funding Update"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-may-june-2026-funding-update/25000"
---

## Simple Summary

This publication presents the May/June Funding Update, consisting of the following key activities:

- Deposit idle ETH on the Collector into the Aave v3 Core instance;
- Refresh the MainnetSwapSteward Allowances to support GHO acquisition and runway;
- Create an aEthLidoGHO Allowance for the Tydro incentive campaign;
- Refresh the AFC aPlaUSDT0 Allowance on Plasma; and,
- Pay out bug bounties and reimburse audit costs.

## Motivation

This publication addresses near-term operational requirements and refreshes the Allowances that support the buyback and runway initiatives.

The MainnetSwapSteward continues executing a rolling GHO acquisition strategy to maintain adequate runway and support AAVE buybacks. 3.7M GHO was acquired during May 2026, and 4M GHO shall be acquired during June 2026, to be deposited into the Prime instance. These swaps are executed through the MainnetSwapSteward and are not part of this proposal's payload; the proposal only replenishes the Allowances that fund them.

TokenLogic is reimbursed for costs incurred in facilitating the audit of the GhoRouter PR intended to streamline the UX for moving from USDC or USDT to GHO or sGHO.

This update also includes a bug bounty payment to a security researcher, along with the corresponding Immunefi fee. A separate publication from Aave Labs will provide insights into the findings.

## Specification

### Runway

Deposit idle ETH on the Collector into the Aave v3 Core instance.

In addition to the 3.7M GHO acquired during May 2026, use the [MainnetSwapSteward](https://governance.aave.com/t/arfc-steward-deployment-mainnetswapsteward-and-rewardssteward/23070) to acquire 4M of GHO to be deposited into the Prime instance during June 2026.

### Tydro Incentive Campaign

To support the continued success of the friendly Tydro deployment, an aEthLidoGHO Allowance will be created to fund an upcoming incentive campaign.

- Asset: aEthLidoGHO `0x18eFE565A5373f430e2F809b97De30335B3ad96A`
- Amount: 5,000,000
- Spender: Ahab `0xAA2461f0f0A3dE5fEAF3273eAe16DEF861cf594e`
- Method: `approve()` the above asset on the Aave Collector contract to the Ahab address.

### Token Budget

To support the acquisition of GHO, replenish the Allowances on the MainnetSwapSteward `0xb7D402138Cb01BfE97d95181C849379d6AD14d19`.

| Token | Amount |
| ----- | ------ |
| WETH  | 5K     |
| USDC  | 10M    |
| USDT  | 10M    |
| USDe  | 10M    |
| USDS  | 10M    |
| DAI   | 5M     |

Method: `increaseTokenBudget(token, amount)` the above assets on the MainnetSwapSteward address.

Reference: [MainnetSwapSteward forum post](https://governance.aave.com/t/arfc-steward-deployment-mainnetswapsteward-and-rewardssteward/23070).

### Plasma

Refresh the existing aPlaUSDT0 Allowance down to 3M.

- Asset: aPlaUSDT0 `0x5D72a9d9A9510Cd8cBdBA12aC62593A58930a948`
- Amount: 3,000,000
- Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`
- Method: `approve()` the above asset on the Aave Collector contract to the AFC address.

### Reimbursements

Reimburse 11,655 aEthLidoGHO to TokenLogic for GhoRouter audit expenses incurred.

- Asset: aEthLidoGHO `0x18eFE565A5373f430e2F809b97De30335B3ad96A`
- Amount: 11,655
- Recipient: TokenLogic `0xAA088dfF3dcF619664094945028d44E779F19894`

Reimburse Aave Labs for costs incurred in facilitating the audit of Aave Pro, Aave Kit, Aave App and general protocol services.

- Asset: aEthLidoGHO `0x18eFE565A5373f430e2F809b97De30335B3ad96A`
- Amount: 392,746.66
- Spender: Aave Labs `0x1c037b3C22240048807cC9d7111be5d455F640bd`

### Bug Bounty

- 7,500 GHO `0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48` to the security researcher `0xcC7383b24631d8BfC8571dbF9c81d6D094688628`.
- 750 GHO to Immunefi `0x7119f398b6C06095c6E8964C1f58e7C1BAa79E18`. This is the fee corresponding to 10% of the bounty.
- 1,100 GHO to `0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48` to the security researcher `0x666B8EbFbF4D5f0CE56962a25635CfF563F13161` (Sherlock).

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/ea917103102b2535cfc7a001e6697b077a88b14e/src/20260601_Multi_MayJune2026FundingUpdate/AaveV3Ethereum_MayJune2026FundingUpdate_20260601.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/ea917103102b2535cfc7a001e6697b077a88b14e/src/20260601_Multi_MayJune2026FundingUpdate/AaveV3Plasma_MayJune2026FundingUpdate_20260601.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/ea917103102b2535cfc7a001e6697b077a88b14e/src/20260601_Multi_MayJune2026FundingUpdate/AaveV3Ethereum_MayJune2026FundingUpdate_20260601.t.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/ea917103102b2535cfc7a001e6697b077a88b14e/src/20260601_Multi_MayJune2026FundingUpdate/AaveV3Plasma_MayJune2026FundingUpdate_20260601.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-may-june-2026-funding-update/25000)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
