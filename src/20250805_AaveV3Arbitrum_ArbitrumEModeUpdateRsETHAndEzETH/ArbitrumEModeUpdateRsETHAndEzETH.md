---
title: "Arbitrum eMode Update - rsETH and ezETH"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-arbitrum-emode-update-rseth-and-ezeth/22731"
---

### Summary

This publication proposes updating the ezETH and rsETH eMode categories on Arbitrum

### Motivation

In preparation for the upcoming DRIPs campaign on Arbitrum, this publication proposes enabling Kelp and Renzo Liquid Restaking Tokens (LRTs) access to ETH via existing v3.2 eModes.

Upon implementing this proposal, weETH, rsETH and ezETH will each have the same LTV and LT for borrowing wstETH and ETH on Arbitrum.

### Specification

#### Update rsETH/WETH eMode

| **Parameter**             | **Value**    |
| ------------------------- | ------------ |
| **Collateral**            | rsETH        |
| **Borrowable**            | wstETH, wETH |
| **Max LTV**               | 93.00%       |
| **Liquidation Threshold** | 95.00%       |
| **Liquidation Penalty**   | 1.00%        |

#### Update ezETH/WETH eMode

| **Parameter**             | **Value**    |
| ------------------------- | ------------ |
| **Collateral**            | rsETH        |
| **Borrowable**            | wstETH, wETH |
| **Max LTV**               | 93.00%       |
| **Liquidation Threshold** | 95.00%       |
| **Liquidation Penalty**   | 1.00%        |

## References

- Implementation: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250805_AaveV3Arbitrum_ArbitrumEModeUpdateRsETHAndEzETH/AaveV3Arbitrum_ArbitrumEModeUpdateRsETHAndEzETH_20250805.sol)
- Tests: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250805_AaveV3Arbitrum_ArbitrumEModeUpdateRsETHAndEzETH/AaveV3Arbitrum_ArbitrumEModeUpdateRsETHAndEzETH_20250805.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-arbitrum-emode-update-rseth-and-ezeth/22731)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
