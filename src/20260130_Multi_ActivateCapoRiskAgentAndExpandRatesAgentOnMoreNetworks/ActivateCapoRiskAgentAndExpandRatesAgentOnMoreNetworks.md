---
title: "Activate Capo Risk Agent and expand Rates Agent on more networks"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-dynamic-calibration-of-capo-parameters-via-risk-oracles/22601"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x66aa6904f140d56ada880f45c911994c5c6cc20109b55081f508ccdd6417066d"
---

## Simple Summary

This proposal activates the CAPO Risk Agent on Ethereum and expands the Interest Rates Agent (Slope2) to Avalanche, Arbitrum, and Base networks.

## Motivation

Following the successful [migration of the AGRS (Risk Stewards) infrastructure to Risk Agents](https://vote.onaave.com/proposal/?proposalId=432), it makes sense to extend this framework to additional networks and introduce new agent types.

The CAPO system provides critical price safeguards for yield-bearing assets by defining upper bounds on exchange rates. However, when CAPO parameters remain static for extended periods, the derived maximum ratio can become increasingly detached from real-world exchange rate dynamics, creating vulnerability to price manipulations. By activating the CAPO Risk Agent on Ethereum, parameters like `snapshotRatio` and `maxYearlyRatioGrowthPercent` can be dynamically calibrated through the Risk Oracle, maintaining tight and responsive protection for yield-bearing collateral assets without requiring manual governance intervention. More details could be found on the forum post [here](https://governance.aave.com/t/arfc-dynamic-calibration-of-capo-parameters-via-risk-oracles/22601).

Additionally, extending the Interest Rates Agent to Avalanche, Arbitrum, and Base networks allows for automated adjustment of the `variableRateSlope2` parameter on high-utilization assets, ensuring interest rates remain responsive to market conditions across these networks.

## Specification

The proposal activates the [AaveCapoAgent](https://github.com/bgd-labs/aave-risk-agents/blob/c09d73bc4080a7d14114957dc30cbdfe0b4cb326/src/contracts/agent/AaveCapoAgent.sol) and [AaveRatesAgent](https://github.com/bgd-labs/aave-risk-agents/blob/c09d73bc4080a7d14114957dc30cbdfe0b4cb326/src/contracts/agent/AaveRatesAgent.sol) with the following params using the [chaos-agents](https://github.com/ChaosLabsInc/chaos-agents) infra:

| Parameter                        | Network   | Assets                                                                                          | Constraints                        |
| -------------------------------- | --------- | ----------------------------------------------------------------------------------------------- | ---------------------------------- |
| CAPO snapshotRatio               | Ethereum  | wstETH, weETH, rsETH, osETH, ezETH, cbETH, rETH, tETH, ETHx, LBTC, eBTC, sUSDe, syrupUSDT, sDAI | Max 3% relative change per 3 days  |
| CAPO maxYearlyRatioGrowthPercent | Ethereum  | wstETH, weETH, rsETH, osETH, ezETH, cbETH, rETH, tETH, ETHx, LBTC, eBTC, sUSDe, syrupUSDT, sDAI | Max 10% relative change per 3 days |
| variableRateSlope2               | Avalanche | USDC, USDt, WETHe                                                                               | Max 4% absolute change per 8 hours |
| variableRateSlope2               | Arbitrum  | USDC, USDT, WETH                                                                                | Max 4% absolute change per 8 hours |
| variableRateSlope2               | Base      | USDC, WETH                                                                                      | Max 4% absolute change per 8 hours |

The payload does the following actions:

- Register new agents on the AgentHub contract by calling `registerAgent()`
- Configure constrained ranges on the RangeValidationModule to strictly bound the risk param update from the Chaos Risk Oracle.
- Give `RISK_ADMIN` role to the AgentContract which will be called by the Chaos Agent system to inject updates onto the Aave protocol.
- Register new chainlink automation on the AgentHub Automation wrapper contract for the agents.
- Reimburse BGD Labs with 108 LINK by withdrawing aLINK from Collector on Ethereum, which was used to fund chainlink automation on Base as Collector did not have LINK on those networks, and to fund governance automation actions.

**Please note: On Ethereum, the following price feeds are shared across both Core and Prime instances: wstETH, rsETH, ezETH, tETH, sUSDe so changes on the capo feed params will be applied to both instances. Since the CAPO feeds use the ACL Manager of both instances, we give the `RISK_ADMIN` role to the agent contract from both core Core and Prime instances.**

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260130_Multi_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks/AaveV3Ethereum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260130_Multi_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks/AaveV3Avalanche_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260130_Multi_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks/AaveV3Arbitrum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260130_Multi_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks/AaveV3Base_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260130_Multi_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks/AaveV3Ethereum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260130_Multi_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks/AaveV3Avalanche_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260130_Multi_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks/AaveV3Arbitrum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260130_Multi_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks/AaveV3Base_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x66aa6904f140d56ada880f45c911994c5c6cc20109b55081f508ccdd6417066d)
- [Discussion](https://governance.aave.com/t/arfc-dynamic-calibration-of-capo-parameters-via-risk-oracles/22601)
- Github: [Chaos Agents](https://github.com/ChaosLabsInc/chaos-agents), [Aave Risk Agents](https://github.com/bgd-labs/aave-risk-agents)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
