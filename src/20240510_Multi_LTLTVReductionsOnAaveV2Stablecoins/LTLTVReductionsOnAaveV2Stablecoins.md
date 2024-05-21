---
title: "LT/LTV Reductions on Aave V2 Stablecoins"
author: "ChaosLabs"
discussions: "https://governance.aave.com/t/arfc-lt-ltv-reductions-on-aave-v2-stablecoins/17508"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xe3a29b7d6d936a22ee340811f842a29e4be654e08972f53f43dde7748c722195"
---

# Summary

A proposal to reduce LT and LTV for major stablecoins on Aave V2

# Motivation

Following our [ongoing reduction](https://governance.aave.com/t/generalized-lt-ltv-reduction-on-aave/16766) of stablecoin LTs and LTVs on Aave V3 markets, we propose reducing LTs and LTVs on V2 to limit risks posed by the current parameters and align them closer to V3’s parameters.

It is important to note that in some cases, it is difficult to reduce LTs because of users looping assets with themselves. For example, on Ethereum, there are 58 wallets that are both supplying and borrowing more than 10,000 USDC. This leads us to recommend two different options on which the community can decide: a more aggressive LT reduction, which will result in more liquidations but help reduce LT more quickly and a conservative LT reduction, which will prioritize limiting liquidations. For all options, we recommend decreasing LTV to the target of 75%.

## LT/LTV Reduction

The overall goal of our stablecoin LT/LTV reduction is the same as on V3, ultimately achieving the following parameters:

| Final LTV | Final LT |
| --------- | -------- |
| 75.00%    | 78.00%   |

**_USDC (Ethereum)_**

Currently, reducing LT would require inducing a significant number of liquidations; a reduction of just 0.50% would create $137K in new liquidations, and a 2% reduction would create $200K in new liquidations. This is largely caused by two users ([1](https://community.chaoslabs.xyz/aave-v2/risk/wallets/0xb60bda0bab52839a3334bd849d2afb2aa566e631), [2](https://community.chaoslabs.xyz/aave-v2/risk/wallets/0xf451d30a7ac2e56f52a36825b155b0ac1fb7a867)), both of whom are looping USDC with itself. Thus, our conservative proposal is not adjusting LT, while the aggressive calls for reducing it by 0.50%.

| Asset        | Value Liquidated ($) | Accounts Liquidated |
| ------------ | -------------------- | ------------------- |
| Conservative | -                    | -                   |
| Aggressive   | 137.3K               | 10                  |

_USDC.e (Polygon)_

Similar to USDC on Ethereum, it is difficult to reduce the LT without inducing large liquidations, thus the conservative proposal calls for a reduction to 84.50%.

The three largest potential liquidations ([1](https://community.chaoslabs.xyz/aave-v2/risk/wallets/0xb3095b2861fba8ebcfd199546ce9488c75676850),[2](https://community.chaoslabs.xyz/aave-v2/risk/wallets/0x299b189f47838ee8ebb630c3024bb1cd9f109ee8),[3](https://community.chaoslabs.xyz/aave-v2/risk/wallets/0x818b84cc4c3012cb6b36bfb627fd82438718fc7c)), representing the majority of new value eligible for liquidation, are all wallets that are looping USDC.e with itself.

The more aggressive approach would reduce LT to 83% and potentially induce $103K worth of liquidations.

| Asset        | Value Liquidated ($) | Accounts Liquidated |
| ------------ | -------------------- | ------------------- |
| Conservative | 10K                  | 45                  |
| Aggressive   | 103K                 | 235                 |

_USDC.e (Avalanche)_

Our approach involves reducing USDC.e’s LT to 78%, inducing $10,300 worth of liquidations across 11 new wallets.

Again, the largest liquidation would be a [user](https://community.chaoslabs.xyz/aave-v2/risk/wallets/0xdb815d4071c3d8b2ebec6c003f30bfbfa6a5d8b8) who is looping USDC.e. This would bring the market in line with our final parameters, and thus there is no need for an aggressive proposal.

# Specification

## LT/LTV Reduction

As per the community Snaphsot vote, this proposal adopts the conservative recommendations:

| Chain     | Asset  | Current LTV | Rec. LTV  | Current LT | Rec LT    |
| --------- | ------ | ----------- | --------- | ---------- | --------- |
| Ethereum  | USDC   | 80.00%      | 75.00%    | 87.50%     | No Change |
| Polygon   | USDC.e | 80.00%      | 75.00%    | 85.00%     | 84.50%    |
| Avalanche | USDC.e | 75.00%      | No Change | 80.00%     | 78%       |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240510_Multi_LTLTVReductionsOnAaveV2Stablecoins/AaveV2Ethereum_LTLTVReductionsOnAaveV2Stablecoins_20240510.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240510_Multi_LTLTVReductionsOnAaveV2Stablecoins/AaveV2Polygon_LTLTVReductionsOnAaveV2Stablecoins_20240510.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240510_Multi_LTLTVReductionsOnAaveV2Stablecoins/AaveV2Avalanche_LTLTVReductionsOnAaveV2Stablecoins_20240510.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240510_Multi_LTLTVReductionsOnAaveV2Stablecoins/AaveV2Ethereum_LTLTVReductionsOnAaveV2Stablecoins_20240510.t.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240510_Multi_LTLTVReductionsOnAaveV2Stablecoins/AaveV2Polygon_LTLTVReductionsOnAaveV2Stablecoins_20240510.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240510_Multi_LTLTVReductionsOnAaveV2Stablecoins/AaveV2Avalanche_LTLTVReductionsOnAaveV2Stablecoins_20240510.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xe3a29b7d6d936a22ee340811f842a29e4be654e08972f53f43dde7748c722195)
- [Discussion](https://governance.aave.com/t/arfc-lt-ltv-reductions-on-aave-v2-stablecoins/17508)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
