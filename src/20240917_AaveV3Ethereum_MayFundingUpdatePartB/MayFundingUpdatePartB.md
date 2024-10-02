---
title: "May Funding Update Part B"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-may-funding-update/17768/5"
snapshot: "Direct-to-AIP"
---

## Simple Summary

This AIP will deposit idle assets and migrate v2 treasury holdings to Aave v3 on Ethereum. This AIP also executes the [Request for Bounty Payout - September 2024](https://governance.aave.com/t/bgd-request-for-bounty-payout-september-2024/19256).

## Motivation

This AIP furthers the ongoing migration of Aave DAO Treasury assets from v2 to v3. Additionally, it proposes depositing assets currently not generating yield, which are held in the Treasury from previous funding proposals, into Aave v3 on Ethereum.

## Specification

This AIP will implement the following when executes:

- Deposit idle assets into Aave v3:
  - USDC
  - DAI
  - USDT
  - wETH
- Migrate the following assets from v2 to v3 main market:
  - All aUSDT excluding 200k
  - All aDAI excluding 1
  - All aUSDC excluding 1
  - All awETH excluding 1

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240917_AaveV3Ethereum_MayFundingUpdatePartB/AaveV3Ethereum_MayFundingUpdatePartB_20240917.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240917_AaveV3Ethereum_MayFundingUpdatePartB/AaveV3Ethereum_MayFundingUpdatePartB_20240917.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-may-funding-update/17768/5)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
