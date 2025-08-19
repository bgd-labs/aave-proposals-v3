---
title: "Multi eMode Update and Creation - rsETH and ezETH, wstETH"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-arbitrum-emode-update-rseth-and-ezeth/22731/3"
---

### Summary

This publication proposes updating the ezETH and rsETH eMode categories on Arbitrum, a new wstETH/wETH category on Arbitrum and the creation of weETH <> wstETH eMode on Core.

### Motivation

In preparation for the upcoming DRIPs campaign on Arbitrum, this publication proposes enabling Kelp and Renzo Liquid Restaking Tokens (LRTs) access to ETH via existing v3.2 eModes.

Upon implementing this proposal, weETH, rsETH and ezETH will each have the same LTV and LT for borrowing wstETH and ETH on Arbitrum.

Given the behavior of market participants and expected growth of borrowing demand for WETH market, we recommend including WETH into the E-Modes for rsETH and ezETH. Additionally, in order to align the risk profiles of LRTs and wstETH we recommend creating the wstETH/WETH E-Mode.

### Specification

#### Update rsETH/WETH eMode on Arbitrum

| **Parameter**             | **Value**    |
| ------------------------- | ------------ |
| **Collateral**            | rsETH        |
| **Borrowable**            | wstETH, wETH |
| **Max LTV**               | 93.00%       |
| **Liquidation Threshold** | 95.00%       |
| **Liquidation Penalty**   | 1.00%        |

#### Update ezETH/WETH eMode on Arbitrum

| **Parameter**             | **Value**    |
| ------------------------- | ------------ |
| **Collateral**            | ezETH        |
| **Borrowable**            | wstETH, wETH |
| **Max LTV**               | 93.00%       |
| **Liquidation Threshold** | 95.00%       |
| **Liquidation Penalty**   | 1.00%        |

#### Create wstETH/WETH eMode on Arbitrum

| **Parameter**             | **Value** |
| ------------------------- | --------- |
| **Collateral**            | wstETH    |
| **Borrowable**            | WETH      |
| **Max LTV**               | 94.00%    |
| **Liquidation Threshold** | 96.00%    |
| **Liquidation Penalty**   | 1.00%     |

#### Create weETH/wstETH eMode on Core

| **Parameter**             | **Value**    |
| ------------------------- | ------------ |
| **Collateral**            | weETH        |
| **Borrowable**            | wstETH, wETH |
| **Max LTV**               | 93.00%       |
| **Liquidation Threshold** | 95.00%       |
| **Liquidation Penalty**   | 1.00%        |

## References

- Implementation: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250805_AaveV3Arbitrum_ArbitrumEModeUpdateRsETHAndEzETH/AaveV3Arbitrum_ArbitrumEModeUpdateRsETHAndEzETH_20250805.sol)[AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250805_AaveV3Arbitrum_ArbitrumEModeUpdateRsETHAndEzETH/AaveV3Ethereum_ArbitrumEModeUpdateRsETHAndEzETH_20250805.sol)
- Tests: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250805_AaveV3Arbitrum_ArbitrumEModeUpdateRsETHAndEzETH/AaveV3Arbitrum_ArbitrumEModeUpdateRsETHAndEzETH_20250805.t.sol)[AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250805_AaveV3Arbitrum_ArbitrumEModeUpdateRsETHAndEzETH/AaveV3Ethereum_ArbitrumEModeUpdateRsETHAndEzETH_20250805.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-arbitrum-emode-update-rseth-and-ezeth/22731/3)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
