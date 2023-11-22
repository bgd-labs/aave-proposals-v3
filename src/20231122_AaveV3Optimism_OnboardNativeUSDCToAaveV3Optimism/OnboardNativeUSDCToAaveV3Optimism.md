---
title: "Onboard Native USDC to Aave V3 Optimism"
author: "@marczeller - Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboard-native-usdc-to-aave-v3-optimism-market/15463"
---

## Simple Summary

This ARFC proposes integrating native USDC into the Aave V3 pool on Optimism, positioning it as the primary stablecoin version over the bridged USDC.e.

## Motivation

With the evolution of L2 networks, adopting native USDC versions becomes vital for efficiency. This proposal seeks a balanced transition from USDC.e to native USDC on Optimism, drawing from similar successful integrations on other networks.

## Specification

### Token Information

- **Token Symbol:** USDC
- **Token Address:** [0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85](https://optimistic.etherscan.io/address/0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85)

### Parameters

- **Supply Cap:**
  - USDC: 25M
  - USDC.e: 25M
- **Borrow Cap:**
  - USDC: 20M
  - USDC.e: 20M
- **Reserve Factor (RF):**
  - USDC.e: Increase to 20% to incentivize native USDC usage.

All other risk parameters for native USDC will mirror those of USDC.e.

## References

- Implementation: [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/84cee62f8de8e53c7459e7f30297e06c70f8b7d6/src/20231122_AaveV3Optimism_OnboardNativeUSDCToAaveV3Optimism/AaveV3Optimism_OnboardNativeUSDCToAaveV3Optimism_20231122.sol)
- Tests: [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/84cee62f8de8e53c7459e7f30297e06c70f8b7d6/src/20231122_AaveV3Optimism_OnboardNativeUSDCToAaveV3Optimism/AaveV3Optimism_OnboardNativeUSDCToAaveV3Optimism_20231122.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xf04fdb85e27849310557716d09fb2ed7f84b1a8c4f493088899ad91a2d834fb0)
- [Discussion](https://governance.aave.com/t/arfc-onboard-native-usdc-to-aave-v3-optimism-market/15463)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
