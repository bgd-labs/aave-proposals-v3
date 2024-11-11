---
title: "Automated (Edge) AGRS Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-aave-generalized-risk-stewards-agrs-activation/19178/3"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x4809f179e517e5745ec13eba8f40d98dab73ca65f8a141bd2f18cc16dcd0cc16"
---

## Simple Summary

This proposal activates the automated Aave Generalized Risk Stewards (AGRS) system on the Aave Ethereum Lido Instance to perform automated interest rate updates for the WETH asset.
Under the hood, the AGRS consumes the Edge infrastructure by Chaos Labs.

## Motivation

With the manual Aave Generalized Risk Stewards (AGRS) already being activated via this [proposal](https://vote.onaave.com/proposal/?proposalId=197), we think it's fair to also activate the automated AGRS system to perform automated interest rate update for WETH on Lido instance using the [Edge Risk Oracle](https://chaoslabs.xyz/posts/introducing-edge-the-next-generation-oracle) proposed by Chaos Labs.

Regarding this pilot integration of automated AGRS with Chaos Labs new Edge infrastructure, it has the following rationale:

- Whenever aligned with other strategic and technical aspects, Aave should benefit from infrastructure built by service providers, in this case, Chaos Labs.
- This pilot will be very non-invasive and with only positive outcomes, as the AGRS layer will guarantee that only acceptable interest rate recommendations will reach the Aave protocol, while ideally having a way more dynamic rate.

The Aave Lido Market facilitates leveraged staking strategy by allowing users to supply wstETH as collateral for WETH borrowing. The market's viability hinges on maintaining WETH borrowing rates below Lido's daily rebasing staking rewards. However, when utilization approaches the Optimal Utilization point and enters Slope2 of the interest rate model, even minor utilization increases can trigger sharp borrowing rate spikes due to the steeper curve and can make the looping strategy unpredictable and deter user participation.

The enhanced Liquid E-Mode configurations in the Lido Instance have significantly impacted market dynamics by driving increased demand for wstETH borrowing, as users pursue looping strategies for wstETH interest accrual. This heightened demand creates upward pressure on ETH interest rates, affecting what users are willing to pay. To stabilize rates in this environment, the risk oracle should consider the wstETH supply rate.

To optimize market dynamics, the interest rate updates being proposed by the risk oracle and updated via AGRS aligns WETH borrowing rates with Lido's staking rewards while considering the impact of pool utilization and E-Mode demand. This alignment helps maintain stable lending conditions and keeps the looping strategy viable for users.

## Specification

The automated AGRS will use another instance of AGRS (exactly the same codebase as the other model), but with the following constraints:

- This instance will only have configurable rate-related parameters: base variable borrow rate, Slope 1, and Slope 2 and uOptimal (Kink).
- Recommendations of these parameters will be submitted to [RiskOracle](https://github.com/ChaosLabsInc/risk-oracle/blob/main/src/RiskOracle.sol) smart contract, from the Edge off-chain infrastructure.
- Between the risk oracle smart contract and the AGRS contract, there will be a very thin middleware [AaveStewardsInjector](https://etherscan.io/address/0x834a5aC6e9D05b92F599A031941262F761c34859), which will have the following logic:
  - Will take recommendations from the Edge Risk Oracle side and propagate them to the AGRS contract.
  - Enforce that only the WETH asset can be acted upon.
  - Given the protections (percentage constraints and time delay) on the AGRS side and that it is an assumption that risk recommendation will be the time correct on the Edge Risk Oracle, the propagation will be permissionless.

The [AaveStewardsInjector](https://etherscan.io/address/0x834a5aC6e9D05b92F599A031941262F761c34859) middleware, technically being part of the Aave Robot infrastructure, will run on Chainlink Automation and will be registered using the [AaveCLRobotOperator](https://etherscan.io/address/0x1cDF8879eC8bE012bA959EB515b11008E0cb6323) contract with 600 LINK from the Ethereum Collector.

The new instance of the [RiskSteward](https://etherscan.io/address/0x81aFd0F99c2Afa2f2DD7E387c2Ef9CD2a29b6E1A) will be given the RiskAdmin role with the following method: `ACL_MANAGER.addRiskAdmin()`

### AGRS

The automated AGRS system will be configured with the following params:

| Parameter                 | Percent change allowed | minimumDelay |
| ------------------------- | ---------------------- | ------------ |
| Base Variable Borrow Rate | 0.5% (absolute change) | 1 day        |
| Slope 1                   | 0.5% (absolute change) | 1 day        |
| Slope 2                   | 5% (absolute change)   | 1 day        |
| Optimal Point (Kink)      | 3% (absolute change)   | 1 day        |

### Edge Risk Oracle

- The risk oracle will retrieve the current Lido staking rewards rate once a day, aligning with the stETH rebasing schedule.
- The new Slope1 will be set to Lido’s staking rewards minus a predefined buffer (initially 0.5%) to account for market volatility and incentives.
- The initial buffer of 0.5% provides a safety margin to accommodate minor fluctuations in staking rewards and market conditions.
- The buffer may be adjusted based on the level of incentives and market feedback to optimize profitability and risk management.
- Update Frequency:
  - Adjustments will occur once daily to align with stETH rebasing.
- Parameter Adjustments:
  - While the risk oracle has the technical capability to adjust the entire interest rate strategy (base rate, optimal utilization, slope 1, slope 2) under the constraints of the risk stewards, the most updated parameter will be slop 1.
- Monitoring and Transparency:
  - All adjustments and calculations will be transparent and auditable, with data available for community review.

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241108_AaveV3EthereumLido_AutomatedAGRSActivation/AaveV3EthereumLido_AutomatedAGRSActivation_20241108.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241108_AaveV3EthereumLido_AutomatedAGRSActivation/AaveV3EthereumLido_AutomatedAGRSActivation_20241108.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x4809f179e517e5745ec13eba8f40d98dab73ca65f8a141bd2f18cc16dcd0cc16)
- [Discussion](https://governance.aave.com/t/arfc-aave-generalized-risk-stewards-agrs-activation/19178/3)
- AaveStewardsInjector: [github](https://github.com/aave-dao/aave-v3-risk-stewards/blob/650d51e2ec6bb1f4d9ae56da5a341436ef9bb8a1/src/contracts/AaveStewardInjector.sol), [deployed-contract](https://etherscan.io/address/0x834a5aC6e9D05b92F599A031941262F761c34859)
- EdgeRiskSteward: [github](https://github.com/aave-dao/aave-v3-risk-stewards/blob/650d51e2ec6bb1f4d9ae56da5a341436ef9bb8a1/src/contracts/EdgeRiskSteward.sol), [deployed-contract](https://etherscan.io/address/0x81aFd0F99c2Afa2f2DD7E387c2Ef9CD2a29b6E1A)
- EdgeRiskOracle: [github](https://github.com/ChaosLabsInc/risk-oracle/blob/be09f47d749985f9537e185016d0f81c003a9fc9/src/RiskOracle.sol), [deployed-contract](https://etherscan.io/address/0x7ABB46C690C52E919687D19ebF89C81A6136C1F2)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
