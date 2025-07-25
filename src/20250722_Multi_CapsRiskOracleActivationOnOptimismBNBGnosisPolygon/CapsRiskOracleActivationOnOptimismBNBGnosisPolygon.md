---
title: "Caps Risk Oracle Activation on Optimism, BNB, Gnosis, Polygon"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/98"
---

## Simple Summary

Following the successful operation of the automated cap risk stewards (AGRS) on Aave v3 Arbitrum, Base and Avalanche, this proposal enables exactly the same constraint system on Optimism, Gnosis, BNB and Polygon instances.

## Motivation

Proposal [253](https://vote.onaave.com/proposal/?proposalId=253) and [292](https://vote.onaave.com/proposal/?proposalId=292) approved by governance enabled an automated AGRS (Aave Generalised Risk Stewards) system to allow modification of supply and borrow caps in Aave v3 Arbitrum, Base and Avalanche, in order to make caps maintenance more efficient, reducing the overall overhead of updating them via manual stewards or governance proposals, while having a more dynamic system reducing the delta between caps and supplies/borrowings.

Since then, the system has been working flawlessly on Arbitrum, Base and Avalanche. So following the plan it is reasonable to continue optimizing by introducing the same on other networks, more precisely Optimism, Gnosis, BNB and Polygon.

## Specification

These new instances of AGRS on Optimism, Gnosis, BNB and Polygon will mirror exactly the same infrastructure as the currently active on the previous networks like Arbitrum, Base and Avalanche, but a summary of specifications is the following:

- The AGRS will only have two configurable parameters: supply and borrow caps.
- Recommendation of these parameters will be submitted to a RiskOracle smart contract, from the Edge off-chain infrastructure.
- Between the risk oracle smart contract and the AGRS contract, there will be a thin middleware AaveStewardCapsInjector, with the following logic:
  - Takes recommendations from the Edge Risk Oracle side and propagate them to the AGRS contract.
  - Enforce that only the whitelisted assets can be acted upon.
  - Given the protections (percentage constraints and time delay) on the AGRS side and that it is an assumption that risk recommendations will be timed correctly on the Edge Risk Oracle side, the propagation will be permissionless.
- The AaveStewardCapsInjector will be part of the Aave Robot infrastructure, running on Chainlink Automation and consuming LINK from the Aave Collector on each network. **_Please note: on Gnosis network the injector robot will be running on Gelato Automation_**
- The new AGRS contract will be given `RISK_ADMIN` role.
- Constraints on the new instances will be the same as on the system currently live: maximum 30% increase/decrease each 3 days
- The off-chain caps methodology description can be found on the Aave governance forum [here](https://governance.aave.com/t/arfc-supply-and-borrow-cap-risk-oracle-activation/20834)

The following assets have been whitelisted for automated AGRS system, enforced on the AaveStewardCapsInjector contract:

- Optimism: [WETH](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000006), [wstETH](https://optimistic.etherscan.io/address/0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb), [rETH](https://optimistic.etherscan.io/address/0x9Bcef72be871e61ED4fBbc7630889beE758eb81D), [WBTC](https://optimistic.etherscan.io/address/0x68f180fcCe6836688e9084f035309E29Bf0A2095), [USDC](https://optimistic.etherscan.io/address/0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85), [USDT](https://optimistic.etherscan.io/address/0x94b008aA00579c1307B0EF2c499aD98a8ce58e58), [OP](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000042)
- BNB: [ETH](https://bscscan.com/address/0x2170Ed0880ac9A755fd29B2688956BD959F933F8), [wstETH](https://bscscan.com/address/0x26c5e01524d2E6280A48F2c50fF6De7e52E9611C), [BTCB](https://bscscan.com/address/0x7130d2A12B9BCbFAe4f2634d864A1Ee1Ce3Ead9c), [USDC](https://bscscan.com/address/0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d), [USDT](https://bscscan.com/address/0x55d398326f99059fF775485246999027B3197955), [WBNB](https://bscscan.com/address/0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c)
- Gnosis: [WETH](https://gnosisscan.io/address/0x6A023CCd1ff6F2045C3309768eAd9E68F978f6e1), [wstETH](https://gnosisscan.io/address/0x6C76971f98945AE98dD7d4DFcA8711ebea946eA6), [USDCe](https://gnosisscan.io/address/0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0), [sDAI](https://gnosisscan.io/address/0xaf204776c7245bF4147c2612BF6e5972Ee483701), [EURe](https://gnosisscan.io/address/0xcB444e90D8198415266c6a2724b7900fb12FC56E), [GNO](https://gnosisscan.io/address/0x9C58BAcC331c9aa871AFD802DB6379a98e80CEdb)
- Polygon: [WETH](https://polygonscan.com/address/0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619), [wstETH](https://polygonscan.com/address/0x03b54A6e9a984069379fae1a4fC4dBAE93B3bCCD), [WBTC](https://polygonscan.com/address/0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6), [USDC](https://polygonscan.com/address/0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359), [USDC.e](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174), [USDT](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F), [DAI](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063), [AAVE](https://polygonscan.com/address/0xD6DF932A45C0f255f85145f286eA0b292B21C90B), [LINK](https://polygonscan.com/address/0x53E0bca35eC356BD5ddDFebbD1Fc0fD03FaBad39), [WPOL](https://polygonscan.com/address/0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270)

**Optimism**

| Contract                | Address                                                                                                                          |
| ----------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| EdgeRiskStewardCaps     | [0x14a6801DBEBbd6CBE009c10eCFDA98C1c7B89012](http://optimistic.etherscan.io/address/0x14a6801DBEBbd6CBE009c10eCFDA98C1c7B89012)  |
| AaveStewardInjectorCaps | [0x54714FAc85b0bf627288CC3a186dE81A42f1D635](https://optimistic.etherscan.io/address/0x54714FAc85b0bf627288CC3a186dE81A42f1D635) |
| RiskOracle              | [0x9f6aA2aB14bFF53e4b79A81ce1554F1DFdbb6608](https://optimistic.etherscan.io/address/0x9f6aA2aB14bFF53e4b79A81ce1554F1DFdbb6608) |

**Gnosis**

| Contract                | Address                                                                                                                |
| ----------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| EdgeRiskStewardCaps     | [0x655252250f4A453854040A49E8280951A76f3033](https://gnosisscan.io/address/0x655252250f4A453854040A49E8280951A76f3033) |
| AaveStewardInjectorCaps | [0x394aDC8772DDD076BD3c5C545c4Edd3617C7d5e6](https://gnosisscan.io/address/0x394aDC8772DDD076BD3c5C545c4Edd3617C7d5e6) |
| RiskOracle              | [0x7BD97DD6C199532d11Cf5f55E13a120dB6dd0F4F](https://gnosisscan.io/address/0x7BD97DD6C199532d11Cf5f55E13a120dB6dd0F4F) |

**BNB**

| Contract                | Address                                                                                                              |
| ----------------------- | -------------------------------------------------------------------------------------------------------------------- |
| EdgeRiskStewardCaps     | [0x655252250f4A453854040A49E8280951A76f3033](http://bscscan.com/address/0x655252250f4A453854040A49E8280951A76f3033)  |
| AaveStewardInjectorCaps | [0x54714FAc85b0bf627288CC3a186dE81A42f1D635](https://bscscan.com/address/0x54714FAc85b0bf627288CC3a186dE81A42f1D635) |
| RiskOracle              | [0x239d3Bc5fa247337287cb03f53B8bc63DBBc332D](https://bscscan.com/address/0x239d3Bc5fa247337287cb03f53B8bc63DBBc332D) |

**Polygon**

| Contract                | Address                                                                                                                  |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| EdgeRiskStewardCaps     | [0x35b09a414f6003346ca2e2553b3ea91cd3524af3](https://polygonscan.com/address/0x35b09a414f6003346ca2e2553b3ea91cd3524af3) |
| AaveStewardInjectorCaps | [0x54714fac85b0bf627288cc3a186de81a42f1d635](https://polygonscan.com/address/0x54714fac85b0bf627288cc3a186de81a42f1d635) |
| RiskOracle              | [0x9f6aA2aB14bFF53e4b79A81ce1554F1DFdbb6608](https://polygonscan.com/address/0x9f6aA2aB14bFF53e4b79A81ce1554F1DFdbb6608) |

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/f69dc09142d979ce755027ffccd64ba58264150d/src/20250722_Multi_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon/AaveV3Polygon_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/f69dc09142d979ce755027ffccd64ba58264150d/src/20250722_Multi_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon/AaveV3Optimism_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/f69dc09142d979ce755027ffccd64ba58264150d/src/20250722_Multi_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon/AaveV3Gnosis_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/f69dc09142d979ce755027ffccd64ba58264150d/src/20250722_Multi_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon/AaveV3BNB_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.sol)
- Tests: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/f69dc09142d979ce755027ffccd64ba58264150d/src/20250722_Multi_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon/AaveV3Polygon_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/f69dc09142d979ce755027ffccd64ba58264150d/src/20250722_Multi_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon/AaveV3Optimism_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/f69dc09142d979ce755027ffccd64ba58264150d/src/20250722_Multi_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon/AaveV3Gnosis_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/f69dc09142d979ce755027ffccd64ba58264150d/src/20250722_Multi_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon/AaveV3BNB_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.t.sol)
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/98)
- Snapshot: Direct To AIP

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
