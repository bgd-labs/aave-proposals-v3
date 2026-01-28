---
title: "Enhancing Market Granularity in Aave 3.6: part 2"
author: "ChaosLabs (implemented by Aavechan Initiative @aci via Skyward)"
discussions: "https://governance.aave.com/t/direct-to-aip-enhancing-market-granularity-in-aave-v3-6-restricting-borrowability-and-collateralization-outside-of-liquid-emodes/23592"
---

## Simple Summary

This proposal leverages the configurability improvements introduced in [Aave v3.6](https://governance.aave.com/t/arfc-bgd-aave-v3-6/23172/2) to strengthen risk isolation and improve parameter clarity. Specifically, it introduces:

- LTV0 for assets not intended to serve as collateral outside of eModes.
- Non-borrowable status for assets whose use cases are restricted to within their respective eModes.
- Exclusive eMode participation, ensuring these assets are only active within targeted, high-correlation environments.

This aims to reduce systemic exposure, simplify risk management, and enable cleaner differentiation between general market assets and those intended for correlated or high-efficiency lending environments.

## Motivation

Aave v3.6 represents an inflection point in the protocol’s ability to model and manage granular risk domains. Historically, reserve-level configurations in Aave v3 (prior to 3.6) constrained risk management, as all eMode behaviors were inherited from the global market configuration. This coupling led to inefficiencies, forced workarounds, and limited the ability to cleanly separate correlated-asset risk from the general pool.

### **Legacy Limitation: Coupled Configurations**

Under Aave v3.0–v3.5, an asset’s global (base) configuration dictated its eMode behavior. Specifically:

- An asset had to be collateralized outside of eMode to be collateralized within it.
- Similarly, to be borrowable within an eMode, it had to be borrowable in the main pool.
- If an asset’s base configuration had LTV = 0, it was treated as LTV = 0 in every eMode, triggering LTV0 rules globally.

This architectural coupling meant that assets could not be scoped to eMode-specific roles, e.g., collateral-only inside an eMode, or borrow-only within one. To accommodate, risk management often used low but nonzero LT values, which was not feasible for alternative assets with effective non-zero collateral values outside of E-mode, if and when reserves need updating in the future, or enabled borrowability globally with no practical use case, introducing unnecessary systemic exposure.

### **Emerging Complexity: Cross-Asset and Cross-Market Contagion**

As Aave’s markets evolved with Liquid Staking Tokens (LSTs), Liquid Restaking Tokens (LRTs), and Principal Tokens (PTs), risk dependencies grew more complex.

Many of these assets are highly correlated with ETH or stablecoins and are designed to operate only within structured environments, where both collateral and borrowing assets adhere to tight risk parameters (e.g., the LST eMode).

Without configuration independence, some of these tokens remain borrowable in the general market even though demand exists exclusively within the eMode (e.g., borrowing wstETH only makes sense against rsETH, not against AAVE). Their presence as general borrowables artificially expands the exposure surface and increases the potential for recursive or unintended leverage. Their collateral eligibility outside of eModes complicates the dynamics of liquidation, volatility sensitivity, and the effective exposure of liquidity to the weakest links of the system.

### **Risk Management Efficiency**

The inability to enforce LTV0 selectively has long been a point of friction for both risk managers and integrations.

Risk management often relied on LTV0 flags to gradually deprecate or isolate assets, e.g., to offboard an asset from a specific eMode or phase out its collateral use. Under the old model, setting LTV0 outside of an eMode would cascade that rule across all modes, making targeted adjustments impossible.

With v3.6 introducing per-eMode `ltvzerobitmap`, Aave can now:

- Flag specific assets as LTV0 outside eModes (fully removing their collateral role in the main pool).
- Keep them collateralizable within eModes where risk conditions are known and bounded.
- Effectively migrate eMode risk configurations via setting LTV0 of an existing Emode and creating a new Emode with a lower LT, thereby not affecting existing users within the E-mode while subjecting new users to the updated config.

This enables Aave to evolve into a multi-environment structure, where the “main pool” functions as a conservative liquidity base layer, and eModes serve as risk-contained, higher-efficiency sub-markets, allowing independent caps, parameters, and monitoring per eMode without interference from the base layer.
In line with this efficiency, we provide the following specifications for relevant risk parameter optimizations at the protocol level, made possible by the launch of v3.6, aiming to minimize tail risks while minimizing the impact on protocol revenue.

## Specification

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Ethereum_EnhancingMarketGranularityInAave36Part2_20260127.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3EthereumLido_EnhancingMarketGranularityInAave36Part2_20260127.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Polygon_EnhancingMarketGranularityInAave36Part2_20260127.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Avalanche_EnhancingMarketGranularityInAave36Part2_20260127.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Arbitrum_EnhancingMarketGranularityInAave36Part2_20260127.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Base_EnhancingMarketGranularityInAave36Part2_20260127.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3BNB_EnhancingMarketGranularityInAave36Part2_20260127.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Linea_EnhancingMarketGranularityInAave36Part2_20260127.sol), [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Plasma_EnhancingMarketGranularityInAave36Part2_20260127.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Ethereum_EnhancingMarketGranularityInAave36Part2_20260127.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3EthereumLido_EnhancingMarketGranularityInAave36Part2_20260127.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Polygon_EnhancingMarketGranularityInAave36Part2_20260127.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Avalanche_EnhancingMarketGranularityInAave36Part2_20260127.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Arbitrum_EnhancingMarketGranularityInAave36Part2_20260127.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Base_EnhancingMarketGranularityInAave36Part2_20260127.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3BNB_EnhancingMarketGranularityInAave36Part2_20260127.t.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Linea_EnhancingMarketGranularityInAave36Part2_20260127.t.sol), [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Plasma_EnhancingMarketGranularityInAave36Part2_20260127.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-enhancing-market-granularity-in-aave-v3-6-restricting-borrowability-and-collateralization-outside-of-liquid-emodes/23592)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
