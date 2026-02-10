---
title: "February 2026 - Funding Update"
author: "TokenLogic"
discussions: "https://governance.aave.com/"
---

## Simple Summary

This publication presents the **February Funding Update**, consisting of the following key activities:

- **Runway**: Acquire GHO to support operational runway.
- **GHO liquidity**: Expand Ahab & AFC SAFEs remit to support GHO liquidity.
- **Operations**: Create allowances to support ongoing operations.

## Motivation

This publication addresses near-term operational requirements, consolidates asset holdings, and renews allowances to the `MainnetSwapSteward` to optimise the DAO’s stablecoin management.

The `MainnetSwapSteward` will continue executing a rolling GHO acquisition strategy to maintain adequate runway and support AAVE buybacks, while preserving sufficient budget to fund ongoing growth initiatives.

Additionally, this publication initiates a process to reduce DEX and CEX GHO liquidity expenses by providing liquidity directly and indirectly across multiple pools.

## Specification

### Runway

Using the `MainnetSwapSteward` and a portion of the ETH received from recent liquidation volume to acquire **2M GHO**, to be deposited into the **Prime** instance.

### Operations

Create allowances for the following assets to be transferred from the Treasury to the **AFC**:

- **Asset**: `AAVE` (`0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9`)
- **Amount**: `100,000`
- **Spender**: `AFC` SAFE (`0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`)
- **Method**: `approve()` AAVE on the Aave Collector contract to the AFC address

This allowance enables the AAVE acquired via buybacks to be held on the AFC SAFE. The allowance is larger than the current balance to facilitate future buybacks and minimise governance overhead.

## References

- **MainnetSwapSteward ARFC**: <https://governance.aave.com/t/arfc-steward-deployment-mainnetswapsteward-and-rewardssteward/23070>
- **Implementation**: [AaveV3Ethereum payload](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260206_AaveV3Ethereum_February2026FundingUpdate/AaveV3Ethereum_February2026FundingUpdate_20260206.sol)
- **Tests**: [AaveV3Ethereum tests](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260206_AaveV3Ethereum_February2026FundingUpdate/AaveV3Ethereum_February2026FundingUpdate_20260206.t.sol)
- **Snapshot**: Direct-to-AIP
- **Discussion**: <https://governance.aave.com/>

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
