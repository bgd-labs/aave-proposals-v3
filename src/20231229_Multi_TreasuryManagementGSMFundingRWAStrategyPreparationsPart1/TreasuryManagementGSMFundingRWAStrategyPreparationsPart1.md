---
title: "Treasury Management - GSM Funding & RWA Strategy Preparations (Part 1), Frontier Staking as a Service"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/gho-stability-module-update/14442/10"
---

## Simple Summary

In preparation for launching the GHO Stability Module (GSM) and the $1M RWA strategy with Centirfuge, this publication seeks to make available the necessary amount of USDC, USDT and DAI on Ethereum.

# Motivation

The GSM is expected to be available for deployment in the near future. The Centrifuge proposal is currently mid way through the review process. The current stable coin holdings on Ethereum are insufficient to support both the GSM, RWA strategy and Service Provider (SP) commitments. Additional funds are needed on Ethereum to support the GSM.

In addition to the above, this proposal also contains a small bit of house keeping that includes setting two legacy aUSDC Allowances to zero. Whilst the funds mentioned can not be claimed, they are currently showing as available when querying the Allowance ([10.](https://etherscan.io/address/0xBcca60bB61934080951369a648Fb03DF4F96263C#readProxyContract)) balance.

The two allowances, 174k and 196k, are legacy from previous [CRV](https://app.aave.com/governance/proposal/146) and [BAL](https://app.aave.com/governance/proposal/115) bonding curve deployments respectively.

# Specification

Part A of this proposal will perform the following:

- Withdraw all amUSDC & aPolUSDC from Polygon V2 and V3
- Withdraw all amDAI from Polygon V2
- Withdraw 1.0M amPolDAI from Polygon V3
- Withdraw all amUSDT & aPolUSDT from Polygon V2 and V3
- Bridge all withdrawn assets to Ethereum

_note_ When withdrawing all units from pools, in actuality, 10 units will be left as to not empty the pool.

- Withdraw 128 aWETH from Ethereum V2
- The received 128 wETH is to be withdrawn into ETH
- Transfer the 128 ETH to SAFE address: 0xCDb4fA6ba08bF1FB7Aa9fDf6002E78EDc431a642 as part of the "Frontier" [initiative](https://governance.aave.com/t/arfc-introducing-frontier-staking-as-a-service-for-the-aave-dao/16225). The snapshot for Frontier can be found [here](https://snapshot.org/#/aave.eth/proposal/0x6fc11878e04e6bd26def1077115f67294c7a4cb0b91d4c4eacfa4e036791cfef).

Revoke the following allowances for the Aave Collector on Mainnet:

`IERC20Token.approve(spender, 0);`

| token | spender                                    | description                  |
| ----- | ------------------------------------------ | ---------------------------- |
| aENS  | 0xa426759e433224c2b04f6619ab44217dad626c6e | Aave Collector Consolidation |
| aMANA | 0xa426759e433224C2b04f6619aB44217DaD626c6e | Aave Collector Consolidation |
| aUST  | 0xa426759e433224c2b04f6619ab44217dad626c6e | Aave Collector Consolidation |
| sUSD  | 0xa426759e433224c2b04f6619ab44217dad626c6e | Aave Collector Consolidation |
| aUSDC | 0x04f90d449d4f8316edd6ef4f963b657f8444a4ca | One Way Bonding Curve        |
| aRAI  | 0xa426759e433224C2b04f6619aB44217DaD626c6e | Aave Collector Consolidation |
| aZRX  | 0xa426759e433224C2b04f6619aB44217DaD626c6e | Aave Collector Consolidation |
| aAMPL | 0xa426759e433224C2b04f6619aB44217DaD626c6e | Aave Collector Consolidation |
| aSUSD | 0xa426759e433224C2b04f6619aB44217DaD626c6e | Aave Collector Consolidation |
| aUSDC | 0x46a1b7d4a2920270c7eb2c2db4df2259a109bcb4 | CRV Bad Debt Repayment       |
| TUSD  | 0xa426759e433224c2b04f6619ab44217dad626c6e | Aave Collector Consolidation |
| BUSD  | 0xa426759e433224c2b04f6619ab44217dad626c6e | Aave Collector Consolidation |
| aTUSD | 0xa426759e433224C2b04f6619aB44217DaD626c6e | Aave Collector Consolidation |
| aDPI  | 0xa426759e433224C2b04f6619aB44217DaD626c6e | Aave Collector Consolidation |
| aFRAX | 0xa426759e433224C2b04f6619aB44217DaD626c6e | Aave Collector Consolidation |
| aBUSD | 0xa426759e433224C2b04f6619aB44217DaD626c6e | Aave Collector Consolidation |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231229_Multi_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1/AaveV2Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231229_Multi_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1/AaveV3Polygon_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231229_Multi_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1/AaveV2Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231229_Multi_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1/AaveV3Polygon_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb39537e468eef8c212c67a539cdc6d802cd857f186a4f66aefd44faaadd6ba19)
- [Discussion](https://governance.aave.com/t/arfc-treasury-management-gsm-funding-rwa-strategy-preparations/16128)

## Disclaimer

TokenLogic and karpatkey receive no compensation beyond Aave protocol for the creation of this proposal. TokenLogic and karpatkey are both delegates within the Aave ecosystem.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
