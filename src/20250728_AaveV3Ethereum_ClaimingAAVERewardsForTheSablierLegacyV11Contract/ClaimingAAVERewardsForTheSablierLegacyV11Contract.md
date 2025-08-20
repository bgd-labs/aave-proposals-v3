---
title: "Claiming AAVE Rewards for the Sablier Legacy v1.1 Contract"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-claiming-aave-rewards-for-the-sablier-legacy-v1-1-contract/21975"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xd0d6ae015476ab371ea10e68ce270af05f45ec4ebcb105a8d573f606277956e1"
---

## Simple Summary

This AIP proposes the transfer of **895.8057 AAVE** (~$160K) in staking rewards from the Aave Safety Module to **[sablier.eth](https://etherscan.io/address/0x5cE95bff1297dADBDcF9929a10Bd02BDfab0DCC6)**, due to the inability of Sablier’s Legacy v1.1 contract to claim them through standard mechanisms.

## Motivation

Sablier Legacy v1.1 is a non-upgradeable smart contract that lacks an ERC-20 recovery or sweeping function. Over time, the contract has accrued staking rewards from participation in the Aave Safety Module. However, due to its immutable design and lack of reward-claiming logic, these tokens are currently inaccessible.

To prevent permanent loss of funds, this proposal seeks governance approval to manually transfer the AAVE rewards to the Sablier treasury ([sablier.eth](https://etherscan.io/address/0x5cE95bff1297dADBDcF9929a10Bd02BDfab0DCC6)), ensuring recovery of assets legitimately earned.

**Supporting context:**

* The contract is publicly documented in [Sablier’s official documentation](https://docs.sablier.com/guides/legacy/deployments).
* Source code is verified on [Etherscan](https://etherscan.io/address/0xCD18eAa163733Da39c232722cBC4E8940b1D8888) and open-source on [GitHub](https://github.com/sablier-labs/legacy-contracts/blob/%40sablier/protocol%401.1.0/packages/protocol/contracts/Sablier.sol).

## Specification

This proposal calls **`claimRewardsOnBehalf()`** on [0xCD18eAa163733Da39c232722cBC4E8940b1D8888](https://etherscan.io/address/0xCD18eAa163733Da39c232722cBC4E8940b1D8888) and then transfer [895805689180182547296](https://etherscan.io/unitconverter?wei=895805689180182547296) wei of AAVE collected to [sablier.eth](https://etherscan.io/address/0x5cE95bff1297dADBDcF9929a10Bd02BDfab0DCC6)

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250728_AaveV3Ethereum_ClaimingAAVERewardsForTheSablierLegacyV11Contract/AaveV3Ethereum_ClaimingAAVERewardsForTheSablierLegacyV11Contract_20250728.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250728_AaveV3Ethereum_ClaimingAAVERewardsForTheSablierLegacyV11Contract/AaveV3Ethereum_ClaimingAAVERewardsForTheSablierLegacyV11Contract_20250728.t.sol)
  [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xd0d6ae015476ab371ea10e68ce270af05f45ec4ebcb105a8d573f606277956e1)
- [Discussion](https://governance.aave.com/t/arfc-claiming-aave-rewards-for-the-sablier-legacy-v1-1-contract/21975)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
