---
title: "Discount Rate Risk Oracle Activation and update manual AGRS"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/93"
snapshot: "Direct To AIP"
---

## Simple Summary

This proposal activates the automated Aave Generalised Risk Stewards (AGRS) system on the Ethereum core instance to perform automated discount rate updates on Pendle PT feeds. It also updates the manual AGRS to the most up-to-date iteration (already active on Ethereum), which allows for e-Mode category updates across all instances.

## Motivation

### Automated AGRS for PT discount rate Risk Oracle

Currently, the discount rate on PT feeds requires manual updates through the manual AGRS on the core instance, creating operational inefficiencies, including:

- Additional delays in risk parameter adjustments
- Increased workload and suboptimal response times on manual AGRS due to the high volume of risk updates

To optimize this, and following the same approach as with other risk parameters, this proposal extends the automated AGRS system using Edge Risk Oracles to update the discount rate on the Pendle PT feeds.

### Manual AGRS

Following the successful activation of the new version of manual AGRS as part of [Proposal 299](https://vote.onaave.com/proposal/?proposalId=299) on the Ethereum core instance, we propose extending this same implementation to all other instances.
The new version enables constrained updates to eMode category collateral parameters (LT, LTV, and LB) and allows modification of Pendle PT feed discount rates.

## Specification

### Automated AGRS for PT discount rate Risk Oracle

This new discount rate AGRS will mirror the same infrastructure as the currently active for other automated AGRS, but a summary of specifications is the following:

- The AGRS will have only one configurable parameter: discount rate on pt feeds.
- Recommendation of these parameters will be submitted to a RiskOracle smart contract, from the Edge off-chain infrastructure. Between the risk oracle smart contract and the AGRS contract, there will be a thin middleware [AaveStewardInjectorDiscountRate](http://github.com/aave-dao/aave-v3-risk-stewards/blob/6e8fef4f74d2c68052be9ffa6983aae918c7579b/src/contracts/AaveStewardInjectorDiscountRate.sol), with the following logic:
  - Takes recommendations from the Edge Risk Oracle side and propagates them to the AGRS contract.
  - Enforce that only the whitelisted Pendle PT feeds can be acted upon.
  - Given the protections (percentage constraints and time delay) on the AGRS side and that it is an assumption that risk recommendations will be timed correctly on the Edge Risk Oracle side, the propagation will be permissionless.
- The [AaveStewardInjectorDiscountRate](http://github.com/aave-dao/aave-v3-risk-stewards/blob/6e8fef4f74d2c68052be9ffa6983aae918c7579b/src/contracts/AaveStewardInjectorDiscountRate.sol) will be part of the Aave Robot infrastructure, running on Chainlink Automation and consuming LINK from the Aave Collector.
- The new AGRS contract will be given `RISK_ADMIN` role.

The following feeds for Pendle PT assets on core instance will be automated: `PT_sUSDE_31JUL2025`, `PT_USDe_31JUL2025`, `PT_eUSDE_14AUG2025`.

**Constraints on the discount rate update of the Pendle PT feeds will be as follow: maximum 1% absolute increase/decrease per 2 days.**

The price of pendle PT asset is calculated as the following: `priceOfAsset * (100% - (timeLeftForMaturity * discountRate) / 100%)`.
What this means in practice is that, for ex. a 1% increase of the discount rate per year, the price of the PT asset would reduce by 1% if the time to reach maturity of the PT asset is 1 year. This is never the case on Aave, as maturities are shorter, so the practical impact of the change is ever lower, 0.5% if 6 months are left, 0.25% if 3 months are left, and so on.

### Manual AGRS

The new manual AGRS will be activated on all instances and will be given the `RISK_ADMIN` role via: `ACL_MANAGER.addRiskAdmin(RISK_STEWARD);` and the `RISK_ADMIN` role of the previous manual AGRS along with other legacy contracts like `FREEZING_STEWARD` and `CAPS_PLUS_RISK_STEWARD` will be revoked.

**_Please note: GHO asset will be set as restricted on the new manual stewards as the asset is to be updated via the gho stewards._**

The following risk configuration will be set on the new manual AGRS for all instances:

| **Parameter**                | **Percent change allowed** | **minimumDelay** |
| ---------------------------- | -------------------------- | ---------------- |
| EMode LTV                    | 0.5% absolute change       | 3 days           |
| EMode LiquidationThreshold   | 0.1% absolute change       | 3 days           |
| EMode LiquidationBonus       | 0.5% absolute change       | 3 days           |
| Pendle PT Feed Discount Rate | 2.5% absolute change       | 2 days           |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3EthereumLido_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Polygon_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Avalanche_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Optimism_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Arbitrum_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Metis_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Base_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Gnosis_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Scroll_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3BNB_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/zksync/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3ZkSync_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Linea_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Celo_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Sonic_PendlePTDiscountRateRiskOracleActivation_20250606.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3EthereumLido_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Polygon_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Avalanche_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Optimism_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Arbitrum_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Metis_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Base_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Gnosis_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Scroll_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3BNB_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/zksync/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3ZkSync_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Linea_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Celo_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/cf10b6e96772c028c6d90685943410aa0f1422b7/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Sonic_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol)
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/93)
- AaveStewardInjectorDiscountRate: [github](https://github.com/aave-dao/aave-v3-risk-stewards/blob/6e8fef4f74d2c68052be9ffa6983aae918c7579b/src/contracts/AaveStewardInjectorDiscountRate.sol), [deployed-contract](https://etherscan.io/address/0x15885a83936eb943e98eeffb91e9a49040d93993)
- EdgeRiskStewardDiscountRate: [github](https://github.com/aave-dao/aave-v3-risk-stewards/blob/6e8fef4f74d2c68052be9ffa6983aae918c7579b/src/contracts/EdgeRiskStewardDiscountRate.sol), [deployed-contract](https://etherscan.io/address/0x9F76954f5b55B4908d178f31C07F9537AC8328E7)
- EdgeRiskOracle: [github](https://github.com/ChaosLabsInc/risk-oracle/blob/be09f47d749985f9537e185016d0f81c003a9fc9/src/RiskOracle.sol), [deployed-contract](https://etherscan.io/address/0x7ABB46C690C52E919687D19ebF89C81A6136C1F2)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
