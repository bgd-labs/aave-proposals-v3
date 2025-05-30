---
title: "May Funding Part B"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-may-2025-funding-update/21906/5"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x4dfc398fabb63305900572dff38b2ff8e104b0710077f6b7e48049de173d186b"
---

## Simple Summary

This publication finalizes the May Funding Update and provides the funding required to support the upcoming Base Incentive Campaign, which includes the following key components:

- Allocation for Base Incentive Campaign allowances;
- Allowances for Merit and Ahab contributors; and,
- Consolidation of funds from the Collector.

## Motivation

This publication outlines several near-term operational actions required to support both ongoing and upcoming initiatives. Specifically, it includes the following components:

**Base Incentive Campaign**
Upon execution, this AIP will establish the necessary allowances on both Ethereum and Base networks, enabling the Aave Finance Committee (AFC) to transfer funds from the Collector to the AFC SAFE. From there, the AFC will periodically disburse funds to the ACI team for the implementation of the Base Incentive Campaign.

**Asset Consolidation**
Consistent with previous AIPs, this proposal facilitates the conversion of DAI, aDAI, and aEthDAI balances held in the Collector into USDS. The converted USDS will be deposited into Aave v3 to generate yield on idle assets.

**Ahab and Merit Incentive Programs**
The current budgets for the Merit and Ahab programs are due for renewal. Upon execution, this AIP will extend funding for both programs through May, June, and July to ensure continued operation and alignment with ACI’s incentive framework.

## Specification

Base:

The payload creates the following allowances.

| Token      | Amount                | Recipient                                                                                                             |
| ---------- | --------------------- | --------------------------------------------------------------------------------------------------------------------- |
| aBaseUSDC  | ALL Collector Balance | [0x22740deBa78d5a0c24C58C740e3715ec29de1bFa](https://basescan.org/address/0x22740deBa78d5a0c24C58C740e3715ec29de1bFa) |
| aBaseCbBTC | ALL Collector Balance | [0x22740deBa78d5a0c24C58C740e3715ec29de1bFa](https://basescan.org/address/0x22740deBa78d5a0c24C58C740e3715ec29de1bFa) |
| aBaseUSDbC | ALL Collector Balance | [0x22740deBa78d5a0c24C58C740e3715ec29de1bFa](https://basescan.org/address/0x22740deBa78d5a0c24C58C740e3715ec29de1bFa) |

Ethereum:

The payload creates the following allowances.

| Token       | Amount                | Recipient                                                                                                             |
| ----------- | --------------------- | --------------------------------------------------------------------------------------------------------------------- |
| aEthLidoGHO | 3,000,000             | [0xdeadD8aB03075b7FBA81864202a2f59EE25B312b](https://etherscan.io/address/0xdeadD8aB03075b7FBA81864202a2f59EE25B312b) |
| aEthWETH    | 800                   | [0xdeadD8aB03075b7FBA81864202a2f59EE25B312b](https://etherscan.io/address/0xdeadD8aB03075b7FBA81864202a2f59EE25B312b) |
| aEthUSDC    | 2,400,000             | [0x22740deBa78d5a0c24C58C740e3715ec29de1bFa](https://etherscan.io/address/0x22740deBa78d5a0c24C58C740e3715ec29de1bFa) |
| RAI         | ALL Collector Balance | [0x22740deBa78d5a0c24C58C740e3715ec29de1bFa](https://etherscan.io/address/0x22740deBa78d5a0c24C58C740e3715ec29de1bFa) |
| CRV         | ALL Collector Balance | [0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b](https://etherscan.io/address/0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b) |
| BAL         | ALL Collector Balance | [0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b](https://etherscan.io/address/0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b) |

Migrates TokenLogic stream to new SAFE: [`0xAA088dfF3dcF619664094945028d44E779F19894`](https://etherscan.io/address/0xAA088dfF3dcF619664094945028d44E779F19894)

Withdraws all aDAI, aEthDAI and couples with the collector's DAI to migrate all to USDS via the Spark migration contract.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250524_Multi_MayFundingPartB/AaveV3Ethereum_MayFundingPartB_20250524.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250524_Multi_MayFundingPartB/AaveV3Base_MayFundingPartB_20250524.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250524_Multi_MayFundingPartB/AaveV3Ethereum_MayFundingPartB_20250524.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250524_Multi_MayFundingPartB/AaveV3Base_MayFundingPartB_20250524.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x4dfc398fabb63305900572dff38b2ff8e104b0710077f6b7e48049de173d186b)
- [Discussion](https://governance.aave.com/t/arfc-may-2025-funding-update/21906/5)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
