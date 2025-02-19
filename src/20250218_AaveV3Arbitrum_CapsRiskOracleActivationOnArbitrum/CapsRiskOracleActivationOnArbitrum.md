---
title: "Caps Risk Oracle Activation on Arbitrum"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-supply-and-borrow-cap-risk-oracle-activation/20834"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0x1d8d0d25f3b705bf207a130308658d15256e2cebc58d123e4ad9e7e3a177ac11"
---

## Simple Summary

This proposal activates the automated Aave Generalized Risk Stewards (AGRS) system on the Arbitrum Instance to perform automated supply and borrow cap updates.
Under the hood, the AGRS consumes risk recommendations from the Edge infrastructure by Chaos Labs.

## Motivation

The current implementation of manual AGRS allows for the periodic manual updating of Supply and Borrow caps, generally performed in response to market demand. The high volume of updates, combined with the manual triggering of supply and borrow cap simulations, written analyses, and coordination across multiple service providers, often leads to delays in implementing cap increases.
These delays can hinder potential growth opportunities for underlying assets that might otherwise contribute significantly, but more importantly, they create overhead to have tighter risk configurations and dynamism.

This new component of AGRS follows the example of interest rate updates for WETH on v3 Prime Ethereum ([this proposal](https://vote.onaave.com/proposal/?proposalId=200), in production for some time.

## Specification

The automated AGRS will use another instance of AGRS (exactly the same codebase as the other model), but with the following constraints:

- This instance will only have configurable caps-related parameters: supplyCap and borrowCap.
- Recommendations of these parameters will be submitted to a RiskOracle smart contract, from the Edge off-chain infrastructure.
- Between the risk oracle smart contract and the AGRS contract, there will be a very thin middleware AaveStewardCapsInjector, which will have the following logic:
  - Will take recommendations from the Edge Risk Oracle side and propagate them to the AGRS contract.
  - Enforce that only the whitelisted asset can be acted upon.
  - Given the protections (percentage constraints and time delay) on the AGRS side and that it is an assumption that risk recommendation will be timing correct updates on the Edge Risk Oracle, the propagation will be permissionless.

The [AaveStewardCapsInjector](https://arbiscan.io/address/0x35d53dEB2F6f40Ea7af32B6F8BEd88eA966DF1D9) middleware, technically being part of the Aave Robot infrastructure, will run on Chainlink Automation and will be registered using the [AaveCLRobotOperator](https://arbiscan.io/address/0xaa944aD95e51CB83C1f35FAEEDfC7d2c31B0BB4d) contract with 50 LINK from the Arbitrum Collector.

The new instance of the [RiskSteward](https://arbiscan.io/address/0x085e34722e04567df9e6d2c32e82fd74f3342e79) will be given the RiskAdmin role with the following method: `ACL_MANAGER.addRiskAdmin()`

Please note that only the following assets on Arbitrum instance have been whitelisted for automatic AGRS system, enforced strictly on the AaveStewardCapsInjector contract: [WETH](https://arbiscan.io/address/0x82aF49447D8a07e3bd95BD0d56f35241523fBab1), [USDC](https://arbiscan.io/address/0xaf88d065e77c8cC2239327C5EDb3A432268e5831), [USDT](https://arbiscan.io/address/0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9), [WBTC](https://arbiscan.io/address/0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f), [DAI](https://arbiscan.io/address/0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1), [weETH](https://arbiscan.io/address/0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe), [ARB](https://arbiscan.io/address/0x912CE59144191C1204E64559FE8253a0e49E6548), [USDC.e](https://arbiscan.io/address/0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8), [GHO](https://arbiscan.io/address/0x7dfF72693f6A4149b17e7C6314655f6A9F7c8B33), [LINK](https://arbiscan.io/address/0xf97f4df75117a78c1A5a0DBb814Af92458539FB4), [wstETH](https://arbiscan.io/address/0x5979D7b546E38E414F7E9822514be443A4800529), [LUSD](https://arbiscan.io/address/0x93b346b6BC2548dA6A1E7d98E9a421B42541425b), [FRAX](https://arbiscan.io/address/0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F), [rETH](https://arbiscan.io/address/0xEC70Dcb4A1EFa46b8F2D97C310C9c4790ba5ffA8), [AAVE](https://arbiscan.io/address/0xba5DdD1f9d7F570dc94a51479a000E3BCE967196)

### AGRS

The automated AGRS system will be configured with the following params:

| **Parameter** | **Percent change allowed** | **minimumDelay** |
| ------------- | -------------------------- | ---------------- |
| Supply Cap    | 30% (relative change)      | 3 days           |
| Borrow Cap    | 30% (relative change)      | 3 days           |

### Edge Risk Oracle

The methodology used by the Edge Risk Oracle to suggest cap updates is described on the governance forum [here](https://governance.aave.com/t/arfc-supply-and-borrow-cap-risk-oracle-activation/20834).

## References

- Implementation: [Payload](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250218_AaveV3Arbitrum_CapsRiskOracleActivationOnArbitrum/AaveV3Arbitrum_CapsRiskOracleActivationOnArbitrum_20250218.sol)
- Tests: [Payload](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250218_AaveV3Arbitrum_CapsRiskOracleActivationOnArbitrum/AaveV3Arbitrum_CapsRiskOracleActivationOnArbitrum_20250218.t.sol), [AaveStewardsInjectorCaps](https://github.com/aave-dao/aave-v3-risk-stewards/blob/dcfb2aca52f5cae34a68c2d5da8ba0f9260a0ee5/tests/AaveStewardsInjectorCaps.t.sol), [EdgeRiskStewardCaps](https://github.com/aave-dao/aave-v3-risk-stewards/blob/dcfb2aca52f5cae34a68c2d5da8ba0f9260a0ee5/tests/EdgeRiskStewardCaps.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x1d8d0d25f3b705bf207a130308658d15256e2cebc58d123e4ad9e7e3a177ac11)
- [Discussion](https://governance.aave.com/t/arfc-supply-and-borrow-cap-risk-oracle-activation/20834)
- AaveStewardsInjectorCaps: [github](https://github.com/aave-dao/aave-v3-risk-stewards/blob/dcfb2aca52f5cae34a68c2d5da8ba0f9260a0ee5/src/contracts/AaveStewardInjectorCaps.sol), [deployed-contract](https://arbiscan.io/address/0x35d53dEB2F6f40Ea7af32B6F8BEd88eA966DF1D9)
- EdgeRiskStewardCaps: [github](https://github.com/aave-dao/aave-v3-risk-stewards/blob/dcfb2aca52f5cae34a68c2d5da8ba0f9260a0ee5/src/contracts/EdgeRiskStewardCaps.sol), [deployed-contract](https://arbiscan.io/address/0x085E34722e04567Df9E6d2c32e82fd74f3342e79)
- EdgeRiskOracle: [github](https://github.com/ChaosLabsInc/risk-oracle/blob/be09f47d749985f9537e185016d0f81c003a9fc9/src/RiskOracle.sol), [deployed-contract](https://arbiscan.io/address/0x861eeAdB55E41f161F31Acb1BFD4c70E3a964Aed)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
