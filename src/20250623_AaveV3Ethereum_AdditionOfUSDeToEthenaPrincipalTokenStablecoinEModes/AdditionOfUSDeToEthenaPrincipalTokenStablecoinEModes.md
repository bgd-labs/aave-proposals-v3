---
title: "Addition of USDe to Ethena Principal Token Stablecoin E-Modes"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-addition-of-usde-to-ethena-principal-token-stablecoin-e-modes/22355"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x92235fc2feaa585d700789395bb69374d4de1a7a2735a7565815f8423009f160"
---

## Simple Summary

Chaos Labs provides an addition of USDe to the PT Tokens/Stablecoin E-Modes in order to improve the user experience with regard to debt asset migration.

## Motivation

The creation of a new E-Mode which allows users to leverage USDe-linked PT tokens against USDe itself has already proven a success, as USDe has generated a significant revenue relative to its size.

Also beneficial, and as discussed in our previous [post](https://governance.aave.com/t/chaos-labs-risk-stewards-usde-interest-rate-and-borrow-cap-adjustments-05-28-25/22205), leveraging these PT tokens against their underlying assets, rather than other stablecoins, reduces the risks inherent in these strategies, allowing for more permissive collateral parameters and creating less risk for the protocol.

However, the current configuration leads to frictions for users who may wish to transfer their PT-token-backed debt from USDe to USDT or vice versa; allowing easier debt swapping benefits both the protocol, by creating more stable rates, and users, by granting access to the most competitive rates available. Currently, a user would be required to unwind their position on Aave, potentially including swapping on Pendle, introducing transaction and execution costs. As suggested by @myriad, it is preferable to instead add USDe to each PT-Tokens’ respective Stablecoin E-Mode.

Please note that if a user is borrowing to the maximum LTV/LT in the USDe E-Mode, they will be required to reduce their leverage before performing the E-Mode migration. For example, a user borrowing at 92.5% LTV in the USDe E-Mode will be required to reduce their LTV to 92.1% or lower to comply with the parameters of the PT-USDe-July Stablecoin E-Mode, presented below.

As indicated in the subsequent chart, the advantage of migrating from USDe to Stablecoin debt is expected to persist only briefly, until the USDe E-Mode loan-to-value and liquidation-threshold parameters are raised to reflect the lower risk of a highly correlated collateral–debt pair. Hence, following this initial period, we expect the majority of the migration flow to be performed in the opposite direction.

Additionally, the APY projections shown assume utilisation reaches the kink. Demand for these leveraged strategies is highly rate-sensitive, and as such, their profitability will be reflected in utilisation metrics. To date, USDe-denominated E-Modes have consistently delivered higher profitability than the general Stablecoin E-Mode.

## Specification

Add USDe as a borrow-only asset in the following E-Modes:

- PT-eUSDe Stablecoins August 2025 (id: 13)
- PT-USDe Stablecoins July 2025 (id: 10)

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250623_AaveV3Ethereum_AdditionOfUSDeToEthenaPrincipalTokenStablecoinEModes/AaveV3Ethereum_AdditionOfUSDeToEthenaPrincipalTokenStablecoinEModes_20250623.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250623_AaveV3Ethereum_AdditionOfUSDeToEthenaPrincipalTokenStablecoinEModes/AaveV3Ethereum_AdditionOfUSDeToEthenaPrincipalTokenStablecoinEModes_20250623.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x92235fc2feaa585d700789395bb69374d4de1a7a2735a7565815f8423009f160)
- [Discussion](https://governance.aave.com/t/arfc-addition-of-usde-to-ethena-principal-token-stablecoin-e-modes/22355)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
