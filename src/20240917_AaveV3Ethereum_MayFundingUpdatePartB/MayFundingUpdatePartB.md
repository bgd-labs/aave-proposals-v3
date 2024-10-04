---
title: "May Funding Update Part B"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-may-funding-update/17768/5"
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
- Pay the following bug bounties:
  - $500 to 0x1770776deB0A5CA58439759FAdb5cAA014501241
  - $1’000 to 0x7dF98A6e1895fd247aD4e75B8EDa59889fa7310b
  - $150 to 0x7119f398b6C06095c6E8964C1f58e7C1BAa79E18 (immunefi.eth). This is the fee corresponding to the 10% of the previous bounties.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/6b9228328a9aee78b9a1706862c01a593ca80cc6/src/20240917_AaveV3Ethereum_MayFundingUpdatePartB/AaveV3Ethereum_MayFundingUpdatePartB_20240917.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/6b9228328a9aee78b9a1706862c01a593ca80cc6/src/20240917_AaveV3Ethereum_MayFundingUpdatePartB/AaveV3Ethereum_MayFundingUpdatePartB_20240917.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-may-funding-update/17768/5)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
