---
title: "Treasury Management - GSM Funding & RWA Strategy Preparations (Part 1)"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/gho-stability-module-update/14442/10"
---

## Simple Summary

In preparation for launching the GHO Stability Module (GSM) and the $1M RWA strategy with Centirfuge, this publication seeks to make available the necessary amount of USDC, USDT and DAI available on Ethereum.

# Motivation

The GSM is in the late stages of audit and is expected to be available for deployment in the near future. The Centrifuge proposal is currently mid way through the review process. The current stable coin holdings on Ethereum are insufficient to support both the GSM, RWA strategy and Service Provider (SP) commitments. Additional funds are needed on Ethereum to support the GSM.

The [largest most recent GSM funding requested](https://governance.aave.com/t/gho-stability-module-update/14442/10) consisted of the following:

- 3.5M USDC
- 3.5M USDT

The RWA Strategy is valued at [1M](https://governance.aave.com/t/arfc-aave-treasury-rwa-allocation/14790) of USDC funding.

The expected aEthUSDC and aEthUSDT Reserve Holding, post Aave Funding Part B being implemented, is as shown below:

- 3.0M aEthUSDC (376,900 current holding plus Aave Funding Part B)
- 0.4M aEthUSDT (current holding plus)

It is clear from comparing the numbers above, there is a need to add to the aEthUSDC and aEthUSDT holdings in order to fullfill the GSM and RWA Strategy commitments.

Tapping into the aUSDT and aUSDC holdings is not enough as the current aUSDT (Aave v2) is only sufficient to cover 1 years runway and all the aUSDC will already migrated to aEthUSDC upon implementing Aave Funding Part B.

The aEthDAI reserve holds sufficient funds to cover any [ImmuneFi Bug Bounty Program](ipns://app.aave.com/governance/proposal/325/), sustain [BGDLabs stream](ipns://app.aave.com/governance/proposal/311/), support this [bug bounty](https://governance.aave.com/t/bgd-request-for-bounty-payout-december-2023/15826) and this [adhoc security request](https://governance.aave.com/t/arfc-bgd-security-budget-request-december-2023/15783).

At the time of writing, it is only possible to move funds between the Polygon and Ethereum Treasuries via on-chain governance. The below summaries the expected Polygon Treasury holdings based upon this [migration PR](https://github.com/bgd-labs/aave-proposals-v3/pull/126) being implemented.

- 2.4M aPolUSDC
- 1.5M aPolDAI
- 0.8M aPolUSDT

There is sufficient funds on Polygon to cover the immediate needs of the GHO GSM.

In addition to the above, this proposal also contains a small bit of house keeping that includes setting two legacy aUSDC Allowances to zero. Whilst the funds mentioned can not be claimed, they are currently showing as available when querying the Allowance ([10.](https://etherscan.io/address/0xBcca60bB61934080951369a648Fb03DF4F96263C#readProxyContract)) balance.

The two allowances, 174k and 196k, are legacy from previous [CRV](https://app.aave.com/governance/proposal/146) and [BAL](https://app.aave.com/governance/proposal/115) bonding curve deployments respectively.

# Specification

Part A of this proposal will perform the following:

- Withdraw all amUSDC & aPolUSDC from Polygon V2 and V3
- Withdraw all amDAI & aPolDAI from Polygon V2 and V3
- Withdraw all amUSDT & aPolUSDT from Polygon V2 and V3
- Bridge all withdrawn assets to Ethereum

The following [aUSDC](https://etherscan.io/address/0xBcca60bB61934080951369a648Fb03DF4F96263C) Allowances are to set to zero on Ethereum mainnet:

- approve(0x04f90d449D4f8316eDd6Ef4F963b657f8444a4cA,0)
- approve(0x46a1b7d4a2920270c7eb2c2db4df2259a109bcb4,0)

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231229_Multi_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1/AaveV2Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231229_Multi_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1/AaveV3Polygon_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231229_Multi_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1/AaveV2Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231229_Multi_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1/AaveV3Polygon_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229.t.sol)
- [Snapshot](TODO)
- [Discussion](https://governance.aave.com/t/gho-stability-module-update/14442/10)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
