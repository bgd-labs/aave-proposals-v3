---
title: "Discount Rate Risk Oracle Activation and update manual AGRS"
author: "BGD Labs (@bgdlabs)"
discussions: "http://governance.aave.com/t/chaos-labs-risk-oracles/17216"
snapshot: "Direct To AIP"
---

## Simple Summary

This proposal activates the automated Aave Generalized Risk Stewards (AGRS) system on the ethereum core instance to perform automated discount rate updates on pendle pt feeds. We also update the manual AGRS to the newer iteration which allows for e-mode category updates across all instances.

## Motivation

### Automated AGRS

The automated AGRS system, powered by Edge Risk Oracles, has proven effective for managing caps and interest rate updates. We propose extending this automation to include discount rate updates for Pendle PT feeds, leveraging the existing infrastructure.

Currently, the discount rate on pt feeds requires manual updates through the manual AGRS on the core instance, creating operational inefficiencies including:

- Additional delays in risk parameter adjustments
- Increased workload and suboptimal response times on manual AGRS due to high volume of risk updates

To optimize this, we think it's a good idea to extend the automated AGRS system using Edge Risk Oracles to update discount rate on the pendle pt feeds.

### Manual AGRS

With the successful activation of the new version of manual AGRS as part of [Proposal 299](https://vote.onaave.com/proposal/?proposalId=299) on ethereum core instance which has been live for a while, and allows updating eMode category collateral params such as LT, LTV, and LB in a constrained manner, while also allowing to change the discount rate of pendle pt feeds, we think it's a good idea to activate it on all other instances as well to align the manual AGRS implementation across all instances.

## Specification

### Automated AGRS

This new discount rate AGRS will mirror the same infrastructure as the currently active for other automated AGRS, but a summary of specifications is the following:

- The AGRS will have only one configurable parameter: discount rate on pt feeds.
- Recommendation of these parameters will be submitted to a RiskOracle smart contract, from the Edge off-chain infrastructure. Between the risk oracle smart contract and the AGRS contract, there will be a thin middleware [AaveStewardInjectorDiscountRate](http://github.com/aave-dao/aave-v3-risk-stewards/blob/6e8fef4f74d2c68052be9ffa6983aae918c7579b/src/contracts/AaveStewardInjectorDiscountRate.sol), with the following logic:
  - Takes recommendations from the Edge Risk Oracle side and propagates them to the AGRS contract.
  - Enforce that only the whitelisted pendle pt feeds can be acted upon.
  - Given the protections (percentage constraints and time delay) on the AGRS side and that it is an assumption that risk recommendations will be timed correctly on the Edge Risk Oracle side, the propagation will be permissionless.

The [AaveStewardInjectorDiscountRate](http://github.com/aave-dao/aave-v3-risk-stewards/blob/6e8fef4f74d2c68052be9ffa6983aae918c7579b/src/contracts/AaveStewardInjectorDiscountRate.sol) will be part of the Aave Robot infrastructure, running on Chainlink Automation and consuming LINK from the Aave Collector. The new AGRS contract will be given `RISK_ADMIN` role.

The following feeds for pendle pt assets on core instance will be automated: `PT_sUSDE_31JUL2025`, `PT_USDe_31JUL2025`, `PT_eUSDE_14AUG2025`.

Constraints on the discount rate update of the pendle pt feeds will be as follow: maximum 1% absolute increase/decrease per 2 days.

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

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3EthereumLido_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Polygon_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Avalanche_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Optimism_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Arbitrum_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Metis_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Base_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Gnosis_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Scroll_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3BNB_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3ZkSync_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Linea_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Celo_PendlePTDiscountRateRiskOracleActivation_20250606.sol), [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Sonic_PendlePTDiscountRateRiskOracleActivation_20250606.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3EthereumLido_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Polygon_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Avalanche_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Optimism_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Arbitrum_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Metis_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Base_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Gnosis_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Scroll_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3BNB_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3ZkSync_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Linea_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Celo_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol), [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Sonic_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol)
- [Discussion](http://governance.aave.com/t/chaos-labs-risk-oracles/17216)
- AaveStewardInjectorDiscountRate: [github](https://github.com/aave-dao/aave-v3-risk-stewards/blob/6e8fef4f74d2c68052be9ffa6983aae918c7579b/src/contracts/AaveStewardInjectorDiscountRate.sol), [deployed-contract](https://etherscan.io/address/0x15885a83936eb943e98eeffb91e9a49040d93993)
- EdgeRiskStewardDiscountRate: [github](https://github.com/aave-dao/aave-v3-risk-stewards/blob/6e8fef4f74d2c68052be9ffa6983aae918c7579b/src/contracts/EdgeRiskStewardDiscountRate.sol), [deployed-contract](https://etherscan.io/address/0x9F76954f5b55B4908d178f31C07F9537AC8328E7)
- EdgeRiskOracle: [github](https://github.com/ChaosLabsInc/risk-oracle/blob/be09f47d749985f9537e185016d0f81c003a9fc9/src/RiskOracle.sol), [deployed-contract](https://etherscan.io/address/0x7ABB46C690C52E919687D19ebF89C81A6136C1F2)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
