---
title: "Slope2 Risk Oracle Activation On Core Ethereum, Linea"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/chaos-labs-risk-stewards-slope2-parameter-adjustments-for-risk-oracle-deployment/23192"
---

## Simple Summary

This proposal activates the automated Aave Generalized Risk Stewards (AGRS) system on the Aave Ethereum Core and Linea Instance to perform automated slope2 interest rate updates for WETH, USDT, USDC, USDe assets. Under the hood, the AGRS consumes the Risk Oracle infrastructure by Chaos Labs.

## Motivation

The slope2 risk oracle introduces a dynamic mechanism to address liquidity contraction in high-leverage lending markets. Unlike traditional piecewise-linear rate curves that produce abrupt APR spikes during supply shocks, the oracle stages its response by starting with a low baseline when utilization first crosses the kink, compounding convexly as stress persists, and decaying predictably once conditions normalize.
This approach minimizes unnecessary preemptive shocks while providing transparent escalation and robust solvency protection for suppliers, with borrowers facing fair, time-aligned incentives that intensify only during sustained high utilization periods. Detailed methodology can be found [here](https://governance.aave.com/t/chaos-labs-risk-stewards-slope2-parameter-adjustments-for-risk-oracle-deployment/23192#p-59097-motivation-2).

This new component of AGRS follows the same example of interest rate updates for WETH on v3 Prime Ethereum ([this proposal](https://vote.onaave.com/proposal/?proposalId=200)), in production for some time.

## Specification

The automated AGRS will use another instance of AGRS (exactly the same codebase as the other model), with the following constraints:

- This instance will only allow changes of one risk parameter: slope 2.
- Recommendations of the parameter will be submitted to a RiskOracle smart contract, from the Edge off-chain infrastructure.
- Between the risk oracle smart contract and the AGRS contract, there will be a very thin middleware [AaveStewardRatesInjector](https://github.com/aave-dao/aave-v3-risk-stewards/blob/ecbe493bb2c7799e58c44ebe907382ffd570e54b/src/contracts/AaveStewardInjectorRates.sol), which will have the following logic:
  - Will take recommendations from the Edge Risk Oracle side and propagate them to the AGRS contract.
  - Enforce that only the configured asset can be acted upon.
  - Given the protections (percentage constraints and time delay) on the AGRS side and that it is an assumption that risk recommendation will be timing correct updates on the Edge Risk Oracle, the propagation will be permissionless.

**Automation**. The [AaveStewardRatesInjector](https://github.com/aave-dao/aave-v3-risk-stewards/blob/ecbe493bb2c7799e58c44ebe907382ffd570e54b/src/contracts/AaveStewardInjectorRates.sol) middleware, technically being part of the Aave Robot infrastructure, will run on Chainlink Automation and will be registered using the AaveCLRobotOperator contract with 250 LINK from the Ethereum Collector.
Since Chainlink Automation is not available on Linea, the automation will be configured using Gelato’s infrastructure over there.

**Roles from the Aave protocol**. The new instance of the RiskSteward will be given the `RiskAdmin` role with the following method: `ACL_MANAGER.addRiskAdmin()`

**Whitelisted assets**. Only the following assets will be whitelisted for the automatic AGRS system, enforced strictly on the AaveStewardRatesInjector contract:

- AaveV3Ethereum: [WETH](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2), [USDC](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48), [USDT](https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7), [USDe](https://etherscan.io/address/0x4c9EDD5852cd905f086C759E8383e09bff1E68B3)
- AaveV3Linea: [WETH](https://lineascan.build/address/0xe5D7C2a44FfDDf6b295A15c148167daaAf5Cf34f), [USDC](https://lineascan.build/address/0x176211869cA2b568f2A7D4EE941E073a821EE1ff), [USDT](https://lineascan.build/address/0xA219439258ca9da29E9Cc4cE5596924745e12B93)

**Enforced constraints**. The automated AGRS system will be configured with the following constraints:

| Parameter | Maximum Change (Absolute) | minimumDelay |
| --------- | ------------------------- | ------------ |
| Slope2    | 4%                        | 8 Hours      |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251009_Multi_Slope2RiskOracleActivationOnCoreEthereumLinea/AaveV3Ethereum_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251009_Multi_Slope2RiskOracleActivationOnCoreEthereumLinea/AaveV3Linea_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251009_Multi_Slope2RiskOracleActivationOnCoreEthereumLinea/AaveV3Ethereum_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009.t.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251009_Multi_Slope2RiskOracleActivationOnCoreEthereumLinea/AaveV3Linea_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009.t.sol)
- [Discussion](https://governance.aave.com/t/chaos-labs-risk-stewards-slope2-parameter-adjustments-for-risk-oracle-deployment/23192)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
