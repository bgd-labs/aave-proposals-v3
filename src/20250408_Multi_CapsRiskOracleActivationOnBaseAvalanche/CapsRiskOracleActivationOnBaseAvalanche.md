---
title: "Caps Risk Oracle Activation on Base, Avalanche"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/78"
snapshot: "Direct To AIP"
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

**Base**

| Contract                | Address                                                                                                                    |
| ----------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| EdgeRiskStewardCaps     | [0xB892202d9Ce2C16C565A492a5168689b215Eb269](https://basescan.org/address/0xB892202d9Ce2C16C565A492a5168689b215Eb269#code) |
| AaveStewardInjectorCaps | [0x4f84A364B66Eb6280350da011829a6BD02B4712f](https://basescan.org/address/0x4f84A364B66Eb6280350da011829a6BD02B4712f#code) |
| RiskOracle              | [0x239d3Bc5fa247337287cb03f53B8bc63DBBc332D](https://basescan.org/address/0x239d3Bc5fa247337287cb03f53B8bc63DBBc332D#code) |

**Avalanche**

| Contract                | Address                                                                                                                                   |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| EdgeRiskStewardCaps     | [0x57218F3aB422A39115951c3Eb06881a7A719DfdD](https://snowtrace.io/address/0x57218F3aB422A39115951c3Eb06881a7A719DfdD#code)                |
| AaveStewardInjectorCaps | [0x54714FAc85b0bf627288CC3a186dE81A42f1D635](https://snowtrace.io/address/0x54714FAc85b0bf627288CC3a186dE81A42f1D635#code)                |
| RiskOracle              | [0x1273f29204fC102bD4620485B13cFE27a794fF32](https://snowtrace.io/address/0x1273f29204fC102bD4620485B13cFE27a794fF32/contract/43114/code) |

## References

- Implementation: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250408_Multi_CapsRiskOracleActivationOnBaseAvalanche/AaveV3Avalanche_CapsRiskOracleActivationOnBaseAvalanche_20250408.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250408_Multi_CapsRiskOracleActivationOnBaseAvalanche/AaveV3Base_CapsRiskOracleActivationOnBaseAvalanche_20250408.sol)
- Tests: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250408_Multi_CapsRiskOracleActivationOnBaseAvalanche/AaveV3Avalanche_CapsRiskOracleActivationOnBaseAvalanche_20250408.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250408_Multi_CapsRiskOracleActivationOnBaseAvalanche/AaveV3Base_CapsRiskOracleActivationOnBaseAvalanche_20250408.t.sol)
- Code Diffs: [Base-Arbitrum-AaveStewardInjectorCaps](https://contract-diff.swiss-knife.xyz/?contractOld=0x4f84A364B66Eb6280350da011829a6BD02B4712f&contractNew=0x35d53dEB2F6f40Ea7af32B6F8BEd88eA966DF1D9&chainIdOld=8453&chainIdNew=42161), [Avalanche-Arbitrum-AaveStewardInjectorCaps](https://contract-diff.swiss-knife.xyz/?contractOld=0x54714FAc85b0bf627288CC3a186dE81A42f1D635&contractNew=0x35d53dEB2F6f40Ea7af32B6F8BEd88eA966DF1D9&chainIdOld=43114&chainIdNew=42161), [Base-Arbitrum-EdgeRiskStewardCaps](https://contract-diff.swiss-knife.xyz/?contractOld=0xB892202d9Ce2C16C565A492a5168689b215Eb269&contractNew=0x085E34722e04567Df9E6d2c32e82fd74f3342e79&chainIdOld=8453&chainIdNew=42161), [Avalanche-Arbitrum-EdgeRiskStewardCaps](https://contract-diff.swiss-knife.xyz/?contractOld=0x57218F3aB422A39115951c3Eb06881a7A719DfdD&contractNew=0x085E34722e04567Df9E6d2c32e82fd74f3342e79&chainIdOld=43114&chainIdNew=42161)
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/78)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
