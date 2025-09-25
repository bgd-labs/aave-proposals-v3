---
title: "Steward Deployment: MainnetSwapSteward and RewardsSteward"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-steward-deployment-mainnetswapsteward-and-rewardssteward/23070"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xdc005c2385a548143bbeb35b8bb92e5f0ed29829a445f5e986a2b010bc349c6a"
---

## Simple Summary

We are excited to present the next iteration of Aave’s non-custodial Treasury Management tooling suite. We are expanding the Aave `Finance Steward` role to perform swaps on Ethereum via `MainnetSwapSteward` v1 and claim Liquidity Mining rewards across accrued to the collector across all networks via the `RewardsSteward`. Activating these steward roles will enable Aave DAO to further streamline operations and reduce governance overhead in a secure and safe manner.

## Overview

Following the successful deployment of the Pool Exposure Stewards back in [April](https://vote.onaave.com/proposal/?proposalId=279&ipfsHash=0x0b0274c64c3044960cc136a5c813bb461e40da836c5873e85f99aafd1cd9f813), this publication seeks to deploy the next set of modules that comprise the [Aave Finance Steward](https://governance.aave.com/t/arfc-aave-finance-steward/17570/1).

The Finance Steward role is comprised of a set of Modules (Smart Contracts) that provide approved signers with the ability to perform DAO approved actions such as swapping tokens or migrating assets from Aave V2 to Aave V3, without having to rely on governance.

This publication deploys the MainnetSwapSteward, grants the initial budget for swaps, and deploys the Rewards Stewards to claim earned rewards on a timely manner.

## Motivation

The Finance Steward modules enables the DAO to define a core set of financial capabilities to be carried out within strict role-based guardrails. As the role matures or new use cases arise, we plan to bring forward additional capabilities for the DAO to discuss.

This publication includes deploying two separate contracts. The MainnetSwapSteward is deployed to more easily perform swaps on behalf of the DAO, as well as introducing TWAP Orders on-chain without having to grant an allowance to the AFC, meaning the DAO’s funds never leave the DAO’s possession.

The RewardsSteward grants the stewards the ability to claim Aave rewards to be sent to the collector.

### MainnetSwapSteward

_Regular Orders_

Regular orders of token for token, using Chainlink price oracles and a slippage number. This is the current behavior used in all swaps.

_Limit Orders_

Orders that only execute from a certain price point and only better for the DAO.

_TWAP Orders_

Time weighted average price orders, which are orders that execute over a period of time, with a minimum amount allowed to be received.

_Cancellation of Orders_

The ability to cancel orders if needed or wanted by the DAO.

### RewardsSteward

_ClaimRewards_

Claims specific rewards on behalf of the DAO, which are sent to the collector.

_ClaimAllRewards_

Claims all pending rewards on behalf of the DAO, which are sent to the collector.

## Specification

The RewardsSteward is a permissionless contract that can be called by anyone to claim rewards, but first the ability for that contract to claim rewards must be granted by the Emission Manager by calling `setClaimer()` on the IncentivesController for each deployment, listed below:

| Network   |
| --------- |
| Mainnet   |
| Polygon   |
| Avalanche |
| Optimism  |
| Arbitrum  |
| Scroll    |
| Base      |
| BNB       |
| Gnosis    |
| Sonic     |

The `MainnetSwapSteward` contract has been deployed (with more chains coming in the future), with the DAO as the owner of the contracts and the following SAFE acting as the guardian [0x22740deBa78d5a0c24C58C740e3715ec29de1bFa](https://app.safe.global/home?safe=eth:0x22740deBa78d5a0c24C58C740e3715ec29de1bFa).

The SAFE is configured as a 3-out-of-4 multi-sig, and the signers for the SAFE are the following:

Marc (AaveChan) - `0x329c54289Ff5D6B7b7daE13592C6B1EDA1543eD4`
Matt (TokenLogic) - `0xb647055A9915bF9c8021a684E175A353525b9890`
Chaos Labs - `0x5d49dBcdd300aECc2C311cFB56593E71c445d60d`
Val (LlamaRisk) - `0xbA037E4746ff58c55dc8F27a328C428F258DDACb`

The initial budget (allowance) granted to the SwapSteward via this proposal will be as follows:

| Token | Budget |
| ----- | ------ |
| USDC  | 5M     |
| USDT  | 5M     |
| USDe  | 5M     |
| USDS  | 5M     |
| DAI   | 3M     |
| rlUSD | 1M     |
| LUSD  | 500k   |
| FRAX  | 150k   |
| pyUSD | 20k    |
| UNI   | 15k    |
| MKR   | 100    |
| 1INCH | 50k    |
| ENS   | 200    |
| SNX   | 150k   |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/879609835279f38a6c2b738305118e04891fb125/src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3Ethereum_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/879609835279f38a6c2b738305118e04891fb125/src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3Polygon_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/879609835279f38a6c2b738305118e04891fb125/src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3Avalanche_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/879609835279f38a6c2b738305118e04891fb125/src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3Optimism_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/879609835279f38a6c2b738305118e04891fb125/src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3Arbitrum_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/879609835279f38a6c2b738305118e04891fb125/src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3Base_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/879609835279f38a6c2b738305118e04891fb125/src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3Gnosis_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/879609835279f38a6c2b738305118e04891fb125/src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3Scroll_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/879609835279f38a6c2b738305118e04891fb125/src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3BNB_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.sol), [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/879609835279f38a6c2b738305118e04891fb125/src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3Sonic_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/879609835279f38a6c2b738305118e04891fb125/src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3Ethereum_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/879609835279f38a6c2b738305118e04891fb125/src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3Polygon_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/879609835279f38a6c2b738305118e04891fb125/src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3Avalanche_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/879609835279f38a6c2b738305118e04891fb125/src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3Optimism_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/879609835279f38a6c2b738305118e04891fb125/src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3Arbitrum_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/879609835279f38a6c2b738305118e04891fb125/src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3Base_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/879609835279f38a6c2b738305118e04891fb125/src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3Gnosis_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/879609835279f38a6c2b738305118e04891fb125/src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3Scroll_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/879609835279f38a6c2b738305118e04891fb125/src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3BNB_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.t.sol), [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/879609835279f38a6c2b738305118e04891fb125/src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3Sonic_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xdc005c2385a548143bbeb35b8bb92e5f0ed29829a445f5e986a2b010bc349c6a)
- [Discussion](https://governance.aave.com/t/arfc-steward-deployment-mainnetswapsteward-and-rewardssteward/23070)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
