---
title: "Gho Mantle Activation"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-deploy-aave-v3-on-mantle/20542/10"
snapshot: "TODO"
---

## Simple Summary

This AIP proposes deploying GHO on the Mantle blockchain. By deploying on Mantle, Aave can take advantage of Mantle’s integration with Bybit products, enabling seamless access to Bybit’s 30 million active users. This creates a significant opportunity to broaden GHO's user base and make the stablecoin more accessible to a wider audience.

## Motivation

Considering the substantial amount of lending activity projected for the instance, the strategic placement of GHO in the list of initial assets paves the way to broader expansion and adoption of the stablecoin.

GHO’s price performance has been strong on the Ethereum network, as empirically observed pricing data extracted from the GHO/USDC Uniswap v3 pool indicates high peg stability, with maximum dislocations of only 20 basis points compared to its anchor price of $1.

## Specification

This AIP includes a series of actions required to launch GHO on Mantle:

1. Configure new Chainlink CCIP lanes between Mantle and the chains where GHO is launched with a rate limit of 1.5M GHO capacity and 300 GHO per second rate.
2. Configure GhoCcipSteward.
3. Configure GhoBucketSteward

The table below lists the address of the new **Mantle** deployments

| Contract         | Address                                                                                                                 |
| :--------------- | :---------------------------------------------------------------------------------------------------------------------- |
| GhoToken         | [0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73](https://mantlescan.xyz/address/0xb0e1c7830aa781362f79225559aa068e6bdaf1d1) |
| GhoTokenPool     | [0xDe6539018B095353A40753Dc54C91C68c9487D4E](https://mantlescan.xyz/address/0xde6539018b095353a40753dc54c91c68c9487d4e) |
| GhoBucketSteward | [0x2Ce400703dAcc37b7edFA99D228b8E70a4d3831B](https://mantlescan.xyz/address/0x2ce400703dacc37b7edfa99d228b8e70a4d3831b) |
| GhoCcipSteward   | [0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6](https://mantlescan.xyz/address/0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6) |

## References

- Implementation: [AaveV3Mantle](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260105_AaveV3Mantle_GhoMantleActivation/AaveV3Mantle_GhoMantleActivation_20260105.sol)
- Tests: [AaveV3Mantle](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260105_AaveV3Mantle_GhoMantleActivation/AaveV3Mantle_GhoMantleActivation_20260105.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xa3dc5b82f2dc5176c2a7543a6cc10aa75cccf96a73afe06478795182cff9d771)
- [Discussion](https://governance.aave.com/t/arfc-deploy-aave-v3-on-mantle/20542/10)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
