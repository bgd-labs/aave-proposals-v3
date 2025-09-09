---
title: " Increase rsETH Supply Cap on Aave V3 Linea Instance"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-increase-rseth-supply-cap-on-aave-v3-linea-instance/23073"
---

## Simple Summary

This proposal seeks to increase the rsETH supply cap on the Aave V3 Linea instance to accommodate growing demand and prevent supply cap limitations that restrict user access.

## Motivation

rsETH has demonstrated strong demand across Aave V3 deployments, with supply caps frequently reaching high utilization rates.

As a liquid restaking token that has proven its utility and risk profile across multiple Aave instances (Ethereum, Arbitrum, Base), increasing the supply cap on Linea will:

- **Improve User Experience**: Prevent users from being unable to supply rsETH when caps are reached
- **Optimize Capital Efficiency**: Allow more users to access rsETH-based strategies on Linea
- **Support Network Growth**: Enable the Linea ecosystem to capture more TVL and activity
- **Maintain Competitiveness**: Ensure Aave on Linea remains attractive for rsETH holders

While current cap increase via Risk Steward (100% per time lock period) does not accommodate the strong market demand for this asset, rsETH has demonstrated a strong track record across Aave deployments with:

- Proven liquidation mechanisms and oracle reliability
- Consistent performance across market conditions
- Active risk monitoring by service providers
- Established precedent on other networks

## Specification

| Asset  | Blockchain | Current Supply Cap | Recommended Supply Cap |
| ------ | ---------- | ------------------ | ---------------------- |
| wrsETH | Linea      | 6,400              | 70,000                 |

## References

- Implementation: [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/5c18771cf3e6deff4e225801cec2115dd21061d4/src/20250905_AaveV3Linea_IncreaseRsETHSupplyCapOnAaveV3LineaInstance/AaveV3Linea_IncreaseRsETHSupplyCapOnAaveV3LineaInstance_20250905.sol)
- Tests: [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/5c18771cf3e6deff4e225801cec2115dd21061d4/src/20250905_AaveV3Linea_IncreaseRsETHSupplyCapOnAaveV3LineaInstance/AaveV3Linea_IncreaseRsETHSupplyCapOnAaveV3LineaInstance_20250905.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-increase-rseth-supply-cap-on-aave-v3-linea-instance/23073)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
