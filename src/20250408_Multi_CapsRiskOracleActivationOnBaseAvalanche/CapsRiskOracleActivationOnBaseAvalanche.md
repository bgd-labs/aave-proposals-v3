---
title: "Caps Risk Oracle Activation on Base, Avalanche"
author: "BGD Labs (@bgdlabs)"
discussions: TODO
---

## Simple Summary

Following the successful operation of the cap risk stewards (AGRS) on Aave v3 Arbitrum since end of February, this proposal enables exactly the same constraint system on Base and Avalanche.

## Motivation

[Proposal 253](https://vote.onaave.com/proposal/?proposalId=253) approved by governance and executed February 25th enabled an automated AGRS (Aave Generalised Risk Stewards) system to allow modification of supply and borrow caps in Aave v3 Arbitrum as pilot, in order to make caps maintenance more efficient, reducing the overall overhead of updating them via manual stewards or governance proposals, while having a more dynamic system reducing the delta between caps and supplies/borrowings.

Since then, the system has been working [flawlessly on Arbitrum](https://governance.aave.com/t/chaos-labs-monthly-community-update/11174/26?u=chaoslabs#p-55100-supply-and-borrow-caps-7), with 55 caps updates. So following the plan it is reasonable to continue optimizing by introducing the same on other networks, more precisely Base and Avalanche.

## Specification

_This new Base and Avalanche instances of AGRS will mirror exactly the same infrastructure as the currently active on Arbitrum_, but a summary of specifications is the following:

- The AGRS will only have two configurable parameters: supply and borrow caps.
- Recommendation of these parameters will be submitted to a RiskOracle smart contract, from the Edge off-chain infrastructure.
- Between the risk oracle smart contract and the AGRS contract, there will be a thin middleware AaveStewardCapsInjector, with the following logic:
  - Takes recommendations from the Edge Risk Oracle side and propagate them to the AGRS contract.
  - Enforce that only the whitelisted assets can be acted upon.
  - Given the protections (percentage constraints and time delay) on the AGRS side and that it is an assumption that risk recommendations will be timed correctly on the Edge Risk Oracle side, the propagation will be permissionless.
- The AaveStewardCapsInjector will be part of the Aave Robot infrastructure, running on Chainlink Automation and consuming LINK from the Aave Collector on each network.
- The new AGRS contract will be given RISK_ADMIN role.
- All currently listed assets on Base and Arbitrum will be automated, aside from rsETH and ezETH on Base, as those have pretty ad-hoc caps dynamics.
- Constraints on both Base and Avalanche will be the same as on the system currently live on Arbitrum: maximum 30% increase/decrease each 3 days
- The off-chain caps methodology description can be found on the Aave governance forum [here](https://governance.aave.com/t/arfc-supply-and-borrow-cap-risk-oracle-activation/20834)

## References

- Implementation: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250408_Multi_CapsRiskOracleActivationOnBaseAvalanche/AaveV3Avalanche_CapsRiskOracleActivationOnBaseAvalanche_20250408.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250408_Multi_CapsRiskOracleActivationOnBaseAvalanche/AaveV3Base_CapsRiskOracleActivationOnBaseAvalanche_20250408.sol)
- Tests: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250408_Multi_CapsRiskOracleActivationOnBaseAvalanche/AaveV3Avalanche_CapsRiskOracleActivationOnBaseAvalanche_20250408.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250408_Multi_CapsRiskOracleActivationOnBaseAvalanche/AaveV3Base_CapsRiskOracleActivationOnBaseAvalanche_20250408.t.sol)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
