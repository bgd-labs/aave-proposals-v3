---
title: " Adjusting Interest Rate Curve for weETH on Arbitrum"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-adjusting-interest-rate-curve-for-weeth-on-arbitrum/17804"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xed2fd3dfee1f29f04b6cda4a5c4629fcca32a5c961b1b3e2a49ba6842367ce31"
---

## Simple Summary

The current proposal suggests adjusting the Interest Rate Curve for weETH on Arbitrum network to align with the mainnet, so Risk Parameters will be the same for weETH on Mainnet, Arbitrum, and Base networks.

The aim is to optimize the utilization rates and improve revenue for the DAO.

## Motivation

By adjusting the Interest Rate Curve and updating the RF, we aim to encourage Increase efficiency and optimize DAO revenue for the weETH asset.

## Specification

Change Arbitrum Risk Parameters for weETH to align with Mainnet & Base.

**Proposed Changes:**

| Parameter      | Value  |
| -------------- | ------ |
| Uoptimal       | 35.00% |
| Reserve Factor | 45.00% |

## References

- Implementation: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/15298f4d41cd6165cc15d9c03d49c9affa7bbb4b/src/20240603_AaveV3Arbitrum_AdjustingInterestRateCurveForWeETHOnArbitrum/AaveV3Arbitrum_AdjustingInterestRateCurveForWeETHOnArbitrum_20240603.sol)
- Tests: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/15298f4d41cd6165cc15d9c03d49c9affa7bbb4b/src/20240603_AaveV3Arbitrum_AdjustingInterestRateCurveForWeETHOnArbitrum/AaveV3Arbitrum_AdjustingInterestRateCurveForWeETHOnArbitrum_20240603.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xed2fd3dfee1f29f04b6cda4a5c4629fcca32a5c961b1b3e2a49ba6842367ce31)
- [Discussion](https://governance.aave.com/t/arfc-adjusting-interest-rate-curve-for-weeth-on-arbitrum/17804)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
