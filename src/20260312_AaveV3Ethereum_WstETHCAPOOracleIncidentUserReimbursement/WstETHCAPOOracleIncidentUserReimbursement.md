---
title: "wstETH CAPO Oracle Incident User Reimbursement"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-wsteth-capo-oracle-incident-user-reimbursement/24275"
---

## Simple Summary

This proposal refunds users who were erroneously liquidated during the wstETH CAPO oracle misconfiguration incident on Ethereum Core and Prime instances. The total refund amounts to 513.19 ETH, with a net cost to the DAO of 358.56 ETH after recoveries, a figure that should decrease as more recoveries are processed.

## Motivation

A configuration misalignment between the `snapshotRatio` and `snapshotTimestamp` parameters in the wstETH CAPO risk oracle caused the reported wstETH/stETH exchange rate cap to fall approximately 2.85% below the actual market rate. This triggered erroneous liquidations across 34 accounts on the Ethereum Core and Prime instances, totaling ~10,938 wstETH liquidated.

As detailed in the [Post-Mortem](https://governance.aave.com/t/post-mortem-exchange-rate-misallignment-on-wsteth-core-and-prime-instances/24269), the root cause was a mismatch between two interdependent Oracle parameters, `snapshotRatio` and `snapshotTimestamp`. The issue was promptly identified and resolved through Risk Steward intervention.

The affected users bear no responsibility for these liquidations, which were the direct result of a protocol-level configuration error. Making these users whole is a straightforward decision for the DAO and reinforces the trust that underpins Aave's position as the leading lending protocol.

## Loss Breakdown

| Category                          | ETH        |
| --------------------------------- | ---------- |
| Oracle profit (loss to users)     | 382.76     |
| Liquidation bonus (loss to users) | 129.72     |
| Goodwill allowance                | 1          |
| **Total loss**                    | **513.19** |
| Recovered from Titan Builder      | (141.60)   |
| Recovered liquidation fees        | (13.32)    |
| **Net cost to the DAO**           | **358.56** |

Recovery efforts remain ongoing. The DAO is actively pursuing additional funds from builders involved in the incident.

## Specification

Create allowance on the Aave Ethereum Collector for the AFC to distribute refunds to affected users:

- **Method**: `approve()` on the Aave Ethereum Collector
- **Spender**: [AFC](https://etherscan.io/address/0x22740deBa78d5a0c24C58C740e3715ec29de1bFa) `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`
- **Amount**: 513.19 ETH
- **Asset**: [WETH](https://etherscan.io/token/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2) `0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2`

Upon AIP execution, the AFC will distribute the appropriate refund amount to each affected user address.

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/a93ce7ec2ed3a2df946f6add33b9951bb022d9dc/src/20260312_AaveV3Ethereum_WstETHCAPOOracleIncidentUserReimbursement/AaveV3Ethereum_WstETHCAPOOracleIncidentUserReimbursement_20260312.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/a93ce7ec2ed3a2df946f6add33b9951bb022d9dc/src/20260312_AaveV3Ethereum_WstETHCAPOOracleIncidentUserReimbursement/AaveV3Ethereum_WstETHCAPOOracleIncidentUserReimbursement_20260312.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-wsteth-capo-oracle-incident-user-reimbursement/24275)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
