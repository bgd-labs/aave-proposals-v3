---
title: "SUSD risk parameters update"
author: "Chaos Labs, ACI"
discussions: "https://governance.aave.com/t/susd-depeg-update-05-16-2024/17719"
---

## Simple Summary

This proposal is to update the risk parameters of the SUSD asset on Aave V3 Optimism.

## Motivation

The SUSD asset has been experiencing a depegging issue. This proposal aims to update the risk parameters of the SUSD asset to mitigate risk for the Aave protocol.

## Specification

Contract address: [0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9](https://optimistic.etherscan.io/address/0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9)

| Chain       | Asset | Current LTV | Rec. LTV |
| ----------- | ----- | ----------- | -------- |
| Optimism V3 | sUSD  | 60.00%      | 0%       |

## References

- Implementation: [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240517_AaveV3Optimism_SUSDRiskParametersUpdate/AaveV3Optimism_SUSDRiskParametersUpdate_20240517.sol)
- Tests: [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240517_AaveV3Optimism_SUSDRiskParametersUpdate/AaveV3Optimism_SUSDRiskParametersUpdate_20240517.t.sol)
- [Discussion](https://governance.aave.com/t/susd-depeg-update-05-16-2024/17719)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
