---
title: "Add WETH to the wrsETH wstETH E-Mode on Aave V3 Base Instance"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-add-weth-to-the-wrseth-wsteth-e-mode-on-aave-v3-base-instance/23431"
---

## Simple Summary

This proposal seeks to extend utility for wrsETH on the Aave V3 Base market by adding WETH borrowing to the existing wrsETH/wstETH E-Mode category. And adjust the supply cap of rsETH on the mainnet Prime instance and Linea

## Motivation

rsETH—issued by Kelp DAO—is already integrated across various Aave deployments and has exhibited a stable risk and liquidity profile. On Base, wrsETH suppliers currently rely primarily on stablecoin borrowing and the existing wstETH E-Mode, which limits the efficiency of yield-maximizing leveraged positions.

By adding WETH as a borrowable asset in the wrsETH/wstETH E-Mode, Aave unlocks traditional wrsETH–WETH looping strategies.

Given strong sidelined demand and Kelp’s growing LRT ecosystem, we expect significant additional rsETH inflows to Base, enabling the market to absorb excess WETH supply while restoring balanced utilization levels.

## Specification

| **Parameter**         | **Value** | **Value** | Value |
| --------------------- | --------- | --------- | ----- |
| Asset                 | wrsETH    | wstETH    | WETH  |
| Collateral            | Yes       | No        | No    |
| Borrowable            | No        | Yes       | Yes   |
| Max LTV               | 93.0%     | -         | -     |
| Liquidation Threshold | 95.0%     | -         | -     |
| Liquidation Bonus     | 1.0%      | -         | -     |

| **Instance** | **Asset** | **Current Supply Cap** | **Recommended Supply Cap** |
| ------------ | --------- | ---------------------- | -------------------------- |
| Prime        | rsETH     | 65,000                 | 15,000                     |
| Linea        | wrsETH    | 140,000                | 30,000                     |

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251212_Multi_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance/AaveV3EthereumLido_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance_20251212.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251212_Multi_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance/AaveV3Base_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance_20251212.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251212_Multi_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance/AaveV3Linea_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance_20251212.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251212_Multi_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance/AaveV3EthereumLido_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance_20251212.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251212_Multi_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance/AaveV3Base_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance_20251212.t.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251212_Multi_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance/AaveV3Linea_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance_20251212.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-add-weth-to-the-wrseth-wsteth-e-mode-on-aave-v3-base-instance/23431)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
