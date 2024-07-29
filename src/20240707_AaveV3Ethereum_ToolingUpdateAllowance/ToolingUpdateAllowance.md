---
title: "Treasury Tooling Payment"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-treasury-management-tooling-upgrade/15201"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x461571b38365b12ebe39b80d4d9663daa9c7e574cd4bf190ec6fb48dec96371f"
---

# Summary

This AIP grants payment to TokenLogic for 12,430 GHO for delivery of three asset bridging contracts.

# Motivation

For the Aave DAO to move assets between networks, intermediary contracts are required to link each Treasury to a preferred bridge, enabling assets to move between Treasury addresses. TokenLogic was engaged by Aave DAO to provide these intermediary bridging contracts, connecting Arbitrum, Optimism, and Avalanche to Ethereum.

Due to technical considerations relating to the Avalanche bridge itself, the Avalanche-related scope was substituted with Polygon's Plasma bridge. The contracts developed by TokenLogic have been peer-reviewed and are in the process of being used for various funding proposals.

The internal Aave asset bridging contracts are linked below:

- [Optimism Bridge](https://github.com/bgd-labs/aave-helpers/pull/304)
- [Arbitrum Bridge](https://github.com/bgd-labs/aave-helpers/pull/209)
- [Plasma Bridge](https://github.com/bgd-labs/aave-helpers/pull/261)

The Plasma contract was used within the [April Funding Update](https://app.aave.com/governance/v3/proposal/?proposalId=103) and both the Optimism and Arbitrum contracts within the [May Funding Update](https://github.com/bgd-labs/aave-proposals-v3/pull/370) proposal.

# Specification

Create an Allowance for 12,430 GHO to the following address.

TokenLogic: `0x3e4A9f478C0c13A15137Fc81e9d8269F127b4B40`

# References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/ca87247401e8c2a38cf03f751ac197869c63daaf/src/20240707_AaveV3Ethereum_ToolingUpdateAllowance/AaveV3Ethereum_ToolingUpdateAllowance_20240707.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/ca87247401e8c2a38cf03f751ac197869c63daaf/src/20240707_AaveV3Ethereum_ToolingUpdateAllowance/AaveV3Ethereum_ToolingUpdateAllowance_20240707.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x461571b38365b12ebe39b80d4d9663daa9c7e574cd4bf190ec6fb48dec96371f)
- [Discussion](https://governance.aave.com/t/arfc-treasury-management-tooling-upgrade/15201)

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
