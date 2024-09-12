---
title: "Harmonize weETH Parameters"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-harmonize-weeth-parameters/19012"
snapshot: "Direct-To-AIP"
---

## Simple Summary

This proposal aims to harmonize weETH parameters across all networks where it is supported.

## Motivation

This proposal aims to harmonize weETH parameters across all networks where it is supported.

The key changes include:

Setting the base variable borrow rate for weETH to 1%
Adjusting the Reserve Factor (RF) to 45% on all networks
Setting the optimal utilization ratio to 30%
The primary motivations for these parameter adjustments are:

**Increased Revenue for the DAO**: By harmonizing these parameters, particularly the increase in the Reserve Factor, we can generate additional revenue for the Aave DAO.

**Improved External Liquidity**: The proposed changes, especially the adjustment of the optimal utilization ratio, are expected to enhance the external liquidity of weETH. This improvement in liquidity can lead to more efficient liquidity and better capital utilization within the Aave ecosystem.

**Consistency Across Networks**: By standardizing these parameters across all networks where weETH is supported, we create a more uniform and predictable environment for users and integrators. This consistency will lead to improved user experience and easier management of the asset across different networks.

These changes represent a balanced approach to optimizing the performance of weETH within the Aave protocol, benefiting both the DAO and its users while maintaining weETH’s attractiveness and utility

## Specification

On all networks, change weETH parameters to:

- Base variable borrow rate for weETH to 1%
- Adjusting the Reserve Factor (RF) to 45%
- Setting the optimal utilization ratio to 30%

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/0dc19277b2a0817c3e90f718ab688f400b4b2318/src/20240911_Multi_HarmonizeWeETHParameters/AaveV3Ethereum_HarmonizeWeETHParameters_20240911.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/0dc19277b2a0817c3e90f718ab688f400b4b2318/src/20240911_Multi_HarmonizeWeETHParameters/AaveV3Arbitrum_HarmonizeWeETHParameters_20240911.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/0dc19277b2a0817c3e90f718ab688f400b4b2318/src/20240911_Multi_HarmonizeWeETHParameters/AaveV3Base_HarmonizeWeETHParameters_20240911.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/0dc19277b2a0817c3e90f718ab688f400b4b2318/src/20240911_Multi_HarmonizeWeETHParameters/AaveV3Scroll_HarmonizeWeETHParameters_20240911.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/0dc19277b2a0817c3e90f718ab688f400b4b2318/src/20240911_Multi_HarmonizeWeETHParameters/AaveV3Ethereum_HarmonizeWeETHParameters_20240911.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/0dc19277b2a0817c3e90f718ab688f400b4b2318/src/20240911_Multi_HarmonizeWeETHParameters/AaveV3Arbitrum_HarmonizeWeETHParameters_20240911.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/0dc19277b2a0817c3e90f718ab688f400b4b2318/src/20240911_Multi_HarmonizeWeETHParameters/AaveV3Base_HarmonizeWeETHParameters_20240911.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/0dc19277b2a0817c3e90f718ab688f400b4b2318/src/20240911_Multi_HarmonizeWeETHParameters/AaveV3Scroll_HarmonizeWeETHParameters_20240911.t.sol)
- [Snapshot](Direct-To-AIP)
- [Discussion](https://governance.aave.com/t/arfc-harmonize-weeth-parameters/19012)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
