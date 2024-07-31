---
title: "Reduce Reserve Factor on wstETH"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-reduce-reserve-factor-on-wsteth/18044/1"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x7ef3a8d68fa8a1b69d298aceddfafe9d2a24eefb19365d995c839b1cd1b0b97d"
---

## Simple Summary

For further alignment with the upcoming Lido Alliance proposals, this proposal will reduce the reserve factor for wstETH to 5%.

## Motivation

Aave and Lido have historically seen symbiotic growth, with stETH being one of the premier collaterals on Aave and leveraged staking being one of the most profitable use cases for both Aave DAO and Lido users.

As part of the recently passed [TEMP CHECK proposal ](https://governance.aave.com/t/temp-check-deploy-a-lido-aave-v3-instance/17930) to create an isolated instance for wstETH borrowers, a number of other parameter changes were proposed to align Lido and Aave.

This proposal implements the agreed reserve factor change for wstETH to 5%.

## Specification

On all networks, change wstETH Reserve Factor to 5%.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240716_Multi_ReduceReserveFactorOnWstETH/AaveV3Ethereum_ReduceReserveFactorOnWstETH_20240716.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240716_Multi_ReduceReserveFactorOnWstETH/AaveV3Polygon_ReduceReserveFactorOnWstETH_20240716.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240716_Multi_ReduceReserveFactorOnWstETH/AaveV3Optimism_ReduceReserveFactorOnWstETH_20240716.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240716_Multi_ReduceReserveFactorOnWstETH/AaveV3Arbitrum_ReduceReserveFactorOnWstETH_20240716.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240716_Multi_ReduceReserveFactorOnWstETH/AaveV3Base_ReduceReserveFactorOnWstETH_20240716.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240716_Multi_ReduceReserveFactorOnWstETH/AaveV3Gnosis_ReduceReserveFactorOnWstETH_20240716.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240716_Multi_ReduceReserveFactorOnWstETH/AaveV3Scroll_ReduceReserveFactorOnWstETH_20240716.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240716_Multi_ReduceReserveFactorOnWstETH/AaveV3Ethereum_ReduceReserveFactorOnWstETH_20240716.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240716_Multi_ReduceReserveFactorOnWstETH/AaveV3Polygon_ReduceReserveFactorOnWstETH_20240716.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240716_Multi_ReduceReserveFactorOnWstETH/AaveV3Optimism_ReduceReserveFactorOnWstETH_20240716.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240716_Multi_ReduceReserveFactorOnWstETH/AaveV3Arbitrum_ReduceReserveFactorOnWstETH_20240716.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240716_Multi_ReduceReserveFactorOnWstETH/AaveV3Base_ReduceReserveFactorOnWstETH_20240716.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240716_Multi_ReduceReserveFactorOnWstETH/AaveV3Gnosis_ReduceReserveFactorOnWstETH_20240716.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240716_Multi_ReduceReserveFactorOnWstETH/AaveV3Scroll_ReduceReserveFactorOnWstETH_20240716.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x7ef3a8d68fa8a1b69d298aceddfafe9d2a24eefb19365d995c839b1cd1b0b97d)
- [Discussion](https://governance.aave.com/t/arfc-reduce-reserve-factor-on-wsteth/18044/1)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
