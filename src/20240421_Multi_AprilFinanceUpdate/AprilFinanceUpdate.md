---
title: "April Finance Update"
author: "@karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-april-finance-update/17390"
---

## Simple Summary

This proposal presents April's funding update, including the following key activities:

- Migrating holdings from v2 to v3 (Polygon and Ethereum)
- Extending the DAO's GHO runway to cover upcoming expenses
- Returning RealT's supplied WXDAI to RealT
- Migrating AGD's allowance to GHO
- Reimburse BGD Labs for the costs paid towards external security reviews
- Send LINK and MATIC to refill Aave Robot and Aave Delivery Infrastructure

The forum discussion for BGD labs' reimbursements can be found [here](https://governance.aave.com/t/arfc-bgd-security-budget-request-december-2023/15783) and the Snapshot can be found [here](https://snapshot.org/#/aave.eth/proposal/0xf95bc210e3e93c2112c694cb158db22c93504155b48c03d9358e4c41c33ee782).

## Motivation

With the upcoming extension of [Merit](https://governance.aave.com/t/arfc-merit-is-forever-reward-system-program-extension/17336) and the funding request from [Chaos Labs](https://governance.aave.com/t/arfc-chaos-labs-engagement-amendment/17324), this proposal will swap sufficient assets to GHO to ensure enough funds are available as required.

This proposal cancels the existing USDT Allowance to the Aave Grants DAO and replaces it with a GHO Allowance of equal size, 612.9k. This represents a continuation of transitioning to using GHO as the preferred means of covering DAO expenses.

Also within this proposal, there is the corrective action of returning [3504 RealT WXDAI](https://gnosisscan.io/tx/0xf70a507847da2ad4acbecc35cd84c2f5d2489b0b0eb0e16af49c9262ca95707e) sent by RealT to the Aave Gnosis Chain collector by accident. Details on the agreement with realT can be found [here](https://snapshot.org/#/aave.eth/proposal/0xff69be7580614ebc1a455591c1bd651d8f0af12070d277d7d8846beb3c7c964b).

This proposal will follow the Direct-To-AIP as outlined in this [proposal](https://governance.aave.com/t/arfc-funding-update/16675).

Certain permissionless actions on the aave governance requires interaction (transaction) by someone for the governance system to run. This is done by the Aave Robot, which spends LINK tokens for the gas amount spent during the automation of these permissionless actions.

During the past months BGD labs had spent in total of 1640 LINK for the Aave Robot, and 4000 MATIC for funding the Aave Delivery Infrastructure which is used to pay for the bridging fees in order for the governance system to work.

BGD has paid the following amounts for security reviews so reimbursement is in order:

- Compensation to Mixbytes for the review of Governance v3 Tokens: $30'000
- Compensation to Emanuele Ricci (@stermi) for the review done on Aave 3.1 Feature: $12'000
- Engagement with Spearbit for Aave v3 Ad-hoc Review: $109'200

## Specification

## BGD Reimbursements

- Transfer 42'000 aUSDC v2 Ethereum to `0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF`
- Transfer 109'200 aUSDT v2 Ethereum to `0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF`
- Transfer 1640 aLINK v2 Ethereum to `0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF`
- Transfer 4000 aMATIC v2 Polygon to `0xbCEB4f363f2666E2E8E430806F37e97C405c130b`

## aDI BOT Refill

- Transfer 20,000 MATIC to `0xF6B99959F0b5e79E1CC7062E12aF632CEb18eF0d`

### Migrating AGD's allowance to GHO

The following Allowance is to be cancelled and replaced with GHO:

- Cancel aUSDT Allowance
- Increase GHO Allowance by 613,000 units

The AGD mulisig `eth:0x89C51828427F70D77875C6747759fB17Ba10Ceb0` will be able to use the allowance function on `0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c` to claim the GHO.

### Merit Allowances

- Allowance of 3.0M GHO for the Merit program
- Allowance of 645 aEthWETH for the Merit program

### Returning RealT's supplied WXDAI to RealT

Transfer 3,504 armmv3WXDAI to `0x7DA9A33d15413F499299687cC9d81DE84684E28E` on Gnosis Chain.

### Consolidate GHO funding and Migrate funds from V2 to V3

#### Part A

Perform the following Swaps, Migrate Eth v2 to v3 and bridge from Polyon to Ethereum.

| Withdraw & Swap to GHO | Migrate Eth v2 to v3 |    Pol to Eth     | Migrate Pol v2 to v3 |
| :--------------------: | :------------------: | :---------------: | :------------------: |
|    aEthUSDC (1.4M)     |    awBTC (All-1)     |  aPolDAI (All-1)  |    amUSDT (All-1)    |
|      aDAI (All-1)      |    awETH (All-1)     |  amUSDC (All-1)   |                      |
|     aUSDC (All-1)      |    aLINK (All-1)     | aPolMATIC (All-1) |                      |
|   aUSDT (All-0.65M)    |     aSNX (All-1)     |   amDAI (All-1)   |                      |
|    aEthDAI (All-1)     |                      |  aPolUSDC(All-1)  |                      |

Deposit wETH and wBTC in the Treasury into Aave v3.

Assets migrated from Polygon to Ethereum are to be deposited into Aave v3 where practical, with the exception of DAI and USDC which will be swapped to GHO during Part B.

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/24ea0fb8557d38c0acabfe52e0e5750883a1ab1c/src/20240421_Multi_AprilFinanceUpdate/AaveV2Ethereum_AprilFinanceUpdate_20240421.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/24ea0fb8557d38c0acabfe52e0e5750883a1ab1c/src/20240421_Multi_AprilFinanceUpdate/AaveV2Polygon_AprilFinanceUpdate_20240421.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/24ea0fb8557d38c0acabfe52e0e5750883a1ab1c/src/20240421_Multi_AprilFinanceUpdate/AaveV3Gnosis_AprilFinanceUpdate_20240421.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/24ea0fb8557d38c0acabfe52e0e5750883a1ab1c/src/20240421_Multi_AprilFinanceUpdate/AaveV2Ethereum_AprilFinanceUpdate_20240421.t.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/24ea0fb8557d38c0acabfe52e0e5750883a1ab1c/src/20240421_Multi_AprilFinanceUpdate/AaveV2Polygon_AprilFinanceUpdate_20240421.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/24ea0fb8557d38c0acabfe52e0e5750883a1ab1c/src/20240421_Multi_AprilFinanceUpdate/AaveV3Gnosis_AprilFinanceUpdate_20240421.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-april-finance-update/17390)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
